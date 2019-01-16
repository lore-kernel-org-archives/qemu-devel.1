Received: from eggs.gnu.org ([209.51.188.92]:44032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoZO-0001QR-Uq
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoZM-0001A1-L7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:38 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjoZI-00017i-RY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 16 Jan 2019 12:01:13 -0500
Message-Id: <20190116170114.26802-3-cota@braap.org>
In-Reply-To: <20190116170114.26802-1-cota@braap.org>
References: <20190116170114.26802-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v7 2/3] tcg: introduce dynamic TLB sizing
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

Disabled in all TCG backends for now.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-defs.h  |  57 ++++++++++-
 include/exec/cpu_ldst.h  |  21 ++++
 tcg/aarch64/tcg-target.h |   1 +
 tcg/arm/tcg-target.h     |   1 +
 tcg/i386/tcg-target.h    |   1 +
 tcg/mips/tcg-target.h    |   1 +
 tcg/ppc/tcg-target.h     |   1 +
 tcg/riscv/tcg-target.h   |   1 +
 tcg/s390/tcg-target.h    |   1 +
 tcg/sparc/tcg-target.h   |   1 +
 tcg/tci/tcg-target.h     |   1 +
 accel/tcg/cputlb.c       | 202 ++++++++++++++++++++++++++++++++++++++-
 12 files changed, 282 insertions(+), 7 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 6a60f94a41..191a1e021f 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -67,6 +67,28 @@ typedef uint64_t target_ulong;
 #define CPU_TLB_ENTRY_BITS 5
 #endif
 
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+#define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_DEFAULT_BITS 8
+
+
+# if HOST_LONG_BITS == 32
+/* Make sure we do not require a double-word shift for the TLB load */
+#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
+# else /* HOST_LONG_BITS == 64 */
+/*
+ * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
+ * 2**34 == 16G of address space. This is roughly what one would expect a
+ * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
+ * Skylake's Level-2 STLB has 16 1G entries.
+ * Also, make sure we do not size the TLB past the guest's address space.
+ */
+#  define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+# endif
+
+#else /* !TCG_TARGET_IMPLEMENTS_DYN_TLB */
+
 /* TCG_TARGET_TLB_DISPLACEMENT_BITS is used in CPU_TLB_BITS to ensure that
  * the TLB is not unnecessarily small, but still small enough for the
  * TLB lookup instruction sequence used by the TCG target.
@@ -98,6 +120,7 @@ typedef uint64_t target_ulong;
          NB_MMU_MODES <= 8 ? 3 : 4))
 
 #define CPU_TLB_SIZE (1 << CPU_TLB_BITS)
+#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
 
 typedef struct CPUTLBEntry {
     /* bit TARGET_LONG_BITS to TARGET_PAGE_BITS : virtual address
@@ -141,6 +164,18 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
+/**
+ * struct CPUTLBWindow
+ * @begin_ns: host time (in ns) at the beginning of the time window
+ * @max_entries: maximum number of entries observed in the window
+ *
+ * See also: tlb_mmu_resize_locked()
+ */
+typedef struct CPUTLBWindow {
+    int64_t begin_ns;
+    size_t max_entries;
+} CPUTLBWindow;
+
 typedef struct CPUTLBDesc {
     /*
      * Describe a region covering all of the large pages allocated
@@ -152,6 +187,10 @@ typedef struct CPUTLBDesc {
     target_ulong large_page_mask;
     /* The next index to use in the tlb victim table.  */
     size_t vindex;
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+    CPUTLBWindow window;
+    size_t n_used_entries;
+#endif
 } CPUTLBDesc;
 
 /*
@@ -176,6 +215,20 @@ typedef struct CPUTLBCommon {
     size_t elide_flush_count;
 } CPUTLBCommon;
 
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+# define CPU_TLB                                                        \
+    /* tlb_mask[i] contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */    \
+    uintptr_t tlb_mask[NB_MMU_MODES];                                   \
+    CPUTLBEntry *tlb_table[NB_MMU_MODES];
+# define CPU_IOTLB                              \
+    CPUIOTLBEntry *iotlb[NB_MMU_MODES];
+#else
+# define CPU_TLB                                        \
+    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];
+# define CPU_IOTLB                                      \
+    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];
+#endif
+
 /*
  * The meaning of each of the MMU modes is defined in the target code.
  * Note that NB_MMU_MODES is not yet defined; we can only reference it
@@ -184,9 +237,9 @@ typedef struct CPUTLBCommon {
 #define CPU_COMMON_TLB \
     CPUTLBCommon tlb_c;                                                 \
     CPUTLBDesc tlb_d[NB_MMU_MODES];                                     \
-    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
+    CPU_TLB                                                             \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
-    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
+    CPU_IOTLB                                                           \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];
 
 #else
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 959068495a..83b2907d86 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -135,6 +135,21 @@ static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
 #endif
 }
 
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
@@ -142,6 +157,12 @@ static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
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
index f966a4fcb3..bff91c5aa0 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -15,6 +15,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #undef TCG_TARGET_STACK_GROWSUP
 
 typedef enum {
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 16172f73a3..c5a7064bdc 100644
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
index f378d29568..bd7d37c7ef 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -27,6 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 5cb8672470..8600eefd9a 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -37,6 +37,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 52c1bb04b1..b51854b5cf 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,6 +34,7 @@
 #define TCG_TARGET_NB_REGS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 60918cacb4..1eb032626c 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -33,6 +33,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 853ed6e7aa..394b545369 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -27,6 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 
 typedef enum TCGReg {
     TCG_REG_R0 = 0,
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index a0ed2a3342..dc0a227890 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -29,6 +29,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 086f34e69a..816dc4697c 100644
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
index 10f1150c62..a3a1614f0e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -74,6 +74,187 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+#if TCG_TARGET_IMPLEMENTS_DYN_TLB
+static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
+{
+    return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_ENTRY_BITS);
+}
+
+static void tlb_window_reset(CPUTLBWindow *window, int64_t ns,
+                             size_t max_entries)
+{
+    window->begin_ns = ns;
+    window->max_entries = max_entries;
+}
+
+static void tlb_dyn_init(CPUArchState *env)
+{
+    int i;
+
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        CPUTLBDesc *desc = &env->tlb_d[i];
+        size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
+
+        tlb_window_reset(&desc->window, get_clock_realtime(), 0);
+        desc->n_used_entries = 0;
+        env->tlb_mask[i] = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
+        env->tlb_table[i] = g_new(CPUTLBEntry, n_entries);
+        env->iotlb[i] = g_new(CPUIOTLBEntry, n_entries);
+    }
+}
+
+/**
+ * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if necessary
+ * @env: CPU that owns the TLB
+ * @mmu_idx: MMU index of the TLB
+ *
+ * Called with tlb_lock_held.
+ *
+ * We have two main constraints when resizing a TLB: (1) we only resize it
+ * on a TLB flush (otherwise we'd have to take a perf hit by either rehashing
+ * the array or unnecessarily flushing it), which means we do not control how
+ * frequently the resizing can occur; (2) we don't have access to the guest's
+ * future scheduling decisions, and therefore have to decide the magnitude of
+ * the resize based on past observations.
+ *
+ * In general, a memory-hungry process can benefit greatly from an appropriately
+ * sized TLB, since a guest TLB miss is very expensive. This doesn't mean that
+ * we just have to make the TLB as large as possible; while an oversized TLB
+ * results in minimal TLB miss rates, it also takes longer to be flushed
+ * (flushes can be _very_ frequent), and the reduced locality can also hurt
+ * performance.
+ *
+ * To achieve near-optimal performance for all kinds of workloads, we:
+ *
+ * 1. Aggressively increase the size of the TLB when the use rate of the
+ * TLB being flushed is high, since it is likely that in the near future this
+ * memory-hungry process will execute again, and its memory hungriness will
+ * probably be similar.
+ *
+ * 2. Slowly reduce the size of the TLB as the use rate declines over a
+ * reasonably large time window. The rationale is that if in such a time window
+ * we have not observed a high TLB use rate, it is likely that we won't observe
+ * it in the near future. In that case, once a time window expires we downsize
+ * the TLB to match the maximum use rate observed in the window.
+ *
+ * 3. Try to keep the maximum use rate in a time window in the 30-70% range,
+ * since in that range performance is likely near-optimal. Recall that the TLB
+ * is direct mapped, so we want the use rate to be low (or at least not too
+ * high), since otherwise we are likely to have a significant amount of
+ * conflict misses.
+ */
+static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
+{
+    CPUTLBDesc *desc = &env->tlb_d[mmu_idx];
+    size_t old_size = tlb_n_entries(env, mmu_idx);
+    size_t rate;
+    size_t new_size = old_size;
+    int64_t now = get_clock_realtime();
+    int64_t window_len_ms = 100;
+    int64_t window_len_ns = window_len_ms * 1000 * 1000;
+    bool window_expired = now > desc->window.begin_ns + window_len_ns;
+
+    if (desc->n_used_entries > desc->window.max_entries) {
+        desc->window.max_entries = desc->n_used_entries;
+    }
+    rate = desc->window.max_entries * 100 / old_size;
+
+    if (rate > 70) {
+        new_size = MIN(old_size << 1, 1 << CPU_TLB_DYN_MAX_BITS);
+    } else if (rate < 30 && window_expired) {
+        size_t ceil = pow2ceil(desc->window.max_entries);
+        size_t expected_rate = desc->window.max_entries * 100 / ceil;
+
+        /*
+         * Avoid undersizing when the max number of entries seen is just below
+         * a pow2. For instance, if max_entries == 1025, the expected use rate
+         * would be 1025/2048==50%. However, if max_entries == 1023, we'd get
+         * 1023/1024==99.9% use rate, so we'd likely end up doubling the size
+         * later. Thus, make sure that the expected use rate remains below 70%.
+         * (and since we double the size, that means the lowest rate we'd
+         * expect to get is 35%, which is still in the 30-70% range where
+         * we consider that the size is appropriate.)
+         */
+        if (expected_rate > 70) {
+            ceil *= 2;
+        }
+        new_size = MAX(ceil, 1 << CPU_TLB_DYN_MIN_BITS);
+    }
+
+    if (new_size == old_size) {
+        if (window_expired) {
+            tlb_window_reset(&desc->window, now, desc->n_used_entries);
+        }
+        return;
+    }
+
+    g_free(env->tlb_table[mmu_idx]);
+    g_free(env->iotlb[mmu_idx]);
+
+    tlb_window_reset(&desc->window, now, 0);
+    /* desc->n_used_entries is cleared by the caller */
+    env->tlb_mask[mmu_idx] = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+    env->tlb_table[mmu_idx] = g_try_new(CPUTLBEntry, new_size);
+    env->iotlb[mmu_idx] = g_try_new(CPUIOTLBEntry, new_size);
+    /*
+     * If the allocations fail, try smaller sizes. We just freed some
+     * memory, so going back to half of new_size has a good chance of working.
+     * Increased memory pressure elsewhere in the system might cause the
+     * allocations to fail though, so we progressively reduce the allocation
+     * size, aborting if we cannot even allocate the smallest TLB we support.
+     */
+    while (env->tlb_table[mmu_idx] == NULL || env->iotlb[mmu_idx] == NULL) {
+        if (new_size == (1 << CPU_TLB_DYN_MIN_BITS)) {
+            error_report("%s: %s", __func__, strerror(errno));
+            abort();
+        }
+        new_size = MAX(new_size >> 1, 1 << CPU_TLB_DYN_MIN_BITS);
+        env->tlb_mask[mmu_idx] = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+
+        g_free(env->tlb_table[mmu_idx]);
+        g_free(env->iotlb[mmu_idx]);
+        env->tlb_table[mmu_idx] = g_try_new(CPUTLBEntry, new_size);
+        env->iotlb[mmu_idx] = g_try_new(CPUIOTLBEntry, new_size);
+    }
+}
+
+static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
+{
+    tlb_mmu_resize_locked(env, mmu_idx);
+    memset(env->tlb_table[mmu_idx], -1, sizeof_tlb(env, mmu_idx));
+    env->tlb_d[mmu_idx].n_used_entries = 0;
+}
+
+static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
+{
+    env->tlb_d[mmu_idx].n_used_entries++;
+}
+
+static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
+{
+    env->tlb_d[mmu_idx].n_used_entries--;
+}
+
+#else /* !TCG_TARGET_IMPLEMENTS_DYN_TLB */
+
+static inline void tlb_dyn_init(CPUArchState *env)
+{
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
@@ -82,6 +263,8 @@ void tlb_init(CPUState *cpu)
 
     /* Ensure that cpu_reset performs a full flush.  */
     env->tlb_c.dirty = ALL_MMUIDX_BITS;
+
+    tlb_dyn_init(env);
 }
 
 /* flush_all_helper: run fn across all cpus
@@ -122,7 +305,7 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
 
 static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
-    memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+    tlb_table_flush_by_mmuidx(env, mmu_idx);
     memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
     env->tlb_d[mmu_idx].large_page_addr = -1;
     env->tlb_d[mmu_idx].large_page_mask = -1;
@@ -234,12 +417,14 @@ static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
 }
 
 /* Called with tlb_c.lock held */
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
 
 /* Called with tlb_c.lock held */
