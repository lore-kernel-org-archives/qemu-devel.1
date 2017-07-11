Received: from eggs.gnu.org ([2001:4830:134:3::10]:40899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxp-0002pn-Qb
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxo-0007ly-Ob
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:05 +1000
Message-Id: <20170711043917.1757-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/17] target-ppc: SPR_BOOKE_ESR not set on FP
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Aaron Larson <alarson@ddci.com>, David Gibson <david@gibson.dropbear.id.au>

From: Aaron Larson <alarson@ddci.com>

Properly set the book E exception syndrome register when a floating
point exception occurs.

Currently on a book E processor, the POWERPC_EXCP_FP exception handler
fails to set "env->spr[SPR_BOOKE_ESR] = ESR_FP;" as required by the
book E specification.

Signed-off-by: Aaron Larson <alarson@ddci.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 3a9f086..e6009e7 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -283,6 +283,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
              * precise in the MSR.
              */
             msr |= 0x00100000;
+            env->spr[SPR_BOOKE_ESR] = ESR_FP;
             break;
         case POWERPC_EXCP_INVAL:
             LOG_EXCP("Invalid instruction at " TARGET_FMT_lx "\n", env->nip);
-- 
2.9.4
