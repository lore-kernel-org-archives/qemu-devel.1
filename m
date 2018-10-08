Received: from eggs.gnu.org ([2001:4830:134:3::10]:39913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9K0g-0007nu-Gn
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9JzG-0001g6-G2
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:05:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9JzE-0001Kr-NT
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:05:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id f29-v6so4679619pff.5
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 18:05:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  7 Oct 2018 18:05:22 -0700
Message-Id: <20181008010522.7885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg: Add tlb_index and tlb_entry helpers
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

Isolate the computation of an index from an address into a
helper before we change that function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Emilio, this should make your dynamic tlb sizing patch 1/6
significantly smaller.


r~

---
 accel/tcg/softmmu_template.h     | 68 +++++++++++++++++---------------
 include/exec/cpu_ldst.h          | 14 +++++++
 include/exec/cpu_ldst_template.h | 25 ++++++------
 accel/tcg/cputlb.c               | 60 +++++++++++++---------------
 4 files changed, 90 insertions(+), 77 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index f060a693d4..fae901f00d 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -111,9 +111,10 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
 WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, index);
+    target_ulong tlb_addr = entry->ADDR_READ;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
     DATA_TYPE res;
@@ -129,7 +130,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
+        tlb_addr = entry->ADDR_READ;
     }
 
     /* Handle an IO access.  */
@@ -166,7 +167,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
         return res;
     }
 
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+    haddr = addr + entry->addend;
 #if DATA_SIZE == 1
     res = glue(glue(ld, LSUFFIX), _p)((uint8_t *)haddr);
 #else
@@ -179,9 +180,10 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
 WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, index);
+    target_ulong tlb_addr = entry->ADDR_READ;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
     DATA_TYPE res;
@@ -197,7 +199,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
+        tlb_addr = entry->ADDR_READ;
     }
 
     /* Handle an IO access.  */
@@ -234,7 +236,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
         return res;
     }
 
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+    haddr = addr + entry->addend;
     res = glue(glue(ld, LSUFFIX), _be_p)((uint8_t *)haddr);
     return res;
 }
@@ -275,9 +277,10 @@ static inline void glue(io_write, SUFFIX)(CPUArchState *env,
 void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, index);
+    target_ulong tlb_addr = entry->addr_write;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
 
