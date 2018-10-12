Received: from eggs.gnu.org ([2001:4830:134:3::10]:35835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gB2ju-0002lV-GM
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gB2jq-0003dF-Jn
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gB2jo-0003bC-CZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 12 Oct 2018 15:04:33 -0400
Message-Id: <20181012190434.19477-3-cota@braap.org>
In-Reply-To: <20181012190434.19477-1-cota@braap.org>
References: <20181012190434.19477-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 2/3] tcg: introduce dynamic TLB sizing
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

Disable for all TCG backends for now.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-defs.h  |  43 +++++++++++-
 include/exec/cpu_ldst.h  |  21 ++++++
 tcg/aarch64/tcg-target.h |   1 +
 tcg/arm/tcg-target.h     |   1 +
 tcg/i386/tcg-target.h    |   1 +
 tcg/mips/tcg-target.h    |   1 +
 tcg/ppc/tcg-target.h     |   1 +
 tcg/s390/tcg-target.h    |   1 +
 tcg/sparc/tcg-target.h   |   1 +
 tcg/tci/tcg-target.h     |   1 +
 accel/tcg/cputlb.c       | 138 +++++++++++++++++++++++++++++++++++++--
 11 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 4ff62f32bf..40cd5d4774 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -67,6 +67,19 @@ typedef uint64_t target_ulong;
 #define CPU_TLB_ENTRY_BITS 5
 #endif
 
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+#define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_DEFAULT_BITS 8
+/*
+ * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
+ * 2**34 == 16G of address space. This is roughly what one would expect a
+ * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
+ * Skylake's Level-2 STLB has 16 1G entries.
+ */
+#define CPU_TLB_DYN_MAX_BITS 22
+
+#else /* !TCG_TARGET_IMPLEMENTS_DYN_TLB */
+
 /* TCG_TARGET_TLB_DISPLACEMENT_BITS is used in CPU_TLB_BITS to ensure that
  * the TLB is not unnecessarily small, but still small enough for the
  * TLB lookup instruction sequence used by the TCG target.
@@ -98,6 +111,7 @@ typedef uint64_t target_ulong;
          NB_MMU_MODES <= 8 ? 3 : 4))
 
 #define CPU_TLB_SIZE (1 << CPU_TLB_BITS)
+#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
 
 typedef struct CPUTLBEntry {
     /* bit TARGET_LONG_BITS to TARGET_PAGE_BITS : virtual address
@@ -141,13 +155,36 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
-#define CPU_COMMON_TLB \
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+
+typedef struct CPUTLBDesc {
+    size_t n_used_entries;
+    size_t n_flushes_low_rate;
+} CPUTLBDesc;
+
+#define CPU_TLB                                                         \
+    CPUTLBDesc tlb_desc[NB_MMU_MODES];                                  \
+    /* tlb_mask[i] contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */    \
+    uintptr_t tlb_mask[NB_MMU_MODES];                                   \
+    CPUTLBEntry *tlb_table[NB_MMU_MODES];
+
+#define CPU_IOTLB                               \
+    CPUIOTLBEntry *iotlb[NB_MMU_MODES];
+#else
+#define CPU_TLB                                         \
+    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];
+
+#define CPU_IOTLB                                       \
+    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];
+#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
+
+#define CPU_COMMON_TLB                                                  \
     /* The meaning of the MMU modes is defined in the target code. */   \
     /* tlb_lock serializes updates to tlb_table and tlb_v_table */      \
     QemuSpin tlb_lock;                                                  \
-    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
+    CPU_TLB                                                             \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
-    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
+    CPU_IOTLB                                                           \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
     size_t tlb_flush_count;                                             \
     target_ulong tlb_flush_addr;                                        \
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index e3d8d738aa..91f29c1188 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -126,6 +126,21 @@ extern __thread uintptr_t helper_retaddr;
 /* The memory helpers for tcg-generated code need tcg_target_long etc.  */
 #include "tcg.h"
 
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+/* Find the TLB index corresponding to the mmu_idx + address pair.  */
+static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
+                                  target_ulong addr)
+{
+    uintptr_t size_mask = env->tlb_mask[mmu_idx] >> CPU_TLB_ENTRY_BITS;
+
+    return (addr >> TARGET_PAGE_BITS) & size_mask;
+}
+
+static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
+{
+    return (env->tlb_mask[mmu_idx] >> CPU_TLB_ENTRY_BITS) + 1;
+}
+#else
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
                                   target_ulong addr)
