Received: from eggs.gnu.org ([2001:4830:134:3::10]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eFQzF-0007az-30
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eFQzB-0001Wb-4i
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:42:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:34523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eFQzA-0001TX-Pl
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:42:09 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Fri, 17 Nov 2017 04:44:37 +0800
Message-Id: <1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v5 1/4] vhost-user: add new vhost user messages
 to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: changpeng.liu@intel.com, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
used for live migration of vhost user devices, also vhost user devices
can benefit from the messages to get/set virtio config space from/to the
I/O target. For the purpose to support virtio config space change,
VHOST_USER_SET_CONFIG_FD message is added as the event notifier
in case virtio config space change in the I/O target.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 docs/interop/vhost-user.txt       | 39 ++++++++++++++++
 hw/virtio/vhost-user.c            | 98 +++++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 | 63 +++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  8 ++++
 include/hw/virtio/vhost.h         | 16 +++++++
 5 files changed, 224 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 954771d..1b98388 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -116,6 +116,16 @@ Depending on the request type, payload can be:
     - 3: IOTLB invalidate
     - 4: IOTLB access fail
 
+ * Virtio device config space
+   ---------------------------
+   | offset | size | payload |
+   ---------------------------
+
+   Offset: a 32-bit offset of virtio device's configuration space
+   Size: a 32-bit size of configuration space that master wanted to change
+   Payload: a 256-bytes array holding the contents of the virtio
+       device's configuration space
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -129,6 +139,7 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
+        VhostUserConfig config;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -596,6 +607,34 @@ Master message types
       and expect this message once (per VQ) during device configuration
       (ie. before the master starts the VQ).
 
+ * VHOST_USER_GET_CONFIG
+      Id: 24
+      Equivalent ioctl: N/A
+      Master payload: virtio device config space
+
+      Submitted by the vhost-user master to fetch the contents of the virtio
+      device configuration space. The vhost-user master may cache the contents
+      to avoid repeated VHOST_USER_GET_CONFIG calls.
+
+* VHOST_USER_SET_CONFIG
+      Id: 25
+      Equivalent ioctl: N/A
+      Master payload: virtio device config space
+
+      Submitted by the vhost-user master when the Guest changes the virtio
+      device configuration space and also can be used for live migration
+      on the destination host.
+
+* VHOST_USER_SET_CONFIG_FD
+      Id: 26
+      Equivalent ioctl: N/A
+      Master payload: N/A
+
+      Sets the notifier file descriptor, which is passed as ancillary data.
+      The vhost-user slave uses the file descriptor to notify the vhost-user
+      master of changes to the virtio configuration space. The vhost-user
+      master can read the virtio configuration space to get the latest update.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675e..ef1687b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -26,6 +26,11 @@
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 
+/*
+ * Maximum size of virtio device config space
+ */
+#define VHOST_USER_MAX_CONFIG_SIZE 256
+
 enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
@@ -65,6 +70,9 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
     VHOST_USER_IOTLB_MSG = 22,
     VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_GET_CONFIG = 24,
+    VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_SET_CONFIG_FD = 26,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -92,6 +100,12 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
 
+typedef struct VhostUserConfig {
+    uint32_t offset;
+    uint32_t size;
+    uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
+} VhostUserConfig;
+
 typedef struct VhostUserMsg {
     VhostUserRequest request;
 
@@ -109,6 +123,7 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
+        VhostUserConfig config;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -922,6 +937,86 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
     /* No-op as the receive channel is not dedicated to IOTLB messages. */
 }
 
