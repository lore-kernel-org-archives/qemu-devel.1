Received: from eggs.gnu.org ([2001:4830:134:3::10]:36363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cEJJv-000720-S0
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cEJJs-0001wo-Mb
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:14:23 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1cEJJs-0001vT-GC
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:14:20 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Tue, 6 Dec 2016 22:43:45 +0530
Message-ID: <1481044425-23920-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/2] vfio iommu: Fix size argument to
 vfio_find_dma() in pin_pages/unpin_pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, cjia@nvidia.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>

vfio_dma keeps track of address range from (dma->iova + 0) to
(dma->iova + dma->size - 1), while vfio_find_dma() search logic looks for
range from (dma->iova + 1) to (dma->iova + dma->size).
In vfio_find_dma(), when the start address is equal to dma->iova and size
is 0, check for the end of search range makes it to take wrong side of
RB-tree. That fails the search even though the address is present in
mapped dma ranges.
In functions pin_pages and unpin_pages, the iova which is being searched
is base address of page to be pinned or unpinned. So here size should be
set to PAGE_SIZE, as argument to vfio_find_dma.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Signed-off-by: Neo Jia <cjia@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 8e9e94ccb2ff..023fba7b8d5a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -581,7 +581,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 		struct vfio_pfn *vpfn;
 
 		iova = user_pfn[i] << PAGE_SHIFT;
-		dma = vfio_find_dma(iommu, iova, 0);
+		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
 		if (!dma) {
 			ret = -EINVAL;
 			goto pin_unwind;
@@ -622,7 +622,7 @@ pin_unwind:
 		dma_addr_t iova;
 
 		iova = user_pfn[j] << PAGE_SHIFT;
-		dma = vfio_find_dma(iommu, iova, 0);
+		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
 		vfio_unpin_page_external(dma, iova, do_accounting);
 		phys_pfn[j] = 0;
 	}
@@ -659,7 +659,7 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
 		dma_addr_t iova;
 
 		iova = user_pfn[i] << PAGE_SHIFT;
-		dma = vfio_find_dma(iommu, iova, 0);
+		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
 		if (!dma)
 			goto unpin_exit;
 		vfio_unpin_page_external(dma, iova, do_accounting);
-- 
2.7.0
