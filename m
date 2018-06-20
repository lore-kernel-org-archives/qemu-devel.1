Received: from eggs.gnu.org ([2001:4830:134:3::10]:50365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVcol-0003Ms-U6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVcoj-00052f-V0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:35 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:06:17 +0100
Message-Id: <20180620130619.11362-2-peter.maydell@linaro.org>
In-Reply-To: <20180620130619.11362-1-peter.maydell@linaro.org>
References: <20180620130619.11362-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Add support for MMU protection regions that are smaller than
TARGET_PAGE_SIZE. We do this by marking the TLB entry for those
pages with a flag TLB_RECHECK. This flag causes us to always
take the slow-path for accesses. In the slow path we can then
special case them to always call tlb_fill() again, so we have
the correct information for the exact address being accessed.

This change allows us to handle reading and writing from small
regions; we cannot deal with execution from the small region.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/softmmu_template.h |  24 ++++---
 include/exec/cpu-all.h       |   5 +-
 accel/tcg/cputlb.c           | 131 +++++++++++++++++++++++++++++------
 3 files changed, 130 insertions(+), 30 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index 239ea6692b4..c47591c9709 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -98,10 +98,12 @@
 static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
                                               size_t mmu_idx, size_t index,
                                               target_ulong addr,
-                                              uintptr_t retaddr)
+                                              uintptr_t retaddr,
+                                              bool recheck)
 {
     CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, DATA_SIZE);
+    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, recheck,
+                    DATA_SIZE);
 }
 #endif
 
@@ -138,7 +140,8 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
 
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
-        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);
+        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
+                                    tlb_addr & TLB_RECHECK);
         res = TGT_LE(res);
         return res;
     }
@@ -205,7 +208,8 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
 
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
-        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr);
+        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
+                                    tlb_addr & TLB_RECHECK);
         res = TGT_BE(res);
         return res;
     }
@@ -259,10 +263,12 @@ static inline void glue(io_write, SUFFIX)(CPUArchState *env,
                                           size_t mmu_idx, size_t index,
                                           DATA_TYPE val,
                                           target_ulong addr,
-                                          uintptr_t retaddr)
+                                          uintptr_t retaddr,
+                                          bool recheck)
 {
     CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, DATA_SIZE);
+    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
+                     recheck, DATA_SIZE);
 }
 
 void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
@@ -298,7 +304,8 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
         val = TGT_LE(val);
-        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
+        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr,
+                               retaddr, tlb_addr & TLB_RECHECK);
         return;
     }
 
@@ -375,7 +382,8 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         /* ??? Note that the io helpers always read data in the target
            byte ordering.  We should push the LE/BE request down into io.  */
         val = TGT_BE(val);
-        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
+        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr,
+                               tlb_addr & TLB_RECHECK);
         return;
     }
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7fa726b8e36..7338f57062f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -330,11 +330,14 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
+/* Set if TLB entry must have MMU lookup repeated for every access */
+#define TLB_RECHECK         (1 << (TARGET_PAGE_BITS - 4))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
-#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO)
+#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
+                         | TLB_RECHECK)
 
 void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
 void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0a721bb9c40..d893452295f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -621,27 +621,42 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     target_ulong code_address;
     uintptr_t addend;
     CPUTLBEntry *te, *tv, tn;
-    hwaddr iotlb, xlat, sz;
+    hwaddr iotlb, xlat, sz, paddr_page;
+    target_ulong vaddr_page;
     unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
 
     assert_cpu_is_self(cpu);
-    assert(size >= TARGET_PAGE_SIZE);
-    if (size != TARGET_PAGE_SIZE) {
-        tlb_add_large_page(env, vaddr, size);
-    }
 
