Received: from eggs.gnu.org ([2001:4830:134:3::10]:48333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjn-0005Z0-Nv
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjl-0004Lb-TF
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Dec 2017 14:48:01 +1100
Message-Id: <20171204034802.7336-3-david@gibson.dropbear.id.au>
In-Reply-To: <20171204034802.7336-1-david@gibson.dropbear.id.au>
References: <20171204034802.7336-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/3] target-ppc: Don't invalidate non-supported
 msr bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Kurban Mallachiev <mallachiev@ispras.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Kurban Mallachiev <mallachiev@ispras.ru>

The msr invalidation code (commits 993eb and 2360b) inverts all
bits except MSR_TGPR and MSR_HVB. On non PowerPC 601 processors
this leads to incorrect change of excp_prefix in hreg_store_msr()
function. The problem is that new msr value get multiplied by msr_mask
and inverted msr does not, thus values of MSR_EP bit in new msr value
and inverted msr are distinct, so that excp_prefix changes but should
not.

Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 24117e8f31..e475206c6a 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -300,9 +300,9 @@ static int cpu_post_load(void *opaque, int version_id)
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
     }
 
-    /* Invalidate all msr bits except MSR_TGPR/MSR_HVB before restoring */
+    /* Invalidate all supported msr bits except MSR_TGPR/MSR_HVB before restoring */
     msr = env->msr;
-    env->msr ^= ~((1ULL << MSR_TGPR) | MSR_HVB);
+    env->msr ^= env->msr_mask & ~((1ULL << MSR_TGPR) | MSR_HVB);
     ppc_store_msr(env, msr);
 
     hreg_compute_mem_idx(env);
-- 
2.14.3
