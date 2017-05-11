Received: from eggs.gnu.org ([2001:4830:134:3::10]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d8nHX-0002a4-AW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d8nHV-0004m9-Ui
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1d8nHV-0004lL-NK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:21 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 11 May 2017 14:32:42 +0200
Message-Id: <20170511123246.31308-3-maxime.coquelin@redhat.com>
In-Reply-To: <20170511123246.31308-1-maxime.coquelin@redhat.com>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] vhost: rework IOTLB messaging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch reworks IOTLB messaging to prepare for vhost-user
device IOTLB support.

IOTLB messages handling is extracted from vhost-kernel backend,
so that only the messages transport remains backend specifics.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost-backend.c         | 135 +++++++++++++++++++++-----------------
 hw/virtio/vhost.c                 |   8 +--
 include/hw/virtio/vhost-backend.h |  23 ++++---
 3 files changed, 94 insertions(+), 72 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index be927b8..d6c38cc 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -192,7 +192,6 @@ static void vhost_kernel_iotlb_read(void *opaque)
     ssize_t len;
 
     while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
-        struct vhost_iotlb_msg *imsg = &msg.iotlb;
         if (len < sizeof msg) {
             error_report("Wrong vhost message len: %d", (int)len);
             break;
@@ -201,70 +200,21 @@ static void vhost_kernel_iotlb_read(void *opaque)
             error_report("Unknown vhost iotlb message type");
             break;
         }
-        switch (imsg->type) {
-        case VHOST_IOTLB_MISS:
-            vhost_device_iotlb_miss(dev, imsg->iova,
-                                    imsg->perm != VHOST_ACCESS_RO);
-            break;
-        case VHOST_IOTLB_UPDATE:
-        case VHOST_IOTLB_INVALIDATE:
-            error_report("Unexpected IOTLB message type");
-            break;
-        case VHOST_IOTLB_ACCESS_FAIL:
-            /* FIXME: report device iotlb error */
-            break;
-        default:
-            break;
-        }
-    }
-}
 
-static int vhost_kernel_update_device_iotlb(struct vhost_dev *dev,
-                                            uint64_t iova, uint64_t uaddr,
-                                            uint64_t len,
-                                            IOMMUAccessFlags perm)
-{
-    struct vhost_msg msg;
-    msg.type = VHOST_IOTLB_MSG;
-    msg.iotlb.iova =  iova;
-    msg.iotlb.uaddr = uaddr;
-    msg.iotlb.size = len;
-    msg.iotlb.type = VHOST_IOTLB_UPDATE;
-
-    switch (perm) {
-    case IOMMU_RO:
-        msg.iotlb.perm = VHOST_ACCESS_RO;
-        break;
-    case IOMMU_WO:
-        msg.iotlb.perm = VHOST_ACCESS_WO;
-        break;
-    case IOMMU_RW:
-        msg.iotlb.perm = VHOST_ACCESS_RW;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
-        error_report("Fail to update device iotlb");
-        return -EFAULT;
+        vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
     }
-
-    return 0;
 }
 
-static int vhost_kernel_invalidate_device_iotlb(struct vhost_dev *dev,
-                                                uint64_t iova, uint64_t len)
+static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
+                                              struct vhost_iotlb_msg *imsg)
 {
-    struct vhost_msg msg;
-
-    msg.type = VHOST_IOTLB_MSG;
-    msg.iotlb.iova = iova;
-    msg.iotlb.size = len;
-    msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
+    struct vhost_msg msg = {
+        .type = VHOST_IOTLB_MSG,
+        .iotlb = *imsg,
+    };
 
     if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
-        error_report("Fail to invalidate device iotlb");
+        error_report("Fail to update device iotlb");
         return -EFAULT;
     }
 
@@ -311,8 +261,7 @@ static const VhostOps kernel_ops = {
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
 #endif /* CONFIG_VHOST_VSOCK */
         .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
-        .vhost_update_device_iotlb = vhost_kernel_update_device_iotlb,
-        .vhost_invalidate_device_iotlb = vhost_kernel_invalidate_device_iotlb,
+        .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
 };
 
 int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
@@ -333,3 +282,69 @@ int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
 
     return r;
 }
