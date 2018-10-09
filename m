Received: from eggs.gnu.org ([2001:4830:134:3::10]:52493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5c-00035v-14
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5X-0005oc-Vj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9w5X-0005nU-H8
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  9 Oct 2018 13:45:56 -0400
Message-Id: <20181009174557.16125-6-cota@braap.org>
In-Reply-To: <20181009174557.16125-1-cota@braap.org>
References: <20181009174557.16125-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 5/6] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Currently we rely on atomic operations for cross-CPU invalidations.
There are two cases that these atomics miss: cross-CPU invalidations
can race with either (1) vCPU threads flushing their TLB, which
happens via memset, or (2) vCPUs calling tlb_reset_dirty on their TLB,
which updates .addr_write with a regular store. This results in
undefined behaviour, since we're mixing regular and atomic ops
on concurrent accesses.

Fix it by using tlb_lock, a per-vCPU lock. All updaters of tlb_table
and the corresponding victim cache now hold the lock.
The readers that do not hold tlb_lock must use atomic reads when
reading .addr_write, since this field can be updated by other threads;
the conversion to atomic reads is done in the next patch.

Note that an alternative fix would be to expand the use of atomic ops.
However, in the case of TLB flushes this would have a huge performance
impact, since (1) TLB flushes can happen very frequently and (2) we
currently use a full memory barrier to flush each TLB entry, and a TLB
has many entries. Instead, acquiring the lock is barely slower than a
full memory barrier since it is uncontended, and with a single lock
acquisition we can flush the entire TLB.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-defs.h |   3 +
 accel/tcg/cputlb.c      | 155 ++++++++++++++++++++++------------------
 2 files changed, 87 insertions(+), 71 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index a171ffc1a4..4ff62f32bf 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -24,6 +24,7 @@
 #endif
 
 #include "qemu/host-utils.h"
+#include "qemu/thread.h"
 #include "qemu/queue.h"
 #ifdef CONFIG_TCG
 #include "tcg-target.h"
@@ -142,6 +143,8 @@ typedef struct CPUIOTLBEntry {
 
 #define CPU_COMMON_TLB \
     /* The meaning of the MMU modes is defined in the target code. */   \
+    /* tlb_lock serializes updates to tlb_table and tlb_v_table */      \
+    QemuSpin tlb_lock;                                                  \
     CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
     CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f6b388c961..c2a6190674 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -75,6 +75,9 @@ QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 
 void tlb_init(CPUState *cpu)
 {
+    CPUArchState *env = cpu->env_ptr;
+
+    qemu_spin_init(&env->tlb_lock);
 }
 
 /* flush_all_helper: run fn across all cpus
@@ -129,8 +132,17 @@ static void tlb_flush_nocheck(CPUState *cpu)
     atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
     tlb_debug("(count: %zu)\n", tlb_flush_count());
 
+    /*
+     * tlb_table/tlb_v_table updates from any thread must hold tlb_lock.
+     * However, updates from the owner thread (as is the case here; see the
+     * above assert_cpu_is_self) do not need atomic_set because all reads
+     * that do not hold the lock are performed by the same owner thread.
+     */
+    qemu_spin_lock(&env->tlb_lock);
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
+    qemu_spin_unlock(&env->tlb_lock);
+
     cpu_tb_jmp_cache_clear(cpu);
 
     env->vtlb_index = 0;
@@ -182,6 +194,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
 
+    qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
 
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
@@ -191,6 +204,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
         }
     }
+    qemu_spin_unlock(&env->tlb_lock);
 
     cpu_tb_jmp_cache_clear(cpu);
 
@@ -247,19 +261,24 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
            tlb_hit_page(tlb_entry->addr_code, page);
 }
 
-static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong page)
+/* Called with tlb_lock held */
+static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
+                                          target_ulong page)
 {
     if (tlb_hit_page_anyprot(tlb_entry, page)) {
         memset(tlb_entry, -1, sizeof(*tlb_entry));
     }
 }
 
-static inline void tlb_flush_vtlb_page(CPUArchState *env, int mmu_idx,
-                                       target_ulong page)
+/* Called with tlb_lock held */
+static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
+                                              target_ulong page)
 {
     int k;
+
+    assert_cpu_is_self(ENV_GET_CPU(env));
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
-        tlb_flush_entry(&env->tlb_v_table[mmu_idx][k], page);
+        tlb_flush_entry_locked(&env->tlb_v_table[mmu_idx][k], page);
     }
 }
 
@@ -286,10 +305,12 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 
     addr &= TARGET_PAGE_MASK;
     i = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_flush_entry(&env->tlb_table[mmu_idx][i], addr);
