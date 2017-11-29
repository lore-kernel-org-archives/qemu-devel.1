Received: from eggs.gnu.org ([2001:4830:134:3::10]:44630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1eK59U-0004at-KQ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1eK59O-0003sf-Th
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:24:00 -0500
From: Kurban Mallachiev <mallachiev@ispras.ru>
Date: Wed, 29 Nov 2017 19:22:19 +0300
Message-Id: <20171129162219.16288-2-mallachiev@ispras.ru>
In-Reply-To: <20171129162219.16288-1-mallachiev@ispras.ru>
References: <20171129162219.16288-1-mallachiev@ispras.ru>
Subject: [Qemu-devel] [RFC PATCH 1/1] target-ppc: Don't invalidate
 non-supported msr bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Kurban Mallachiev <mallachiev@ispras.ru>

The msr invalidation code (commits 993eb and 2360b) inverts all
bits except MSR_TGPR and MSR_HVB. On non PowerPC 601 processors
this leads to incorrect change of excp_prefix in hreg_store_msr()
function. The problem is that new msr value get multiplied by msr_mask
and inverted msr does not, thus values of MSR_EP bit in new msr value
and inverted msr are distinct, so that excp_prefix changes but should
not.

Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>
---
 target/ppc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 384caee800..96113ee881 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -298,9 +298,9 @@ static int cpu_post_load(void *opaque, int version_id)
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
2.15.0
