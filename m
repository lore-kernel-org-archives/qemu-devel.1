Received: from eggs.gnu.org ([2001:4830:134:3::10]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMl-0005kF-S4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMj-00013U-4Q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:03 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dLCMi-00013E-Sz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:01 -0400
Received: by mail-lf0-x243.google.com with SMTP id o28so970535lfk.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:46:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 14 Jun 2017 19:45:49 +0200
Message-Id: <1497462353-3432-4-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 3/7] cputlb: fix the way get_page_addr_code
 fills the tlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: fred.konrad@greensocs.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

get_page_addr_code(..) does a cpu_ldub_code to fill the tlb:
This can lead to some side effects if a device is mapped at this address.

So this patch replaces the cpu_memory_ld by a tlb_fill.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 cputlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 5d6c755..95265a0 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -849,8 +849,10 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = cpu_mmu_index(env, true);
     if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
-                 (addr & TARGET_PAGE_MASK))) {
-        cpu_ldub_code(env, addr);
+                 (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {
+        if (!VICTIM_TLB_HIT(addr_read, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, MMU_INST_FETCH, mmu_idx, 0);
+        }
     }
     iotlbentry = &env->iotlb[mmu_idx][index];
     pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
-- 
2.7.4