@@ -292,7 +295,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = entry->addr_write & ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -313,16 +316,16 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     if (DATA_SIZE > 1
         && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
                      >= TARGET_PAGE_SIZE)) {
-        int i, index2;
-        target_ulong page2, tlb_addr2;
+        int i;
+        target_ulong page2;
+        CPUTLBEntry *entry2;
     do_unaligned_access:
         /* Ensure the second page is in the TLB.  Note that the first page
            is already guaranteed to be filled, and that the second page
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (!tlb_hit_page(tlb_addr2, page2)
+        entry2 = tlb_entry(env, mmu_idx, page2);
+        if (!tlb_hit_page(entry2->addr_write, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
@@ -340,7 +343,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         return;
     }
 
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+    haddr = addr + entry->addend;
 #if DATA_SIZE == 1
     glue(glue(st, SUFFIX), _p)((uint8_t *)haddr, val);
 #else
@@ -352,9 +355,10 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
 void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    unsigned mmu_idx = get_mmuidx(oi);
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, index);
+    target_ulong tlb_addr = entry->addr_write;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     uintptr_t haddr;
 
@@ -369,7 +373,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+        tlb_addr = entry->addr_write & ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -381,8 +385,8 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
         val = TGT_BE(val);
-        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr,
-                               tlb_addr & TLB_RECHECK);
+        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr,
+                               retaddr, tlb_addr & TLB_RECHECK);
         return;
     }
 
@@ -390,16 +394,16 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     if (DATA_SIZE > 1
         && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
                      >= TARGET_PAGE_SIZE)) {
-        int i, index2;
-        target_ulong page2, tlb_addr2;
+        int i;
+        target_ulong page2;
+        CPUTLBEntry *entry2;
     do_unaligned_access:
         /* Ensure the second page is in the TLB.  Note that the first page
            is already guaranteed to be filled, and that the second page
            cannot evict the first.  */
         page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
-        if (!tlb_hit_page(tlb_addr2, page2)
+        entry2 = tlb_entry(env, mmu_idx, page2);
+        if (!tlb_hit_page(entry2->addr_write, page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
             tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
@@ -417,7 +421,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         return;
     }
 
-    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+    haddr = addr + entry->addend;
     glue(glue(st, SUFFIX), _be_p)((uint8_t *)haddr, val);
 }
 #endif /* DATA_SIZE > 1 */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 41ed0526e2..47aaf21d94 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -126,6 +126,20 @@ extern __thread uintptr_t helper_retaddr;
 /* The memory helpers for tcg-generated code need tcg_target_long etc.  */
 #include "tcg.h"
 
+/* Find the TLB index corresponding to the mmu_idx + address pair.  */
+static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
+                                  target_ulong addr)
+{
+    return (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+}
+
+/* Find the TLB entry corresponding to the mmu_idx + address pair.  */
+static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
+                                     target_ulong addr)
+{
+    return &env->tlb_table[mmu_idx][tlb_index(env, mmu_idx, addr)];
+}
+
 #ifdef MMU_MODE0_SUFFIX
 #define CPU_MMU_INDEX 0
 #define MEMSUFFIX MMU_MODE0_SUFFIX
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 4db2302962..d21a0b59bf 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -81,7 +81,7 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    int page_index;
+    CPUTLBEntry *entry;
     RES_TYPE res;
     target_ulong addr;
     int mmu_idx;
@@ -94,15 +94,15 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 #endif
 
     addr = ptr;
-    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = CPU_MMU_INDEX;
-    if (unlikely(env->tlb_table[mmu_idx][page_index].ADDR_READ !=
+    entry = tlb_entry(env, mmu_idx, addr);
+    if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
         res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
                                                             oi, retaddr);
     } else {
-        uintptr_t hostaddr = addr + env->tlb_table[mmu_idx][page_index].addend;
+        uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
     }
     return res;
@@ -120,7 +120,8 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    int res, page_index;
+    CPUTLBEntry *entry;
+    int res;
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
@@ -132,15 +133,15 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 #endif
 
     addr = ptr;
-    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = CPU_MMU_INDEX;
-    if (unlikely(env->tlb_table[mmu_idx][page_index].ADDR_READ !=
+    entry = tlb_entry(env, mmu_idx, addr);
+    if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
         res = (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
                                MMUSUFFIX)(env, addr, oi, retaddr);
     } else {
-        uintptr_t hostaddr = addr + env->tlb_table[mmu_idx][page_index].addend;
+        uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
     }
     return res;
@@ -162,7 +163,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                  target_ulong ptr,
                                                  RES_TYPE v, uintptr_t retaddr)
 {
-    int page_index;
+    CPUTLBEntry *entry;
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
@@ -174,15 +175,15 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 #endif
 
     addr = ptr;
-    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = CPU_MMU_INDEX;
-    if (unlikely(env->tlb_table[mmu_idx][page_index].addr_write !=
+    entry = tlb_entry(env, mmu_idx, addr);
+    if (unlikely(entry->addr_write !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
         oi = make_memop_idx(SHIFT, mmu_idx);
         glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
                                                      retaddr);
     } else {
-        uintptr_t hostaddr = addr + env->tlb_table[mmu_idx][page_index].addend;
+        uintptr_t hostaddr = addr + entry->addend;
         glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
     }
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f4702ce91f..015f9d58dd 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -263,7 +263,6 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
     target_ulong addr = (target_ulong) data.target_ptr;
-    int i;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
@@ -281,9 +280,8 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     }
 
     addr &= TARGET_PAGE_MASK;
-    i = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_flush_entry(&env->tlb_table[mmu_idx][i], addr);
+        tlb_flush_entry(tlb_entry(env, mmu_idx, addr), addr);
         tlb_flush_vtlb_page(env, mmu_idx, addr);
     }
 
@@ -314,17 +312,16 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     target_ulong addr_and_mmuidx = (target_ulong) data.target_ptr;
     target_ulong addr = addr_and_mmuidx & TARGET_PAGE_MASK;
     unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
-    int page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("page:%d addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
-              page, addr, mmu_idx_bitmap);
+    tlb_debug("flush page addr:"TARGET_FMT_lx" mmu_idx:0x%lx\n",
+              addr, mmu_idx_bitmap);
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
-            tlb_flush_entry(&env->tlb_table[mmu_idx][page], addr);
+            tlb_flush_entry(tlb_entry(env, mmu_idx, addr), addr);
             tlb_flush_vtlb_page(env, mmu_idx, addr);
         }
     }
