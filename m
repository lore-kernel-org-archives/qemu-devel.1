Received: from eggs.gnu.org ([2001:4830:134:3::10]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgh-0000sB-MB
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqge-0005qi-Pw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:27 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:35742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqge-0005qQ-Js
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:24 -0400
Received: by mail-pf0-x232.google.com with SMTP id c22-v6so8321771pfi.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:08 -0700
Message-Id: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/13] target/ppc improve atomic operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

In another patch set this week, I had noticed the old linux-user
do_store_exclusive code was still present.  I had thought that was
dead code that simply hadn't been removed, but it turned out that
we had not completed the transition to tcg atomics for linux-user.

In the process, I discovered that we weren't using atomic operations
for the 128-bit lq, lqarx, and stqcx insns.  These would have simply
produced incorrect results for -smp in system mode.

I tidy the code a bit by making use of MO_ALIGN, which means that
we don't need a separate explicit alignment check.

I use the new min/max atomic operations I added recently for
ARMv8.2-Atomics and RISC-V.

Finally, Power9 has some *really* odd atomic operations in its
l[wd]at and st[wd]at instructions.  We were generating illegal
instruction for these.  I implement them for serial context and
force parallel context to grab the exclusive lock and try again.

Except for the trivial linux-user ll/sc case, I do not have any
code that exercises these instructions.  Perhaps the IBM folk
have something that can test the others?


r~


Richard Henderson (13):
  target/ppc: Add do_unaligned_access hook
  target/ppc: Use atomic load for LQ and LQARX
  target/ppc: Use atomic store for STQ
  target/ppc: Use atomic cmpxchg for STQCX
  target/ppc: Remove POWERPC_EXCP_STCX
  target/ppc: Tidy gen_conditional_store
  target/ppc: Split out gen_load_locked
  target/ppc: Split out gen_ld_atomic
  target/ppc: Split out gen_st_atomic
  target/ppc: Use MO_ALIGN for EXIWX and ECOWX
  target/ppc: Use atomic min/max helpers
  target/ppc: Implement the rest of gen_ld_atomic
  target/ppc: Implement the rest of gen_st_atomic

 target/ppc/cpu.h                |   8 +-
 target/ppc/helper.h             |  11 +
 target/ppc/internal.h           |   5 +
 linux-user/ppc/cpu_loop.c       | 123 ++----
 target/ppc/excp_helper.c        |  18 +-
 target/ppc/mem_helper.c         |  72 +++-
 target/ppc/translate.c          | 648 ++++++++++++++++++++------------
 target/ppc/translate_init.inc.c |   1 +
 8 files changed, 539 insertions(+), 347 deletions(-)

-- 
2.17.1
