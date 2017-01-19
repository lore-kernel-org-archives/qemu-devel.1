Received: from eggs.gnu.org ([2001:4830:134:3::10]:36618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxT-0000FZ-PJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxQ-0007no-Df
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:23 -0500
Received: from mail.kernel.org ([198.145.29.136]:56572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxQ-0007lL-07
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:20 -0500
Date: Thu, 19 Jan 2017 23:09:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-5-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 04/17] vhost_net: device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>

From: Jason Wang <jasowang@redhat.com>

This patches implements Device IOTLB support for vhost kernel. This is
done through:

1) switch to use dma helpers when map/unmap vrings from vhost codes
2) introduce a set of VhostOps to:
   - setting up device IOTLB request callback
   - processing device IOTLB request
   - processing device IOTLB invalidation
2) kernel support for Device IOTLB API:

- allow vhost-net to query the IOMMU IOTLB entry through eventfd
- enable the ability for qemu to update a specified mapping of vhost
- through ioctl.
- enable the ability to invalidate a specified range of iova for the
  device IOTLB of vhost through ioctl. In x86/intel_iommu case this is
  triggered through iommu memory region notifier from device IOTLB
  invalidation descriptor processing routine.

With all the above, kernel vhost_net can co-operate with userspace
IOMMU. For vhost-user, the support could be easily done on top by
implementing the VhostOps.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-backend.h |  13 +++
 include/hw/virtio/vhost.h         |   4 +
 hw/net/vhost_net.c                |   1 +
 hw/virtio/vhost-backend.c         |  99 +++++++++++++++++++++++
 hw/virtio/vhost.c                 | 166 +++++++++++++++++++++++++++++++++-----
 net/tap.c                         |   1 +
 6 files changed, 262 insertions(+), 22 deletions(-)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 30abc11..c3cf4a7 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -11,6 +11,8 @@
 #ifndef VHOST_BACKEND_H
 #define VHOST_BACKEND_H
 
