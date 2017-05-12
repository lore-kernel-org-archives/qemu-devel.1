Received: from eggs.gnu.org ([2001:4830:134:3::10]:44908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968p-0005hD-SX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968o-0001vR-P8
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968o-0001je-Gl
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:38 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:40 +0800
Message-Id: <1494578148-102868-9-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 08/16] vhost-user: send guest physical
 address of virtqueues to the slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

In the vhost-pci case, the slave needs the master side guest physical
address, rather than the qemu virtual address.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost.c         | 63 ++++++++++++++++++++++++++++++++---------------
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 613494d..1ce7b92 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "hw/virtio/vhost-user.h"
 #include "migration/migration.h"
 #include "sysemu/dma.h"
 
@@ -994,6 +995,12 @@ out:
     rcu_read_unlock();
 }
 
+bool vhost_pci_enabled(struct vhost_dev *dev)
+{
+    return ((dev->protocol_features &
+            (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI)) != 0);
+}
+
 static int vhost_virtqueue_start(struct vhost_dev *dev,
                                 struct VirtIODevice *vdev,
                                 struct vhost_virtqueue *vq,
@@ -1037,26 +1044,38 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
-    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = vhost_memory_map(dev, a, &l, 0);
-    if (!vq->desc || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_desc;
+    if (vhost_pci_enabled(dev)) {
+        vq->desc = (void *)a;
+    } else {
+        vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
+        vq->desc = cpu_physical_memory_map(a, &l, 0);
+        if (!vq->desc || l != s) {
+            r = -ENOMEM;
+            goto fail_alloc_desc;
+        }
     }
     vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = vhost_memory_map(dev, a, &l, 0);
-    if (!vq->avail || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_avail;
+    if (vhost_pci_enabled(dev)) {
+        vq->avail = (void *)a;
+    } else {
+        vq->avail = cpu_physical_memory_map(a, &l, 0);
+        if (!vq->avail || l != s) {
+            r = -ENOMEM;
+            goto fail_alloc_avail;
+        }
     }
     vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = vhost_memory_map(dev, a, &l, 1);
-    if (!vq->used || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_used;
+    if (vhost_pci_enabled(dev)) {
+        vq->used = (void *)a;
+    } else {
+        vq->used = cpu_physical_memory_map(a, &l, 1);
+        if (!vq->used || l != s) {
+            r = -ENOMEM;
+            goto fail_alloc_used;
+        }
     }
 
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
@@ -1139,13 +1158,17 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 !virtio_is_big_endian(vdev),
                                                 vhost_vq_index);
     }
-
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
-                       1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, virtio_queue_get_desc_size(vdev, idx));
+    if (!vhost_pci_enabled(dev)) {
+        cpu_physical_memory_unmap(vq->used,
+                                  virtio_queue_get_used_size(vdev, idx),
+                                  1, virtio_queue_get_used_size(vdev, idx));
+        cpu_physical_memory_unmap(vq->avail,
+                                  virtio_queue_get_avail_size(vdev, idx),
+                                  0, virtio_queue_get_avail_size(vdev, idx));
+        cpu_physical_memory_unmap(vq->desc,
+                                  virtio_queue_get_desc_size(vdev, idx),
+                                  0, virtio_queue_get_desc_size(vdev, idx));
+    }
 }
 
 static void vhost_eventfd_add(MemoryListener *listener,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 40ba87e..09e02d8 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -107,4 +107,6 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
 void vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
+
+bool vhost_pci_enabled(struct vhost_dev *dev);
 #endif
-- 
2.7.4
