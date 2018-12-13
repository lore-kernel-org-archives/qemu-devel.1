Received: from eggs.gnu.org ([2001:4830:134:3::10]:38719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXTeD-0002Zg-7G
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXTe9-00027t-3c
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:15:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:58836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gXTe8-00026H-SC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:15:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gXTe7-0004P8-EB
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 16:15:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 620EC2E807C
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 16:15:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Dec 2018 16:08:39 -0000
From: YVT <1806824@bugs.launchpad.net>
Reply-To: Bug 1806824 <1806824@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154399222698.26202.11105511106314070474.malonedeb@gac.canonical.com>
Message-Id: <154471731911.27872.427957015632187378.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806824] Re: SIE-200 (TrustZone) MPC: BLK_MAX
 returns an incorrect value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Command line:

    $ qemu-system-arm -kernel Image.elf -machine mps2-an505 -nographic
-d guest_errors -s -semihosting

The guest I'm running is an unreleased program for a research purpose.
I'm not aware of any publicly-known application or operating system that
make use of the hardware register concerned by this issue.

The attached program is an artificial example that reproduces the issue.
The program writes a random value to every LUT block within [0,
BLK_MAX]. After that, it examines the content of every LUT block to see
if it has the intended value or not.

With the AN505 FPGA image, you get the following output (via UART1,
115200 baud):

    =3D=3D=3D=3D The test program has started =3D=3D=3D=3D
     LUT[0x00000000] =3D 07345a3f
     LUT[0x00000001] =3D 020c7cc6
    =3D=3D=3D=3D The test program has completed =3D=3D=3D=3D

With QEMU, you get the following output because the LUT index 0x00000040 do=
esn't actually exist and is wrapped around to the first block:
    =

    $ make qemu
    qemu-system-arm -kernel Image.elf -machine mps2-an505 -nographic -d gue=
st_errors -s -semihosting
    =3D=3D=3D=3D The test program has started =3D=3D=3D=3D
     LUT[0x00000000] =3D 07345a3f
     LUT[0x00000001] =3D 020c7cc6
     ...
     LUT[0x0000003f] =3D ce3b657b
     LUT[0x00000040] =3D f01ed211
    [ERROR] Verify failed at 0x00000000 - expected 0x07345a3f, got 0xf01ed2=
11.
    =3D=3D=3D=3D The test program has completed =3D=3D=3D=3D

** Attachment added: "An artificial example that reproduces the issue"
   https://bugs.launchpad.net/qemu/+bug/1806824/+attachment/5222023/+files/=
qemu-1806824-test.tar.gz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806824

Title:
  SIE-200 (TrustZone) MPC: BLK_MAX returns an incorrect value

Status in QEMU:
  New

Bug description:
  Version: =

  $ qemu-system-arm --version
  QEMU emulator version 3.0.92 (v3.1.0-rc2-31-gd522fba244)

  Arm SIE-200 Technical Reference Manual describes that BLK_MAX
  indicates the maximum value of "block based index register" (BLK_IDX).
  For example, the value 1 would indicate that BLK_IDX can be 0 or 1.
  According to my experiments, the AN505 FPGA image apparently follows
  this behavior.

  In the current implementation of QEMU, it appears to indicate the
  number of possible values for BLK_IDX, i.e., one plus the value it's
  supposed to return.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806824/+subscriptions
