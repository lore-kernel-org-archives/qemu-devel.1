Received: from eggs.gnu.org ([2001:4830:134:3::10]:49510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYic-00062x-Ie
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYiX-0004Nl-N8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:42 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYiX-0004M5-HJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:37 -0400
Received: by mail-qt0-x241.google.com with SMTP id p25so2577092qtp.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:03:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:25 -1000
Message-Id: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/30] target/sh4 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

The big ticket item in this series is the support for
user-space atomics.  But a lot of other cleanup has
crept in as well.

Changes since v2 incorporate feedback from Aurelien.
I've tried to remember to add individual changelogs
to the patches, but I may have forgotten some.

I do now include the linux-user reserved_va changes
that I posted subsequent to posting v2.

I believe there are only 4 patches that have not 
seen a Reviewed-by yet.


r~


Richard Henderson (30):
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
  tcg: Fix off-by-one in assert in page_set_flags
  linux-user: Tidy and enforce reserved_va initialization
  linux-user/sh4: Reduce TARGET_VIRT_ADDR_SPACE_BITS to 31

 linux-user/arm/target_cpu.h |   4 +
 target/mips/mips-defs.h     |   6 +-
 target/nios2/cpu.h          |   6 +-
 target/sh4/cpu.h            |  33 +-
 target/sh4/helper.h         |   2 +
 accel/tcg/translate-all.c   |   2 +-
 linux-user/main.c           |  39 +-
 linux-user/signal.c         |  33 ++
 target/sh4/cpu.c            |   2 +-
 target/sh4/helper.c         |   2 +-
 target/sh4/op_helper.c      |  22 +
 target/sh4/translate.c      | 975 ++++++++++++++++++++++++++++++++------------
 12 files changed, 839 insertions(+), 287 deletions(-)

-- 
2.9.4
