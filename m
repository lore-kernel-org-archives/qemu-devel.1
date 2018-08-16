Received: from eggs.gnu.org ([2001:4830:134:3::10]:38028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fqKGi-00047m-HW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fqKGh-0002ou-8a
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:33:00 -0400
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:52981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1fqKGg-0002nW-R0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:32:59 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Thu, 16 Aug 2018 18:32:42 +0300
Message-Id: <1534433563-30865-3-git-send-email-yury-kotov@yandex-team.ru>
In-Reply-To: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
Subject: [Qemu-devel] [PATCH 2/3] vhost: refactor vhost_dev_start and
 vhost_virtqueue_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

vhost_dev_start and vhost_virtqueue_start do two things:
1. Initialize its own structs vhost_dev and vhost_virtqueue,
2. Sync with vhost backend.

It's ok, but we want to do sync part separately.
This refactoring is needed for the next patch, which adds reconnect
support for vhost-user.

So,
1. Move initialization part of vhost_dev_start which syncs with backend
   to the separate function: vhost_dev_sync_backend.
2. Divide vhost_virtqueue_start into two functions:
   * vhost_virtqueue_setup: prepares vhost_virtqueue to work with
     corresponding VirtQueue,
   * vhost_virtqueue_sync_backend: syncs vhost_virtqueue and backend.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 hw/virtio/vhost.c         | 192 ++++++++++++++++++++++++++++------------------
 include/hw/virtio/vhost.h |   1 +
 2 files changed, 119 insertions(+), 74 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d4cb589..6fcfb87 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -941,15 +941,14 @@ out:
     return ret;
 }
 
-static int vhost_virtqueue_start(struct vhost_dev *dev,
-                                struct VirtIODevice *vdev,
-                                struct vhost_virtqueue *vq,
-                                unsigned idx)
+static int vhost_virtqueue_sync_backend(struct vhost_dev *dev,
+                                        struct VirtIODevice *vdev,
+                                        struct vhost_virtqueue *vq,
+                                        unsigned idx)
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
-    hwaddr s, l, a;
     int r;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_file file = {
@@ -960,13 +959,7 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
-    a = virtio_queue_get_desc_addr(vdev, idx);
-    if (a == 0) {
-        /* Queue might not be ready for start */
-        return 0;
-    }
-
-    vq->num = state.num = virtio_queue_get_num(vdev, idx);
+    state.num = virtio_queue_get_num(vdev, idx);
     r = dev->vhost_ops->vhost_set_vring_num(dev, &state);
     if (r) {
         VHOST_OPS_DEBUG("vhost_set_vring_num failed");
@@ -989,32 +982,10 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
-    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
-    vq->desc_phys = a;
-    vq->desc = vhost_memory_map(dev, a, &l, 0);
-    if (!vq->desc || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_desc;
-    }
-    vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
-    vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = vhost_memory_map(dev, a, &l, 0);
-    if (!vq->avail || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_avail;
-    }
-    vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
-    vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = vhost_memory_map(dev, a, &l, 1);
-    if (!vq->used || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_used;
-    }
-
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
     if (r < 0) {
         r = -errno;
-        goto fail_alloc;
+        goto fail;
     }
 
     file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
@@ -1022,7 +993,7 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
     if (r) {
         VHOST_OPS_DEBUG("vhost_set_vring_kick failed");
         r = -errno;
-        goto fail_kick;
+        goto fail;
     }
 
     /* Clear and discard previous events if any. */
@@ -1042,15 +1013,56 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
-            goto fail_vector;
+            goto fail;
         }
     }
 
     return 0;
 
-fail_vector:
-fail_kick:
-fail_alloc:
+fail:
+    return r;
+}
+
+static int vhost_virtqueue_setup(struct vhost_dev *dev,
+                                 struct VirtIODevice *vdev,
+                                 struct vhost_virtqueue *vq,
+                                 unsigned idx)
+{
+    hwaddr s, l, a;
+    int r;
+
+    a = virtio_queue_get_desc_addr(vdev, idx);
+    if (a == 0) {
+        /* Queue might not be ready for start */
+        return 0;
+    }
+
+    vq->num = virtio_queue_get_num(vdev, idx);
+
+    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
+    vq->desc_phys = a;
+    vq->desc = vhost_memory_map(dev, a, &l, 0);
+    if (!vq->desc || l != s) {
+        r = -ENOMEM;
+        goto fail_alloc_desc;
+    }
+    vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
+    vq->avail = vhost_memory_map(dev, a, &l, 0);
+    if (!vq->avail || l != s) {
+        r = -ENOMEM;
+        goto fail_alloc_avail;
+    }
+    vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
+    vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
+    vq->used = vhost_memory_map(dev, a, &l, 1);
+    if (!vq->used || l != s) {
+        r = -ENOMEM;
+        goto fail_alloc_used;
+    }
+
+    return 0;
+
     vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
                        0, 0);
 fail_alloc_used:
