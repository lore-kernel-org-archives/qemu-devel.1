Received: from eggs.gnu.org ([2001:4830:134:3::10]:59370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gAFp8-00049M-U0
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gAFp3-0005tK-Vd
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:50:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:56950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gAFp3-0005rP-MP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:50:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gAFp0-0006jA-6W
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:50:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9E8D72E80E4
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:50:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Oct 2018 14:45:07 -0000
From: Koutheir Attouchi <1793119@bugs.launchpad.net>
Reply-To: Bug 1793119 <1793119@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153726785322.19300.9182114718255539260.malonedeb@wampee.canonical.com>
Message-Id: <153918270799.8644.15638199435058534781.malone@chaenomeles.canonical.com>
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

Thanks a lot :-)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1793119

Title:
  Wrong floating-point emulation on AArch64 with FPCR set to zero

Status in QEMU:
  Fix Committed

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
