Received: from eggs.gnu.org ([2001:4830:134:3::10]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceN4u-0002LG-6Y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceN4q-0007RJ-V7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:30:36 -0500
Received: from greensocs.com ([193.104.36.180]:53197)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceN4q-0007OM-Ig
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:30:32 -0500
From: fred.konrad@greensocs.com
Date: Thu, 16 Feb 2017 15:30:08 +0100
Message-Id: <1487255413-14196-3-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1487255413-14196-1-git-send-email-fred.konrad@greensocs.com>
References: <1487255413-14196-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V1 2/7] cputlb: move get_page_addr_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This just moves the code before VICTIM_TLB_HIT macro definition
so we can use it.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 cputlb.c | 72 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 665caea..b3a5f47 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -452,42 +452,6 @@ static void report_bad_exec(CPUState *cpu, target_ulong addr)
     log_cpu_state_mask(LOG_GUEST_ERROR, cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
 }
 
-/* NOTE: this function can trigger an exception */
-/* NOTE2: the returned address is not exactly the physical address: it
- * is actually a ram_addr_t (in system mode; the user mode emulation
- * version of this function returns a guest virtual address).
- */
-tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
-{
-    int mmu_idx, index, pd;
-    void *p;
-    MemoryRegion *mr;
-    CPUState *cpu = ENV_GET_CPU(env);
-    CPUIOTLBEntry *iotlbentry;
-
-    index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    mmu_idx = cpu_mmu_index(env, true);
-    if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
-                 (addr & TARGET_PAGE_MASK))) {
-        cpu_ldub_code(env, addr);
-    }
-    iotlbentry = &env->iotlb[mmu_idx][index];
-    pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
-    mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
-    if (memory_region_is_unassigned(mr)) {
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-
-        if (cc->do_unassigned_access) {
-            cc->do_unassigned_access(cpu, addr, false, true, 0, 4);
-        } else {
-            report_bad_exec(cpu, addr);
-            exit(1);
-        }
-    }
-    p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
-    return qemu_ram_addr_from_host_nofail(p);
-}
-
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          target_ulong addr, uintptr_t retaddr, int size)
 {
@@ -554,6 +518,42 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
   victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
                  (ADDR) & TARGET_PAGE_MASK)
 
+/* NOTE: this function can trigger an exception */
+/* NOTE2: the returned address is not exactly the physical address: it
+ * is actually a ram_addr_t (in system mode; the user mode emulation
+ * version of this function returns a guest virtual address).
+ */
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+{
+    int mmu_idx, index, pd;
+    void *p;
+    MemoryRegion *mr;
+    CPUState *cpu = ENV_GET_CPU(env);
+    CPUIOTLBEntry *iotlbentry;
+
+    index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    mmu_idx = cpu_mmu_index(env, true);
+    if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
+                 (addr & TARGET_PAGE_MASK))) {
+        cpu_ldub_code(env, addr);
+    }
+    iotlbentry = &env->iotlb[mmu_idx][index];
+    pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
+    mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
+    if (memory_region_is_unassigned(mr)) {
+        CPUClass *cc = CPU_GET_CLASS(cpu);
+
+        if (cc->do_unassigned_access) {
+            cc->do_unassigned_access(cpu, addr, false, true, 0, 4);
+        } else {
+            report_bad_exec(cpu, addr);
+            exit(1);
+        }
+    }
+    p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
+    return qemu_ram_addr_from_host_nofail(p);
+}
+
 /* Probe for whether the specified guest write access is permitted.
  * If it is not permitted then an exception will be taken in the same
  * way as if this were a real write access (and we will not return).
-- 
1.8.3.1