-    sz = size;
-    section = address_space_translate_for_iotlb(cpu, asidx, paddr, &xlat, &sz,
-                                                attrs, &prot);
+    if (size < TARGET_PAGE_SIZE) {
+        sz = TARGET_PAGE_SIZE;
+    } else {
+        if (size > TARGET_PAGE_SIZE) {
+            tlb_add_large_page(env, vaddr, size);
+        }
+        sz = size;
+    }
+    vaddr_page = vaddr & TARGET_PAGE_MASK;
+    paddr_page = paddr & TARGET_PAGE_MASK;
+
+    section = address_space_translate_for_iotlb(cpu, asidx, paddr_page,
+                                                &xlat, &sz, attrs, &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
     tlb_debug("vaddr=" TARGET_FMT_lx " paddr=0x" TARGET_FMT_plx
               " prot=%x idx=%d\n",
               vaddr, paddr, prot, mmu_idx);
 
-    address = vaddr;
-    if (!memory_region_is_ram(section->mr) && !memory_region_is_romd(section->mr)) {
+    address = vaddr_page;
+    if (size < TARGET_PAGE_SIZE) {
+        /*
+         * Slow-path the TLB entries; we will repeat the MMU check and TLB
+         * fill on every access.
+         */
+        address |= TLB_RECHECK;
+    }
+    if (!memory_region_is_ram(section->mr) &&
+        !memory_region_is_romd(section->mr)) {
         /* IO memory case */
         address |= TLB_MMIO;
         addend = 0;
@@ -651,10 +666,10 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     }
 
     code_address = address;
-    iotlb = memory_region_section_get_iotlb(cpu, section, vaddr, paddr, xlat,
-                                            prot, &address);
+    iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
+                                            paddr_page, xlat, prot, &address);
 
-    index = (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    index = (vaddr_page >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     te = &env->tlb_table[mmu_idx][index];
     /* do not discard the translation in te, evict it into a victim tlb */
     tv = &env->tlb_v_table[mmu_idx][vidx];
@@ -670,18 +685,18 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * TARGET_PAGE_BITS, and either
      *  + the ram_addr_t of the page base of the target RAM (if NOTDIRTY or ROM)
      *  + the offset within section->mr of the page base (otherwise)
-     * We subtract the vaddr (which is page aligned and thus won't
+     * We subtract the vaddr_page (which is page aligned and thus won't
      * disturb the low bits) to give an offset which can be added to the
      * (non-page-aligned) vaddr of the eventual memory access to get
      * the MemoryRegion offset for the access. Note that the vaddr we
      * subtract here is that of the page base, and not the same as the
      * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
      */
-    env->iotlb[mmu_idx][index].addr = iotlb - vaddr;
+    env->iotlb[mmu_idx][index].addr = iotlb - vaddr_page;
     env->iotlb[mmu_idx][index].attrs = attrs;
 
     /* Now calculate the new entry */
-    tn.addend = addend - vaddr;
+    tn.addend = addend - vaddr_page;
     if (prot & PAGE_READ) {
         tn.addr_read = address;
     } else {
@@ -702,7 +717,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
             tn.addr_write = address | TLB_MMIO;
         } else if (memory_region_is_ram(section->mr)
                    && cpu_physical_memory_is_clean(
-                        memory_region_get_ram_addr(section->mr) + xlat)) {
+                       memory_region_get_ram_addr(section->mr) + xlat)) {
             tn.addr_write = address | TLB_NOTDIRTY;
         } else {
             tn.addr_write = address;
@@ -775,7 +790,8 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
 
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx,
-                         target_ulong addr, uintptr_t retaddr, int size)
+                         target_ulong addr, uintptr_t retaddr,
+                         bool recheck, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -785,6 +801,29 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    if (recheck) {
+        /*
+         * This is a TLB_RECHECK access, where the MMU protection
+         * covers a smaller range than a target page, and we must
+         * repeat the MMU check here. This tlb_fill() call might
+         * longjump out if this access should cause a guest exception.
+         */
+        int index;
+        target_ulong tlb_addr;
+
+        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+
+        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
+            /* RAM access */
+            uintptr_t haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+            return ldn_p((void *)haddr, size);
+        }
+        /* Fall through for handling IO accesses */
+    }
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -819,7 +858,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       int mmu_idx,
                       uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, int size)
+                      uintptr_t retaddr, bool recheck, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -828,6 +867,30 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    if (recheck) {
+        /*
+         * This is a TLB_RECHECK access, where the MMU protection
+         * covers a smaller range than a target page, and we must
+         * repeat the MMU check here. This tlb_fill() call might
+         * longjump out if this access should cause a guest exception.
+         */
+        int index;
+        target_ulong tlb_addr;
+
+        tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
+
+        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
+            /* RAM access */
+            uintptr_t haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+            stn_p((void *)haddr, size, val);
+            return;
+        }
+        /* Fall through for handling IO accesses */
+    }
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -911,6 +974,32 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
         }
     }
+
+    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
+        /*
+         * This is a TLB_RECHECK access, where the MMU protection
+         * covers a smaller range than a target page, and we must
+         * repeat the MMU check here. This tlb_fill() call might
+         * longjump out if this access should cause a guest exception.
+         */
+        int index;
+        target_ulong tlb_addr;
+
+        tlb_fill(cpu, addr, 0, MMU_INST_FETCH, mmu_idx, 0);
+
+        index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
+            /* RAM access. We can't handle this, so for now just stop */
+            cpu_abort(cpu, "Unable to handle guest executing from RAM within "
+                      "a small MPU region at 0x" TARGET_FMT_lx, addr);
+        }
+        /*
+         * Fall through to handle IO accesses (which will almost certainly
+         * also result in failure)
+         */
+    }
+
     iotlbentry = &env->iotlb[mmu_idx][index];
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
@@ -1019,8 +1108,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         tlb_addr = tlbe->addr_write & ~TLB_INVALID_MASK;
     }
 
-    /* Notice an IO access  */
-    if (unlikely(tlb_addr & TLB_MMIO)) {
+    /* Notice an IO access or a needs-MMU-lookup access */
+    if (unlikely(tlb_addr & (TLB_MMIO | TLB_RECHECK))) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */
         goto stop_the_world;
-- 
2.17.1
