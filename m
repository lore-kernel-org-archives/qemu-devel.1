Received: from eggs.gnu.org ([2001:4830:134:3::10]:53767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0I-0003B3-HD
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0H-0004hw-DI
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0H-0004Vl-1r
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:53 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:53 +0800
Message-Id: <1482127152-84732-19-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 18/37] vhost-user: send guest
 physical address of virtqueues to the slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

In the vhost-pci case, the slave needs the master side guest physical
address, rather than the qemu virtual address.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost.c         | 64 +++++++++++++++++++++++++++++++++--------------
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f7f7023..e945be8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/migration.h"
+#include "hw/virtio/vhost-user.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -858,6 +859,12 @@ static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *dev,
     return -errno;
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
@@ -901,26 +908,40 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
-    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = cpu_physical_memory_map(a, &l, 0);
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
+
     vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = cpu_physical_memory_map(a, &l, 0);
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
+
     vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = cpu_physical_memory_map(a, &l, 1);
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
@@ -1003,12 +1024,17 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    cpu_physical_memory_unmap(vq->used, virtio_queue_get_used_size(vdev, idx),
-                              1, virtio_queue_get_used_size(vdev, idx));
-    cpu_physical_memory_unmap(vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                              0, virtio_queue_get_avail_size(vdev, idx));
-    cpu_physical_memory_unmap(vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                              0, virtio_queue_get_desc_size(vdev, idx));
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
index 9cf32e2..9955e07 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -92,4 +92,6 @@ bool vhost_has_free_slot(void);
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
+bool vhost_pci_enabled(struct vhost_dev *dev);
+
 #endif
-- 
2.7.4
