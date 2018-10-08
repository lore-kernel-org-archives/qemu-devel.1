Received: from eggs.gnu.org ([2001:4830:134:3::10]:33903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9ewV-0000fu-Ol
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 19:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9ewS-0000Ul-B0
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 19:28:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9ewR-0000U1-WB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 19:28:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  8 Oct 2018 19:27:53 -0400
Message-Id: <20181008232756.30704-3-cota@braap.org>
In-Reply-To: <20181008232756.30704-1-cota@braap.org>
References: <20181008232756.30704-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 2/5] (XXX) cputlb: introduce indirection for
 TLB size
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

This paves the way for implementing dynamic TLB resizing.

XXX: convert other TCG backends

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-defs.h   | 10 ++++++----
 include/exec/cpu_ldst.h   | 14 +++++++++++++-
 accel/tcg/cputlb.c        | 18 +++++++++++++++---
 tcg/i386/tcg-target.inc.c | 28 ++++++++++++++--------------
 4 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 4ff62f32bf..87cd015f60 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -141,13 +141,15 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
-#define CPU_COMMON_TLB \
+#define CPU_COMMON_TLB  \
     /* The meaning of the MMU modes is defined in the target code. */   \
-    /* tlb_lock serializes updates to tlb_table and tlb_v_table */      \
+    /* tlb_lock serializes updates to tlb_mask, tlb_table and tlb_v_table */ \
     QemuSpin tlb_lock;                                                  \
-    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
+    /* tlb_mask[i] contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */    \
+    uintptr_t tlb_mask[NB_MMU_MODES];                                   \
+    CPUTLBEntry *tlb_table[NB_MMU_MODES];                               \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
-    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
+    CPUIOTLBEntry *iotlb[NB_MMU_MODES];                                 \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
     size_t tlb_flush_count;                                             \
     target_ulong tlb_flush_addr;                                        \
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index e3d8d738aa..3ded1df9b7 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -130,7 +130,9 @@ extern __thread uintptr_t helper_retaddr;
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
                                   target_ulong addr)
 {
-    return (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    uintptr_t size_mask = env->tlb_mask[mmu_idx] >> CPU_TLB_ENTRY_BITS;
+
+    return (addr >> TARGET_PAGE_BITS) & size_mask;
 }
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
@@ -140,6 +142,16 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
     return &env->tlb_table[mmu_idx][tlb_index(env, mmu_idx, addr)];
 }
 
+static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
+{
+    return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_ENTRY_BITS);
+}
+
+static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
+{
+    return (env->tlb_mask[mmu_idx] >> CPU_TLB_ENTRY_BITS) + 1;
+}
+
 #ifdef MMU_MODE0_SUFFIX
 #define CPU_MMU_INDEX 0
 #define MEMSUFFIX MMU_MODE0_SUFFIX
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a5972773de..80406f1033 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -76,8 +76,16 @@ QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 void tlb_init(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
+    int i;
 
     qemu_spin_init(&env->tlb_lock);
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        size_t n_entries = CPU_TLB_SIZE;
+
+        env->tlb_mask[i] = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
+        env->tlb_table[i] = g_new(CPUTLBEntry, n_entries);
+        env->iotlb[i] = g_new0(CPUIOTLBEntry, n_entries);
+    }
 }
 
 /* flush_all_helper: run fn across all cpus
@@ -120,6 +128,7 @@ size_t tlb_flush_count(void)
 static void tlb_flush_nocheck(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
+    int i;
 
     /* The QOM tests will trigger tlb_flushes without setting up TCG
      * so we bug out here in that case.
@@ -139,7 +148,9 @@ static void tlb_flush_nocheck(CPUState *cpu)
      * that do not hold the lock are performed by the same owner thread.
      */
     qemu_spin_lock(&env->tlb_lock);
-    memset(env->tlb_table, -1, sizeof(env->tlb_table));
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        memset(env->tlb_table[i], -1, sizeof_tlb(env, i));
+    }
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     qemu_spin_unlock(&env->tlb_lock);
 
