#! /bin/sh


error_exit(){
	echo "$1"
	exit 1
	}



echo "Enter Game ID :  "
read GAME_ID

echo ""
echo "Entered game ID is "${GAME_ID}""
echo ""

echo '{"gameid":"'${GAME_ID}'"}' > game.json

sudo mkdir -p /home/pi/RRP
[ $? -ne 0 ] && error_exit "error: make directory failed"

sudo cp -rf ./* /home/pi/RRP/
[ $? -ne 0 ] && error_exit "error: copy failed"

cd /home/pi/RRP/

npm install

sudo chmod 0777 /home/pi/RRP/rrpd 
[ $? -ne 0 ] && error_exit "error: rrpd file permission was not successful"

sudo cp -f /home/pi/RRP/rrpd /etc/init.d/
[ $? -ne 0 ] && error_exit "error: rrpd copy failed"

sudo update-rc.d rrpd defaults

sudo service rrpd start
