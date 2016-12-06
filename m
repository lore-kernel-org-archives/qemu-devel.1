Received: from eggs.gnu.org ([2001:4830:134:3::10]:52704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cEKS3-0000WW-BM
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cEKRy-0003X4-A4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:26:51 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1cEKRy-0003WR-4y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:26:46 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Tue, 6 Dec 2016 23:58:12 +0530
Message-ID: <1481048892-29881-1-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1481044425-23920-1-git-send-email-kwankhede@nvidia.com>
References: <1481044425-23920-1-git-send-email-kwankhede@nvidia.com>
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

Passing zero for the size to vfio_find_dma() isn't compatible with
matching the start address of an existing vfio_dma. Doing so triggers a
corner case. In vfio_find_dma(), when the start address is equal to
dma->iova and size is 0, check for the end of search range makes it to
take wrong side of RB-tree. That fails the search even though the address
is present in mapped dma ranges.
In functions pin_pages and unpin_pages, the iova which is being searched
is base address of page to be pinned or unpinned. So here size should be
set to PAGE_SIZE, as argument to vfio_find_dma().

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
