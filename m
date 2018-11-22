Received: from eggs.gnu.org ([2001:4830:134:3::10]:33035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gPs2E-0003re-8X
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gPs2A-0005G0-Bs
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:40:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:52080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gPs2A-0005Au-6E
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:40:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gPs21-0007Kn-VG
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 16:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E646C2E80C8
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 16:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Nov 2018 16:26:58 -0000
From: Alberto Ortega <1804678@bugs.launchpad.net>
Reply-To: Bug 1804678 <1804678@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154290401870.17569.13384923487355075536.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1804678] [NEW] qemu-3.1.0-rc0: mips emulation
 hangs when executing invalid instructions
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

QEMU version:
-------------

qemu-3.1.0-rc0 compiled from sources (earlier versions also affected)

Summary:
--------

QEMU MIPS system emulation hangs when trying to execute the following
invalid instructions:

71c5a9bf       sdbbp 0x716a6
2c4745aa       sltiu a3, v0, 0x45aa
f47539fb       sdc1 f21, 0x39fb(v1)
5fa5e284       invalid

qemu-system-mips falls under an infinite loop condition and it needs to
be ended.

The issue has been reproduced in Ubuntu x64 host running Debian MIPS
32-bits guest with the following command line:

qemu-system-mips -M malta -kernel vmlinux-3.2.0-4-4kc-malta -hda
debian_wheezy_mips_standard.qcow2 -append "root=3D/dev/sda1 console=3Dtty0"

It can also be reproduced using mips-linux-user, in which case throws
the following exception:

qemu-mips mips_loop_static.elf
qemu: unhandled CPU exception 0x10 - aborting
pc=3D0x004a9da0 HI=3D0x00000003 LO=3D0x00000002 ds 00e2 004a9da0 0
GPR00: r0 00000000 at fffffff8 v0 004a9da0 v1 004ad000
GPR04: a0 00000001 a1 7fffefc4 a2 7fffefcc a3 00000000
GPR08: t0 004ab854 t1 0ffffffe t2 81010100 t3 2f2f2f2f
GPR12: t4 7ffff1ad t5 004ab090 t6 004ab06c t7 004ab07c
GPR16: s0 00000000 s1 452ac505 s2 00400db4 s3 00400d38
GPR20: s4 00000000 s5 00000000 s6 00000000 s7 00000000
GPR24: t8 004ab0a8 t9 004a9da0 k0 00000000 k1 00000000
GPR28: gp 004b25a0 sp 7fffeec0 s8 7fffeec0 ra 0040041c
CP0 Status  0x24000010 Cause   0x00000000 EPC    0x00000000
    Config0 0x80008482 Config1 0x9e190c8f LLAddr 0xffffffffffffffff
    Config2 0x80000000 Config3 0x00000000
    Config4 0x00000000 Config5 0x00000000
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x602dba=
d8

Testcase:
---------

C program to reproduce the problem:

unsigned char code[] =3D "\x71\xC5\xA9\xBF\x2C\x47\x45\xAA\xF4\x75\x39\xFB\=
x5F\xA5\xE2\x84";
main()
{
  int (*ret)() =3D (int(*)())code;
  ret();
}

Also, find a statically compiled ELF attached.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "mips_loop_static.elf"
   https://bugs.launchpad.net/bugs/1804678/+attachment/5215344/+files/mips_=
loop_static.elf

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1804678

Title:
  qemu-3.1.0-rc0: mips emulation hangs when executing invalid
  instructions

Status in QEMU:
  New

Bug description:
  QEMU version:
  -------------

  qemu-3.1.0-rc0 compiled from sources (earlier versions also affected)

  Summary:
  --------

  QEMU MIPS system emulation hangs when trying to execute the following
  invalid instructions:

  71c5a9bf       sdbbp 0x716a6
  2c4745aa       sltiu a3, v0, 0x45aa
  f47539fb       sdc1 f21, 0x39fb(v1)
  5fa5e284       invalid

  qemu-system-mips falls under an infinite loop condition and it needs
  to be ended.

  The issue has been reproduced in Ubuntu x64 host running Debian MIPS
  32-bits guest with the following command line:

  qemu-system-mips -M malta -kernel vmlinux-3.2.0-4-4kc-malta -hda
  debian_wheezy_mips_standard.qcow2 -append "root=3D/dev/sda1
  console=3Dtty0"

  It can also be reproduced using mips-linux-user, in which case throws
  the following exception:

  qemu-mips mips_loop_static.elf
  qemu: unhandled CPU exception 0x10 - aborting
  pc=3D0x004a9da0 HI=3D0x00000003 LO=3D0x00000002 ds 00e2 004a9da0 0
  GPR00: r0 00000000 at fffffff8 v0 004a9da0 v1 004ad000
  GPR04: a0 00000001 a1 7fffefc4 a2 7fffefcc a3 00000000
  GPR08: t0 004ab854 t1 0ffffffe t2 81010100 t3 2f2f2f2f
  GPR12: t4 7ffff1ad t5 004ab090 t6 004ab06c t7 004ab07c
  GPR16: s0 00000000 s1 452ac505 s2 00400db4 s3 00400d38
  GPR20: s4 00000000 s5 00000000 s6 00000000 s7 00000000
  GPR24: t8 004ab0a8 t9 004a9da0 k0 00000000 k1 00000000
  GPR28: gp 004b25a0 sp 7fffeec0 s8 7fffeec0 ra 0040041c
  CP0 Status  0x24000010 Cause   0x00000000 EPC    0x00000000
      Config0 0x80008482 Config1 0x9e190c8f LLAddr 0xffffffffffffffff
      Config2 0x80000000 Config3 0x00000000
      Config4 0x00000000 Config5 0x00000000
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x602d=
bad8

  Testcase:
  ---------

  C program to reproduce the problem:

  unsigned char code[] =3D "\x71\xC5\xA9\xBF\x2C\x47\x45\xAA\xF4\x75\x39\xF=
B\x5F\xA5\xE2\x84";
  main()
  {
    int (*ret)() =3D (int(*)())code;
    ret();
  }

  Also, find a statically compiled ELF attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1804678/+subscriptions