+#include "exec/memory.h"
+
 typedef enum VhostBackendType {
     VHOST_BACKEND_TYPE_NONE = 0,
     VHOST_BACKEND_TYPE_KERNEL = 1,
@@ -77,6 +79,14 @@ typedef bool (*vhost_backend_can_merge_op)(struct vhost_dev *dev,
 typedef int (*vhost_vsock_set_guest_cid_op)(struct vhost_dev *dev,
                                             uint64_t guest_cid);
 typedef int (*vhost_vsock_set_running_op)(struct vhost_dev *dev, int start);
+typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
+                                           int enabled);
+typedef int (*vhost_update_device_iotlb_op)(struct vhost_dev *dev,
+                                            uint64_t iova, uint64_t uaddr,
+                                            uint64_t len,
+                                            IOMMUAccessFlags perm);
+typedef int (*vhost_invalidate_device_iotlb_op)(struct vhost_dev *dev,
+                                                uint64_t iova, uint64_t len);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -109,6 +119,9 @@ typedef struct VhostOps {
     vhost_backend_can_merge_op vhost_backend_can_merge;
     vhost_vsock_set_guest_cid_op vhost_vsock_set_guest_cid;
     vhost_vsock_set_running_op vhost_vsock_set_running;
+    vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
+    vhost_update_device_iotlb_op vhost_update_device_iotlb;
+    vhost_invalidate_device_iotlb_op vhost_invalidate_device_iotlb;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 1fe5aad..52f633e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -21,6 +21,7 @@ struct vhost_virtqueue {
     unsigned long long used_phys;
     unsigned used_size;
     EventNotifier masked_notifier;
+    struct vhost_dev *dev;
 };
 
 typedef unsigned long vhost_log_chunk_t;
@@ -38,6 +39,7 @@ struct vhost_log {
 
 struct vhost_memory;
 struct vhost_dev {
+    VirtIODevice *vdev;
     MemoryListener memory_listener;
     struct vhost_memory *mem;
     int n_mem_sections;
@@ -62,6 +64,7 @@ struct vhost_dev {
     void *opaque;
     struct vhost_log *log;
     QLIST_ENTRY(vhost_dev) entry;
+    IOMMUNotifier n;
 };
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -91,4 +94,5 @@ bool vhost_has_free_slot(void);
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
+void vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 #endif
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6280422..22874a9 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -52,6 +52,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 272a5ec..be927b8 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -185,6 +185,102 @@ static int vhost_kernel_vsock_set_running(struct vhost_dev *dev, int start)
 }
 #endif /* CONFIG_VHOST_VSOCK */
 
+static void vhost_kernel_iotlb_read(void *opaque)
+{
+    struct vhost_dev *dev = opaque;
+    struct vhost_msg msg;
+    ssize_t len;
+
+    while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
+        struct vhost_iotlb_msg *imsg = &msg.iotlb;
+        if (len < sizeof msg) {
+            error_report("Wrong vhost message len: %d", (int)len);
+            break;
+        }
+        if (msg.type != VHOST_IOTLB_MSG) {
+            error_report("Unknown vhost iotlb message type");
+            break;
+        }
+        switch (imsg->type) {
+        case VHOST_IOTLB_MISS:
+            vhost_device_iotlb_miss(dev, imsg->iova,
+                                    imsg->perm != VHOST_ACCESS_RO);
+            break;
+        case VHOST_IOTLB_UPDATE:
+        case VHOST_IOTLB_INVALIDATE:
+            error_report("Unexpected IOTLB message type");
+            break;
+        case VHOST_IOTLB_ACCESS_FAIL:
+            /* FIXME: report device iotlb error */
+            break;
+        default:
+            break;
+        }
+    }
+}
+
+static int vhost_kernel_update_device_iotlb(struct vhost_dev *dev,
+                                            uint64_t iova, uint64_t uaddr,
+                                            uint64_t len,
+                                            IOMMUAccessFlags perm)
+{
+    struct vhost_msg msg;
+    msg.type = VHOST_IOTLB_MSG;
+    msg.iotlb.iova =  iova;
+    msg.iotlb.uaddr = uaddr;
+    msg.iotlb.size = len;
+    msg.iotlb.type = VHOST_IOTLB_UPDATE;
+
+    switch (perm) {
+    case IOMMU_RO:
+        msg.iotlb.perm = VHOST_ACCESS_RO;
+        break;
+    case IOMMU_WO:
+        msg.iotlb.perm = VHOST_ACCESS_WO;
+        break;
+    case IOMMU_RW:
+        msg.iotlb.perm = VHOST_ACCESS_RW;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
+        error_report("Fail to update device iotlb");
+        return -EFAULT;
+    }
+
+    return 0;
+}
+
+static int vhost_kernel_invalidate_device_iotlb(struct vhost_dev *dev,
+                                                uint64_t iova, uint64_t len)
+{
+    struct vhost_msg msg;
+
+    msg.type = VHOST_IOTLB_MSG;
+    msg.iotlb.iova = iova;
+    msg.iotlb.size = len;
+    msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
+
+    if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
+        error_report("Fail to invalidate device iotlb");
+        return -EFAULT;
+    }
+
+    return 0;
+}
+
+static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
+                                           int enabled)
+{
+    if (enabled)
+        qemu_set_fd_handler((uintptr_t)dev->opaque,
+                            vhost_kernel_iotlb_read, NULL, dev);
+    else
+        qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
+}
+
 static const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
         .vhost_backend_init = vhost_kernel_init,
@@ -214,6 +310,9 @@ static const VhostOps kernel_ops = {
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
 #endif /* CONFIG_VHOST_VSOCK */
+        .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
+        .vhost_update_device_iotlb = vhost_kernel_update_device_iotlb,
+        .vhost_invalidate_device_iotlb = vhost_kernel_invalidate_device_iotlb,
 };
 
 int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d396b22..9cacf55 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/migration.h"
+#include "sysemu/dma.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -421,8 +422,36 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
     dev->log_size = size;
 }
 
+static int vhost_dev_has_iommu(struct vhost_dev *dev)
+{
+    VirtIODevice *vdev = dev->vdev;
+    AddressSpace *dma_as = vdev->dma_as;
+
+    return memory_region_is_iommu(dma_as->root) &&
+           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+}
+
+static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
+                              hwaddr *plen, int is_write)
+{
+    if (!vhost_dev_has_iommu(dev)) {
+        return cpu_physical_memory_map(addr, plen, is_write);
+    } else {
+        return (void *)(uintptr_t)addr;
+    }
+}
+
+static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
+                               hwaddr len, int is_write,
+                               hwaddr access_len)
+{
+    if (!vhost_dev_has_iommu(dev)) {
+        cpu_physical_memory_unmap(buffer, len, is_write, access_len);
+    }
+}
 
