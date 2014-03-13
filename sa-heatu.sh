#!/bin/sh
# SpamAssassin HEATU Auto-Whitelist maintenance / expiry
# see http://www.real-world-systems.com/mail/sa-heatu.html

export PATH=$PATH:/usr/local/bin/
export COLUMNS=120
DIR=/var/spool/mqueue/.spamassassin
AWL=$DIR/auto-whitelist
TMS=$DIR/timestamps
LOG=/var/log/exim/sa-heatu.log
AGE=730

echo -e "\n---------------------" >> $LOG
echo `date +'%m/%d/%Y %T'` >> $LOG
sa-heatu $1 $2 $3 --showUpdates --expireOlderThan $AGE $AWL $TMS >> $LOG
if [ $? -ne 0 ]; then echo "sa-heatu failed, databases unmoved\!"; exit 1; fi
chown mailnull:pop ${AWL} ${TMS}
exit 0