-        tlb_flush_vtlb_page(env, mmu_idx, addr);
+        tlb_flush_entry_locked(&env->tlb_table[mmu_idx][i], addr);
+        tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
     }
+    qemu_spin_unlock(&env->tlb_lock);
 
     tb_flush_jmp_cache(cpu, addr);
 }
@@ -326,12 +347,14 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
               page, addr, mmu_idx_bitmap);
 
+    qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
-            tlb_flush_entry(&env->tlb_table[mmu_idx][page], addr);
-            tlb_flush_vtlb_page(env, mmu_idx, addr);
+            tlb_flush_entry_locked(&env->tlb_table[mmu_idx][page], addr);
+            tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
         }
     }
+    qemu_spin_unlock(&env->tlb_lock);
 
     tb_flush_jmp_cache(cpu, addr);
 }
@@ -454,72 +477,44 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
  * most usual is detecting writes to code regions which may invalidate
  * generated code.
  *
- * Because we want other vCPUs to respond to changes straight away we
- * update the te->addr_write field atomically. If the TLB entry has
- * been changed by the vCPU in the mean time we skip the update.
+ * Other vCPUs might be reading their TLBs during guest execution, so we update
+ * te->addr_write with atomic_set. We don't need to worry about this for
+ * oversized guests as MTTCG is disabled for them.
  *
- * As this function uses atomic accesses we also need to ensure
- * updates to tlb_entries follow the same access rules. We don't need
- * to worry about this for oversized guests as MTTCG is disabled for
- * them.
+ * Called with tlb_lock held.
  */
-
-static void tlb_reset_dirty_range(CPUTLBEntry *tlb_entry, uintptr_t start,
-                           uintptr_t length)
+static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
+                                         uintptr_t start, uintptr_t length)
 {
-#if TCG_OVERSIZED_GUEST
     uintptr_t addr = tlb_entry->addr_write;
 
     if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) == 0) {
         addr &= TARGET_PAGE_MASK;
         addr += tlb_entry->addend;
         if ((addr - start) < length) {
+#if TCG_OVERSIZED_GUEST
             tlb_entry->addr_write |= TLB_NOTDIRTY;
-        }
-    }
 #else
-    /* paired with atomic_mb_set in tlb_set_page_with_attrs */
-    uintptr_t orig_addr = atomic_mb_read(&tlb_entry->addr_write);
-    uintptr_t addr = orig_addr;
-
-    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) == 0) {
-        addr &= TARGET_PAGE_MASK;
-        addr += atomic_read(&tlb_entry->addend);
-        if ((addr - start) < length) {
-            uintptr_t notdirty_addr = orig_addr | TLB_NOTDIRTY;
-            atomic_cmpxchg(&tlb_entry->addr_write, orig_addr, notdirty_addr);
+            atomic_set(&tlb_entry->addr_write,
+                       tlb_entry->addr_write | TLB_NOTDIRTY);
+#endif
         }
     }
-#endif
 }
 
-/* For atomic correctness when running MTTCG we need to use the right
- * primitives when copying entries */
-static inline void copy_tlb_helper(CPUTLBEntry *d, CPUTLBEntry *s,
-                                   bool atomic_set)
+/*
+ * Called with tlb_lock held.
+ * Called only from the vCPU context, i.e. the TLB's owner thread.
+ */
+static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
 {
-#if TCG_OVERSIZED_GUEST
     *d = *s;
-#else
-    if (atomic_set) {
-        d->addr_read = s->addr_read;
-        d->addr_code = s->addr_code;
-        atomic_set(&d->addend, atomic_read(&s->addend));
-        /* Pairs with flag setting in tlb_reset_dirty_range */
-        atomic_mb_set(&d->addr_write, atomic_read(&s->addr_write));
-    } else {
-        d->addr_read = s->addr_read;
-        d->addr_write = atomic_read(&s->addr_write);
-        d->addr_code = s->addr_code;
-        d->addend = atomic_read(&s->addend);
-    }
-#endif
 }
 
 /* This is a cross vCPU call (i.e. another vCPU resetting the flags of
- * the target vCPU). As such care needs to be taken that we don't
- * dangerously race with another vCPU update. The only thing actually
- * updated is the target TLB entry ->addr_write flags.
+ * the target vCPU).
+ * We must take tlb_lock to avoid racing with another vCPU update. The only
+ * thing actually updated is the target TLB entry ->addr_write flags.
  */
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 {
@@ -528,22 +523,26 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     int mmu_idx;
 
     env = cpu->env_ptr;
+    qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
 
         for (i = 0; i < CPU_TLB_SIZE; i++) {
-            tlb_reset_dirty_range(&env->tlb_table[mmu_idx][i],
-                                  start1, length);
+            tlb_reset_dirty_range_locked(&env->tlb_table[mmu_idx][i], start1,
+                                         length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range(&env->tlb_v_table[mmu_idx][i],
-                                  start1, length);
+            tlb_reset_dirty_range_locked(&env->tlb_v_table[mmu_idx][i], start1,
+                                         length);
         }
     }
+    qemu_spin_unlock(&env->tlb_lock);
 }
 
