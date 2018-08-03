Received: from eggs.gnu.org ([2001:4830:134:3::10]:57262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNP-0003xJ-Po
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNL-00020E-Q0
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1flWNL-0001yh-Kf
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:27:59 -0400
Date: Fri, 3 Aug 2018 12:27:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803083830.775669-2-mst@redhat.com>
References: <20180803083830.775669-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803083830.775669-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] vhost: check region type before casting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Tiwei Bie <tiwei.bie@intel.com>

From: Tiwei Bie <tiwei.bie@intel.com>

Check region type first before casting the memory region
to IOMMUMemoryRegion. Otherwise QEMU will abort with below
error message when casting non-IOMMU memory region:

vhost_iommu_region_add: Object 0x561f28bce4f0 is not an
instance of type qemu:iommu-memory-region

Fixes: cb1efcf462a2 ("iommu: Add IOMMU index argument to notifier APIs")
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