@@ -250,7 +435,9 @@ static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
 
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
-        tlb_flush_entry_locked(&env->tlb_v_table[mmu_idx][k], page);
+        if (tlb_flush_entry_locked(&env->tlb_v_table[mmu_idx][k], page)) {
+            tlb_n_used_entries_dec(env, mmu_idx);
+        }
     }
 }
 
@@ -267,7 +454,9 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
                   midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(env, midx);
     } else {
-        tlb_flush_entry_locked(tlb_entry(env, midx, page), page);
+        if (tlb_flush_entry_locked(tlb_entry(env, midx, page), page)) {
+            tlb_n_used_entries_dec(env, midx);
+        }
         tlb_flush_vtlb_page_locked(env, midx, page);
     }
 }
@@ -444,8 +633,9 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     qemu_spin_lock(&env->tlb_c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
+        unsigned int n = tlb_n_entries(env, mmu_idx);
 
-        for (i = 0; i < CPU_TLB_SIZE; i++) {
+        for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&env->tlb_table[mmu_idx][i], start1,
                                          length);
         }
@@ -607,6 +797,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         /* Evict the old entry into the victim tlb.  */
         copy_tlb_helper_locked(tv, te);
         env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
+        tlb_n_used_entries_dec(env, mmu_idx);
     }
 
     /* refill the tlb */
@@ -658,6 +849,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     }
 
     copy_tlb_helper_locked(te, &tn);
+    tlb_n_used_entries_inc(env, mmu_idx);
     qemu_spin_unlock(&env->tlb_c.lock);
 }
 
-- 
2.17.1
