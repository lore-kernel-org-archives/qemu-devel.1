Received: from eggs.gnu.org ([2001:4830:134:3::10]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPtlj-0007u9-DZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPsYL-00068I-1Z
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:22 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dPsYK-000649-QC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:20 -0400
Received: by mail-lf0-x244.google.com with SMTP id f28so3050947lfi.3
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 08:37:20 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 27 Jun 2017 17:37:10 +0200
Message-Id: <1498577836-25883-2-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
References: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v2 1/7] cputlb: cleanup get_page_addr_code to
 use VICTIM_TLB_HIT
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

This replaces env1 and page_index variables by env and index
so we can use VICTIM_TLB_HIT macro later.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 accel/tcg/cputlb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 743776a..1cc382d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
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
2.7.4
