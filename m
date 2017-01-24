Received: from eggs.gnu.org ([2001:4830:134:3::10]:53179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyJD-0004hc-6Z
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyJC-00064b-1o
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVyJB-00064S-SG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:37 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 24 Jan 2017 18:25:56 +0800
Message-Id: <1485253571-19058-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1485253571-19058-1-git-send-email-peterx@redhat.com>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/18] vfio: allow to notify unmap for very
 large region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

Linux vfio driver supports to do VFIO_IOMMU_UNMAP_DMA for a very big
region. This can be leveraged by QEMU IOMMU implementation to cleanup
existing page mappings for an entire iova address space (by notifying
with an IOTLB with extremely huge addr_mask). However current
vfio_iommu_map_notify() does not allow that. It make sure that all the
translated address in IOTLB is falling into RAM range.

The check makes sense, but it should only be a sensible checker for
mapping operations, and mean little for unmap operations.

This patch moves this check into map logic only, so that we'll get
faster unmap handling (no need to translate again), and also we can then
better support unmapping a very big region when it covers non-ram ranges
or even not-existing ranges.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ce55dff..4d90844 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -354,11 +354,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         return;
     }
 
-    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
-        return;
-    }
-
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
+        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
+            return;
+        }
         ret = vfio_dma_map(container, iova,
                            iotlb->addr_mask + 1, vaddr,
                            read_only);
-- 
2.7.4