-static int vhost_verify_ring_part_mapping(void *part,
+static int vhost_verify_ring_part_mapping(struct vhost_dev *dev,
+                                          void *part,
                                           uint64_t part_addr,
                                           uint64_t part_size,
                                           uint64_t start_addr,
@@ -436,14 +465,14 @@ static int vhost_verify_ring_part_mapping(void *part,
         return 0;
     }
     l = part_size;
-    p = cpu_physical_memory_map(part_addr, &l, 1);
+    p = vhost_memory_map(dev, part_addr, &l, 1);
     if (!p || l != part_size) {
         r = -ENOMEM;
     }
     if (p != part) {
         r = -EBUSY;
     }
-    cpu_physical_memory_unmap(p, l, 0, 0);
+    vhost_memory_unmap(dev, p, l, 0, 0);
     return r;
 }
 
@@ -463,21 +492,21 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
         struct vhost_virtqueue *vq = dev->vqs + i;
 
         j = 0;
-        r = vhost_verify_ring_part_mapping(vq->desc, vq->desc_phys,
+        r = vhost_verify_ring_part_mapping(dev, vq->desc, vq->desc_phys,
                                            vq->desc_size, start_addr, size);
         if (!r) {
             break;
         }
 
         j++;
-        r = vhost_verify_ring_part_mapping(vq->avail, vq->avail_phys,
+        r = vhost_verify_ring_part_mapping(dev, vq->avail, vq->avail_phys,
                                            vq->avail_size, start_addr, size);
         if (!r) {
             break;
         }
 
         j++;
-        r = vhost_verify_ring_part_mapping(vq->used, vq->used_phys,
+        r = vhost_verify_ring_part_mapping(dev, vq->used, vq->used_phys,
                                            vq->used_size, start_addr, size);
         if (!r) {
             break;
@@ -715,7 +744,8 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
     return 0;
 }
 
-static int vhost_dev_set_features(struct vhost_dev *dev, bool enable_log)
+static int vhost_dev_set_features(struct vhost_dev *dev,
+                                  bool enable_log)
 {
     uint64_t features = dev->acked_features;
     int r;
@@ -858,6 +888,56 @@ static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *dev,
     return -errno;
 }
 
+static int vhost_memory_region_lookup(struct vhost_dev *hdev,
+                                      uint64_t gpa, uint64_t *uaddr,
+                                      uint64_t *len)
+{
+    int i;
+
+    for (i = 0; i < hdev->mem->nregions; i++) {
+        struct vhost_memory_region *reg = hdev->mem->regions + i;
+
+        if (gpa >= reg->guest_phys_addr &&
+            reg->guest_phys_addr + reg->memory_size > gpa) {
+            *uaddr = reg->userspace_addr + gpa - reg->guest_phys_addr;
+            *len = reg->guest_phys_addr + reg->memory_size - gpa;
+            return 0;
+        }
+    }
+
+    return -EFAULT;
+}
+
+void vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
+{
+    IOMMUTLBEntry iotlb;
+    uint64_t uaddr, len;
+
+    rcu_read_lock();
+
+    iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
+                                          iova, write);
+    if (iotlb.target_as != NULL) {
+        if (vhost_memory_region_lookup(dev, iotlb.translated_addr,
+                                       &uaddr, &len)) {
+            error_report("Fail to lookup the translated address "
+                         "%"PRIx64, iotlb.translated_addr);
+            goto out;
+        }
+
+        len = MIN(iotlb.addr_mask + 1, len);
+        iova = iova & ~iotlb.addr_mask;
+
+        if (dev->vhost_ops->vhost_update_device_iotlb(dev, iova, uaddr,
+                                                      len, iotlb.perm)) {
+            error_report("Fail to update device iotlb");
+            goto out;
+        }
+    }
+out:
+    rcu_read_unlock();
+}
+
 static int vhost_virtqueue_start(struct vhost_dev *dev,
                                 struct VirtIODevice *vdev,
                                 struct vhost_virtqueue *vq,
@@ -903,21 +983,21 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 
     vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = cpu_physical_memory_map(a, &l, 0);
+    vq->desc = vhost_memory_map(dev, a, &l, 0);
     if (!vq->desc || l != s) {
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
     vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = cpu_physical_memory_map(a, &l, 0);
+    vq->avail = vhost_memory_map(dev, a, &l, 0);
     if (!vq->avail || l != s) {
         r = -ENOMEM;
         goto fail_alloc_avail;
     }
     vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = cpu_physical_memory_map(a, &l, 1);
+    vq->used = vhost_memory_map(dev, a, &l, 1);
     if (!vq->used || l != s) {
         r = -ENOMEM;
         goto fail_alloc_used;
@@ -963,14 +1043,14 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 fail_vector:
 fail_kick:
 fail_alloc:
-    cpu_physical_memory_unmap(vq->used, virtio_queue_get_used_size(vdev, idx),
-                              0, 0);
+    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
+                       0, 0);
 fail_alloc_used:
-    cpu_physical_memory_unmap(vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                              0, 0);
+    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
+                       0, 0);
 fail_alloc_avail:
-    cpu_physical_memory_unmap(vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                              0, 0);
+    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
+                       0, 0);
 fail_alloc_desc:
     return r;
 }
@@ -1004,12 +1084,12 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    cpu_physical_memory_unmap(vq->used, virtio_queue_get_used_size(vdev, idx),
-                              1, virtio_queue_get_used_size(vdev, idx));
-    cpu_physical_memory_unmap(vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                              0, virtio_queue_get_avail_size(vdev, idx));
-    cpu_physical_memory_unmap(vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                              0, virtio_queue_get_desc_size(vdev, idx));
+    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
+                       1, virtio_queue_get_used_size(vdev, idx));
+    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
+                       0, virtio_queue_get_avail_size(vdev, idx));
+    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
+                       0, virtio_queue_get_desc_size(vdev, idx));
 }
 
 static void vhost_eventfd_add(MemoryListener *listener,
@@ -1066,6 +1146,9 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
         r = -errno;
         goto fail_call;
     }
