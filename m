Received: from eggs.gnu.org ([2001:4830:134:3::10]:48092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dNpas-00040h-2b
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 20:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dNpao-00065o-VE
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 20:03:30 -0400
Date: Wed, 21 Jun 2017 17:03:08 -0700
From: Aaron Larson <alarson@ddci.com>
Message-Id: <201706220003.v5M038Ns005683@linux03a.ddci.com>
Subject: [Qemu-devel] [PATCH] target-ppc: SPR_BOOKE_ESR not set on FP
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: agraf@suse.de, alarson@ddci.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Properly set the book E exception syndrome register when a floating
point exception occurs.

Currently on a book E processor, the POWERPC_EXCP_FP exception handler
fails to set "env->spr[SPR_BOOKE_ESR] = ESR_FP;" as required by the
book E specification.

Signed-off-by: Aaron Larson <alarson@ddci.com>
---
 target/ppc/excp_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9cb2123..7a82bdd 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -282,6 +282,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
              * precise in the MSR.
              */
             msr |= 0x00100000;
+            env->spr[SPR_BOOKE_ESR] = ESR_FP;
             break;
         case POWERPC_EXCP_INVAL:
             LOG_EXCP("Invalid instruction at " TARGET_FMT_lx "\n", env->nip);
-- 
2.7.4
