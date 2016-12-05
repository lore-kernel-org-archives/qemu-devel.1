Received: from eggs.gnu.org ([2001:4830:134:3::10]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cE0TS-0006nC-B1
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cE0TQ-00077s-TA
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:06:58 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1cE0TQ-00077W-Nb
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:06:56 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Tue, 6 Dec 2016 02:38:20 +0530
Message-ID: <1480972100-846-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/1] vfio iommu type1: WARN_ON if notifier
 block is not unregistered
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

mdev vendor driver should unregister the iommu notifier since the vfio
iommu can persist beyond the attachment of the mdev group. WARN_ON will
show warning if vendor driver doesn't unregister the notifier and is
forced to follow the implementations steps.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Signed-off-by: Neo Jia <cjia@nvidia.com>
Change-Id: I75fd0a40e582a144fe7a037c7140d3513e8ff030
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 023fba7b8d5a..37871ee0c0c5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1361,6 +1361,8 @@ static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
 		if (WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list)))
 			break;
 	}
+	/* mdev venfor driver must unregister notifier */
+	WARN_ON(iommu->notifier.head);
 }
 
 static void vfio_iommu_type1_detach_group(void *iommu_data,
-- 
2.7.0
