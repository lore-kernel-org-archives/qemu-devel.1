Received: from eggs.gnu.org ([2001:4830:134:3::10]:43477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1faKIr-0001LX-2r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1faKIm-0008HZ-Lf
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:21:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1faKIm-0008H5-Ez
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:21:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1faKIk-00054U-Hb
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 12:20:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C57342E81A9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 12:20:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Jul 2018 12:14:43 -0000
From: guysoft <guysoft@gmail.com>
Reply-To: Bug 1776478 <1776478@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152880770129.26761.1762643804065210181.malonedeb@gac.canonical.com>
Message-Id: <153062008407.30364.13319759781273794677.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776478] Re: Getting qemu: uncaught target signal
 6 when running lv2 plugin cross-compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ok, got it to run with (had to septate arguments with --):

sudo chroot . usr/bin/qemu-arm-static -g -- DISTRHO-
Ports/libs/lv2_ttl_generator DISTRHO-Ports/bin/lv2/TAL-Filter-2.lv2/TAL-
Filter-2.so

When running I can see two processes:

root     31993  0.0  0.0  86556  4696 pts/9    S+   15:06   0:00 sudo chroo=
t . usr/bin/qemu-arm-static -g -- DISTRHO-Ports/libs/lv2_ttl_generator DIST=
RHO-Ports/bin/lv2/TAL-Filter-2.lv2/TAL-Filter-2.so
root     31994  0.0  0.0 4240444 9592 pts/9    Rl+  15:06   0:00 usr/bin/qe=
mu-arm-static -g -- DISTRHO-Ports/libs/lv2_ttl_generator DISTRHO-Ports/bin/=
lv2/TAL-Filter-2.lv2/TAL-Filter-2.so


I can attach to the pid using something like this:

sudo gdb -p $(ps aux | grep usr/bin/qemu-arm-static | grep -v grep |
grep -v chroot | awk '{  print $2 }')


When I continue I get:
Attaching to process 32519
[New LWP 32520]
0x00000000607a0973 in ?? ()
(gdb) c
Continuing.

Thread 1 "qemu-arm-static" received signal SIGABRT, Aborted.
0x00000000601786cd in ?? ()


The other process I can get with removing "-v" chroot so:

...

sudo gdb -p $(ps aux | grep usr/bin/qemu-arm-static | grep -v grep |
grep chroot | awk '{  print $2 }')

Reading symbols from /lib/x86_64-linux-gnu/libsystemd.so.0...(no debugging =
symbols found)...done.
Reading symbols from /lib/x86_64-linux-gnu/liblzma.so.5...(no debugging sym=
bols found)...done.
Reading symbols from /usr/lib/x86_64-linux-gnu/liblz4.so.1...(no debugging =
symbols found)...done.
Reading symbols from /lib/x86_64-linux-gnu/libgcrypt.so.20...(no debugging =
symbols found)...done.
Reading symbols from /lib/x86_64-linux-gnu/libgpg-error.so.0...(no debuggin=
g symbols found)...done.
0x00007f65cfd51bc4 in __GI___poll (fds=3D0x560bc6fe3040, nfds=3D2, timeout=
=3D-1) at ../sysdeps/unix/sysv/linux/poll.c:29
29      ../sysdeps/unix/sysv/linux/poll.c: No such file or directory.
(gdb) =



I think the first one is the interesting run, but being verbose.

Any tips on adding symbols?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776478

Title:
  Getting qemu: uncaught target signal 6 when running  lv2 plugin cross-
  compilation

Status in QEMU:
  New

Bug description:
  Hey,
  I am part of the Zynthian team and we use qemu-arm-static to cross compil=
e lv2 audio plugins.

  When running a compilation of DISTRHO-Ports we get:

  lv2_ttl_generator: pthread_mutex_lock.c:81: __pthread_mutex_lock: Asserti=
on `mutex->__data.__owner =3D=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  ./scripts/generate-ttl.sh: line 27: 16524 Aborted                 $GEN ./=
$FILE
  Makefile:62: recipe for target 'gen_lv2' failed
  make[1]: *** [gen_lv2] Error 134
  make[1]: Leaving directory '/home/pi/zynthian-sw/plugins/DISTRHO-Ports'
  Makefile:104: recipe for target 'lv2' failed
  make: *** [lv2] Error 2

  =

  lv2_ttl_generator source is here:
  https://github.com/DISTRHO/DISTRHO-Ports/tree/master/libs/lv2-ttl-generat=
or

  The command that is ruining is
  lv2_ttl_generator ./TAL-Filter-2.so =


  And ./TAL-Filter-2.so source is here:
  https://github.com/DISTRHO/DISTRHO-Ports/tree/master/ports/tal-filter-2/s=
ource


  Is there a way to debug what is going on?
  This runs fine on a Raspberrypi which is armv7

  A workaround would also help.

  =

  Bug in Zynthian:
  https://github.com/zynthian/zynthian-sys/issues/59
  Bug in DISTRHO-Ports:
  https://github.com/DISTRHO/DISTRHO-Ports/issues/29

  Using qemu-arm-static version from master from two days ago:
  qemu-arm version 2.12.50 (v2.12.0-1182-ga7a7309ca5-dirty), commit: a7a730=
9ca52c327c6603d60db90ae4feeae719f7

  Also saw this in qemu-arm version 2.12.0 (Debian 1:2.12+dfsg-3)

  Thanks,
  Guy

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776478/+subscriptions
