Received: from eggs.gnu.org ([2001:4830:134:3::10]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1drJGV-0001DS-EF
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1drJGT-0007eQ-GA
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:36:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:49932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1drJGT-0007dn-4H
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:36:17 -0400
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Tue, 12 Sep 2017 15:56:15 +0800
Message-Id: <1505202976-1784-4-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1505202976-1784-1-git-send-email-changpeng.liu@intel.com>
References: <1505202976-1784-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v3 3/4] contrib/libvhost-user: enable virtio
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
 contrib/libvhost-user/libvhost-user.c | 74 +++++++++++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h | 15 +++++++
 2 files changed, 89 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d27d630..ff37d6b 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -63,6 +63,9 @@ vu_request_to_string(int req)
         REQ(VHOST_USER_SET_VRING_ENABLE),
         REQ(VHOST_USER_SEND_RARP),
         REQ(VHOST_USER_INPUT_GET_CONFIG),
+        REQ(VHOST_USER_GET_CONFIG),
+        REQ(VHOST_USER_SET_CONFIG),
+        REQ(VHOST_USER_SET_CONFIG_FD),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -757,6 +760,66 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
+vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int ret = -1;
+
+    if (dev->iface->get_config) {
+        ret = dev->iface->get_config(dev, vmsg->payload.config, vmsg->size);
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
+        ret = dev->iface->set_config(dev, vmsg->payload.config, vmsg->size);
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
@@ -819,6 +882,12 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_get_queue_num_exec(dev, vmsg);
     case VHOST_USER_SET_VRING_ENABLE:
         return vu_set_vring_enable_exec(dev, vmsg);
+    case VHOST_USER_GET_CONFIG:
+        return vu_get_config(dev, vmsg);
+    case VHOST_USER_SET_CONFIG:
+        return vu_set_config(dev, vmsg);
+    case VHOST_USER_SET_CONFIG_FD:
+        return vu_set_config_fd(dev, vmsg);
     case VHOST_USER_NONE:
         break;
     default:
@@ -893,6 +962,10 @@ vu_deinit(VuDev *dev)
 
     vu_close_log(dev);
 
+    if (dev->config_fd != -1) {
+        close(dev->config_fd);
+    }
+
     if (dev->sock != -1) {
         close(dev->sock);
     }
@@ -922,6 +995,7 @@ vu_init(VuDev *dev,
     dev->remove_watch = remove_watch;
     dev->iface = iface;
     dev->log_call_fd = -1;
+    dev->config_fd = -1;
     for (i = 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
         dev->vq[i] = (VuVirtq) {
             .call_fd = -1, .kick_fd = -1, .err_fd = -1,
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 4021f11..15167b8 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -30,10 +30,13 @@
 
 #define VHOST_MEMORY_MAX_NREGIONS 8
 
+#define VHOST_USER_MAX_CONFIG_SIZE 256
+
 enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
     VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -62,6 +65,9 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_SEND_RARP = 19,
     VHOST_USER_INPUT_GET_CONFIG = 20,
+    VHOST_USER_GET_CONFIG = 24,
+    VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_SET_CONFIG_FD = 26,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -105,6 +111,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        uint8_t config[VHOST_USER_MAX_CONFIG_SIZE];
     } payload;
 
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -133,6 +140,9 @@ typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
+typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, size_t len);
+typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *config,
+                                 size_t len);
 
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
@@ -155,6 +165,10 @@ typedef struct VuDevIface {
      * on unmanaged exit/crash.
      */
     vu_queue_is_processed_in_order_cb queue_is_processed_in_order;
+    /* get the config space of the device */
+    vu_get_config_cb get_config;
+    /* set the config space of the device */
+    vu_set_config_cb set_config;
 } VuDevIface;
 
 typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
@@ -219,6 +233,7 @@ struct VuDev {
     VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
     VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
     int log_call_fd;
+    int config_fd;
     uint64_t log_size;
     uint8_t *log_table;
     uint64_t features;
-- 
1.9.3
