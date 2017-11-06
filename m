Received: from eggs.gnu.org ([2001:4830:134:3::10]:42059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBikK-0001b4-Ph
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBikF-0005Qg-Sz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:51:28 -0500
Received: from indium.canonical.com ([91.189.90.7]:50956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBikF-0005ON-Lx
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:51:23 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBikD-0001av-BV
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 14:51:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 02BF52E81C7
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 14:51:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 14:41:36 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1641861 <1641861@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161115075112.3631.29997.malonedeb@soybean.canonical.com>
Message-Id: <150997929659.4205.987813852033178873.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1641861] Re: ARM QEMU doesn't enforce that RES0
 bits in FPSCR are non-writeable
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

- fail to correctly emulate FPSCR register on arm
+ ARM QEMU doesn't enforce that RES0 bits in FPSCR are non-writeable

** Changed in: qemu
       Status: New =3D> Confirmed

** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1641861

Title:
  ARM QEMU doesn't enforce that RES0 bits in FPSCR are non-writeable

Status in QEMU:
  Confirmed

Bug description:
  Hi all, we systematically tested the QEMU implementation for emulating
  arm user mode programs. We found that QEMU incorrectly emulate the
  FPSCR register. The following the proof of code:

  /*********** Beginning of the bug: arm.c **********/

  int printf(const char *format, ...);
  unsigned char i0[0x10];
  unsigned char o[0x10];
  int main() {
  =C2=A0=C2=A0=C2=A0=C2=A0int k =3D 0;
  =C2=A0=C2=A0=C2=A0=C2=A0asm("mov r2, %0\n"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"ldr r0, [r2]\n"::"r"((ch=
ar *)(i0)));;
  =C2=A0=C2=A0=C2=A0=C2=A0asm("vmsr fpscr, r0");
  =C2=A0=C2=A0=C2=A0=C2=A0asm("mov r2, %0\n"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"vmrs r4, fpscr\n"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"str r4, [r2]\n"::"r"((ch=
ar *)(o)));;
  =C2=A0=C2=A0=C2=A0=C2=A0for (k =3D 0; k < 0x10; k++)
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf("%02x", o[0x10 - 1=
 - k]);
  =C2=A0=C2=A0=C2=A0=C2=A0printf("\n");
  }
  unsigned char i0[0x10] =3D {0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x0=
0, 0x28, 0x1c, 0xc7, 0x01, 0x00, 0x00, 0x00, 0x00};

  /*********** End fo the bug **********/

  When the program is compiled into arm binary code and running on a
  real arm machine, and running in qemu, we have the following result

  $ arm-linux-gnueabihf-gcc arm.c -o arm -static
  $ ./arm
  000000000000000000000000fff7009f
  $ qemu-arm arm
  000000000000000000000000ffffffff

  According to the ARM manual, bits[19, 14:13, 6:5] of FPSCR should be
  reserved as zero. However, arm qemu fails to keep these bits to be
  zero: these bits can be actually modified in QEMU.

  QEMU version is 2.7.0. The operating system is Linux 3.13.0. x86_64.

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1641861/+subscriptions
