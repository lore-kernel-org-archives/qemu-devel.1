Received: from eggs.gnu.org ([2001:4830:134:3::10]:48920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVg-0000pv-Dw
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVe-0001t3-B7
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpVY-0001AM-JZ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id u1-v6so16284474wrn.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:21:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:21:13 +0000
Message-Id: <20181031122119.1669-5-richard.henderson@linaro.org>
In-Reply-To: <20181031122119.1669-1-richard.henderson@linaro.org>
References: <20181031122119.1669-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/10] cputlb: Split large page tracking per
 mmu_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The set of large pages in the kernel is probably not the same
as the set of large pages in the application.  Forcing one
range to cover both will flush more often than necessary.

This allows tlb_flush_page_async_work to flush just the one
mmu_idx implicated, which in turn allows us to remove
tlb_check_page_and_flush_by_mmuidx_async_work.

Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h |  14 +++-
 accel/tcg/cputlb.c      | 138 ++++++++++++++++++----------------------
 2 files changed, 73 insertions(+), 79 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 659c73d2a1..df8ae18d9d 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -141,6 +141,17 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
+typedef struct CPUTLBDesc {
+    /*
+     * Describe a region covering all of the large pages allocated
+     * into the tlb.  When any page within this region is flushed,
+     * we must flush the entire tlb.  The region is matched if
+     * (addr & large_page_mask) == large_page_addr.
+     */
+    target_ulong large_page_addr;
+    target_ulong large_page_mask;
+} CPUTLBDesc;
+
 /*
  * Data elements that are shared between all MMU modes.
  */
@@ -162,13 +173,12 @@ typedef struct CPUTLBCommon {
  */
 #define CPU_COMMON_TLB \
     CPUTLBCommon tlb_c;                                                 \
+    CPUTLBDesc tlb_d[NB_MMU_MODES];                                     \
     CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
     CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
     size_t tlb_flush_count;                                             \
-    target_ulong tlb_flush_addr;                                        \
-    target_ulong tlb_flush_mask;                                        \
     target_ulong vtlb_index;                                            \
 
 #else
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index abcd08a8a2..8060ec99d7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -113,6 +113,14 @@ size_t tlb_flush_count(void)
     return count;
 }
 
+static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
+{
+    memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+    memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+    env->tlb_d[mmu_idx].large_page_addr = -1;
+    env->tlb_d[mmu_idx].large_page_mask = -1;
+}
+
 /* This is OK because CPU architectures generally permit an
  * implementation to drop entries from the TLB at any time, so
  * flushing more entries than required is only an efficiency issue,
@@ -121,6 +129,7 @@ size_t tlb_flush_count(void)
 static void tlb_flush_nocheck(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
+    int mmu_idx;
 
     assert_cpu_is_self(cpu);
     atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
@@ -134,15 +143,14 @@ static void tlb_flush_nocheck(CPUState *cpu)
      */
     qemu_spin_lock(&env->tlb_c.lock);
     env->tlb_c.pending_flush = 0;
-    memset(env->tlb_table, -1, sizeof(env->tlb_table));
-    memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        tlb_flush_one_mmuidx_locked(env, mmu_idx);
+    }
     qemu_spin_unlock(&env->tlb_c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
 
     env->vtlb_index = 0;
-    env->tlb_flush_addr = -1;
-    env->tlb_flush_mask = 0;
 }
 
 static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
@@ -192,25 +200,19 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
+    tlb_debug("mmu_idx:0x%04lx\n", mmu_idx_bitmask);
 
     qemu_spin_lock(&env->tlb_c.lock);
     env->tlb_c.pending_flush &= ~mmu_idx_bitmask;
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
-            tlb_debug("%d\n", mmu_idx);
-
-            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
-            memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+            tlb_flush_one_mmuidx_locked(env, mmu_idx);
         }
     }
     qemu_spin_unlock(&env->tlb_c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
-
-    tlb_debug("done\n");
 }
 
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
@@ -287,6 +289,24 @@ static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
     }
 }
 
+static void tlb_flush_page_locked(CPUArchState *env, int midx,
+                                  target_ulong page)
+{
+    target_ulong lp_addr = env->tlb_d[midx].large_page_addr;
+    target_ulong lp_mask = env->tlb_d[midx].large_page_mask;
+
+    /* Check if we need to flush due to large pages.  */
+    if ((page & lp_mask) == lp_addr) {
+        tlb_debug("forcing full flush midx %d ("
+                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
+                  midx, lp_addr, lp_mask);
+        tlb_flush_one_mmuidx_locked(env, midx);
+    } else {
+        tlb_flush_entry_locked(tlb_entry(env, midx, page), page);
+        tlb_flush_vtlb_page_locked(env, midx, page);
+    }
+}
+
 static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -295,23 +315,12 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page :" TARGET_FMT_lx "\n", addr);
-
-    /* Check if we need to flush due to large pages.  */
-    if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
-        tlb_debug("forcing full flush ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
-                  env->tlb_flush_addr, env->tlb_flush_mask);
-
-        tlb_flush(cpu);
-        return;
-    }
+    tlb_debug("page addr:" TARGET_FMT_lx "\n", addr);
 
     addr &= TARGET_PAGE_MASK;
     qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
