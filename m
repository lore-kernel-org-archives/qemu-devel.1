Received: from eggs.gnu.org ([2001:4830:134:3::10]:34570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpXP-0008BY-48
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpXM-0006VE-FN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGpXM-0006Up-5N
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:56 -0400
Date: Fri, 2 Jun 2017 19:34:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496421247-857-9-git-send-email-mst@redhat.com>
References: <1496421247-857-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496421247-857-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch specifies and implements the master/slave communication
to support device IOTLB in slave.

The vhost_iotlb_msg structure introduced for kernel backends is
re-used, making the design close between the two backends.

An exception is the use of the secondary channel to enable the
slave to send IOTLB miss requests to the master.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/vhost-user.txt | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/net/vhost_net.c        |  1 +
 hw/virtio/vhost-user.c    | 48 +++++++++++++++++++++++++--
 3 files changed, 130 insertions(+), 3 deletions(-)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index 5fa7016..481ab56 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -97,6 +97,25 @@ Depending on the request type, payload can be:
    log offset: offset from start of supplied file descriptor
        where logging starts (i.e. where guest address 0 would be logged)
 
+ * An IOTLB message
+   ---------------------------------------------------------
+   | iova | size | user address | permissions flags | type |
+   ---------------------------------------------------------
+
+   IOVA: a 64-bit I/O virtual address programmed by the guest
+   Size: a 64-bit size
+   User address: a 64-bit user address
+   Permissions: a 8-bit value:
+    - 0: No access
+    - 1: Read access
+    - 2: Write access
+    - 3: Read/Write access
+   Type: a 8-bit IOTLB message type:
+    - 1: IOTLB miss
+    - 2: IOTLB update
+    - 3: IOTLB invalidate
+    - 4: IOTLB access fail
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -109,6 +128,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        struct vhost_iotlb_msg iotlb;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -253,6 +273,38 @@ Once the source has finished migration, rings will be stopped by
 the source. No further update must be done before rings are
 restarted.
 
+IOMMU support
+-------------
+
+When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated, the master
+sends IOTLB entries update & invalidation by sending VHOST_USER_IOTLB_MSG
+requests to the slave with a struct vhost_iotlb_msg as payload. For update
+events, the iotlb payload has to be filled with the update message type (2),
+the I/O virtual address, the size, the user virtual address, and the
+permissions flags. Addresses and size must be within vhost memory regions set
+via the VHOST_USER_SET_MEM_TABLE request. For invalidation events, the iotlb
+payload has to be filled with the invalidation message type (3), the I/O virtual
+address and the size. On success, the slave is expected to reply with a zero
+payload, non-zero otherwise.
+
+The slave relies on the slave communcation channel (see "Slave communication"
+section below) to send IOTLB miss and access failure events, by sending
+VHOST_USER_SLAVE_IOTLB_MSG requests to the master with a struct vhost_iotlb_msg
+as payload. For miss events, the iotlb payload has to be filled with the miss
+message type (1), the I/O virtual address and the permissions flags. For access
+failure event, the iotlb payload has to be filled with the access failure
+message type (4), the I/O virtual address and the permissions flags.
+For synchronization purpose, the slave may rely on the reply-ack feature,
+so the master may send a reply when operation is completed if the reply-ack
+feature is negotiated and slaves requests a reply. For miss events, completed
+operation means either master sent an update message containing the IOTLB entry
+containing requested address and permission, or master sent nothing if the IOTLB
+miss message is invalid (invalid IOVA or permission).
+
+The master isn't expected to take the initiative to send IOTLB update messages,
+as the slave sends IOTLB miss messages for the guest virtual memory areas it
+needs to access.
+
 Slave communication
 -------------------
 
@@ -514,6 +566,38 @@ Master message types
       If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respond
       with zero for success, non-zero otherwise.
 
+ * VHOST_USER_IOTLB_MSG
+
+      Id: 22
+      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
+      Master payload: struct vhost_iotlb_msg
+      Slave payload: u64
+
+      Send IOTLB messages with struct vhost_iotlb_msg as payload.
+      Master sends such requests to update and invalidate entries in the device
+      IOTLB. The slave has to acknowledge the request with sending zero as u64
+      payload for success, non-zero otherwise.
+      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
+      has been successfully negotiated.
+
+Slave message types
+-------------------
+
+ * VHOST_USER_SLAVE_IOTLB_MSG
+
+      Id: 1
+      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
+      Slave payload: struct vhost_iotlb_msg
+      Master payload: N/A
+
+      Send IOTLB messages with struct vhost_iotlb_msg as payload.
+      Slave sends such requests to notify of an IOTLB miss, or an IOTLB
+      access failure. If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated,
+      and slave set the VHOST_USER_NEED_REPLY flag, master must respond with
+      zero when operation is successfully completed, or non-zero otherwise.
+      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
+      has been successfully negotiated.
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 22874a9..e037db6 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -77,6 +77,7 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_HOST_UFO,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6a35600..7a9bb1d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -62,11 +62,13 @@ typedef enum VhostUserRequest {
     VHOST_USER_SEND_RARP = 19,
     VHOST_USER_NET_SET_MTU = 20,
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
+    VHOST_USER_IOTLB_MSG = 22,
     VHOST_USER_MAX
 } VhostUserRequest;
 
 typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_NONE = 0,
+    VHOST_USER_SLAVE_IOTLB_MSG = 1,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
 
@@ -104,6 +106,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        struct vhost_iotlb_msg iotlb;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -615,6 +618,9 @@ static void slave_read(void *opaque)
     }
 
     switch (msg.request) {
+    case VHOST_USER_SLAVE_IOTLB_MSG:
+        ret = vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
+        break;
     default:
         error_report("Received unexpected msg type.");
         ret = -EINVAL;
@@ -697,7 +703,7 @@ out:
 
 static int vhost_user_init(struct vhost_dev *dev, void *opaque)
 {
-    uint64_t features;
+    uint64_t features, protocol_features;
     struct vhost_user *u;
     int err;
 
@@ -717,12 +723,13 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
         dev->backend_features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
 
         err = vhost_user_get_u64(dev, VHOST_USER_GET_PROTOCOL_FEATURES,
-                                 &features);
+                                 &protocol_features);
         if (err < 0) {
             return err;
         }
 
-        dev->protocol_features = features & VHOST_USER_PROTOCOL_FEATURE_MASK;
+        dev->protocol_features =
+            protocol_features & VHOST_USER_PROTOCOL_FEATURE_MASK;
         err = vhost_user_set_protocol_features(dev, dev->protocol_features);
         if (err < 0) {
             return err;
@@ -736,6 +743,16 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
                 return err;
             }
         }
+
+        if (virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM) &&
+                !(virtio_has_feature(dev->protocol_features,
+                    VHOST_USER_PROTOCOL_F_SLAVE_REQ) &&
+                 virtio_has_feature(dev->protocol_features,
+                    VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
+            error_report("IOMMU support requires reply-ack and "
+                         "slave-req protocol features.");
+            return -1;
+        }
     }
 
     if (dev->migration_blocker == NULL &&
@@ -862,6 +879,29 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
     return 0;
 }
 
+static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
+                                            struct vhost_iotlb_msg *imsg)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_IOTLB_MSG,
+        .size = sizeof(msg.payload.iotlb),
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .payload.iotlb = *imsg,
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -EFAULT;
+    }
+
+    return process_message_reply(dev, &msg);
+}
+
+
+static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
+{
+    /* No-op as the receive channel is not dedicated to IOTLB messages. */
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
@@ -886,4 +926,6 @@ const VhostOps user_ops = {
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_backend_can_merge = vhost_user_can_merge,
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
+        .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
+        .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
 };
-- 
MST
