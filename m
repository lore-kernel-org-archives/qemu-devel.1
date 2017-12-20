Received: from eggs.gnu.org ([2001:4830:134:3::10]:38489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRZEA-0002yz-P8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRZE7-0008Pb-FH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:55:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:33314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRZE7-0008NS-60
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:55:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRZE4-00075Z-OA
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 07:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B4EE32E8069
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 07:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Dec 2017 07:42:25 -0000
From: Gustavo Moreira <gmoreira@gmail.com>
Reply-To: Bug 1739371 <1739371@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151375574544.16920.12315859630279795224.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1739371] [NEW] qemu-system-arm snapshot loadvm
 core dumped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Ubuntu Qemu is crashing trying to restore saved snapshot in qemu-system-arm.
I've tried different guests kernels, but I wasn't lucky with any of them.

The guest vm boots and I can use it normally. The issue is when I save
the snapshot using "savevm Base0", "quit" and then I restore that
snapshot using "-loadvm Base0" from the cmd line.

The only difference I've noticed is tweaking the guest memory:
* With -m 512 or 1024 it crashes as you can see below.
* With -m 2048 it doesn't crash, it restores the vm and I can see the scree=
n as it was, but the OS is halted. And it's not just the keyboard. I've tri=
ed saving the snapshot while it's booting with lot of lines being printed o=
n screen and after restoring it, the OS is frozen.

I also tried limiting the guest kernel memory using the mem parameter
(mem=3D2048M) and disabling the kernel address space randomization
(nokaslr) with the same results.

OS: Ubuntu 16.04.3 LTS (xenial)

$ qemu-system-arm --version
QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16), Copyright (c)=
 2003-2008 Fabrice Bellard

$ qemu-system-arm -kernel kernel/vmlinuz-4.10.0-42-generic -initrd kernel/i=
nitrd.img-4.10.0-42-generic -M vexpress-a15 -m 512 -append 'root=3D/dev/mmc=
blk0 rootwait console=3Dtty0' -sd vexpress-4G.qcow2 -dtb device-tree/vexpre=
ss-v2p-ca15-tc1.dtb  -loadvm Base0
pulseaudio: set_sink_input_volume() failed
pulseaudio: Reason: Invalid argument
pulseaudio: set_sink_input_mute() failed
pulseaudio: Reason: Invalid argument
qemu: fatal: Trying to execute code outside RAM or ROM at 0xc0321568

R00=3D00000001 R01=3D00000000 R02=3D00000000 R03=3Dc0321560
R04=3Dc1500000 R05=3Dc150529c R06=3Dc1505234 R07=3Dc14384d0
R08=3D00000000 R09=3D00000000 R10=3Dc1501f50 R11=3Dc1501f3c
R12=3Dc1501f40 R13=3Dc1501f30 R14=3Dc030a184 R15=3Dc0321568
PSR=3D60070093 -ZC- A S svc32
s00=3D6374652f s01=3D636f6c2f d00=3D636f6c2f6374652f
s02=3D7273752f s03=3D6962732f d01=3D6962732f7273752f
s04=3D6e612f6e s05=3D6f726361 d02=3D6f7263616e612f6e
s06=3D7c7c206e s07=3D63202820 d03=3D632028207c7c206e
s08=3D202f2064 s09=3D72202626 d04=3D72202626202f2064
s10=3D702d6e75 s11=3D73747261 d05=3D73747261702d6e75
s12=3D722d2d20 s13=3D726f7065 d06=3D726f7065722d2d20
s14=3D652f2074 s15=3D632f6374 d07=3D632f6374652f2074
s16=3D00000000 s17=3D00000000 d08=3D0000000000000000
s18=3D00000000 s19=3D00000000 d09=3D0000000000000000
s20=3D00000000 s21=3D00000000 d10=3D0000000000000000
s22=3D00000000 s23=3D00000000 d11=3D0000000000000000
s24=3D00000000 s25=3D00000000 d12=3D0000000000000000
s26=3D00000000 s27=3D00000000 d13=3D0000000000000000
s28=3D00000000 s29=3D00000000 d14=3D0000000000000000
s30=3D00000000 s31=3D00000000 d15=3D0000000000000000
s32=3D00000000 s33=3D00000000 d16=3D0000000000000000
s34=3D00000000 s35=3D00000000 d17=3D0000000000000000
s36=3D00000000 s37=3D00000000 d18=3D0000000000000000
s38=3D00000000 s39=3D00000000 d19=3D0000000000000000
s40=3D00000000 s41=3D00000000 d20=3D0000000000000000
s42=3D00000000 s43=3D00000000 d21=3D0000000000000000
s44=3D00000000 s45=3D00000000 d22=3D0000000000000000
s46=3D00000000 s47=3D00000000 d23=3D0000000000000000
s48=3D00000000 s49=3D00000000 d24=3D0000000000000000
s50=3D00000000 s51=3D00000000 d25=3D0000000000000000
s52=3D00000000 s53=3D00000000 d26=3D0000000000000000
s54=3D00000000 s55=3D00000000 d27=3D0000000000000000
s56=3D00000000 s57=3D00000000 d28=3D0000000000000000
s58=3D00000000 s59=3D00000000 d29=3D0000000000000000
s60=3D00000000 s61=3D00000000 d30=3D0000000000000000
s62=3D00000000 s63=3D00000000 d31=3D0000000000000000
FPSCR: 00000000
Aborted (core dumped)