+
+int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
+                                             uint64_t iova, uint64_t uaddr,
+                                             uint64_t len,
+                                             IOMMUAccessFlags perm)
+{
+    struct vhost_iotlb_msg imsg;
+
+    imsg.iova =  iova;
+    imsg.uaddr = uaddr;
+    imsg.size = len;
+    imsg.type = VHOST_IOTLB_UPDATE;
+
+    switch (perm) {
+    case IOMMU_RO:
+        imsg.perm = VHOST_ACCESS_RO;
+        break;
+    case IOMMU_WO:
+        imsg.perm = VHOST_ACCESS_WO;
+        break;
+    case IOMMU_RW:
+        imsg.perm = VHOST_ACCESS_RW;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+}
+
+int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
+                                                 uint64_t iova, uint64_t len)
+{
+    struct vhost_iotlb_msg imsg;
+
+    imsg.iova = iova;
+    imsg.size = len;
+    imsg.type = VHOST_IOTLB_INVALIDATE;
+
+    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+}
+
+int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
+                                          struct vhost_iotlb_msg *imsg)
+{
+    int ret = 0;
+
+    switch (imsg->type) {
+    case VHOST_IOTLB_MISS:
+        ret = vhost_device_iotlb_miss(dev, imsg->iova,
+                                      imsg->perm != VHOST_ACCESS_RO);
+        break;
+    case VHOST_IOTLB_ACCESS_FAIL:
+        /* FIXME: report device iotlb error */
+        ret = -ENOTSUP;
+        break;
+    case VHOST_IOTLB_UPDATE:
+    case VHOST_IOTLB_INVALIDATE:
+    default:
+        error_report("Unexpected IOTLB message type");
+        ret = -EINVAL;
+        break;
+    }
+
+    return ret;
+}
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 369373a..748e331 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -724,8 +724,8 @@ static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     struct vhost_dev *hdev = iommu->hdev;
     hwaddr iova = iotlb->iova + iommu->iommu_offset;
 
-    if (hdev->vhost_ops->vhost_invalidate_device_iotlb(hdev, iova,
-                                                       iotlb->addr_mask + 1)) {
+    if (vhost_backend_invalidate_device_iotlb(hdev, iova,
+                                              iotlb->addr_mask + 1)) {
         error_report("Fail to invalidate device iotlb");
     }
 }
@@ -993,8 +993,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         len = MIN(iotlb.addr_mask + 1, len);
         iova = iova & ~iotlb.addr_mask;
 
-        ret = dev->vhost_ops->vhost_update_device_iotlb(dev, iova, uaddr,
-                                                      len, iotlb.perm);
+        ret = vhost_backend_update_device_iotlb(dev, iova, uaddr,
+                                                len, iotlb.perm);
         if (ret) {
             error_report("Fail to update device iotlb");
             goto out;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index c3cf4a7..a7a5f22 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -27,6 +27,7 @@ struct vhost_vring_file;
 struct vhost_vring_state;
 struct vhost_vring_addr;
 struct vhost_scsi_target;
+struct vhost_iotlb_msg;
 
 typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
 typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
@@ -81,12 +82,8 @@ typedef int (*vhost_vsock_set_guest_cid_op)(struct vhost_dev *dev,
 typedef int (*vhost_vsock_set_running_op)(struct vhost_dev *dev, int start);
 typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
                                            int enabled);
-typedef int (*vhost_update_device_iotlb_op)(struct vhost_dev *dev,
-                                            uint64_t iova, uint64_t uaddr,
-                                            uint64_t len,
-                                            IOMMUAccessFlags perm);
-typedef int (*vhost_invalidate_device_iotlb_op)(struct vhost_dev *dev,
-                                                uint64_t iova, uint64_t len);
+typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
+                                              struct vhost_iotlb_msg *imsg);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -120,8 +117,7 @@ typedef struct VhostOps {
     vhost_vsock_set_guest_cid_op vhost_vsock_set_guest_cid;
     vhost_vsock_set_running_op vhost_vsock_set_running;
     vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
-    vhost_update_device_iotlb_op vhost_update_device_iotlb;
-    vhost_invalidate_device_iotlb_op vhost_invalidate_device_iotlb;
+    vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
 } VhostOps;
 
 extern const VhostOps user_ops;
@@ -129,4 +125,15 @@ extern const VhostOps user_ops;
 int vhost_set_backend_type(struct vhost_dev *dev,
                            VhostBackendType backend_type);
 
+int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
+                                             uint64_t iova, uint64_t uaddr,
+                                             uint64_t len,
+                                             IOMMUAccessFlags perm);
+
+int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
+                                                 uint64_t iova, uint64_t len);
+
+int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
+                                          struct vhost_iotlb_msg *imsg);
+
 #endif /* VHOST_BACKEND_H */
-- 
2.9.3
