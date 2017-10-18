Received: from eggs.gnu.org ([2001:4830:134:3::10]:44196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4kDv-0003or-L5
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4kDo-0000cA-Om
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:01:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:51072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4kDo-0000bC-J4
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:01:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4kDl-0005qO-Ma
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:01:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1438E2E80E2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2017 08:46:49 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1724485 <1724485@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150831492991.17205.1365818841692773714.malonedeb@gac.canonical.com>
Message-Id: <150831640922.22405.7110680437624228271.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724485] Re: Invalid assertion in
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

The tarball contains:
scoped1.exe
etc/ld.so.cache
lib/libm.so.6
lib/libstdc++.so.6
lib/lib.c.so.6
lib/ld-linux-armhf.so.3
lib/libgcc_s.so.1

I can reproduce the problem with qemu-2.10.1:
qemu-armeb -E LD_LIBRARY_PATH=3D$PWD/lib -cpu any -R 0 -d in_asm -L $PWD $P=
WD/scoped1.exe

Removing '-d in_asm' works OK, because the offending assert is triggered
while disassembling.

BTW, the program (scoped1.exe) does abort, it is a GCC testcase I was
trying to debug ;-)

Removing the assert lets execution continue, but the disassembly is incorre=
ct. Without the assert, I see:
IN: strlen
0x40a1a880: f000 f890  bl 0x40a1a9a4
0x40a1a884: 4502       cmp r2, r0
but strlen normally starts with a pld instruction.

So probably print_insn_arm needs also a change like
given =3D (b[1]) | (b[0] <<8)<<16 | given;
instead of
given =3D (b[1]) | (b[0] <<8)|(given << 16);


** Attachment added: "qemu-bug-1724485.tar.xz"
   https://bugs.launchpad.net/qemu/+bug/1724485/+attachment/4974653/+files/=
qemu-bug-1724485.tar.xz

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
