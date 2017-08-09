Received: from eggs.gnu.org ([2001:4830:134:3::10]:46683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2V-0006Dg-Gr
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2S-0003zO-EJ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Aug 2017 17:03:52 +1000
Message-Id: <20170809070357.28723-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170809070357.28723-1-david@gibson.dropbear.id.au>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/6] booke206: fix MAS update on tlb miss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, KONRAD Frederic <frederic.konrad@adacore.com>, David Gibson <david@gibson.dropbear.id.au>

From: KONRAD Frederic <frederic.konrad@adacore.com>

When a tlb instruction miss happen, rw is set to 0 at the bottom
of cpu_ppc_handle_mmu_fault which cause the MAS update function to miss
the SAS and TS bit in MAS6, MAS1 in booke206_update_mas_tlb_miss.

Just calling booke206_update_mas_tlb_miss with rw = 2 solve the issue.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b7b9088842..f06b9382b4 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1551,7 +1551,7 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *env, target_ulong address,
                     env->spr[SPR_40x_ESR] = 0x00000000;
                     break;
                 case POWERPC_MMU_BOOKE206:
-                    booke206_update_mas_tlb_miss(env, address, rw);
+                    booke206_update_mas_tlb_miss(env, address, 2);
                     /* fall through */
                 case POWERPC_MMU_BOOKE:
                     cs->exception_index = POWERPC_EXCP_ITLB;
-- 
2.13.4
