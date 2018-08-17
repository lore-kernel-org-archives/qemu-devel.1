Received: from eggs.gnu.org ([2001:4830:134:3::10]:44661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fqaG2-00060q-3J
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fqaG0-0005T1-O5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:37:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fqaFy-0005PL-Ky
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:37:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 800317A7E8
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 08:37:16 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Aug 2018 16:37:07 +0800
Message-Id: <1534495027-6621-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1534495027-6621-1-git-send-email-jasowang@redhat.com>
References: <1534495027-6621-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] vhost: switch to use IOTLB v2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

This patch tries to switch to use new kernel IOTLB format V2. Previous
version may have inconsistent ABI between 32bit and 64bit machines
because of the hole after type field. Refer kernel commit
("429711aec282 vhost: switch to use new message format") for more
information.

To enable this feature, qemu need to use a new ioctl
VHOST_SET_BACKEND_FEATURE with VHOST_BACKEND_F_IOTLB_MSG_V2 bit. A new
pair of setting and getting backend features ops was introduced. And
when we try to set features for vhost dev, we will examine the support
of new IOTLB format and enable it. This process is total transparent
to guest, which means we can have different IOTLB message type in src
and dst during migration.

The conversion of IOTLB message is straightforward, just check the
type and behave accordingly.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost-backend.c         | 77 +++++++++++++++++++++++++++++++--------
 hw/virtio/vhost.c                 | 18 +++++++++
 include/hw/virtio/vhost-backend.h |  6 +++
 include/hw/virtio/vhost.h         |  2 +
 4 files changed, 87 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 7f09efa..1a68719 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -151,12 +151,24 @@ static int vhost_kernel_set_features(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
 }
 
+static int vhost_kernel_set_backend_features(struct vhost_dev *dev,
+                                     uint64_t features)
+{
+    return vhost_kernel_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
+}
+
 static int vhost_kernel_get_features(struct vhost_dev *dev,
                                      uint64_t *features)
 {
     return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
 }
 
+static int vhost_kernel_get_backend_features(struct vhost_dev *dev,
+                                             uint64_t *features)
+{
+    return vhost_kernel_call(dev, VHOST_GET_BACKEND_FEATURES, features);
+}
+
 static int vhost_kernel_set_owner(struct vhost_dev *dev)
 {
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
@@ -190,34 +202,65 @@ static int vhost_kernel_vsock_set_running(struct vhost_dev *dev, int start)
 static void vhost_kernel_iotlb_read(void *opaque)
 {
     struct vhost_dev *dev = opaque;
-    struct vhost_msg msg;
     ssize_t len;
 
-    while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
-        if (len < sizeof msg) {
-            error_report("Wrong vhost message len: %d", (int)len);
-            break;
+    if (dev->acked_backend_cap & 0x1ULL <<
+        VHOST_BACKEND_F_IOTLB_MSG_V2) {
+        struct vhost_msg_v2 msg;
+
+        while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
+            if (len < sizeof msg) {
+                error_report("Wrong vhost message len: %d", (int)len);
+                break;
+            }
+            if (msg.type != VHOST_IOTLB_MSG_V2) {
+                error_report("Unknown vhost iotlb message type");
+                break;
+            }
+
+            vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
         }
-        if (msg.type != VHOST_IOTLB_MSG) {
-            error_report("Unknown vhost iotlb message type");
-            break;
+    } else {
+        struct vhost_msg msg;
+
+        while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
+            if (len < sizeof msg) {
+                error_report("Wrong vhost message len: %d", (int)len);
+                break;
+            }
+            if (msg.type != VHOST_IOTLB_MSG) {
+                error_report("Unknown vhost iotlb message type");
+                break;
+            }
+
+            vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
         }
-
-        vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
     }
 }
 
 static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg)
 {
-    struct vhost_msg msg;
+    if (dev->acked_backend_cap & 1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) {
+        struct vhost_msg_v2 msg;
+
+        msg.type = VHOST_IOTLB_MSG_V2;
+        msg.iotlb = *imsg;
 
-    msg.type = VHOST_IOTLB_MSG;
-    msg.iotlb = *imsg;
+        if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
+            error_report("Fail to update device iotlb");
+            return -EFAULT;
+        }
+    } else {
+        struct vhost_msg msg;
+
+        msg.type = VHOST_IOTLB_MSG;
+        msg.iotlb = *imsg;
 
-    if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
-        error_report("Fail to update device iotlb");
-        return -EFAULT;
+        if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
+            error_report("Fail to update device iotlb");
+            return -EFAULT;
+        }
     }
 
     return 0;
@@ -254,7 +297,9 @@ static const VhostOps kernel_ops = {
         .vhost_set_vring_busyloop_timeout =
                                 vhost_kernel_set_vring_busyloop_timeout,
         .vhost_set_features = vhost_kernel_set_features,
+        .vhost_set_backend_features = vhost_kernel_set_backend_features,
         .vhost_get_features = vhost_kernel_get_features,
+        .vhost_get_backend_features = vhost_kernel_get_backend_features,
         .vhost_set_owner = vhost_kernel_set_owner,
         .vhost_reset_device = vhost_kernel_reset_device,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d4cb589..16f3776 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -738,6 +738,7 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
                                   bool enable_log)
 {
     uint64_t features = dev->acked_features;
+    uint64_t iotlb_v2 = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2;
     int r;
     if (enable_log) {
         features |= 0x1ULL << VHOST_F_LOG_ALL;
@@ -745,7 +746,24 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
     r = dev->vhost_ops->vhost_set_features(dev, features);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_features failed");
+        goto out;
+    }
+    if (dev->vhost_ops->vhost_get_backend_features) {
+        r = dev->vhost_ops->vhost_get_backend_features(dev, &dev->backend_cap);
+        if (!r && dev->backend_cap & iotlb_v2) {
+            r = dev->vhost_ops->vhost_set_backend_features(dev, iotlb_v2);
+            if (r < 0) {
+                VHOST_OPS_DEBUG("vhost_set_backend_features failed");
+                goto out;
+            }
+            dev->acked_backend_cap = iotlb_v2;
+            goto out;
+        }
+        r = 0;
     }
+    dev->backend_cap = dev->acked_backend_cap = 0;
+
+out:
     return r < 0 ? -errno : 0;
 }
 
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 81283ec..5f0eacf 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -69,8 +69,12 @@ typedef int (*vhost_set_vring_busyloop_timeout_op)(struct vhost_dev *dev,
                                                    struct vhost_vring_state *r);
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
+typedef int (*vhost_set_backend_features_op)(struct vhost_dev *dev,
+                                     uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
+typedef int (*vhost_get_backend_features_op)(struct vhost_dev *dev,
+                                             uint64_t *features);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
@@ -126,6 +130,8 @@ typedef struct VhostOps {
     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
+    vhost_set_backend_features_op vhost_set_backend_features;
+    vhost_get_backend_features_op vhost_get_backend_features;
     vhost_set_owner_op vhost_set_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a7f449f..a8b4ba9 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -71,6 +71,8 @@ struct vhost_dev {
     uint64_t backend_features;
     uint64_t protocol_features;
     uint64_t max_queues;
+    uint64_t backend_cap;
+    uint64_t acked_backend_cap;
     bool started;
     bool log_enabled;
     uint64_t log_size;
-- 
2.7.4
