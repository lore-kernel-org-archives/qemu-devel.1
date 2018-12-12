Received: from eggs.gnu.org ([2001:4830:134:3::10]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0rL-0006Pn-RE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0rJ-0005Ai-G9
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:58672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gX0rH-0004zt-Cs
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gX0r8-0007Wd-Ir
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:31:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9FE7D2E80DF
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:31:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Dec 2018 09:17:37 -0000
From: Thomas Huth <1793119@bugs.launchpad.net>
Reply-To: Bug 1793119 <1793119@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153726785322.19300.9182114718255539260.malonedeb@wampee.canonical.com>
Message-Id: <154460625718.23822.6085974060385294768.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1793119] Re: Wrong floating-point emulation on
 AArch64 with FPCR set to zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5dfbc9e4903c0121140f2

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1793119

Title:
  Wrong floating-point emulation on AArch64 with FPCR set to zero

Status in QEMU:
  Fix Released

Bug description:
  On AArch64, with FPCR set to Zero (i.e., FPU set to IEEE-754 compliant
  mode), floating-point emulation does not produce the same results as
  real hardware (e.g., Raspberry Pi 3 with AArch64 Linux).

  I attached a sample that reproduces the issue. It divides `x` by `y`
  and puts the result in `r`. The expected result of the operation is
  `q`.

  Output on real hardware:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
  fpcr =3D 0x07000000.
  x =3D 0x03250f416dcdc6d0. y =3D 0x00029f4e5837c977. r =3D 0x7ff0000000000=
000. q =3D 0x43300fde9cbcf023.
  fpcr =3D 0x00000000.
  x =3D 0x03250f416dcdc6d0. y =3D 0x00029f4e5837c977. r =3D 0x43300fde9cbcf=
023. q =3D 0x43300fde9cbcf023.
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

  Notice that after setting FPCR to zero, `r` equals `q`.

  Output on qemu 3.0.0 (Linux user-mode emulation):
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
  fpcr =3D 0x07000000.
  x =3D 0x03250f416dcdc6d0. y =3D 0x00029f4e5837c977. r =3D 0x7ff0000000000=
000. q =3D 0x43300fde9cbcf023.
  fpcr =3D 0x00000000.
  x =3D 0x03250f416dcdc6d0. y =3D 0x00029f4e5837c977. r =3D 0x43300fde9cbcf=
024. q =3D 0x43300fde9cbcf023.
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

  Notice that after setting FPCR to zero, `r` is not equal to `q`.

  Also notice that, using another proprietary operating system, the same
  issue arises between a real board and QEMU. This might be an issue in
  emulation of the AArch64 instruction "fdiv".

  Build command line: aarch64-linux-gnu-gcc -static -O0 -o sample1
  sample1.c

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1793119/+subscriptions
