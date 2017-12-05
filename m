Received: from eggs.gnu.org ([2001:4830:134:3::10]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4F0-0001Uk-Ey
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Ez-0007R5-Go
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:32277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eM4Ez-0007JF-6T
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:53 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:16 +0800
Message-Id: <1512444796-30615-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 7/7] virtio/vhost.c: vhost-pci needs remote
 gpa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>

The vhost-pci driver uses the remote guest physical address to send/receive
packets from the remote guest, so when sending the ving info to the vhost-pci
device, send the guest physical adress directly.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost.c | 56 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dda7b8f..ffbda6c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1057,26 +1057,38 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
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
+        vq->desc = vhost_memory_map(dev, a, &l, 0);
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
+        vq->avail = vhost_memory_map(dev, a, &l, 0);
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
+        vq->used = vhost_memory_map(dev, a, &l, 1);
+        if (!vq->used || l != s) {
+            r = -ENOMEM;
+            goto fail_alloc_used;
+        }
     }
 
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
@@ -1163,13 +1175,17 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
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
+        vhost_memory_unmap(dev, vq->used,
+                           virtio_queue_get_used_size(vdev, idx),
+                           1, virtio_queue_get_used_size(vdev, idx));
+        vhost_memory_unmap(dev, vq->avail,
+                           virtio_queue_get_avail_size(vdev, idx),
+                           0, virtio_queue_get_avail_size(vdev, idx));
+        vhost_memory_unmap(dev, vq->desc,
+                           virtio_queue_get_desc_size(vdev, idx),
+                           0, virtio_queue_get_desc_size(vdev, idx));
+    }
 }
 
 static void vhost_eventfd_add(MemoryListener *listener,
-- 
2.7.4
