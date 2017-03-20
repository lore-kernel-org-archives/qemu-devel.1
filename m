Received: from eggs.gnu.org ([2001:4830:134:3::10]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cpo7v-00043p-TX
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cpo7u-00065i-HO
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cpo7u-00065W-8O
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E4F7C054C4C
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 03:36:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Mar 2017 11:36:39 +0800
Message-Id: <1489980999-5965-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH fixup 2/2] vhost: genearlize iommu memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

We assumes the iommu_ops were attached to the root region of address
space. This may not true for all kinds of IOMMU implementation. So fix
this by not assume as->root has iommu_ops and:

- register a memory listener to dma_as
- during region_add, if it's a region of IOMMU, register a specific
  IOMMU notifier, and store all notifiers in a list
- during region_del, compare and delete the IOMMU notifier

This is a must for making vhost device IOTLB works for IOMMU other
than intel ones.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c         | 93 +++++++++++++++++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 10 +++++
 2 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ccf8b2e..45f75da 100644
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
@@ -720,6 +718,69 @@ static void vhost_region_del(MemoryListener *listener,
     }
 }
 
+static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
+    struct vhost_dev *hdev = iommu->hdev;
+
+    if (hdev->vhost_ops->vhost_invalidate_device_iotlb(hdev,
+                                                       iotlb->iova,
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
+    Int128 llend;
+
+    if (!memory_region_is_iommu(section->mr)) {
+        return;
+    }
+
+    llend = int128_make64(section->offset_within_address_space);
+    llend = int128_add(llend, section->size);
+    llend = int128_sub(llend, int128_one());
+
+    iommu = g_malloc0(sizeof(*iommu));
+    iommu->mr = section->mr;
+    iommu->hdev = dev;
+    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
+                        IOMMU_NOTIFIER_UNMAP,
+                        section->offset_within_region,
+                        int128_get64(llend));
+    memory_region_register_iommu_notifier(section->mr, &iommu->n);
+    /* TODO: can replay help performance here? */
+    QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
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
+        if (iommu->mr == section->mr &&
+            iommu->n.start == section->offset_within_region) {
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
@@ -1161,17 +1222,6 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
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
@@ -1244,6 +1294,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .priority = 10
     };
 
+    hdev->iommu_listener = (MemoryListener) {
+        .region_add = vhost_iommu_region_add,
+        .region_del = vhost_iommu_region_del,
+    };
+
     iommu_notifier_init(&hdev->n, vhost_iommu_unmap_notify,
                         IOMMU_NOTIFIER_UNMAP, 0, ~0ULL);
 
@@ -1454,9 +1509,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         goto fail_features;
     }
 
-    if (vhost_dev_has_iommu(hdev)) {
-        memory_region_register_iommu_notifier(vdev->dma_as->root,
-                                              &hdev->n);
+    if (true) {
+        memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
     }
 
     r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
@@ -1536,10 +1590,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
                              hdev->vq_index + i);
     }
 
-    if (vhost_dev_has_iommu(hdev)) {
+    if (true) {
         hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
-        memory_region_unregister_iommu_notifier(vdev->dma_as->root,
-                                                &hdev->n);
+        memory_listener_unregister(&hdev->iommu_listener);
     }
     vhost_log_put(hdev, true);
     hdev->started = false;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 52f633e..4d89dcd 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -37,10 +37,19 @@ struct vhost_log {
     vhost_log_chunk_t *log;
 };
 
+struct vhost_dev;
+struct vhost_iommu {
+    struct vhost_dev *hdev;
+    MemoryRegion *mr;
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
@@ -64,6 +73,7 @@ struct vhost_dev {
     void *opaque;
     struct vhost_log *log;
     QLIST_ENTRY(vhost_dev) entry;
+    QLIST_HEAD(,vhost_iommu) iommu_list;
     IOMMUNotifier n;
 };
 
-- 
2.7.4
