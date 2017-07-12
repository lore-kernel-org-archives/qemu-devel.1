Received: from eggs.gnu.org ([2001:4830:134:3::10]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVCmU-0000ql-Oo
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVCmR-0001r6-Ha
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVCmR-0001qJ-C1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74E6E4E33D
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:13:54 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 12 Jul 2017 16:13:40 +0800
Message-Id: <1499847223-8078-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1499847223-8078-1-git-send-email-peterx@redhat.com>
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/4] intel_iommu: fix VTD_PAGE_MASK
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

IOMMUTLBEntry.iova is returned incorrectly in one PT path (though mostly
we cannot really trigger this path, even if we do, we are mostly
disgarding this value, so it didn't break anything). Fix it by
converting the VTD_PAGE_MASK into normal definition (normally it should
be pfn mask, not offset mask), then switch the other user of it.

Fixes: b93130 ("intel_iommu: cleanup vtd_{do_}iommu_translate()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 2 +-
 hw/i386/intel_iommu_internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 88dc042..392da45 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1141,7 +1141,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (vtd_ce_get_type(&ce) == VTD_CONTEXT_TT_PASS_THROUGH) {
         entry->iova = addr & VTD_PAGE_MASK;
         entry->translated_addr = entry->iova;
-        entry->addr_mask = VTD_PAGE_MASK;
+        entry->addr_mask = ~VTD_PAGE_MASK;
         entry->perm = IOMMU_RW;
         trace_vtd_translate_pt(source_id, entry->iova);
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f50ecd8..754cf8a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -384,7 +384,7 @@ typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
 /* Pagesize of VTD paging structures, including root and context tables */
 #define VTD_PAGE_SHIFT              12
 #define VTD_PAGE_SIZE               (1ULL << VTD_PAGE_SHIFT)
-#define VTD_PAGE_MASK               (VTD_PAGE_SIZE - 1)
+#define VTD_PAGE_MASK               (~(VTD_PAGE_SIZE - 1))
 
 #define VTD_PAGE_SHIFT_4K           12
 #define VTD_PAGE_MASK_4K            (~((1ULL << VTD_PAGE_SHIFT_4K) - 1))
-- 
2.7.4
