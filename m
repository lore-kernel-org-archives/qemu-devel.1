Received: from eggs.gnu.org ([2001:4830:134:3::10]:60102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqm3-0008RT-IS
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqie-0003u4-7W
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEqid-0003oD-OB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id a8-v6so547874wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:03:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 08:02:48 +0100
Message-Id: <20181023070253.6407-7-richard.henderson@linaro.org>
In-Reply-To: <20181023070253.6407-1-richard.henderson@linaro.org>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/10] cputlb: Move env->vtlb_index to
 env->tlb_d.vindex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

The rest of the tlb victim cache is per-tlb,
the next use index should be as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 5 +++--
 accel/tcg/cputlb.c      | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index df8ae18d9d..181c0dbfa4 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -150,6 +150,8 @@ typedef struct CPUTLBDesc {
      */
     target_ulong large_page_addr;
     target_ulong large_page_mask;
+    /* The next index to use in the tlb victim table.  */
+    size_t vindex;
 } CPUTLBDesc;
 
 /*
@@ -178,8 +180,7 @@ typedef struct CPUTLBCommon {
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
     CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
-    size_t tlb_flush_count;                                             \
-    target_ulong vtlb_index;                                            \
+    size_t tlb_flush_count;
 
 #else
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 72b0567f70..d3b37ffa85 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -119,6 +119,7 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
     memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
     env->tlb_d[mmu_idx].large_page_addr = -1;
     env->tlb_d[mmu_idx].large_page_mask = -1;
+    env->tlb_d[mmu_idx].vindex = 0;
 }
 
 /* This is OK because CPU architectures generally permit an
@@ -149,8 +150,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     qemu_spin_unlock(&env->tlb_c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
-
-    env->vtlb_index = 0;
 }
 
 static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
@@ -668,7 +667,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * different page; otherwise just overwrite the stale data.
      */
     if (!tlb_hit_page_anyprot(te, vaddr_page)) {
-        unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
+        unsigned vidx = env->tlb_d[mmu_idx].vindex++ % CPU_VTLB_SIZE;
         CPUTLBEntry *tv = &env->tlb_v_table[mmu_idx][vidx];
 
         /* Evict the old entry into the victim tlb.  */
-- 
2.17.2
