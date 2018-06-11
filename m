Received: from eggs.gnu.org ([2001:4830:134:3::10]:60818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSMNK-00017g-TG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSMNJ-0006t5-PS
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fSMNJ-0006nu-GI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:56:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 13:56:33 +0100
Message-Id: <20180611125633.32755-3-peter.maydell@linaro.org>
In-Reply-To: <20180611125633.32755-1-peter.maydell@linaro.org>
References: <20180611125633.32755-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] cputlb: Pass cpu_transaction_failed() the
 correct physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

The API for cpu_transaction_failed() says that it takes the physical
address for the failed transaction. However we were actually passing
it the offset within the target MemoryRegion. We don't currently
have any target CPU implementations of this hook that require the
physical address; fix this bug so we don't get confused if we ever
do add one.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/exec-all.h | 13 ++++++++++--
 accel/tcg/cputlb.c      | 44 +++++++++++++++++++++++++++++------------
 exec.c                  |  5 +++--
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4d09eaba72d..aed55aaaa7d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -437,8 +437,17 @@ void tb_lock_reset(void);
 
 #if !defined(CONFIG_USER_ONLY)
 
-struct MemoryRegion *iotlb_to_region(CPUState *cpu,
-                                     hwaddr index, MemTxAttrs attrs);
+/**
+ * iotlb_to_section:
+ * @cpu: CPU performing the access
+ * @index: TCG CPU IOTLB entry
+ *
+ * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
+ * it refers to. @index will have been initially created and returned
+ * by memory_region_section_get_iotlb().
+ */
+struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+                                             hwaddr index, MemTxAttrs attrs);
 
 void tlb_fill(CPUState *cpu, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 355ded27024..77aa982cfd8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -777,13 +777,16 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          target_ulong addr, uintptr_t retaddr, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    hwaddr physaddr = iotlbentry->addr;
-    MemoryRegion *mr = iotlb_to_region(cpu, physaddr, iotlbentry->attrs);
+    hwaddr mr_offset;
+    MemoryRegionSection *section;
+    MemoryRegion *mr;
     uint64_t val;
     bool locked = false;
     MemTxResult r;
 
-    physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
+    section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
+    mr = section->mr;
+    mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
     if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
@@ -795,9 +798,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_read(mr, physaddr,
+    r = memory_region_dispatch_read(mr, mr_offset,
                                     &val, size, iotlbentry->attrs);
     if (r != MEMTX_OK) {
+        hwaddr physaddr = mr_offset +
+            section->offset_within_address_space -
+            section->offset_within_region;
+
         cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_LOAD,
                                mmu_idx, iotlbentry->attrs, r, retaddr);
     }
@@ -814,12 +821,15 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       uintptr_t retaddr, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    hwaddr physaddr = iotlbentry->addr;
-    MemoryRegion *mr = iotlb_to_region(cpu, physaddr, iotlbentry->attrs);
+    hwaddr mr_offset;
+    MemoryRegionSection *section;
+    MemoryRegion *mr;
     bool locked = false;
     MemTxResult r;
 
-    physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
+    section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
+    mr = section->mr;
+    mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
     if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
@@ -830,9 +840,13 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_write(mr, physaddr,
+    r = memory_region_dispatch_write(mr, mr_offset,
                                      val, size, iotlbentry->attrs);
     if (r != MEMTX_OK) {
+        hwaddr physaddr = mr_offset +
+            section->offset_within_address_space -
+            section->offset_within_region;
+
         cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_STORE,
                                mmu_idx, iotlbentry->attrs, r, retaddr);
     }
@@ -880,12 +894,13 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
  */
 tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 {
-    int mmu_idx, index, pd;
+    int mmu_idx, index;
     void *p;
     MemoryRegion *mr;
+    MemoryRegionSection *section;
     CPUState *cpu = ENV_GET_CPU(env);
     CPUIOTLBEntry *iotlbentry;
-    hwaddr physaddr;
+    hwaddr physaddr, mr_offset;
 
     index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = cpu_mmu_index(env, true);
@@ -896,8 +911,8 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
         }
     }
     iotlbentry = &env->iotlb[mmu_idx][index];
-    pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
-    mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
+    section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
+    mr = section->mr;
     if (memory_region_is_unassigned(mr)) {
         qemu_mutex_lock_iothread();
         if (memory_region_request_mmio_ptr(mr, addr)) {
@@ -918,7 +933,10 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
          * and use the MemTXResult it produced). However it is the
          * simplest place we have currently available for the check.
          */
-        physaddr = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
+        mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
+        physaddr = mr_offset +
+            section->offset_within_address_space -
+            section->offset_within_region;
         cpu_transaction_failed(cpu, physaddr, addr, 0, MMU_INST_FETCH, mmu_idx,
                                iotlbentry->attrs, MEMTX_DECODE_ERROR, 0);
 
diff --git a/exec.c b/exec.c
index f6645ede0c2..9cbba6adcd3 100644
--- a/exec.c
+++ b/exec.c
@@ -2897,14 +2897,15 @@ static const MemoryRegionOps readonly_mem_ops = {
     },
 };
 
-MemoryRegion *iotlb_to_region(CPUState *cpu, hwaddr index, MemTxAttrs attrs)
+MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+                                      hwaddr index, MemTxAttrs attrs)
 {
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
     AddressSpaceDispatch *d = atomic_rcu_read(&cpuas->memory_dispatch);
     MemoryRegionSection *sections = d->map.sections;
 
-    return sections[index & ~TARGET_PAGE_MASK].mr;
+    return &sections[index & ~TARGET_PAGE_MASK];
 }
 
 static void io_mem_init(void)
-- 
2.17.1
