Received: from eggs.gnu.org ([2001:4830:134:3::10]:39627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7NtA-0001B7-9H
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nt8-0005pk-GU
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:35142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7Nt8-0005nv-AO
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7Nt7-000123-2g
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:46:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0D78E2E806E
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:46:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 15:26:09 -0000
From: Thomas Huth <1359930@bugs.launchpad.net>
Reply-To: Bug 1359930 <1359930@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140821193444.13152.52372.malonedeb@wampee.canonical.com>
Message-Id: <150894516930.18213.6894907344862839617.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1359930] Re: [ARMv5] Integrator/CP regression
 when reading FPSID register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch had been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Ded1f13d607e2c64c66bea=
49d

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1359930

Title:
  [ARMv5] Integrator/CP regression when reading FPSID register

Status in HelenOS branches:
  New
Status in QEMU:
  Fix Released

Bug description:
  There seems to be a regression in QEMU 2.1.0 which demonstrates itself
  when running the attached HelenOS Integrator/CP (i.e. ARMv5) image. The
  offending instruction seems to be:

    vmrs r0, fpsid

  Upon its execution, HelenOS kernel receives an Undefined instruction
  exception (which it does not anticipate at that point) and crashes.

  QEMU 2.0.0 was not affected by this issue.

  Command line to reproduce with QEMU 2.1.0:

  $ qemu-system-arm -M integratorcp -kernel image.boot -s -S &
  $ /usr/local/cross/arm32/bin/arm-linux-gnueabi-gdb =

  ...
  (gdb) target remote localhost:1234
  Remote debugging using localhost:1234
  warning: Can not parse XML target description; XML support was disabled a=
t compile time
  0x00000000 in ?? ()
  (gdb) symbol-file kernel/kernel.raw
  Reading symbols from /home/jermar/software/HelenOS.mainline/kernel/kernel=
.raw...done.
  (gdb) break ras_check
  Breakpoint 1 at 0x80a021bc: file arch/arm32/src/ras.c, line 67.
  (gdb) c
  Continuing.

  Breakpoint 1, ras_check (n=3D1, istate=3D0x813e7f70) at arch/arm32/src/ra=
s.c:67
  67	{
  (gdb) set radix 16
  Input and output radices now set to decimal 16, hex 10, octal 20.
  (gdb) print istate->pc
  $1 =3D 0x80a02458
  (gdb) disassemble 0x80a02458
  Dump of assembler code for function fpsid_read:
     0x80a02454 <+0>:	vmrs	r0, fpsid                           <=3D=3D=3D=
=3D=3D=3D=3D UNDEFINED EXCEPTION INSTRUCTION
     0x80a02458 <+4>:	mov	pc, lr
  End of assembler dump.

  =

  The Undefined instruction exception is not expected at this point when ex=
ecuting the VMRS r0,fpsid instruction.

To manage notifications about this bug go to:
https://bugs.launchpad.net/helenos/+bug/1359930/+subscriptions
