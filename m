Received: from eggs.gnu.org ([2001:4830:134:3::10]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1vN-000684-KW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1vM-0003Q8-Ne
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1vM-0003Q0-I7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DFD461BB0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:02:39 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 17:02:29 +0800
Message-Id: <1500282150-28190-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1500282150-28190-1-git-send-email-peterx@redhat.com>
References: <1500282150-28190-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/2] intel_iommu: fix iova for pt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

IOMMUTLBEntry.iova is returned incorrectly on one PT path (though mostly
we cannot really trigger this path, even if we do, we are mostly
disgarding this value, so it didn't break anything). Fix it by
converting the VTD_PAGE_MASK into the correct definition
VTD_PAGE_MASK_4K, then remove VTD_PAGE_MASK.

Fixes: b93130 ("intel_iommu: cleanup vtd_{do_}iommu_translate()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 4 ++--
 hw/i386/intel_iommu_internal.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e398746..e0b0498 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1139,9 +1139,9 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      * Also, let's ignore IOTLB caching as well for PT devices.
      */
     if (vtd_ce_get_type(&ce) == VTD_CONTEXT_TT_PASS_THROUGH) {
-        entry->iova = addr & VTD_PAGE_MASK;
+        entry->iova = addr & VTD_PAGE_MASK_4K;
         entry->translated_addr = entry->iova;
-        entry->addr_mask = VTD_PAGE_MASK;
+        entry->addr_mask = ~VTD_PAGE_MASK_4K;
         entry->perm = IOMMU_RW;
         trace_vtd_translate_pt(source_id, entry->iova);
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f50ecd8..0e73a65 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -384,7 +384,6 @@ typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
 /* Pagesize of VTD paging structures, including root and context tables */
 #define VTD_PAGE_SHIFT              12
 #define VTD_PAGE_SIZE               (1ULL << VTD_PAGE_SHIFT)
-#define VTD_PAGE_MASK               (VTD_PAGE_SIZE - 1)
 
 #define VTD_PAGE_SHIFT_4K           12
 #define VTD_PAGE_MASK_4K            (~((1ULL << VTD_PAGE_SHIFT_4K) - 1))
-- 
2.7.4
