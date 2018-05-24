Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLnYo-0003Si-Gg
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLnYn-00054w-CE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:6501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fLnYn-00053t-07
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:29 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 24 May 2018 18:33:35 +0800
Message-Id: <20180524103336.21233-6-tiwei.bie@intel.com>
In-Reply-To: <20180524103336.21233-1-tiwei.bie@intel.com>
References: <20180524103336.21233-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH 5/6] libvhost-user: support host notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com

This patch introduces the host notifier support in
libvhost-user. A new API is added to support setting
host notifier for each queue.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 contrib/libvhost-user/libvhost-user.c | 81 ++++++++++++++++++++++++---
 contrib/libvhost-user/libvhost-user.h | 32 +++++++++++
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 54e643d871..a6b46cdc03 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -314,11 +314,6 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         msg.msg_controllen = 0;
     }
 
-    /* Set the version in the flags when sending the reply */
-    vmsg->flags &= ~VHOST_USER_VERSION_MASK;
-    vmsg->flags |= VHOST_USER_VERSION;
-    vmsg->flags |= VHOST_USER_REPLY_MASK;
-
     do {
         rc = sendmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
@@ -341,6 +336,39 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
     return true;
 }
 
+static bool
+vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    /* Set the version in the flags when sending the reply */
+    vmsg->flags &= ~VHOST_USER_VERSION_MASK;
+    vmsg->flags |= VHOST_USER_VERSION;
+    vmsg->flags |= VHOST_USER_REPLY_MASK;
+
+    return vu_message_write(dev, conn_fd, vmsg);
+}
+
+static bool
+vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
+{
+    VhostUserMsg msg_reply;
+
+    if ((vmsg->flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
+        return true;
+    }
+
+    if (!vu_message_read(dev, dev->slave_fd, &msg_reply)) {
+        return false;
+    }
+
+    if (msg_reply.request != vmsg->request) {
+        DPRINT("Received unexpected msg type. Expected %d received %d",
+               vmsg->request, msg_reply.request);
+        return false;
+    }
+
+    return msg_reply.payload.u64 == 0;
+}
+
 /* Kick the log_call_fd if required. */
 static void
 vu_log_kick(VuDev *dev)
@@ -536,7 +564,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 
     /* Send the message back to qemu with the addresses filled in */
     vmsg->fd_num = 0;
-    if (!vu_message_write(dev, dev->sock, vmsg)) {
+    if (!vu_send_reply(dev, dev->sock, vmsg)) {
         vu_panic(dev, "failed to respond to set-mem-table for postcopy");
         return false;
     }
@@ -916,6 +944,41 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
     }
 }
 
+bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
+                                int size, int offset)
+{
+    int qidx = vq - dev->vq;
+    int fd_num = 0;
+    VhostUserMsg vmsg = {
+        .request = VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG,
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .size = sizeof(vmsg.payload.area),
+        .payload.area = {
+            .u64 = qidx & VHOST_USER_VRING_IDX_MASK,
+            .size = size,
+            .offset = offset,
+        },
+    };
+
+    if (fd == -1) {
+        vmsg.payload.area.u64 |= VHOST_USER_VRING_NOFD_MASK;
+    } else {
+        vmsg.fds[fd_num++] = fd;
+    }
+
+    vmsg.fd_num = fd_num;
+
+    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) == 0) {
+        return false;
+    }
+
+    if (!vu_message_write(dev, dev->slave_fd, &vmsg)) {
+        return false;
+    }
+
+    return vu_process_message_reply(dev, &vmsg);
+}
+
 static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -968,7 +1031,9 @@ static bool
 vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
-                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ;
+                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
+                        1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER |
+                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD;
 
     if (have_userfault()) {
         features |= 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
@@ -1252,7 +1317,7 @@ vu_dispatch(VuDev *dev)
         goto end;
     }
 
-    if (!vu_message_write(dev, dev->sock, &vmsg)) {
+    if (!vu_send_reply(dev, dev->sock, &vmsg)) {
         goto end;
     }
 
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index b27075ea3b..4aa55b4d2d 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -51,6 +51,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
     VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
+    VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
+    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -92,6 +94,14 @@ typedef enum VhostUserRequest {
     VHOST_USER_MAX
 } VhostUserRequest;
 
+typedef enum VhostUserSlaveRequest {
+    VHOST_USER_SLAVE_NONE = 0,
+    VHOST_USER_SLAVE_IOTLB_MSG = 1,
+    VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
+    VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
+    VHOST_USER_SLAVE_MAX
+}  VhostUserSlaveRequest;
+
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
@@ -122,6 +132,12 @@ static VhostUserConfig c __attribute__ ((unused));
                                    + sizeof(c.size) \
                                    + sizeof(c.flags))
 
+typedef struct VhostUserVringArea {
+    uint64_t u64;
+    uint64_t size;
+    uint64_t offset;
+} VhostUserVringArea;
+
 #if defined(_WIN32)
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -133,6 +149,7 @@ typedef struct VhostUserMsg {
 
 #define VHOST_USER_VERSION_MASK     (0x3)
 #define VHOST_USER_REPLY_MASK       (0x1 << 2)
+#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
     uint32_t flags;
     uint32_t size; /* the following payload size */
 
@@ -145,6 +162,7 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         VhostUserConfig config;
+        VhostUserVringArea area;
     } payload;
 
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -368,6 +386,20 @@ VuVirtq *vu_get_queue(VuDev *dev, int qidx);
 void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
                           vu_queue_handler_cb handler);
 
+/**
+ * vu_set_queue_host_notifier:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @fd: a file descriptor
+ * @size: host page size
+ * @offset: notifier offset in @fd file
+ *
+ * Set queue's host notifier. This function may be called several
+ * times for the same queue. If called with -1 @fd, the notifier
+ * is removed.
+ */
+bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
+                                int size, int offset);
 
 /**
  * vu_queue_set_notification:
-- 
2.17.0
