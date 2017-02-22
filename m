Received: from eggs.gnu.org ([2001:4830:134:3::10]:38340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVI-0003HQ-C4
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVD-0008GC-J3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:46 +1100
Message-Id: <20170222063348.32176-42-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 41/43] target-ppc: fix Book-E TLB matching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Alex Zuepke <azu@sysgo.de>, David Gibson <david@gibson.dropbear.id.au>

From: Alex Zuepke <azu@sysgo.de>

The Book-E TLB matching process should bail out early when a TLB
entry matches, but the access permissions are wrong. The CPU
will then raise a DSI error instead of a Data TLB error, as
described for TLB matching in Freescale and IBM documents.

Signed-off-by: Alex Zuepke <azu@sysgo.de>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 172a305..eb2d482 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -825,7 +825,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         tlb = &env->tlb.tlbe[i];
         ret = mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address, rw,
                                  access_type, i);
-        if (!ret) {
+        if (ret != -1) {
             break;
         }
     }
-- 
2.9.3