As I said above, the same happens when -m 1024 is used.

I have a different issue when I use the qemu git master version, but I'm
submiting a different ticket for that.

Cheers,
Gus

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1739371

Title:
  qemu-system-arm snapshot loadvm core dumped

Status in QEMU:
  New

Bug description:
  Ubuntu Qemu is crashing trying to restore saved snapshot in qemu-system-a=
rm.
  I've tried different guests kernels, but I wasn't lucky with any of them.

  The guest vm boots and I can use it normally. The issue is when I save
  the snapshot using "savevm Base0", "quit" and then I restore that
  snapshot using "-loadvm Base0" from the cmd line.

  The only difference I've noticed is tweaking the guest memory:
  * With -m 512 or 1024 it crashes as you can see below.
  * With -m 2048 it doesn't crash, it restores the vm and I can see the scr=
een as it was, but the OS is halted. And it's not just the keyboard. I've t=
ried saving the snapshot while it's booting with lot of lines being printed=
 on screen and after restoring it, the OS is frozen.

  I also tried limiting the guest kernel memory using the mem parameter
  (mem=3D2048M) and disabling the kernel address space randomization
  (nokaslr) with the same results.

  OS: Ubuntu 16.04.3 LTS (xenial)

  $ qemu-system-arm --version
  QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16), Copyright (=
c) 2003-2008 Fabrice Bellard

  $ qemu-system-arm -kernel kernel/vmlinuz-4.10.0-42-generic -initrd kernel=
/initrd.img-4.10.0-42-generic -M vexpress-a15 -m 512 -append 'root=3D/dev/m=
mcblk0 rootwait console=3Dtty0' -sd vexpress-4G.qcow2 -dtb device-tree/vexp=
ress-v2p-ca15-tc1.dtb  -loadvm Base0
  pulseaudio: set_sink_input_volume() failed
  pulseaudio: Reason: Invalid argument
  pulseaudio: set_sink_input_mute() failed
  pulseaudio: Reason: Invalid argument
  qemu: fatal: Trying to execute code outside RAM or ROM at 0xc0321568

  R00=3D00000001 R01=3D00000000 R02=3D00000000 R03=3Dc0321560
  R04=3Dc1500000 R05=3Dc150529c R06=3Dc1505234 R07=3Dc14384d0
  R08=3D00000000 R09=3D00000000 R10=3Dc1501f50 R11=3Dc1501f3c
  R12=3Dc1501f40 R13=3Dc1501f30 R14=3Dc030a184 R15=3Dc0321568
  PSR=3D60070093 -ZC- A S svc32
  s00=3D6374652f s01=3D636f6c2f d00=3D636f6c2f6374652f
  s02=3D7273752f s03=3D6962732f d01=3D6962732f7273752f
  s04=3D6e612f6e s05=3D6f726361 d02=3D6f7263616e612f6e
  s06=3D7c7c206e s07=3D63202820 d03=3D632028207c7c206e
  s08=3D202f2064 s09=3D72202626 d04=3D72202626202f2064
  s10=3D702d6e75 s11=3D73747261 d05=3D73747261702d6e75
  s12=3D722d2d20 s13=3D726f7065 d06=3D726f7065722d2d20
  s14=3D652f2074 s15=3D632f6374 d07=3D632f6374652f2074
  s16=3D00000000 s17=3D00000000 d08=3D0000000000000000
  s18=3D00000000 s19=3D00000000 d09=3D0000000000000000
  s20=3D00000000 s21=3D00000000 d10=3D0000000000000000
  s22=3D00000000 s23=3D00000000 d11=3D0000000000000000
  s24=3D00000000 s25=3D00000000 d12=3D0000000000000000
  s26=3D00000000 s27=3D00000000 d13=3D0000000000000000
  s28=3D00000000 s29=3D00000000 d14=3D0000000000000000
  s30=3D00000000 s31=3D00000000 d15=3D0000000000000000
  s32=3D00000000 s33=3D00000000 d16=3D0000000000000000
  s34=3D00000000 s35=3D00000000 d17=3D0000000000000000
  s36=3D00000000 s37=3D00000000 d18=3D0000000000000000
  s38=3D00000000 s39=3D00000000 d19=3D0000000000000000
  s40=3D00000000 s41=3D00000000 d20=3D0000000000000000
  s42=3D00000000 s43=3D00000000 d21=3D0000000000000000
  s44=3D00000000 s45=3D00000000 d22=3D0000000000000000
  s46=3D00000000 s47=3D00000000 d23=3D0000000000000000
  s48=3D00000000 s49=3D00000000 d24=3D0000000000000000
  s50=3D00000000 s51=3D00000000 d25=3D0000000000000000
  s52=3D00000000 s53=3D00000000 d26=3D0000000000000000
  s54=3D00000000 s55=3D00000000 d27=3D0000000000000000
  s56=3D00000000 s57=3D00000000 d28=3D0000000000000000
  s58=3D00000000 s59=3D00000000 d29=3D0000000000000000
  s60=3D00000000 s61=3D00000000 d30=3D0000000000000000
  s62=3D00000000 s63=3D00000000 d31=3D0000000000000000
  FPSCR: 00000000
  Aborted (core dumped)

  As I said above, the same happens when -m 1024 is used.

  I have a different issue when I use the qemu git master version, but
  I'm submiting a different ticket for that.

  Cheers,
  Gus

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1739371/+subscriptions
