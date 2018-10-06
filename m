Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uOA-0000An-Eq
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO7-0007IA-Vj
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8uO7-00075R-Nl
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  6 Oct 2018 17:45:03 -0400
Message-Id: <20181006214508.5331-2-cota@braap.org>
In-Reply-To: <20181006214508.5331-1-cota@braap.org>
References: <20181006214508.5331-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 1/6] (XXX) cputlb: separate MMU allocation +
 run-time sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

No dynamic sizing yet, but the indirection is there.

XXX:
- convert other TCG backends

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/softmmu_template.h     | 14 +++++----
 include/exec/cpu-defs.h          | 14 ++++++---
 include/exec/cpu_ldst.h          |  2 +-
 include/exec/cpu_ldst_template.h |  6 ++--
 accel/tcg/cputlb.c               | 49 +++++++++++++++++++++-----------
 tcg/i386/tcg-target.inc.c        | 26 ++++++++---------
 6 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index 1e50263871..3f5a0d4017 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -112,7 +112,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
@@ -180,7 +180,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
@@ -276,7 +276,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
     unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     target_ulong tlb_addr =
         atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
@@ -322,7 +322,8 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
            is already guaranteed to be filled, and that the second page
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        index2 = (page2 >> TARGET_PAGE_BITS) &
+            (env->tlb_desc[mmu_idx].size - 1);
         tlb_addr2 = atomic_read(&env->tlb_table[mmu_idx][index2].addr_write);
         if (!tlb_hit_page(tlb_addr2, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
@@ -355,7 +356,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
     unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     target_ulong tlb_addr =
         atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
     unsigned a_bits = get_alignment_bits(get_memop(oi));
@@ -401,7 +402,8 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
            is already guaranteed to be filled, and that the second page
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        index2 = (page2 >> TARGET_PAGE_BITS) &
+            (env->tlb_desc[mmu_idx].size - 1);
         tlb_addr2 = atomic_read(&env->tlb_table[mmu_idx][index2].addr_write);
         if (!tlb_hit_page(tlb_addr2, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 4ff62f32bf..fa95a4257e 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -141,13 +141,19 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
-#define CPU_COMMON_TLB \
+typedef struct CPUTLBDesc {
+    size_t size;
+    size_t mask; /* (.size - 1) << CPU_TLB_ENTRY_BITS for TLB fast path */
+} CPUTLBDesc;
+
+#define CPU_COMMON_TLB  \
     /* The meaning of the MMU modes is defined in the target code. */   \
-    /* tlb_lock serializes updates to tlb_table and tlb_v_table */      \
+    /* tlb_lock serializes updates to tlb_desc, tlb_table and tlb_v_table */ \
     QemuSpin tlb_lock;                                                  \
-    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];                  \
+    CPUTLBDesc tlb_desc[NB_MMU_MODES];                                  \
+    CPUTLBEntry *tlb_table[NB_MMU_MODES];                               \
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
-    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
+    CPUIOTLBEntry *iotlb[NB_MMU_MODES];                                 \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
     size_t tlb_flush_count;                                             \
     target_ulong tlb_flush_addr;                                        \
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 9581587ce1..df452f5977 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -416,7 +416,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
 #if defined(CONFIG_USER_ONLY)
     return g2h(addr);
 #else
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     CPUTLBEntry *tlbentry = &env->tlb_table[mmu_idx][index];
     abi_ptr tlb_addr;
     uintptr_t haddr;
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index ba7a11123c..6ab9909f46 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -94,8 +94,8 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 #endif
 
     addr = ptr;
-    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = CPU_MMU_INDEX;
+    page_index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     if (unlikely(env->tlb_table[mmu_idx][page_index].ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
@@ -132,8 +132,8 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 #endif
 
     addr = ptr;
-    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = CPU_MMU_INDEX;
+    page_index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     if (unlikely(env->tlb_table[mmu_idx][page_index].ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
@@ -174,8 +174,8 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 #endif
 
     addr = ptr;
-    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = CPU_MMU_INDEX;
+    page_index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     if (unlikely(atomic_read(&env->tlb_table[mmu_idx][page_index].addr_write) !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c7608ccdf8..0b51efc374 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -76,8 +76,17 @@ QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 void tlb_init(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
+    int i;
 
     qemu_spin_init(&env->tlb_lock);
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        CPUTLBDesc *desc = &env->tlb_desc[i];
+
+        desc->size = CPU_TLB_SIZE;
+        desc->mask = (desc->size - 1) << CPU_TLB_ENTRY_BITS;
+        env->tlb_table[i] = g_new(CPUTLBEntry, desc->size);
+        env->iotlb[i] = g_new0(CPUIOTLBEntry, desc->size);
+    }
 }
 
 /* flush_all_helper: run fn across all cpus
@@ -120,6 +129,7 @@ size_t tlb_flush_count(void)
 static void tlb_flush_nocheck(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
+    int i;
 
     /* The QOM tests will trigger tlb_flushes without setting up TCG
      * so we bug out here in that case.
@@ -139,7 +149,10 @@ static void tlb_flush_nocheck(CPUState *cpu)
      * that do not hold the lock are performed by the same owner thread.
      */
     qemu_spin_lock(&env->tlb_lock);
-    memset(env->tlb_table, -1, sizeof(env->tlb_table));
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        memset(env->tlb_table[i], -1,
+               env->tlb_desc[i].size * sizeof(CPUTLBEntry));
+    }
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     qemu_spin_unlock(&env->tlb_lock);
 
@@ -200,7 +213,8 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
             tlb_debug("%d\n", mmu_idx);
 
-            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+            memset(env->tlb_table[mmu_idx], -1,
+                   env->tlb_desc[mmu_idx].size * sizeof(CPUTLBEntry));
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
         }
     }
@@ -286,7 +300,6 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
     target_ulong addr = (target_ulong) data.target_ptr;
-    int i;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
@@ -304,9 +317,10 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     }
 
     addr &= TARGET_PAGE_MASK;
-    i = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        int i = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
+
         tlb_flush_entry_locked(&env->tlb_table[mmu_idx][i], addr);
         tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
     }
@@ -339,16 +353,17 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
     target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
     unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
-    int page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
-              page, addr, mmu_idx_bitmap);
+    tlb_debug("addr: "TARGET_FMT_lx" mmu_idx:0x%lx\n", addr, mmu_idx_bitmap);
 
     qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        int page;
+
+        page = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
             tlb_flush_entry_locked(&env->tlb_table[mmu_idx][page], addr);
             tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
@@ -524,7 +539,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
 
-        for (i = 0; i < CPU_TLB_SIZE; i++) {
+        for (i = 0; i < env->tlb_desc[mmu_idx].size; i++) {
             tlb_reset_dirty_range_locked(&env->tlb_table[mmu_idx][i], start1,
                                          length);
         }
@@ -551,15 +566,15 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
     CPUArchState *env = cpu->env_ptr;
-    int i;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
     vaddr &= TARGET_PAGE_MASK;
-    i = (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     qemu_spin_lock(&env->tlb_lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        int i = (vaddr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
+
         tlb_set_dirty1_locked(&env->tlb_table[mmu_idx][i], vaddr);
     }
 
@@ -660,7 +675,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
                                             paddr_page, xlat, prot, &address);
 
-    index = (vaddr_page >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    index = (vaddr_page >> TARGET_PAGE_BITS) &
+        (env->tlb_desc[mmu_idx].size - 1);
     te = &env->tlb_table[mmu_idx][index];
 
     /*
@@ -788,7 +804,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
         tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
 
-        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
         tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
@@ -855,7 +871,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
         tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 
-        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
         tlb_addr = atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
@@ -943,8 +959,8 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     int mmu_idx, index;
     void *p;
 
-    index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = cpu_mmu_index(env, true);
+    index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr))) {
         if (!VICTIM_TLB_HIT(addr_code, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
@@ -978,7 +994,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr)
 {
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    int index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
     target_ulong tlb_addr =
         atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
 
@@ -998,7 +1014,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
                                NotDirtyInfo *ndi)
 {
     size_t mmu_idx = get_mmuidx(oi);
-    size_t index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    size_t index = (addr >> TARGET_PAGE_BITS) &
+        (env->tlb_desc[mmu_idx].size - 1);
     CPUTLBEntry *tlbe = &env->tlb_table[mmu_idx][index];
     target_ulong tlb_addr = atomic_read(&tlbe->addr_write);
     TCGMemOp mop = get_memop(oi);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 436195894b..fce6a94e22 100644
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
@@ -1633,6 +1634,15 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     }
 
     tcg_out_mov(s, tlbtype, r0, addrlo);
+    tcg_out_shifti(s, SHIFT_SHR + tlbrexw, r0,
+                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+
+    tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, r0, TCG_AREG0,
+                         offsetof(CPUArchState, tlb_desc[mem_index].mask));
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
