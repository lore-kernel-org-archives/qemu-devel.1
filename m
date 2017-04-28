Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N9-00029W-Hl
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N4-0006xB-T1
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:51 -0400
Received: from greensocs.com ([193.104.36.180]:60029)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N4-0006wt-Ht
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:46 -0400
From: fred.konrad@greensocs.com
Date: Fri, 28 Apr 2017 16:59:31 +0200
Message-Id: <1493391576-29401-3-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
References: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V3 2/7] cputlb: move get_page_addr_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, pbonzini@redhat.com, rth@twiddle.net, peter.maydell@linaro.org, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This just moves the code before VICTIM_TLB_HIT macro definition
so we can use it.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>

V2 -> V3:
  * Rebase against cpu_unaligned access recent change.
---
 cputlb.c | 70 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index dcf28f7..ad1d983 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -746,41 +746,6 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
     return ram_addr;
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
-        cpu_unassigned_access(cpu, addr, false, true, 0, 4);
-        /* The CPU's unassigned access hook might have longjumped out
-         * with an exception. If it didn't (or there was no hook) then
-         * we can't proceed further.
-         */
-        report_bad_exec(cpu, addr);
-        exit(1);
-    }
-    p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
-    return qemu_ram_addr_from_host_nofail(p);
-}
-
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          target_ulong addr, uintptr_t retaddr, int size)
 {
@@ -868,6 +833,41 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
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
+        cpu_unassigned_access(cpu, addr, false, true, 0, 4);
+        /* The CPU's unassigned access hook might have longjumped out
+         * with an exception. If it didn't (or there was no hook) then
+         * we can't proceed further.
+         */
+        report_bad_exec(cpu, addr);
+        exit(1);
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
