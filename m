Received: from eggs.gnu.org ([2001:4830:134:3::10]:53162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N9-00029U-Gy
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N5-0006xH-1N
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:51 -0400
Received: from greensocs.com ([193.104.36.180]:60015)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N4-0006wh-Nc
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:46 -0400
From: fred.konrad@greensocs.com
Date: Fri, 28 Apr 2017 16:59:30 +0200
Message-Id: <1493391576-29401-2-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
References: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V3 1/7] cputlb: cleanup get_page_addr_code to
 use VICTIM_TLB_HIT
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

This replaces env1 and page_index variables by env and index
so we can use VICTIM_TLB_HIT macro later.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 cputlb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index f5d056c..dcf28f7 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -751,21 +751,21 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
  * is actually a ram_addr_t (in system mode; the user mode emulation
  * version of this function returns a guest virtual address).
  */
-tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 {
-    int mmu_idx, page_index, pd;
+    int mmu_idx, index, pd;
     void *p;
     MemoryRegion *mr;
-    CPUState *cpu = ENV_GET_CPU(env1);
+    CPUState *cpu = ENV_GET_CPU(env);
     CPUIOTLBEntry *iotlbentry;
 
-    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-    mmu_idx = cpu_mmu_index(env1, true);
-    if (unlikely(env1->tlb_table[mmu_idx][page_index].addr_code !=
+    index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    mmu_idx = cpu_mmu_index(env, true);
+    if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
                  (addr & TARGET_PAGE_MASK))) {
-        cpu_ldub_code(env1, addr);
+        cpu_ldub_code(env, addr);
     }
-    iotlbentry = &env1->iotlb[mmu_idx][page_index];
+    iotlbentry = &env->iotlb[mmu_idx][index];
     pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
     mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
     if (memory_region_is_unassigned(mr)) {
@@ -777,7 +777,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
         report_bad_exec(cpu, addr);
         exit(1);
     }
-    p = (void *)((uintptr_t)addr + env1->tlb_table[mmu_idx][page_index].addend);
+    p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
     return qemu_ram_addr_from_host_nofail(p);
 }
 
-- 
1.8.3.1
