Received: from eggs.gnu.org ([2001:4830:134:3::10]:43200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct4wD-0006MC-NF
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct4w8-0003P1-NK
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:10:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct4w8-0003Of-Fr
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C0FC81F03
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 04:10:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Mar 2017 12:10:04 +0800
Message-Id: <1490760604-9756-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9] vhost: generalize iommu memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: maxime.coquelin@redhat.com, Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>

We assumes the iommu_ops were attached to the root region of address
space. This may not be true for all kinds of IOMMU implementation and
especially after commit 3716d5902d74 ("pci: introduce a bus master
container"). So fix this by not assuming as->root has iommu_ops,
instead depending on the regions reported by memory listener through:

- register a memory listener to dma_as
- during region_add, if it's a region of IOMMU, register a specific
  IOMMU notifier, and store all notifiers in a list.
- during region_del, compare and delete the IOMMU notifier from the list

This is also a must for making vhost device IOTLB works for all types
of IOMMUs. Note, since we register one notifier during each
.region_add, the IOTLB may be flushed more than one times, this is
suboptimal and could be optimized in the future.

Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Fixes: 3716d5902d74 ("pci: introduce a bus master container")
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c         | 84 ++++++++++++++++++++++++++++++++++++-----------
 include/hw/virtio/vhost.h | 11 +++++++
 2 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index febe519..613494d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -425,10 +425,8 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 static int vhost_dev_has_iommu(struct vhost_dev *dev)
 {
     VirtIODevice *vdev = dev->vdev;
-    AddressSpace *dma_as = vdev->dma_as;
 
-    return memory_region_is_iommu(dma_as->root) &&
-           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
 }
 
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
@@ -720,6 +718,63 @@ static void vhost_region_del(MemoryListener *listener,
     }
 }
 
+static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
+    struct vhost_dev *hdev = iommu->hdev;
+    hwaddr iova = iotlb->iova + iommu->iommu_offset;
+
+    if (hdev->vhost_ops->vhost_invalidate_device_iotlb(hdev, iova,
+                                                       iotlb->addr_mask + 1)) {
+        error_report("Fail to invalidate device iotlb");
+    }
+}
+
+static void vhost_iommu_region_add(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         iommu_listener);
+    struct vhost_iommu *iommu;
+
+    if (!memory_region_is_iommu(section->mr)) {
+        return;
+    }
+
+    iommu = g_malloc0(sizeof(*iommu));
+    iommu->n.notify = vhost_iommu_unmap_notify;
+    iommu->n.notifier_flags = IOMMU_NOTIFIER_UNMAP;
+    iommu->mr = section->mr;
+    iommu->iommu_offset = section->offset_within_address_space -
+                          section->offset_within_region;
+    iommu->hdev = dev;
+    memory_region_register_iommu_notifier(section->mr, &iommu->n);
+    QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
+    /* TODO: can replay help performance here? */
+}
+
+static void vhost_iommu_region_del(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         iommu_listener);
+    struct vhost_iommu *iommu;
+
+    if (!memory_region_is_iommu(section->mr)) {
+        return;
+    }
+
+    QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
+        if (iommu->mr == section->mr) {
+            memory_region_unregister_iommu_notifier(iommu->mr,
+                                                    &iommu->n);
+            QLIST_REMOVE(iommu, iommu_next);
+            g_free(iommu);
+            break;
+        }
+    }
+}
+
 static void vhost_region_nop(MemoryListener *listener,
                              MemoryRegionSection *section)
 {
@@ -1161,17 +1216,6 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     event_notifier_cleanup(&vq->masked_notifier);
 }
 
-static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
-{
-    struct vhost_dev *hdev = container_of(n, struct vhost_dev, n);
-
-    if (hdev->vhost_ops->vhost_invalidate_device_iotlb(hdev,
-                                                       iotlb->iova,
-                                                       iotlb->addr_mask + 1)) {
-        error_report("Fail to invalidate device iotlb");
-    }
-}
-
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout)
 {
@@ -1244,8 +1288,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .priority = 10
     };
 
-    hdev->n.notify = vhost_iommu_unmap_notify;
-    hdev->n.notifier_flags = IOMMU_NOTIFIER_UNMAP;
+    hdev->iommu_listener = (MemoryListener) {
+        .region_add = vhost_iommu_region_add,
+        .region_del = vhost_iommu_region_del,
+    };
 
     if (hdev->migration_blocker == NULL) {
         if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
@@ -1455,8 +1501,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
     }
 
     if (vhost_dev_has_iommu(hdev)) {
-        memory_region_register_iommu_notifier(vdev->dma_as->root,
-                                              &hdev->n);
+        memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
     }
 
     r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
@@ -1538,8 +1583,7 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
 
     if (vhost_dev_has_iommu(hdev)) {
         hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
-        memory_region_unregister_iommu_notifier(vdev->dma_as->root,
-                                                &hdev->n);
+        memory_listener_unregister(&hdev->iommu_listener);
     }
     vhost_log_put(hdev, true);
     hdev->started = false;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 52f633e..a450321 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -37,10 +37,20 @@ struct vhost_log {
     vhost_log_chunk_t *log;
 };
 
+struct vhost_dev;
+struct vhost_iommu {
+    struct vhost_dev *hdev;
+    MemoryRegion *mr;
+    hwaddr iommu_offset;
+    IOMMUNotifier n;
+    QLIST_ENTRY(vhost_iommu) iommu_next;
+};
+
 struct vhost_memory;
 struct vhost_dev {
     VirtIODevice *vdev;
     MemoryListener memory_listener;
+    MemoryListener iommu_listener;
     struct vhost_memory *mem;
     int n_mem_sections;
     MemoryRegionSection *mem_sections;
@@ -64,6 +74,7 @@ struct vhost_dev {
     void *opaque;
     struct vhost_log *log;
     QLIST_ENTRY(vhost_dev) entry;
+    QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
 };
 
-- 
2.7.4
