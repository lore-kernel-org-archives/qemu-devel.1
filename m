Received: from eggs.gnu.org ([209.51.188.92]:45008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3L1N-0003vW-8T
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3L1G-0001qC-Qy
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:31:13 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3L19-0001fp-4H
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:31:06 -0400
References: <20190311101428.GA11@765644dd90e5>
	<20190311103106.GG16@765644dd90e5>
	<9b0b6b52-347e-7a48-22be-798f101989ac@vivier.eu>
	<CAGZZdDHBKs46ep-+hnjBDRJpk5vf+kk+fyaBmXzj4_KrawwwsQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4c16264a-5548-6247-e200-a4006f0aa241@vivier.eu>
Date: Mon, 11 Mar 2019 14:30:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAGZZdDHBKs46ep-+hnjBDRJpk5vf+kk+fyaBmXzj4_KrawwwsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 8/10] qemu-binfmt-conf.sh: add option
 --clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: unai.martinezcorral@ehu.eus
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/03/2019 14:19, Unai Martinez Corral wrote:
> 2019/3/11 12:04, Laurent Vivier:
>>> +    find /proc/sys/fs/binfmt_misc/ -type f -name $names -exec sh -c 'printf %s -1 > {}' \;
>>
>> The qemu-* will be expanded here if you have a qemu-XXX in the current
>> directory. You must use "$names".
> 
> You are correct. Indeed, I had not spotted it because I introduced a
> bug when renaming 'reset' to 'clear'. Precisely, '-c' was being used
> twice: for 'credential' and for 'clear'. Both issues will be fixed in
> the next version.
> 
>> But:
>>
>> To remove all, you can do:
>> sh -c 'printf %s -1 > /proc/sys/fs/binfmt_misc/status'
>>
>> so something like
>>
>> if [ $# -eq 0 ] ; then
>>   sh -c 'printf %s -1 > /proc/sys/fs/binfmt_misc/status
>> fi
>> qemu_check_target_list $1
>> for t in $checked_target_list ; do
>>    sh -c 'printf %s -1 > /proc/sys/fs/binfmt_misc/qemu-$t'
>> done
> 
> Wouldn't writing to 'status' remove all the interpreters, and not only
> those that correspond to qemu?

Yes, you are right.

> 
>> But I think you should also taking care of the suffix.
> 
> I think that the suffix is not related to the entry in
> '/proc/sys/fs/binfmt_misc/'. See, e.g.:
> 
> package qemu-$cpu
> interpreter $qemu
> 
> So, independently of which is the executable (interpreter), the
> package name does not include the suffix.

Yes, you are right.

>>> +if [ "x$QEMU_CLEAR" = "xyes" ] ; then
>>> +  case "$BINFMT_SET" in
>>> +    *debian)  BINFMT_CLEAR=qemu_clear_notimplemented ;;
>>> +    *systemd) BINFMT_CLEAR=qemu_clear_notimplemented ;;
>>> +    *)        BINFMT_CLEAR=qemu_clear_interpreter
>>> +  esac
>>
>> Put this in the previous case for decoding options, please.
> 
> It won't work. This if/case block requires all the options to be
> already parsed and processed. If I put it in the case for '-r|--clear'
> above, it will only work only when '-r' is given after '--debian' or
> '--systemd'. Otherwise, BINFMT_SET will always be
> qemu_register_interpreter when '-crear' is evaluated. I think that we
> should not rely on the users providing the options in a specific
> order.

I meant something like this:

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a149..5c2651a6df57 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -327,17 +327,23 @@ QEMU_SUFFIX=""
 options=$(getopt -o ds:Q:S:e:hc:p: -l
debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent:
-- "$@")
 eval set -- "$options"

+BINFMT_CLEAR=qemu_clear_interpreter
 while true ; do
     case "$1" in
+    -c|--clear)
+        QEMU_CLEAR="yes"
+        ;;
     -d|--debian)
         CHECK=qemu_check_debian
         BINFMT_SET=qemu_generate_debian
         EXPORTDIR=${EXPORTDIR:-$DEBIANDIR}
+        BINFMT_CLEAR=qemu_clear_notimplemented
         ;;
     -s|--systemd)
         CHECK=qemu_check_systemd
         BINFMT_SET=qemu_generate_systemd
         EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
+        BINFMT_CLEAR=qemu_clear_notimplemented
         shift
         # check given cpu is in the supported CPU list
         if [ "$1" != "ALL" ] ; then
@@ -387,5 +393,9 @@ while true ; do
     shift
 done

+if [ "x$QEMU_CLEAR" = "xyes" ] ; then
+  $BINFMT_CLEAR "$@"
+  exit
+fi
 $CHECK
 qemu_set_binfmts
