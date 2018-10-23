Received: from eggs.gnu.org ([2001:4830:134:3::10]:60123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqm3-0008Rk-JV
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqid-0003sm-Fq
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEqic-0003hj-8J
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id x6-v6so521592wmc.5
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:02:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 08:02:43 +0100
Message-Id: <20181023070253.6407-2-richard.henderson@linaro.org>
In-Reply-To: <20181023070253.6407-1-richard.henderson@linaro.org>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/10] cputlb: Move tlb_lock to CPUTLBCommon
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

This is the first of several moves to reduce the size of the
CPU_COMMON_TLB macro and improve some locality of refernce.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 17 ++++++++++++---
 accel/tcg/cputlb.c      | 48 ++++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 4ff62f32bf..9005923b4d 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -141,10 +141,21 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
+/*
+ * Data elements that are shared between all MMU modes.
+ */
+typedef struct CPUTLBCommon {
+    /* lock serializes updates to tlb_table and tlb_v_table */
+    QemuSpin lock;
+} CPUTLBCommon;
+
+/*
+ * The meaning of each of the MMU modes is defined in the target code.
+ * Note that NB_MMU_MODES is not yet defined; we can only reference it
+ * within preprocessor defines that will be expanded later.
+ */
 #define CPU_COMMON_TLB \
-    /* The meaning of the MMU modes is defined in the target code. */   \
-    /* tlb_lock serializes updates to tlb_table and tlb_v_table */      \
-    QemuSpin tlb_lock;                                                  \
+    CPUTLBCommon tlb_c;                                                 \
     CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
     CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index af57aca5e4..d4e07056be 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -78,7 +78,7 @@ void tlb_init(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
 
-    qemu_spin_init(&env->tlb_lock);
+    qemu_spin_init(&env->tlb_c.lock);
 }
 
 /* flush_all_helper: run fn across all cpus
@@ -134,15 +134,15 @@ static void tlb_flush_nocheck(CPUState *cpu)
     tlb_debug("(count: %zu)\n", tlb_flush_count());
 
     /*
-     * tlb_table/tlb_v_table updates from any thread must hold tlb_lock.
+     * tlb_table/tlb_v_table updates from any thread must hold tlb_c.lock.
      * However, updates from the owner thread (as is the case here; see the
      * above assert_cpu_is_self) do not need atomic_set because all reads
      * that do not hold the lock are performed by the same owner thread.
      */
-    qemu_spin_lock(&env->tlb_lock);
+    qemu_spin_lock(&env->tlb_c.lock);
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
-    qemu_spin_unlock(&env->tlb_lock);
+    qemu_spin_unlock(&env->tlb_c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
 
@@ -195,7 +195,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
 
-    qemu_spin_lock(&env->tlb_lock);
+    qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
 
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
@@ -205,7 +205,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
         }
     }
-    qemu_spin_unlock(&env->tlb_lock);
+    qemu_spin_unlock(&env->tlb_c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
 
@@ -262,7 +262,7 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
            tlb_hit_page(tlb_entry->addr_code, page);
 }
 
-/* Called with tlb_lock held */
+/* Called with tlb_c.lock held */
 static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
                                           target_ulong page)
 {
@@ -271,7 +271,7 @@ static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
     }
 }
 
-/* Called with tlb_lock held */
+/* Called with tlb_c.lock held */
 static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
                                               target_ulong page)
 {
@@ -304,12 +304,12 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     }
 
     addr &= TARGET_PAGE_MASK;
-    qemu_spin_lock(&env->tlb_lock);
+    qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
         tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
     }
-    qemu_spin_unlock(&env->tlb_lock);
+    qemu_spin_unlock(&env->tlb_c.lock);
 
     tb_flush_jmp_cache(cpu, addr);
 }
@@ -345,14 +345,14 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     tlb_debug("flush page addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
               addr, mmu_idx_bitmap);
 
