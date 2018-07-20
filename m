Received: from eggs.gnu.org ([2001:4830:134:3::10]:37978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fgQub-0008MY-3t
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fgQuX-0006n1-WD
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:37:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:17683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fgQuX-0006mn-Mj
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:37:13 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 20 Jul 2018 16:36:44 +0800
Message-Id: <20180720083644.1431-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH] vhost: check region type before casting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Check region type first before casting the memory region
to IOMMUMemoryRegion. Otherwise QEMU will abort with below
error message when casting non-IOMMU memory region:

vhost_iommu_region_add: Object 0x561f28bce4f0 is not an
instance of type qemu:iommu-memory-region

Fixes: cb1efcf462a2 ("iommu: Add IOMMU index argument to notifier APIs")
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/virtio/vhost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b129cb9ddd..d4cb5894a8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -663,12 +663,14 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     struct vhost_iommu *iommu;
     Int128 end;
     int iommu_idx;
-    IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+    IOMMUMemoryRegion *iommu_mr;
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
     }
 
+    iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+
     iommu = g_malloc0(sizeof(*iommu));
     end = int128_add(int128_make64(section->offset_within_region),
                      section->size);
-- 
2.18.0
