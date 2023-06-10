#!/bin/bash

#Get active wireless adapter
WLAN=$( ip -br a |grep ^wl |grep -i up |awk '{print $1}' )
#printf "\n active wireless nic = $WLAN\n"

#Set ip file and last ip

IPFILE=".lan_ip.txt"

# Retrieve the current WAN IP
LAN_IP=$(ip address show $WLAN |grep -m1 inet | awk '{print $2}' |grep -oE -m1 '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')

#echo "Current LAN IP  is: $LAN_IP"


if ! [[ -f "$IPFILE" ]]
        then
          touch $IPFILE
fi

LAST_IP=$(cat "$IPFILE")

#echo "Previous LAN IP was: $LAST_IP"

if [ "$LAST_IP" != "$LAN_IP" ]; then
#    echo "LAN IP Address has CHANGE to $LAN_IP since last checked."

        #Now lets write this to the file
#       echo "Updating LAN_IP file to: $LAN_IP"
        echo "$LAN_IP"  >  $IPFILE

#lets send an email using a SMTP Service with new IP

                echo "$HOSTNAME IP address is $LAN_IP" |mail -s "$HOSTNAME LanIP" gtreanto@gmail.com

#       else
#               echo "LAN IP Still the same as $LAN_IP."

fi
