Received: from eggs.gnu.org ([2001:4830:134:3::10]:49523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nz-0001Yj-BJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3ny-0004Wa-0j
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:54 +1100
Message-Id: <20180306040154.3669-31-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 30/30] PowerPC: Add TS bits into msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Simon Guo <wei.guo.simon@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Simon Guo <wei.guo.simon@gmail.com>

During migration, after MSR bits is synced, cpu_post_load() will use
msr_mask to determine which PPC MSR bits will be applied into the target
side. Hardware Transaction Memory(HTM) has been supported since Power8,
but TS0/TS1 bit was not in msr_mask yet. That will prevent target KVM
from loading TM checkpointed values.

This patch adds TS bits into msr_mask for Power8, so that transactional
application can be migrated across qemu.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 17a87df654..391b94b97d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8692,6 +8692,8 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
                     (1ull << MSR_DR) |
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI) |
+                    (1ull << MSR_TS0) |
+                    (1ull << MSR_TS1) |
                     (1ull << MSR_LE);
     pcc->mmu_model = POWERPC_MMU_2_07;
 #if defined(CONFIG_SOFTMMU)
-- 
2.14.3