@@ -133,6 +148,12 @@ static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
     return (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
 }
 
+static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
+{
+    return CPU_TLB_SIZE;
+}
+#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
+
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
                                      target_ulong addr)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9aea1d1771..3060d83d14 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -15,6 +15,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #undef TCG_TARGET_STACK_GROWSUP
 
 typedef enum {
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 94b3578c55..0e8b79d20f 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -60,6 +60,7 @@ extern int arm_arch;
 #undef TCG_TARGET_STACK_GROWSUP
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 typedef enum {
     TCG_REG_R0 = 0,
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 9fdf37f23c..9e4bfa90d1 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -27,6 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index a8222476f0..a97f31113e 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -37,6 +37,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index be52ad1d2e..8f03328af4 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,6 +34,7 @@
 #define TCG_TARGET_NB_REGS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 6f2b06a7d1..df92f3065a 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -27,6 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 typedef enum TCGReg {
     TCG_REG_R0 = 0,
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index d8339bf010..975ddc7b0d 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -29,6 +29,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 26140d78cb..bcfd8d69e6 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -43,6 +43,7 @@
 #define TCG_TARGET_INTERPRETER 1
 #define TCG_TARGET_INSN_UNIT_SIZE 1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 #if UINTPTR_MAX == UINT32_MAX
 # define TCG_TARGET_REG_BITS 32
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6ee18308d5..b7bc4bb32f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -74,11 +74,128 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
+{
+    return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_ENTRY_BITS);
+}
+
+static void tlb_dyn_init(CPUArchState *env)
+{
+    int i;
+
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
+
+        env->tlb_desc[i].n_used_entries = 0;
+        env->tlb_desc[i].n_flushes_low_rate = 0;
+        env->tlb_mask[i] = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
+        env->tlb_table[i] = g_new(CPUTLBEntry, n_entries);
+        env->iotlb[i] = g_new(CPUIOTLBEntry, n_entries);
+    }
+}
+
+/*
+ * Perform the resizing only on flushes, otherwise we'd have to take a perf
+ * hit by either rehashing the array or unnecessarily flushing it.
+ *
+ * We grow the array aggressively, and reduce the size more slowly. This
+ * accommodates mixed workloads, where some processes might be memory-heavy
+ * while others might not.
+ *
+ * Called with tlb_lock held.
+ */
+static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
+{
+    CPUTLBDesc *desc = &env->tlb_desc[mmu_idx];
+    size_t old_size = tlb_n_entries(env, mmu_idx);
+    size_t rate = desc->n_used_entries * 100 / old_size;
+    size_t new_size = old_size;
+
+    if (rate == 100) {
+        new_size = MIN(old_size << 2, 1 << CPU_TLB_DYN_MAX_BITS);
+    } else if (rate > 70) {
+        new_size = MIN(old_size << 1, 1 << CPU_TLB_DYN_MAX_BITS);
+    } else if (rate < 30) {
+        desc->n_flushes_low_rate++;
+        if (desc->n_flushes_low_rate == 100) {
+            new_size = MAX(old_size >> 1, 1 << CPU_TLB_DYN_MIN_BITS);
+            desc->n_flushes_low_rate = 0;
+        }
+    }
+
+    if (new_size == old_size) {
+        return;
+    }
+    g_free(env->tlb_table[mmu_idx]);
+    g_free(env->iotlb[mmu_idx]);
+
+    /* desc->n_used_entries is cleared by the caller */
+    desc->n_flushes_low_rate = 0;
+    env->tlb_mask[mmu_idx] = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+    env->tlb_table[mmu_idx] = g_new(CPUTLBEntry, new_size);
+    env->iotlb[mmu_idx] = g_new(CPUIOTLBEntry, new_size);
+}
+
+static inline void tlb_table_flush(CPUArchState *env)
+{
+    int i;
+
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        tlb_mmu_resize_locked(env, i);
+        memset(env->tlb_table[i], -1, sizeof_tlb(env, i));
+        env->tlb_desc[i].n_used_entries = 0;
+    }
+}
+
+static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
+{
+    tlb_mmu_resize_locked(env, mmu_idx);
+    memset(env->tlb_table[mmu_idx], -1, sizeof_tlb(env, mmu_idx));
+    env->tlb_desc[mmu_idx].n_used_entries = 0;
+}
+
+static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
+{
+    env->tlb_desc[mmu_idx].n_used_entries++;
+}
+
+static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
+{
+    env->tlb_desc[mmu_idx].n_used_entries--;
+}
+
+#else /* !TCG_TARGET_IMPLEMENTS_DYN_TLB */
+
+static inline void tlb_dyn_init(CPUArchState *env)
+{
+}
+
+static inline void tlb_table_flush(CPUArchState *env)
+{
+    memset(env->tlb_table, -1, sizeof(env->tlb_table));
+}
+
+static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
+{
+    memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+}
+
+static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
+{
+}
+
+static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
+{
+}
+#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
+
 void tlb_init(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
 
     qemu_spin_init(&env->tlb_lock);
+    tlb_dyn_init(env);
 }
 
 /* flush_all_helper: run fn across all cpus
@@ -140,7 +257,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
      * that do not hold the lock are performed by the same owner thread.
      */
     qemu_spin_lock(&env->tlb_lock);