+static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
+                                 size_t config_len)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_GET_CONFIG,
+        .flags = VHOST_USER_VERSION,
+        .size = sizeof(msg.payload.config),
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        return -1;
+    }
+
+    if (msg.request != VHOST_USER_GET_CONFIG) {
+        error_report("Received unexpected msg type. Expected %d received %d",
+                     VHOST_USER_GET_CONFIG, msg.request);
+        return -1;
+    }
+
+    if (msg.size != sizeof(msg.payload.config)) {
+        error_report("Received bad msg size.");
+        return -1;
+    }
+
+    memcpy(config, msg.payload.config.region, config_len);
+
+    return 0;
+}
+
+static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *config,
+                                 uint32_t offset, uint32_t size)
+{
+    uint8_t *p;
+    bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+
+    VhostUserMsg msg = {
+        .request = VHOST_USER_SET_CONFIG,
+        .flags = VHOST_USER_VERSION,
+        .size = sizeof(msg.payload.config),
+    };
+
+    if (reply_supported) {
+        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    msg.payload.config.offset = offset;
+    msg.payload.config.size = size;
+    p = msg.payload.config.region;
+    memcpy(p + offset, config + offset, size);
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    if (reply_supported) {
+        return process_message_reply(dev, &msg);
+    }
+
+    return 0;
+}
+
+static int vhost_user_set_config_fd(struct vhost_dev *dev, int fd)
+{
+    VhostUserMsg msg = {
+       .request = VHOST_USER_SET_CONFIG_FD,
+       .flags = VHOST_USER_VERSION,
+    };
+
+    if (vhost_user_write(dev, &msg, &fd, 1) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
@@ -948,4 +1043,7 @@ const VhostOps user_ops = {
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
         .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
+        .vhost_get_config = vhost_user_get_config,
+        .vhost_set_config = vhost_user_set_config,
+        .vhost_set_config_fd = vhost_user_set_config_fd,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddc42f0..744ca85 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1354,6 +1354,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     for (i = 0; i < hdev->nvqs; ++i) {
         vhost_virtqueue_cleanup(hdev->vqs + i);
     }
+    if (hdev->config_ops) {
+        event_notifier_cleanup(&hdev->config_notifier);
+    }
     if (hdev->mem) {
         /* those are only safe after successful init */
         memory_listener_unregister(&hdev->memory_listener);
@@ -1501,6 +1504,66 @@ void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
     }
 }
 
+int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config,
+                         size_t config_len)
+{
+    assert(hdev->vhost_ops);
+
+    if (hdev->vhost_ops->vhost_get_config) {
+        return hdev->vhost_ops->vhost_get_config(hdev, config, config_len);
+    }
+
+    return 0;
+}
+
+int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *config,
+                         uint32_t offset, uint32_t size)
+{
+    assert(hdev->vhost_ops);
+
+    if (hdev->vhost_ops->vhost_set_config) {
+        return hdev->vhost_ops->vhost_set_config(hdev, config, offset, size);
+    }
+
+    return 0;
+}
+
+static void vhost_dev_config_notifier_read(EventNotifier *n)
+{
+    struct vhost_dev *hdev = container_of(n, struct vhost_dev,
+                                         config_notifier);
+
+    if (event_notifier_test_and_clear(n)) {
+        if (hdev->config_ops) {
+            hdev->config_ops->vhost_dev_config_notifier(hdev);
+        }
+    }
+}
+
+int vhost_dev_set_config_notifier(struct vhost_dev *hdev,
+                                  const VhostDevConfigOps *ops)
+{
+    int r, fd;
+
+    assert(hdev->vhost_ops);
+
+    r = event_notifier_init(&hdev->config_notifier, 0);
+    if (r < 0) {
+        return r;
+    }
+
+    hdev->config_ops = ops;
+    event_notifier_set_handler(&hdev->config_notifier,
+                               vhost_dev_config_notifier_read);
+
+    if (hdev->vhost_ops->vhost_set_config_fd) {
+        fd  = event_notifier_get_fd(&hdev->config_notifier);
+        return hdev->vhost_ops->vhost_set_config_fd(hdev, fd);
+    }
+
+    return 0;
+}
+
 /* Host notifiers must be enabled at this point. */
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a7a5f22..3ab0b79 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -84,6 +84,11 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
                                            int enabled);
 typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg);
+typedef int (*vhost_set_config_op)(struct vhost_dev *dev, const uint8_t *config,
+                                   uint32_t offset, uint32_t size);
+typedef int (*vhost_get_config_op)(struct vhost_dev *dev, uint8_t *config,
+                                   size_t config_len);
+typedef int (*vhost_set_config_fd_op)(struct vhost_dev *dev, int fd);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -118,6 +123,9 @@ typedef struct VhostOps {
     vhost_vsock_set_running_op vhost_vsock_set_running;
     vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
     vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
+    vhost_get_config_op vhost_get_config;
+    vhost_set_config_op vhost_set_config;
+    vhost_set_config_fd_op vhost_set_config_fd;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 467dc77..593056d 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -46,6 +46,12 @@ struct vhost_iommu {
     QLIST_ENTRY(vhost_iommu) iommu_next;
 };
 
+typedef struct VhostDevConfigOps {
+    /* Vhost device config space changed callback
+     */
+    void (*vhost_dev_config_notifier)(struct vhost_dev *dev);
+} VhostDevConfigOps;
+
 struct vhost_memory;
 struct vhost_dev {
     VirtIODevice *vdev;
@@ -76,6 +82,8 @@ struct vhost_dev {
     QLIST_ENTRY(vhost_dev) entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
+    EventNotifier config_notifier;
+    const VhostDevConfigOps *config_ops;
 };
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -106,4 +114,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
 int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
+int vhost_dev_get_config(struct vhost_dev *dev, uint8_t *config,
+                         size_t config_len);
+int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *config,
+                         uint32_t offset, uint32_t size);
+/* notifier callback in case vhost device config space changed
+ */
+int vhost_dev_set_config_notifier(struct vhost_dev *dev,
+                                  const VhostDevConfigOps *ops);
 #endif
-- 
1.9.3
