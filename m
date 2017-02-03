Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKV-0004cP-1F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKU-0002fr-6s
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:23 -0500
Received: from greensocs.com ([193.104.36.180]:39070)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKT-0002fR-Qr
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:22 -0500
From: fred.konrad@greensocs.com
Date: Fri,  3 Feb 2017 18:06:35 +0100
Message-Id: <1486141597-13941-4-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [RFC 3/5] cputlb: fix the way get_page_addr_code fills
 the tlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, pbonzini@redhat.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

get_page_addr_code(..) does a cpu_ldub_code to fill the tlb:
This can lead to some side effects if a device is mapped at this address.

So this patch replaces the cpu_memory_ld by a tlb_fill.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 cputlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index b3a5f47..846341e 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -534,8 +534,10 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
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