-    memset(env->tlb_table, -1, sizeof(env->tlb_table));
+    tlb_table_flush(env);
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     qemu_spin_unlock(&env->tlb_lock);
 
@@ -201,7 +318,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
             tlb_debug("%d\n", mmu_idx);
 
-            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+            tlb_table_flush_by_mmuidx(env, mmu_idx);
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
         }
     }
@@ -263,12 +380,14 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
 }
 
 /* Called with tlb_lock held */
-static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
+static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
                                           target_ulong page)
 {
     if (tlb_hit_page_anyprot(tlb_entry, page)) {
         memset(tlb_entry, -1, sizeof(*tlb_entry));
+        return true;
     }
+    return false;
 }
 
 /* Called with tlb_lock held */
@@ -279,7 +398,9 @@ static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
 
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
-        tlb_flush_entry_locked(&env->tlb_v_table[mmu_idx][k], page);
+        if (tlb_flush_entry_locked(&env->tlb_v_table[mmu_idx][k], page)) {
+            tlb_n_used_entries_dec(env, mmu_idx);
+        }
     }
 }
 
@@ -306,7 +427,9 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     addr &= TARGET_PAGE_MASK;
     qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr);
+        if (tlb_flush_entry_locked(tlb_entry(env, mmu_idx, addr), addr)) {
+            tlb_n_used_entries_dec(env, mmu_idx);
+        }
         tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
     }
     qemu_spin_unlock(&env->tlb_lock);
@@ -524,8 +647,9 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
+        unsigned int n = tlb_n_entries(env, mmu_idx);
 
-        for (i = 0; i < CPU_TLB_SIZE; i++) {
+        for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&env->tlb_table[mmu_idx][i], start1,
                                          length);
         }
@@ -685,6 +809,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         /* Evict the old entry into the victim tlb.  */
         copy_tlb_helper_locked(tv, te);
         env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
+        tlb_n_used_entries_dec(env, mmu_idx);
     }
 
     /* refill the tlb */
@@ -736,6 +861,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     }
 
     copy_tlb_helper_locked(te, &tn);
+    tlb_n_used_entries_inc(env, mmu_idx);
     qemu_spin_unlock(&env->tlb_lock);
 }
 
-- 
2.17.1
