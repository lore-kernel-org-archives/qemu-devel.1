Received: from eggs.gnu.org ([2001:4830:134:3::10]:33812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTItu-0000tf-D3
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTItq-0007Vb-W7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:46 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTItq-0007Sa-QK
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:42 -0400
Received: by mail-qt0-x243.google.com with SMTP id m54so2709631qtb.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:21:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:44 -1000
Message-Id: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 00/27] target/sh4 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

This fixes two problems with atomic operations on sh4,
including an attempt at supporting the user-space atomics
technique used by most sh-linux-user binaries.

Changes since v1:
  * Rebase on Aurelien's recent sh4 patchset.
  * Patch 3,5 split out of patch 6.
  * Patch 4 fixes the sh4-softmmu problem that Aurelien reported.
  * Handle more cases of atomic_fetch_op seen in debian images.
  * More cleanups for register banking.
  * Fix for 64-bit fp memory operations.
  * Tidy illegal instruction checks.
  * Implement fpchg (missing from sh4a)
  * Implement fsrra (had a nop implementation)
  * Use tcg_gen_lookup_and_goto_ptr for simple branches.

Tested with debian unstable bash and our sh-test-0.2.
I do *not* see the crashes that glaubitz reported.
If they're still there I'll need a more complete report.

Full tree is again at

  git://github.com/rth7680/qemu.git tgt-sh4


r~


Richard Henderson (27):
  target/sh4: Use cmpxchg for movco
  target/sh4: Consolidate end-of-TB tests
  target/sh4: Introduce TB_FLAG_ENVFLAGS_MASK
  target/sh4: Keep env->flags clean
  target/sh4: Adjust TB_FLAG_PENDING_MOVCA
  target/sh4: Handle user-space atomics
  target/sh4: Recognize common gUSA sequences
  linux-user/sh4: Notice gUSA regions during signal delivery
  linux-user/sh4: Clean env->flags on signal boundaries
  target/sh4: Hoist register bank selection
  target/sh4: Unify cpu_fregs into FREG
  target/sh4: Pass DisasContext to fpr64 routines
  target/sh4: Hoist fp register bank selection
  target/sh4: Eliminate unused XREG macro
  target/sh4: Merge DREG into fpr64 routines
  target/sh4: Load/store Dr as 64-bit quantities
  target/sh4: Simplify 64-bit fp reg-reg move
  target/sh4: Unify code for CHECK_NOT_DELAY_SLOT
  target/sh4: Unify code for CHECK_PRIVILEGED
  target/sh4: Unify code for CHECK_FPU_ENABLED
  target/sh4: Tidy misc illegal insn checks
  target/sh4: Introduce CHECK_FPSCR_PR_*
  target/sh4: Introduce CHECK_SH4A
  target/sh4: Implement fpchg
  target/sh4: Add missing FPSCR.PR == 0 checks
  target/sh4: Implement fsrra
  target/sh4: Use tcg_gen_lookup_and_goto_ptr

 target/sh4/cpu.h       |  27 +-
 target/sh4/helper.h    |   2 +
 linux-user/signal.c    |  26 ++
 target/sh4/cpu.c       |   2 +-
 target/sh4/op_helper.c |  22 ++
 target/sh4/translate.c | 946 ++++++++++++++++++++++++++++++++++++-------------
 6 files changed, 775 insertions(+), 250 deletions(-)

-- 
2.9.4
