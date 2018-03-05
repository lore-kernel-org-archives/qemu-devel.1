Received: from eggs.gnu.org ([2001:4830:134:3::10]:34864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1esnlv-0007Vh-R7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1esnlr-0007kI-72
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:55:11 -0500
From: wei.guo.simon@gmail.com
Date: Mon,  5 Mar 2018 18:53:48 +0800
Message-Id: <1520247228-15496-1-git-send-email-wei.guo.simon@gmail.com>
Subject: [Qemu-devel] [PATCH v2] PowerPC: Add TS bits into msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Simon Guo <wei.guo.simon@gmail.com>

From: Simon Guo <wei.guo.simon@gmail.com>

During migration, after MSR bits is synced, cpu_post_load() will use
msr_mask to determine which PPC MSR bits will be applied into the target
side. Hardware Transaction Memory(HTM) has been supported since Power8,
but TS0/TS1 bit was not in msr_mask yet. That will prevent target KVM
from loading TM checkpointed values.

This patch adds TS bits into msr_mask for Power8, so that transactional
application can be migrated across qemu.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 target/ppc/translate_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 55c99c9..ca06028 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8689,6 +8689,8 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
                     (1ull << MSR_DR) |
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI) |
+                    (1ull << MSR_TS0) |
+                    (1ull << MSR_TS1) |
                     (1ull << MSR_LE);
     pcc->mmu_model = POWERPC_MMU_2_07;
 #if defined(CONFIG_SOFTMMU)
-- 
1.8.3.1
