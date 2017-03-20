Received: from eggs.gnu.org ([2001:4830:134:3::10]:54504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cq5gJ-0001pn-W0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cq5gF-0001An-Qx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:21:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:47560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cq5gF-0001Ah-L7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:21:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cq5gC-0003eM-P7
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 22:21:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7D9922E80DA
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 22:21:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Mar 2017 22:14:35 -0000
From: Yongbok Kim <yongbok.kim@imgtec.com>
Reply-To: Bug 1663287 <1663287@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170209154937.3933.99004.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170320221436.22101.88249.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1663287] Re: Illegal delay slot code causes abort
 on mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1663287

Title:
  Illegal delay slot code causes abort on mips64

Status in QEMU:
  Fix Committed

Bug description:
  During some randomised testing of an experimental MIPS implementation
  I found an instruction sequence that also causes aborts on mainline
  qemu's MIPS support.  The problem is triggered by an MSA branch
  instruction appearing in a delay slot when emulating a processor
  without MSA support.

  For example, with the current repository HEAD
  (f073cd3a2bf1054135271b837c58a7da650dd84b) configured for
  mips64-softmmu, if I run the attached binary using

      mips64-softmmu/qemu-system-mips64 -bios ../abort2.bin -machine
  mipssim -nographic

  it will report

      unknown branch 0x13000
      Aborted (core dumped)

  The binary contains the following two instructions:

      00200008 jr at
      47081e61 bz.b       w8,0xffffffffbfc0798c

  The jr sets up a jump, and hflags is set accordingly in
  gen_compute_branch (in target/mips/translate.c).  When processing the
  bz.b, check_insn generates an exception because the instruction isn't
  support, but gen_msa_branch skips the usual delay slot check for the
  same reason, and sets more bits in hflags, leading to an abort in
  gen_branch because the hflags are now invalid.

  I suspect the best fix is to remove the instruction set condition from
  the delay slot check in gen_msa_branch.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1663287/+subscriptions