@@ -551,15 +548,13 @@ static inline void tlb_set_dirty1(CPUTLBEntry *tlb_entry, target_ulong vaddr)
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
     CPUArchState *env = cpu->env_ptr;
-    int i;
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
 
     vaddr &= TARGET_PAGE_MASK;
-    i = (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_set_dirty1(&env->tlb_table[mmu_idx][i], vaddr);
+        tlb_set_dirty1(tlb_entry(env, mmu_idx, vaddr), vaddr);
     }
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -661,8 +656,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
                                             paddr_page, xlat, prot, &address);
 
-    index = (vaddr_page >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    te = &env->tlb_table[mmu_idx][index];
+    index = tlb_index(env, mmu_idx, vaddr_page);
+    te = tlb_entry(env, mmu_idx, vaddr_page);
 
     /*
      * Only evict the old entry to the victim tlb if it's for a
@@ -773,16 +768,16 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
          * repeat the MMU check here. This tlb_fill() call might
          * longjump out if this access should cause a guest exception.
          */
-        int index;
+        CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
         tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
 
-        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+        entry = tlb_entry(env, mmu_idx, addr);
+        tlb_addr = entry->addr_read;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
-            uintptr_t haddr = addr + env->tlb_table[mmu_idx][index].addend;
+            uintptr_t haddr = addr + entry->addend;
 
             return ldn_p((void *)haddr, size);
         }
@@ -840,16 +835,16 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
          * repeat the MMU check here. This tlb_fill() call might
          * longjump out if this access should cause a guest exception.
          */
-        int index;
+        CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
         tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 
-        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+        entry = tlb_entry(env, mmu_idx, addr);
+        tlb_addr = entry->addr_write;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
-            uintptr_t haddr = addr + env->tlb_table[mmu_idx][index].addend;
+            uintptr_t haddr = addr + entry->addend;
 
             stn_p((void *)haddr, size, val);
             return;
@@ -924,20 +919,19 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
  */
 tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 {
-    int mmu_idx, index;
+    uintptr_t mmu_idx = cpu_mmu_index(env, true);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     void *p;
 
-    index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    mmu_idx = cpu_mmu_index(env, true);
-    if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr))) {
+    if (unlikely(!tlb_hit(entry->addr_code, addr))) {
         if (!VICTIM_TLB_HIT(addr_code, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
         }
-        assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
+        assert(tlb_hit(entry->addr_code, addr));
     }
 
-    if (unlikely(env->tlb_table[mmu_idx][index].addr_code &
-                 (TLB_RECHECK | TLB_MMIO))) {
+    if (unlikely(entry->addr_code & (TLB_RECHECK | TLB_MMIO))) {
         /*
          * Return -1 if we can't translate and execute from an entire
          * page of RAM here, which will cause us to execute by loading
@@ -949,7 +943,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
         return -1;
     }
 
-    p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
+    p = (void *)((uintptr_t)addr + entry->addend);
     return qemu_ram_addr_from_host_nofail(p);
 }
 
@@ -962,10 +956,10 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr)
 {
-    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
 
-    if (!tlb_hit(tlb_addr, addr)) {
+    if (!tlb_hit(entry->addr_write, addr)) {
         /* TLB entry is for a different page */
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
@@ -981,8 +975,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
                                NotDirtyInfo *ndi)
 {
     size_t mmu_idx = get_mmuidx(oi);
-    size_t index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    CPUTLBEntry *tlbe = &env->tlb_table[mmu_idx][index];
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr = tlbe->addr_write;
     TCGMemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
-- 
2.17.1