-        tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
+        tlb_flush_page_locked(env, mmu_idx, addr);
     }
     qemu_spin_unlock(&env->tlb_c.lock);
 
@@ -346,14 +355,13 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("flush page addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
+    tlb_debug("page addr:" TARGET_FMT_lx " mmu_map:0x%lx\n",
               addr, mmu_idx_bitmap);
 
     qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
-            tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
-            tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
+            tlb_flush_page_locked(env, mmu_idx, addr);
         }
     }
     qemu_spin_unlock(&env->tlb_c.lock);
@@ -361,29 +369,6 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     tb_flush_jmp_cache(cpu, addr);
 }
 
-static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
-                                                          run_on_cpu_data data)
-{
-    CPUArchState *env = cpu->env_ptr;
-    target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
-    target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
-    unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
-
-    tlb_debug("addr:"TARGET_FMT_lx" mmu_idx: %04lx\n", addr, mmu_idx_bitmap);
-
-    /* Check if we need to flush due to large pages.  */
-    if ((addr & env->tlb_flush_mask) == env->tlb_flush_addr) {
-        tlb_debug("forced full flush ("
-                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
-                  env->tlb_flush_addr, env->tlb_flush_mask);
-
-        tlb_flush_by_mmuidx_async_work(cpu,
-                                       RUN_ON_CPU_HOST_INT(mmu_idx_bitmap));
-    } else {
-        tlb_flush_page_by_mmuidx_async_work(cpu, data);
-    }
-}
-
 void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
 {
     target_ulong addr_and_mmu_idx;
@@ -395,10 +380,10 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
     addr_and_mmu_idx |= idxmap;
 
     if (!qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_check_page_and_flush_by_mmuidx_async_work,
+        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_work,
                          RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     } else {
-        tlb_check_page_and_flush_by_mmuidx_async_work(
+        tlb_flush_page_by_mmuidx_async_work(
             cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     }
 }
@@ -406,7 +391,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
 void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
                                        uint16_t idxmap)
 {
-    const run_on_cpu_func fn = tlb_check_page_and_flush_by_mmuidx_async_work;
+    const run_on_cpu_func fn = tlb_flush_page_by_mmuidx_async_work;
     target_ulong addr_and_mmu_idx;
 
     tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
@@ -420,10 +405,10 @@ void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
 }
 
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
-                                                            target_ulong addr,
-                                                            uint16_t idxmap)
+                                              target_ulong addr,
+                                              uint16_t idxmap)
 {
-    const run_on_cpu_func fn = tlb_check_page_and_flush_by_mmuidx_async_work;
+    const run_on_cpu_func fn = tlb_flush_page_by_mmuidx_async_work;
     target_ulong addr_and_mmu_idx;
 
     tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:%"PRIx16"\n", addr, idxmap);
@@ -577,25 +562,26 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 
 /* Our TLB does not support large pages, so remember the area covered by
    large pages and trigger a full TLB flush if these are invalidated.  */
-static void tlb_add_large_page(CPUArchState *env, target_ulong vaddr,
-                               target_ulong size)
+static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
+                               target_ulong vaddr, target_ulong size)
 {
-    target_ulong mask = ~(size - 1);
+    target_ulong lp_addr = env->tlb_d[mmu_idx].large_page_addr;
+    target_ulong lp_mask = ~(size - 1);
 
-    if (env->tlb_flush_addr == (target_ulong)-1) {
-        env->tlb_flush_addr = vaddr & mask;
-        env->tlb_flush_mask = mask;
-        return;
+    if (lp_addr == (target_ulong)-1) {
+        /* No previous large page.  */
+        lp_addr = vaddr;
+    } else {
+        /* Extend the existing region to include the new page.
+           This is a compromise between unnecessary flushes and
+           the cost of maintaining a full variable size TLB.  */
+        lp_mask &= env->tlb_d[mmu_idx].large_page_mask;
+        while (((lp_addr ^ vaddr) & lp_mask) != 0) {
+            lp_mask <<= 1;
+        }
     }
-    /* Extend the existing region to include the new page.
-       This is a compromise between unnecessary flushes and the cost
-       of maintaining a full variable size TLB.  */
-    mask &= env->tlb_flush_mask;
-    while (((env->tlb_flush_addr ^ vaddr) & mask) != 0) {
-        mask <<= 1;
-    }
-    env->tlb_flush_addr &= mask;
-    env->tlb_flush_mask = mask;
+    env->tlb_d[mmu_idx].large_page_addr = lp_addr & lp_mask;
+    env->tlb_d[mmu_idx].large_page_mask = lp_mask;
 }
 
 /* Add a new TLB entry. At most one entry for a given virtual address
@@ -622,12 +608,10 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 
     assert_cpu_is_self(cpu);
 
-    if (size < TARGET_PAGE_SIZE) {
+    if (size <= TARGET_PAGE_SIZE) {
         sz = TARGET_PAGE_SIZE;
     } else {
-        if (size > TARGET_PAGE_SIZE) {
-            tlb_add_large_page(env, vaddr, size);
-        }
+        tlb_add_large_page(env, mmu_idx, vaddr, size);
         sz = size;
     }
     vaddr_page = vaddr & TARGET_PAGE_MASK;
-- 
2.17.2
