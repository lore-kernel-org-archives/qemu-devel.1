Received: from eggs.gnu.org ([2001:4830:134:3::10]:58170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewWiu-0000dA-UN
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewWiq-0006vs-Os
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:31:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:49788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewWiq-0006vB-I3
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:31:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewWio-00023z-DV
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 17:31:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C8D012E81BB
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 17:31:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 17:21:51 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1680991 <1680991@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170408001403.30529.99444.malonedeb@soybean.canonical.com>
Message-Id: <152113451194.3299.9181106001298488572.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1680991] Re: raspi2: system timer device not
 implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- raspi2: system timer not device implemented
+ raspi2: system timer device not implemented

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1680991

Title:
  raspi2: system timer device not implemented

Status in QEMU:
  Confirmed

Bug description:
  In a small hobby kernel for Raspberry Pi 2B, I am using the system
  timer to control wait durations.  This timer is located at 0x3f003000
  and the timer counts are located at 0x3f003004 (CLO) and 0x3f004008
  (CHI).  Reading these memory locations returns 0 for both.

  The basic code for this function is:
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @@ uint64_t ReadSysTimerCount() -- read the system time running count
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  ReadSysTimerCount:
  	ldr	r0,=3DST_CLO                  @ load the base address of the system =
timer
  	ldrd	r0,r1,[r0]                  @ Get the 64-bit timer "count" into r1:=
r0
  	mov	pc,lr			    @ return

  Tracing back the definition of ST_CLO in my code:
  #define ST_CLO              (ST_BASE+4)                 // Counter Lower =
32 bits
  #define ST_BASE             (HW_BASE+0x3000)            // System Timer b=
ase address
  #define HW_BASE             (0x3f000000)                // this is the ba=
se address for all hardware I/O addresses

  I have tested a similar program that I know to work on real hardware
  with qemu-system-arm reading the same mmio register and have the same
  issue, so I'm pretty sure the issue is not with my code.

  My Host PC is a VM on vmWare esxi running FC25 (8 cores, 8GB RAM): =

  [adam@os-dev ~]$ uname -a
  Linux os-dev.jammin 4.10.8-200.fc25.x86_64 #1 SMP Fri Mar 31 13:20:22 UTC=
 2017 x86_64 x86_64 x86_64 GNU/Linux

  I have confirmed this issue on QEMU 2.7.1 (fc25 Distro) and 2.9.0-rc3
  (git).

  adam@os-dev ~]$ qemu-system-arm --version
  QEMU emulator version 2.7.1(qemu-2.7.1-4.fc25), Copyright (c) 2003-2016 F=
abrice Bellard and the QEMU Project developers

  [adam@os-dev ~]$ ./workspace/qemu/bin/debug/native/arm-softmmu/qemu-syste=
m-arm --version
  QEMU emulator version 2.8.93 (v2.9.0-rc3-15-g5daf9b3)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  A remote debugger for my kernel shows the following:
  (gdb) info reg
  r0             0x0	0
  r1             0x0	0
  r2             0x96	150
  r3             0x0	0
  r4             0xa000	40960
  r5             0x0	0
  r6             0x0	0
  r7             0x0	0
  r8             0x0	0
  r9             0xa000	40960
  r10            0x0	0
  r11            0x7fdc	32732
  r12            0x0	0
  sp             0x7fc8	0x7fc8
  lr             0x8194	33172
  pc             0x80a4	0x80a4
  cpsr           0x800001d3	-2147483181
  (gdb) stepi
  0x000080a8 in ?? ()
  (gdb) info reg
  r0             0x3f003004	1056976900
  r1             0x0	0
  r2             0x96	150
  r3             0x0	0
  r4             0xa000	40960
  r5             0x0	0
  r6             0x0	0
  r7             0x0	0
  r8             0x0	0
  r9             0xa000	40960
  r10            0x0	0
  r11            0x7fdc	32732
  r12            0x0	0
  sp             0x7fc8	0x7fc8
  lr             0x8194	33172
  pc             0x80a8	0x80a8
  cpsr           0x800001d3	-2147483181
  (gdb) stepi
  0x000080ac in ?? ()
  (gdb) info reg
  r0             0x0	0
  r1             0x0	0
  r2             0x96	150
  r3             0x0	0
  r4             0xa000	40960
  r5             0x0	0
  r6             0x0	0
  r7             0x0	0
  r8             0x0	0
  r9             0xa000	40960
  r10            0x0	0
  r11            0x7fdc	32732
  r12            0x0	0
  sp             0x7fc8	0x7fc8
  lr             0x8194	33172
  pc             0x80ac	0x80ac
  cpsr           0x800001d3	-2147483181

  Notice r0 is loaded with the address for CLO and then cleared with 0
  when read.

  I am writing my code against the documented specifications in "BCM2835
  ARM Peripherals" (attached for convenience), section "12 System
  Timer".

  =

  Please let me know if you need anything else from me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1680991/+subscriptions
