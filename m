Received: from eggs.gnu.org ([2001:4830:134:3::10]:47937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSo0-0005fm-FZ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSnw-0006xE-Ji
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:45:32 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Tue,  1 Aug 2017 10:44:57 +0200
Message-Id: <1501577097-14248-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [RFC PATCH] booke206: fix MAS update on tlb miss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, frederic.konrad@adacore.com

When a tlb instruction miss happen, rw is set to 0 at the bottom
of cpu_ppc_handle_mmu_fault which cause the MAS update function to miss
the SAS and TS bit in MAS6, MAS1 in booke206_update_mas_tlb_miss.

Just calling booke206_update_mas_tlb_miss with rw = 2 solve the issue.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 target/ppc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b7b9088..f06b938 100644
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
1.8.3.1
