Received: from eggs.gnu.org ([2001:4830:134:3::10]:55054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6q8-0006BB-90
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6pC-00064Y-DQ
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:24:31 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:23:09 +0200
Message-Id: <20180901142312.11662-18-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 17/20] hw/vfio/common: Register MAP notifier for
 MSI binding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

Register a MAP notifier to propage MSI stage 1 bindings to
the host. When the notifier gets called, we pass the guest
stage 1 MSI binding to the host. The host can then build
a S2 binding whose entry is the guest MSI doorbell GPA.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 49fcbbbc8c..412041593e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -407,6 +407,26 @@ static void vfio_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 }
 
+static void vfio_iommu_msi_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
+    VFIOContainer *container = giommu->container;
+    struct vfio_iommu_type1_bind_guest_msi ustruct;
+    int ret;
+
+    ustruct.argsz = sizeof(struct vfio_iommu_type1_bind_guest_msi);
+    ustruct.flags = 0;
+    ustruct.binding.iova = iotlb->iova;
+    ustruct.binding.gpa = iotlb->translated_addr;
+    ustruct.binding.granule = ctz64(~iotlb->addr_mask);
+
+    ret = ioctl(container->fd, VFIO_IOMMU_BIND_MSI , &ustruct);
+    if (ret) {
+        error_report("%s: failed to pass MSI binding (%d)",
+                     __func__, ret);
+    }
+}
+
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
@@ -742,6 +762,15 @@ static void vfio_listener_region_add(MemoryListener *listener,
                                       iommu_idx);
             QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
             memory_region_register_iommu_notifier(section->mr, &giommu->n);
+
+            giommu = vfio_alloc_guest_iommu(container, iommu_mr, offset);
+            iommu_iotlb_notifier_init(&giommu->n, vfio_iommu_msi_map_notify,
+                                      IOMMU_NOTIFIER_MAP,
+                                      section->offset_within_region,
+                                      int128_get64(llend),
+                                      iommu_idx);
+            QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+            memory_region_register_iommu_notifier(section->mr, &giommu->n);
         } else {
             /* MAP/UNMAP IOTLB notifier */
             giommu = vfio_alloc_guest_iommu(container, iommu_mr, offset);
-- 
2.17.1
