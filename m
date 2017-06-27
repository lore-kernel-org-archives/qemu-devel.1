Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPtlh-000719-RC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPsYM-0006DV-CD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:23 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dPsYM-00068y-4M
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:22 -0400
Received: by mail-lf0-x242.google.com with SMTP id g21so3065759lfk.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 08:37:21 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 27 Jun 2017 17:37:11 +0200
Message-Id: <1498577836-25883-3-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
References: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v2 2/7] cputlb: move get_page_addr_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: frederic.konrad@adacore.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This just moves the code before VICTIM_TLB_HIT macro definition
so we can use it.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 accel/tcg/cputlb.c | 70 +++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1cc382d..5d6c755 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
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
2.7.4
