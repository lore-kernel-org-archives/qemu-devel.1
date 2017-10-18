Received: from eggs.gnu.org ([2001:4830:134:3::10]:55412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4jkh-0006it-10
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4jkd-0001T9-Qi
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:43514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4jkd-0001Sd-Kl
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:30:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4jkc-0007jV-Kn
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 99D462E8031
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2017 08:22:09 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1724485 <1724485@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150831492991.17205.1365818841692773714.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724485] [NEW] Invalid assertion in
 arm_read_memory_func
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

Hi,

I think there is an invalid assertion in arm_read_memory_func:
assert(info->endian =3D=3D BFD_ENDIAN_LITTLE)

I face it in the following use case: target armeb-linux (I use qemu user
mode), -d in_asm -cpu any.

At some point during program startup, glibc's _dl_new_object calls
strlen, which is written in thumb2 mode (armv6t2). So print_insn_arm()
calls arm_read_memory_func() with length=3D=3D2, and info->flags =3D=3D
INSN_ARM_BE32, and the assert is false.

If I remove the assert, execution continues OK.

With the assert, I get the error message from the assert, and qemu then
stalls.

Can you confirm the assert can be removed? Or if not, explain me how to
avoid/fix the subsequent qemu stall?

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1724485

Title:
  Invalid assertion in arm_read_memory_func

Status in QEMU:
  New

Bug description:
  Hi,

  I think there is an invalid assertion in arm_read_memory_func:
  assert(info->endian =3D=3D BFD_ENDIAN_LITTLE)

  I face it in the following use case: target armeb-linux (I use qemu
  user mode), -d in_asm -cpu any.

  At some point during program startup, glibc's _dl_new_object calls
  strlen, which is written in thumb2 mode (armv6t2). So print_insn_arm()
  calls arm_read_memory_func() with length=3D=3D2, and info->flags =3D=3D
  INSN_ARM_BE32, and the assert is false.

  If I remove the assert, execution continues OK.

  With the assert, I get the error message from the assert, and qemu
  then stalls.

  Can you confirm the assert can be removed? Or if not, explain me how
  to avoid/fix the subsequent qemu stall?

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724485/+subscriptions