-static inline void tlb_set_dirty1(CPUTLBEntry *tlb_entry, target_ulong vaddr)
+/* Called with tlb_lock held */
+static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
+                                         target_ulong vaddr)
 {
     if (tlb_entry->addr_write == (vaddr | TLB_NOTDIRTY)) {
         tlb_entry->addr_write = vaddr;
@@ -562,16 +561,18 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 
     vaddr &= TARGET_PAGE_MASK;
     i = (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_set_dirty1(&env->tlb_table[mmu_idx][i], vaddr);
+        tlb_set_dirty1_locked(&env->tlb_table[mmu_idx][i], vaddr);
     }
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         int k;
         for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1(&env->tlb_v_table[mmu_idx][k], vaddr);
+            tlb_set_dirty1_locked(&env->tlb_v_table[mmu_idx][k], vaddr);
         }
     }
+    qemu_spin_unlock(&env->tlb_lock);
 }
 
 /* Our TLB does not support large pages, so remember the area covered by
@@ -658,9 +659,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
     }
 
-    /* Make sure there's no cached translation for the new page.  */
-    tlb_flush_vtlb_page(env, mmu_idx, vaddr_page);
-
     code_address = address;
     iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
                                             paddr_page, xlat, prot, &address);
@@ -668,6 +666,18 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     index = (vaddr_page >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     te = &env->tlb_table[mmu_idx][index];
 
+    /*
+     * Hold the TLB lock for the rest of the function. We could acquire/release
+     * the lock several times in the function, but it is faster to amortize the
+     * acquisition cost by acquiring it just once. Note that this leads to
+     * a longer critical section, but this is not a concern since the TLB lock
+     * is unlikely to be contended.
+     */
+    qemu_spin_lock(&env->tlb_lock);
+
+    /* Make sure there's no cached translation for the new page.  */
+    tlb_flush_vtlb_page_locked(env, mmu_idx, vaddr_page);
+
     /*
      * Only evict the old entry to the victim tlb if it's for a
      * different page; otherwise just overwrite the stale data.
@@ -677,7 +687,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         CPUTLBEntry *tv = &env->tlb_v_table[mmu_idx][vidx];
 
         /* Evict the old entry into the victim tlb.  */
-        copy_tlb_helper(tv, te, true);
+        copy_tlb_helper_locked(tv, te);
         env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
     }
 
@@ -729,9 +739,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         }
     }
 
-    /* Pairs with flag setting in tlb_reset_dirty_range */
-    copy_tlb_helper(te, &tn, true);
-    /* atomic_mb_set(&te->addr_write, write_address); */
+    copy_tlb_helper_locked(te, &tn);
+    qemu_spin_unlock(&env->tlb_lock);
 }
 
 /* Add a new TLB entry, but without specifying the memory
@@ -895,6 +904,8 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
                            size_t elt_ofs, target_ulong page)
 {
     size_t vidx;
+
+    assert_cpu_is_self(ENV_GET_CPU(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
         target_ulong cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
@@ -903,9 +914,11 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
             /* Found entry in victim tlb, swap tlb and iotlb.  */
             CPUTLBEntry tmptlb, *tlb = &env->tlb_table[mmu_idx][index];
 
-            copy_tlb_helper(&tmptlb, tlb, false);
-            copy_tlb_helper(tlb, vtlb, true);
-            copy_tlb_helper(vtlb, &tmptlb, true);
+            qemu_spin_lock(&env->tlb_lock);
+            copy_tlb_helper_locked(&tmptlb, tlb);
+            copy_tlb_helper_locked(tlb, vtlb);
+            copy_tlb_helper_locked(vtlb, &tmptlb);
+            qemu_spin_unlock(&env->tlb_lock);
 
             CPUIOTLBEntry tmpio, *io = &env->iotlb[mmu_idx][index];
             CPUIOTLBEntry *vio = &env->iotlb_v[mmu_idx][vidx];
-- 
2.17.1
