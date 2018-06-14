Received: from eggs.gnu.org ([2001:4830:134:3::10]:37241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyt-0007EO-Ck
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyp-000622-Cb
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:27 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyp-00061a-6j
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:23 -0400
Received: by mail-pg0-x244.google.com with SMTP id c9-v6so3364501pgf.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:45 -1000
Message-Id: <20180614193147.29680-17-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/18] cputlb: remove tb_lock from tlb_flush
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The acquisition of tb_lock was added when the async tlb_flush
was introduced in e3b9ca810 ("cputlb: introduce tlb_flush_* async work.")

tb_lock was there to allow us to do memset() on the tb_jmp_cache's.
However, since f3ced3c5928 ("tcg: consistently access cpu->tb_jmp_cache
atomically") all accesses to tb_jmp_cache are atomic, so tb_lock
is not needed here. Get rid of it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 05439039e9..f5c3a0926f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -125,8 +125,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
     tlb_debug("(count: %zu)\n", tlb_flush_count());
 
-    tb_lock();
-
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     cpu_tb_jmp_cache_clear(cpu);
@@ -135,8 +133,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     env->tlb_flush_addr = -1;
     env->tlb_flush_mask = 0;
 
-    tb_unlock();
-
     atomic_mb_set(&cpu->pending_tlb_flush, 0);
 }
 
@@ -180,8 +176,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     assert_cpu_is_self(cpu);
 
-    tb_lock();
-
     tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -197,8 +191,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     cpu_tb_jmp_cache_clear(cpu);
 
     tlb_debug("done\n");
-
-    tb_unlock();
 }
 
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
-- 
2.17.1
