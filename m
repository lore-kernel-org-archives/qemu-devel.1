Received: from eggs.gnu.org ([2001:4830:134:3::10]:53161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N9-00029T-Gf
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N5-0006xW-EJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:51 -0400
Received: from greensocs.com ([193.104.36.180]:60044)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N5-0006xM-81
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:47 -0400
From: fred.konrad@greensocs.com
Date: Fri, 28 Apr 2017 16:59:32 +0200
Message-Id: <1493391576-29401-4-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
References: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V3 3/7] cputlb: fix the way get_page_addr_code
 fills the tlb
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
index ad1d983..5f6757e 100644
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
1.8.3.1
