Received: from eggs.gnu.org ([2001:4830:134:3::10]:53403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezTxw-0000i8-BC
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezTxs-0003M8-VZ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:11:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:43226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ezTxs-0003Lk-Pc
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:11:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ezTxr-0001Kn-Ua
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 21:11:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E4F6A2E8191
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 21:11:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Mar 2018 20:59:48 -0000
From: philmd <1663287@bugs.launchpad.net>
Reply-To: Bug 1663287 <1663287@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170209154937.3933.99004.malonedeb@chaenomeles.canonical.com>
Message-Id: <152183878935.22149.9888114464000751404.launchpad@soybean.canonical.com>
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

** Tags added: mips

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1663287

Title:
  Illegal delay slot code causes abort on mips64

Status in QEMU:
  New

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