-    qemu_spin_lock(&env->tlb_lock);
+    qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
             tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
             tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
         }
     }
-    qemu_spin_unlock(&env->tlb_lock);
+    qemu_spin_unlock(&env->tlb_c.lock);
 
     tb_flush_jmp_cache(cpu, addr);
 }
@@ -479,7 +479,7 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
  * te->addr_write with atomic_set. We don't need to worry about this for
  * oversized guests as MTTCG is disabled for them.
  *
- * Called with tlb_lock held.
+ * Called with tlb_c.lock held.
  */
 static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
                                          uintptr_t start, uintptr_t length)
@@ -501,7 +501,7 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
 }
 
 /*
- * Called with tlb_lock held.
+ * Called with tlb_c.lock held.
  * Called only from the vCPU context, i.e. the TLB's owner thread.
  */
 static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
@@ -511,7 +511,7 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
 
 /* This is a cross vCPU call (i.e. another vCPU resetting the flags of
  * the target vCPU).
- * We must take tlb_lock to avoid racing with another vCPU update. The only
+ * We must take tlb_c.lock to avoid racing with another vCPU update. The only
  * thing actually updated is the target TLB entry ->addr_write flags.
  */
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
@@ -521,7 +521,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     int mmu_idx;
 
     env = cpu->env_ptr;
-    qemu_spin_lock(&env->tlb_lock);
+    qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
 
@@ -535,10 +535,10 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
                                          length);
         }
     }
-    qemu_spin_unlock(&env->tlb_lock);
+    qemu_spin_unlock(&env->tlb_c.lock);
 }
 
-/* Called with tlb_lock held */
+/* Called with tlb_c.lock held */
 static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
                                          target_ulong vaddr)
 {
@@ -557,7 +557,7 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
     assert_cpu_is_self(cpu);
 
     vaddr &= TARGET_PAGE_MASK;
-    qemu_spin_lock(&env->tlb_lock);
+    qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         tlb_set_dirty1_locked(tlb_entry(env, mmu_idx, vaddr), vaddr);
     }
@@ -568,7 +568,7 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
             tlb_set_dirty1_locked(&env->tlb_v_table[mmu_idx][k], vaddr);
         }
     }
-    qemu_spin_unlock(&env->tlb_lock);
+    qemu_spin_unlock(&env->tlb_c.lock);
 }
 
 /* Our TLB does not support large pages, so remember the area covered by
@@ -669,7 +669,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * a longer critical section, but this is not a concern since the TLB lock
      * is unlikely to be contended.
      */
-    qemu_spin_lock(&env->tlb_lock);
+    qemu_spin_lock(&env->tlb_c.lock);
 
     /* Make sure there's no cached translation for the new page.  */
     tlb_flush_vtlb_page_locked(env, mmu_idx, vaddr_page);
@@ -736,7 +736,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     }
 
     copy_tlb_helper_locked(te, &tn);
-    qemu_spin_unlock(&env->tlb_lock);
+    qemu_spin_unlock(&env->tlb_c.lock);
 }
 
 /* Add a new TLB entry, but without specifying the memory
@@ -917,11 +917,11 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
             /* Found entry in victim tlb, swap tlb and iotlb.  */
             CPUTLBEntry tmptlb, *tlb = &env->tlb_table[mmu_idx][index];
 
-            qemu_spin_lock(&env->tlb_lock);
+            qemu_spin_lock(&env->tlb_c.lock);
             copy_tlb_helper_locked(&tmptlb, tlb);
             copy_tlb_helper_locked(tlb, vtlb);
             copy_tlb_helper_locked(vtlb, &tmptlb);
-            qemu_spin_unlock(&env->tlb_lock);
+            qemu_spin_unlock(&env->tlb_c.lock);
 
             CPUIOTLBEntry tmpio, *io = &env->iotlb[mmu_idx][index];
             CPUIOTLBEntry *vio = &env->iotlb_v[mmu_idx][vidx];
-- 
2.17.2
