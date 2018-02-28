Received: from eggs.gnu.org ([2001:4830:134:3::10]:57178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1eqquQ-0001qZ-1U
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 20:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1eqquP-0004d9-9k
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 20:51:54 -0500
From: wei.guo.simon@gmail.com
Date: Wed, 28 Feb 2018 09:51:37 +0800
Message-Id: <1519782697-13100-1-git-send-email-wei.guo.simon@gmail.com>
Subject: [Qemu-devel] [PATCH] PowerPC: Add TM bits into msr_mask
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

During migration, cpu_post_load() will use msr_mask to determine which
PPC MSR bits will be sync to the target side. Hardware Transaction
Memory(HTM) has been supported since Power8. This patch adds TM/TS bits
into msr_mask for Power8, so that transactional application can be
migrated across qemu.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 target/ppc/translate_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 55c99c9..a438721 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8689,6 +8689,9 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
                     (1ull << MSR_DR) |
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI) |
+                    (1ull << MSR_TM) |
+                    (1ull << MSR_TS0) |
+                    (1ull << MSR_TS1) |
                     (1ull << MSR_LE);
     pcc->mmu_model = POWERPC_MMU_2_07;
 #if defined(CONFIG_SOFTMMU)
-- 
1.8.3.1