+
+    vq->dev = dev;
+
     return 0;
 fail_call:
     event_notifier_cleanup(&vq->masked_notifier);
@@ -1077,12 +1160,24 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     event_notifier_cleanup(&vq->masked_notifier);
 }
 
+static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    struct vhost_dev *hdev = container_of(n, struct vhost_dev, n);
+
+    if (hdev->vhost_ops->vhost_invalidate_device_iotlb(hdev,
+                                                       iotlb->iova,
+                                                       iotlb->addr_mask + 1)) {
+        error_report("Fail to invalidate device iotlb");
+    }
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout)
 {
     uint64_t features;
     int i, r, n_initialized_vqs = 0;
 
+    hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
     r = vhost_set_backend_type(hdev, backend_type);
@@ -1147,6 +1242,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .priority = 10
     };
 
+    hdev->n.notify = vhost_iommu_unmap_notify;
+    hdev->n.notifier_flags = IOMMU_NOTIFIER_UNMAP;
+
     if (hdev->migration_blocker == NULL) {
         if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
             error_setg(&hdev->migration_blocker,
@@ -1342,11 +1440,18 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
     assert(hdev->vhost_ops);
 
     hdev->started = true;
+    hdev->vdev = vdev;
 
     r = vhost_dev_set_features(hdev, hdev->log_enabled);
     if (r < 0) {
         goto fail_features;
     }
+
+    if (vhost_dev_has_iommu(hdev)) {
+        memory_region_register_iommu_notifier(vdev->dma_as->root,
+                                              &hdev->n);
+    }
+
     r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_mem_table failed");
@@ -1380,6 +1485,16 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         }
     }
 
+    if (vhost_dev_has_iommu(hdev)) {
+        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
+
+        /* Update used ring information for IOTLB to work correctly,
+         * vhost-kernel code requires for this.*/
+        for (i = 0; i < hdev->nvqs; ++i) {
+            struct vhost_virtqueue *vq = hdev->vqs + i;
+            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+        }
+    }
     return 0;
 fail_log:
     vhost_log_put(hdev, false);
@@ -1391,6 +1506,7 @@ fail_vq:
                              hdev->vq_index + i);
     }
     i = hdev->nvqs;
+
 fail_mem:
 fail_features:
 
@@ -1413,8 +1529,14 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
                              hdev->vq_index + i);
     }
 
+    if (vhost_dev_has_iommu(hdev)) {
+        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+        memory_region_unregister_iommu_notifier(vdev->dma_as->root,
+                                                &hdev->n);
+    }
     vhost_log_put(hdev, true);
     hdev->started = false;
+    hdev->vdev = NULL;
 }
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
diff --git a/net/tap.c b/net/tap.c
index b6896a7..86071b2 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -696,6 +696,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                                  "tap: open vhost char device failed");
                 return;
             }
+            fcntl(vhostfd, F_SETFL, O_NONBLOCK);
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
 
-- 
MST