@@ -1158,6 +1170,7 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
         return r;
     }
 
+    dev->vqs[n].masked = true;
     file.fd = event_notifier_get_fd(&vq->masked_notifier);
     r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
     if (r) {
@@ -1417,6 +1430,7 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
     } else {
         file.fd = event_notifier_get_fd(virtio_queue_get_guest_notifier(vvq));
     }
+    hdev->vqs[index].masked = mask;
 
     file.index = hdev->vhost_ops->vhost_get_vq_index(hdev, n);
     r = hdev->vhost_ops->vhost_set_vring_call(hdev, &file);
@@ -1483,56 +1497,41 @@ void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
     hdev->config_ops = ops;
 }
 
-/* Host notifiers must be enabled at this point. */
-int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
+static int vhost_dev_sync_backend(struct vhost_dev *hdev)
 {
     int i, r;
-
-    /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
-
-    hdev->started = true;
-    hdev->vdev = vdev;
+    assert(hdev->vdev);
 
     r = vhost_dev_set_features(hdev, hdev->log_enabled);
     if (r < 0) {
-        goto fail_features;
-    }
-
-    if (vhost_dev_has_iommu(hdev)) {
-        memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
+        goto fail;
     }
 
     r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
     if (r < 0) {
-        VHOST_OPS_DEBUG("vhost_set_mem_table failed");
         r = -errno;
-        goto fail_mem;
+        goto fail;
     }
+
     for (i = 0; i < hdev->nvqs; ++i) {
-        r = vhost_virtqueue_start(hdev,
-                                  vdev,
-                                  hdev->vqs + i,
-                                  hdev->vq_index + i);
+        r = vhost_virtqueue_sync_backend(hdev,
+                                         hdev->vdev,
+                                         hdev->vqs + i,
+                                         hdev->vq_index + i);
         if (r < 0) {
-            goto fail_vq;
+            goto fail;
         }
     }
 
     if (hdev->log_enabled) {
         uint64_t log_base;
-
-        hdev->log_size = vhost_get_log_size(hdev);
-        hdev->log = vhost_log_get(hdev->log_size,
-                                  vhost_dev_log_is_shared(hdev));
-        log_base = (uintptr_t)hdev->log->log;
-        r = hdev->vhost_ops->vhost_set_log_base(hdev,
-                                                hdev->log_size ? log_base : 0,
-                                                hdev->log);
+        assert(hdev->log);
+        log_base = hdev->log_size ? (uintptr_t)hdev->log->log : 0;
+        r = hdev->vhost_ops->vhost_set_log_base(hdev, log_base, hdev->log);
         if (r < 0) {
-            VHOST_OPS_DEBUG("vhost_set_log_base failed");
             r = -errno;
-            goto fail_log;
+            goto fail;
         }
     }
 
@@ -1546,20 +1545,65 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
             vhost_device_iotlb_miss(hdev, vq->used_phys, true);
         }
     }
+
     return 0;
-fail_log:
+
+fail:
+    return r;
+}
+
+/* Host notifiers must be enabled at this point. */
+int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+    int i, r;
+
+    /* should only be called after backend is connected */
+    assert(hdev->vhost_ops);
+
+    hdev->started = true;
+    hdev->vdev = vdev;
+
+    if (vhost_dev_has_iommu(hdev)) {
+        memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
+    }
+
+    for (i = 0; i < hdev->nvqs; ++i) {
+        r = vhost_virtqueue_setup(hdev,
+                                  vdev,
+                                  hdev->vqs + i,
+                                  hdev->vq_index + i);
+        if (r < 0) {
+            goto fail_vq;
+        }
+    }
+
+    if (hdev->log_enabled) {
+        hdev->log_size = vhost_get_log_size(hdev);
+        hdev->log = vhost_log_get(hdev->log_size,
+                                  vhost_dev_log_is_shared(hdev));
+    }
+
+    r = vhost_dev_sync_backend(hdev);
+    if (r < 0) {
+        goto fail_sync;
+    }
+
+    return 0;
+
+fail_sync:
     vhost_log_put(hdev, false);
+
 fail_vq:
+    if (vhost_dev_has_iommu(hdev)) {
+        memory_listener_unregister(&hdev->iommu_listener);
+    }
+
     while (--i >= 0) {
         vhost_virtqueue_stop(hdev,
                              vdev,
                              hdev->vqs + i,
                              hdev->vq_index + i);
     }
-    i = hdev->nvqs;
-
-fail_mem:
-fail_features:
 
     hdev->started = false;
     return r;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a7f449f..a43db26 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -20,6 +20,7 @@ struct vhost_virtqueue {
     unsigned avail_size;
     unsigned long long used_phys;
     unsigned used_size;
+    bool masked;
     EventNotifier masked_notifier;
     struct vhost_dev *dev;
 };
-- 
2.7.4