@@ -200,7 +211,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
             tlb_debug("%d\n", mmu_idx);
 
-            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+            memset(env->tlb_table[mmu_idx], -1, sizeof_tlb(env, mmu_idx));
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
         }
     }
@@ -523,8 +534,9 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
+        unsigned int n = tlb_n_entries(env, mmu_idx);
 
-        for (i = 0; i < CPU_TLB_SIZE; i++) {
+        for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&env->tlb_table[mmu_idx][i], start1,
                                          length);
         }
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 436195894b..33de43305a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -330,6 +330,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
 #define OPC_ANDN        (0xf2 | P_EXT38)
 #define OPC_ADD_GvEv	(OPC_ARITH_GvEv | (ARITH_ADD << 3))
+#define OPC_AND_GvEv    (OPC_ARITH_GvEv | (ARITH_AND << 3))
 #define OPC_BLENDPS     (0x0c | P_EXT3A | P_DATA16)
 #define OPC_BSF         (0xbc | P_EXT)
 #define OPC_BSR         (0xbd | P_EXT)
@@ -1625,7 +1626,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         }
         if (TCG_TYPE_PTR == TCG_TYPE_I64) {
             hrexw = P_REXW;
-            if (TARGET_PAGE_BITS + CPU_TLB_BITS > 32) {
+            if (TARGET_PAGE_BITS > 32) {
                 tlbtype = TCG_TYPE_I64;
                 tlbrexw = P_REXW;
             }
@@ -1633,6 +1634,15 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     }
 
     tcg_out_mov(s, tlbtype, r0, addrlo);
+    tcg_out_shifti(s, SHIFT_SHR + tlbrexw, r0,
+                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+
+    tcg_out_modrm_offset(s, OPC_AND_GvEv + hrexw, r0, TCG_AREG0,
+                         offsetof(CPUArchState, tlb_mask[mem_index]));
+
+    tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r0, TCG_AREG0,
+                         offsetof(CPUArchState, tlb_table[mem_index]));
+
     /* If the required alignment is at least as large as the access, simply
        copy the address and mask.  For lesser alignments, check that we don't
        cross pages for the complete access.  */
@@ -1642,20 +1652,10 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         tcg_out_modrm_offset(s, OPC_LEA + trexw, r1, addrlo, s_mask - a_mask);
     }
     tlb_mask = (target_ulong)TARGET_PAGE_MASK | a_mask;
-
-    tcg_out_shifti(s, SHIFT_SHR + tlbrexw, r0,
-                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-
     tgen_arithi(s, ARITH_AND + trexw, r1, tlb_mask, 0);
-    tgen_arithi(s, ARITH_AND + tlbrexw, r0,
-                (CPU_TLB_SIZE - 1) << CPU_TLB_ENTRY_BITS, 0);
-
-    tcg_out_modrm_sib_offset(s, OPC_LEA + hrexw, r0, TCG_AREG0, r0, 0,
-                             offsetof(CPUArchState, tlb_table[mem_index][0])
-                             + which);
 
     /* cmp 0(r0), r1 */
-    tcg_out_modrm_offset(s, OPC_CMP_GvEv + trexw, r1, r0, 0);
+    tcg_out_modrm_offset(s, OPC_CMP_GvEv + trexw, r1, r0, which);
 
     /* Prepare for both the fast path add of the tlb addend, and the slow
        path function argument setup.  There are two cases worth note:
@@ -1672,7 +1672,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 
     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
         /* cmp 4(r0), addrhi */
-        tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, 4);
+        tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, which + 4);
 
         /* jne slow_path */
         tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
@@ -1684,7 +1684,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 
     /* add addend(r0), r1 */
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
-                         offsetof(CPUTLBEntry, addend) - which);
+                         offsetof(CPUTLBEntry, addend));
 }
 
 /*
-- 
2.17.1
