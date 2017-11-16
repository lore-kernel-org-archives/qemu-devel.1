Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eFQzH-0007bb-QI
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eFQzG-0001gT-Nn
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:42:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:34527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eFQzG-0001ZF-Aw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:42:14 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Fri, 17 Nov 2017 04:44:39 +0800
Message-Id: <1510865080-32027-4-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v5 3/4] contrib/libvhost-user: enable virtio
 config space messages
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

Enable VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG/VHOST_USER_SET_CONFIG_FD
messages in libvhost-user library, users can implement their own I/O target
based on the library. This enable the virtio config space delivered between
Qemu host device and the I/O target, also event notifier is added in case
of virtio config space changed.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 contrib/libvhost-user/libvhost-user.c | 79 +++++++++++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h | 24 ++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index f409bd3..16fc4f2 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -84,6 +84,9 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_SET_SLAVE_REQ_FD),
         REQ(VHOST_USER_IOTLB_MSG),
         REQ(VHOST_USER_SET_VRING_ENDIAN),
+        REQ(VHOST_USER_GET_CONFIG),
+        REQ(VHOST_USER_SET_CONFIG),
+        REQ(VHOST_USER_SET_CONFIG_FD),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -798,6 +801,69 @@ vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
+vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int ret = -1;
+
+    if (dev->iface->get_config) {
+        ret = dev->iface->get_config(dev, vmsg->payload.config.region,
+                                     sizeof(vmsg->payload.config.region));
+    }
+
+    if (ret) {
+        /* resize to zero to indicate an error to master */
+        vmsg->size = 0;
+    }
+
+    return true;
+}
+
+static bool
+vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int ret = -1;
+    bool reply_supported = !!(dev->protocol_features &
+                             (1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK));
+
+    if (dev->iface->set_config) {
+        ret = dev->iface->set_config(dev, vmsg->payload.config.region,
+                                     vmsg->payload.config.offset,
+                                     vmsg->payload.config.size);
+    }
+
+    vmsg->size = sizeof(vmsg->payload.u64);
+    if (!ret) {
+        vmsg->payload.u64 = 0;
+    } else {
+        /* indicate an error in case reply supported */
+        vmsg->payload.u64 = 1;
+    }
+
+    if (reply_supported) {
+        return true;
+    }
+
+    return false;
+}
+
+static bool
+vu_set_config_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+   if (vmsg->fd_num != 1) {
+        vu_panic(dev, "Invalid config_fd message");
+        return false;
+    }
+
+    if (dev->config_fd != -1) {
+        close(dev->config_fd);
+    }
+    dev->config_fd = vmsg->fds[0];
+    DPRINT("Got config_fd: %d\n", vmsg->fds[0]);
+
+    return false;
+}
+
+static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
     int do_reply = 0;
@@ -862,6 +928,12 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_vring_enable_exec(dev, vmsg);
     case VHOST_USER_SET_SLAVE_REQ_FD:
         return vu_set_slave_req_fd(dev, vmsg);
+    case VHOST_USER_GET_CONFIG:
+        return vu_get_config(dev, vmsg);
+    case VHOST_USER_SET_CONFIG:
+        return vu_set_config(dev, vmsg);
+    case VHOST_USER_SET_CONFIG_FD:
+        return vu_set_config_fd(dev, vmsg);
     case VHOST_USER_NONE:
         break;
     default:
@@ -940,6 +1012,11 @@ vu_deinit(VuDev *dev)
         dev->slave_fd = -1;
     }
 
+    if (dev->config_fd != -1) {
+        close(dev->config_fd);
+        dev->config_fd = -1;
+    }
+
     if (dev->sock != -1) {
         close(dev->sock);
     }
@@ -970,6 +1047,8 @@ vu_init(VuDev *dev,
     dev->iface = iface;
     dev->log_call_fd = -1;
     dev->slave_fd = -1;
+    dev->config_fd = -1;
+
     for (i = 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
         dev->vq[i] = (VuVirtq) {
             .call_fd = -1, .kick_fd = -1, .err_fd = -1,
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 2f5864b..0d1f674 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -30,6 +30,11 @@
 
 #define VHOST_MEMORY_MAX_NREGIONS 8
 
+/*
+ * Maximum size of virtio device config space
+ */
+#define VHOST_USER_MAX_CONFIG_SIZE 256
+
 enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
@@ -38,7 +43,6 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
-
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -69,6 +73,9 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
     VHOST_USER_IOTLB_MSG = 22,
     VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_GET_CONFIG = 24,
+    VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_SET_CONFIG_FD = 26,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -90,6 +97,12 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
 
+typedef struct VhostUserConfig {
+    uint32_t offset;
+    uint32_t size;
+    uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
+} VhostUserConfig;
+
 #if defined(_WIN32)
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -112,6 +125,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        VhostUserConfig config;
     } payload;
 
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -140,6 +154,9 @@ typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
+typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, size_t len);
+typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *config,
+                                 uint32_t offset, uint32_t size);
 
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
@@ -162,6 +179,10 @@ typedef struct VuDevIface {
      * on unmanaged exit/crash.
      */
     vu_queue_is_processed_in_order_cb queue_is_processed_in_order;
+    /* get the config space of the device */
+    vu_get_config_cb get_config;
+    /* set the config space of the device */
+    vu_set_config_cb set_config;
 } VuDevIface;
 
 typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
@@ -227,6 +248,7 @@ struct VuDev {
     VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
     int log_call_fd;
     int slave_fd;
+    int config_fd;
     uint64_t log_size;
     uint8_t *log_table;
     uint64_t features;
-- 
1.9.3
