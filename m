Received: from eggs.gnu.org ([2001:4830:134:3::10]:33861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAl-00089m-4y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAj-0005ut-TB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:39 -0500
Received: from mail.kernel.org ([198.145.29.136]:48400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAj-0005tk-Iz
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:37 -0500
Date: Tue, 10 Jan 2017 07:40:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-30-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 29/41] vhost-user: Add MTU protocol feature and
 op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Aaron Conole <aconole@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch implements VHOST_USER_PROTOCOL_F_NET_MTU
protocol feature and VHOST_USER_NET_SET_MTU request so
that the backend gets notified of the user defined host
MTU.

If backend supports VHOST_USER_PROTOCOL_F_REPLY_ACK,
QEMU assumes MTU is valid if success is returned.

Vhost-net driver sends this request through a new
vhost_net_set_mtu vhost_ops entry.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/vhost-user.txt         | 16 ++++++++++++++++
 include/hw/virtio/vhost-backend.h |  2 ++
 hw/virtio/vhost-user.c            | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index d70bd83..036890f 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -259,6 +259,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_LOG_SHMFD      1
 #define VHOST_USER_PROTOCOL_F_RARP           2
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
+#define VHOST_USER_PROTOCOL_F_MTU            4
 
 Message types
 -------------
@@ -470,6 +471,21 @@ Message types
       The first 6 bytes of the payload contain the mac address of the guest to
       allow the vhost user backend to construct and broadcast the fake RARP.
 
+ * VHOST_USER_NET_SET_MTU
+
+      Id: 20
+      Equivalent ioctl: N/A
+      Master payload: u64
+
+      Set host MTU value exposed to the guest.
+      This request should be sent only when VIRTIO_NET_F_MTU feature has been
+      successfully negotiated, VHOST_USER_F_PROTOCOL_FEATURES is present in
+      VHOST_USER_GET_FEATURES and protocol feature bit
+      VHOST_USER_PROTOCOL_F_NET_MTU is present in
+      VHOST_USER_GET_PROTOCOL_FEATURES.
+      If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respond
+      with zero in case the specified MTU is valid, or non-zero otherwise.
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 6e90703..30abc11 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -32,6 +32,7 @@ typedef int (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
 
 typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
                                 struct vhost_vring_file *file);
+typedef int (*vhost_net_set_mtu_op)(struct vhost_dev *dev, uint16_t mtu);
 typedef int (*vhost_scsi_set_endpoint_op)(struct vhost_dev *dev,
                                   struct vhost_scsi_target *target);
 typedef int (*vhost_scsi_clear_endpoint_op)(struct vhost_dev *dev,
@@ -83,6 +84,7 @@ typedef struct VhostOps {
     vhost_backend_cleanup vhost_backend_cleanup;
     vhost_backend_memslots_limit vhost_backend_memslots_limit;
     vhost_net_set_backend_op vhost_net_set_backend;
+    vhost_net_set_mtu_op vhost_net_set_mtu;
     vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint;
     vhost_scsi_clear_endpoint_op vhost_scsi_clear_endpoint;
     vhost_scsi_get_abi_version_op vhost_scsi_get_abi_version;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7ee92b3..9334a8a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
     VHOST_USER_PROTOCOL_F_RARP = 2,
     VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -59,6 +60,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_QUEUE_NUM = 17,
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_SEND_RARP = 19,
+    VHOST_USER_NET_SET_MTU = 20,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -186,6 +188,7 @@ static bool vhost_user_one_time_request(VhostUserRequest request)
     case VHOST_USER_RESET_OWNER:
     case VHOST_USER_SET_MEM_TABLE:
     case VHOST_USER_GET_QUEUE_NUM:
+    case VHOST_USER_NET_SET_MTU:
         return true;
     default:
         return false;
@@ -685,6 +688,36 @@ static bool vhost_user_can_merge(struct vhost_dev *dev,
     return mfd == rfd;
 }
 
+static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
+{
+    VhostUserMsg msg;
+    bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+
+    if (!(dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_NET_MTU))) {
+        return 0;
+    }
+
+    msg.request = VHOST_USER_NET_SET_MTU;
+    msg.payload.u64 = mtu;
+    msg.size = sizeof(msg.payload.u64);
+    msg.flags = VHOST_USER_VERSION;
+    if (reply_supported) {
+        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    /* If reply_ack supported, slave has to ack specified MTU is valid */
+    if (reply_supported) {
+        return process_message_reply(dev, msg.request);
+    }
+
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
@@ -708,4 +741,5 @@ const VhostOps user_ops = {
         .vhost_requires_shm_log = vhost_user_requires_shm_log,
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_backend_can_merge = vhost_user_can_merge,
+        .vhost_net_set_mtu = vhost_user_net_set_mtu,
 };
-- 
MST
