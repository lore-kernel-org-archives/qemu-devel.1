Received: from eggs.gnu.org ([2001:4830:134:3::10]:48740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cz5EM-0004dM-6W
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cz5EK-00061v-Mz
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cz5EK-00060t-EN
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:41:56 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 14 Apr 2017 19:40:56 +0200
Message-Id: <20170414174056.28946-5-maxime.coquelin@redhat.com>
In-Reply-To: <20170414174056.28946-1-maxime.coquelin@redhat.com>
References: <20170414174056.28946-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC v2 4/4] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch specifies and implements the master/slave communication
to support device IOTLB in slave.

The vhost_iotlb_msg structure introduced for kernel backends is
re-used, making the design close between the two backends.

An exception is the use of the secondary channel to enable the
slave to send IOTLB miss requests to the master.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 docs/specs/vhost-user.txt | 74 +++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c    | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index 49c6293..a16dc44 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -97,6 +97,23 @@ Depending on the request type, payload can be:
    log offset: offset from start of supplied file descriptor
        where logging starts (i.e. where guest address 0 would be logged)
 
+ * An IOTLB message
+   ---------------------------------------------------------
+   | iova | size | user address | permissions flags | type |
+   ---------------------------------------------------------
+
+   IOVA: a 64-bit guest I/O virtual address
+   Size: a 64-bit size
+   User address: a 64-bit user address
+   Permissions flags: a 8-bit bit field:
+    - Bit 0: Read access
+    - Bit 1: Write access
+   Type: a 8-bit IOTLB message type:
+    - 1: IOTLB miss
+    - 2: IOTLB update
+    - 3: IOTLB invalidate
+    - 4: IOTLB access fail
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -109,6 +126,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        struct vhost_iotlb_msg iotlb;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -253,6 +271,30 @@ Once the source has finished migration, rings will be stopped by
 the source. No further update must be done before rings are
 restarted.
 
+IOMMU support
+-------------
+
+When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated, the master has
+to send IOTLB entries update & invalidation by sending VHOST_USER_IOTLB_MSG
+requests to the slave with a struct vhost_iotlb_msg payload. For update events,
+the iotlb payload has to be filled with the update message type (2), the I/O
+virtual address, the size, the user virtual address, and the permissions
+flags. For invalidation events, the iotlb payload has to be filled with the
+update message type (3), the I/O virtual address and the size. On success, the
+slave is expected to reply with a zero payload, non-zero otherwise.
+
+When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the slave, and the
+master initiated the slave to master communication channel using the
+VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB miss and access
+failure events by sending VHOST_USER_SLAVE_IOTLB_MSG requests to the master
+with a struct vhost_iotlb_msg payload. For miss events, the iotlb payload has
+to be filled with the miss message type (1), the I/O virtual address and the
+permissions flags. For access failure event, the iotlb payload has to be
+filled with the access failure message type (4), the I/O virtual address and
+the permissions flags. For synchronization purpose, the slave may rely on the
+reply-ack feature, so the master may send a reply when operation is completed
+if the reply-ack feature is negotiated and slaves requests a reply.
+
 Slave communication
 -------------------
 
@@ -512,6 +554,38 @@ Master message types
       has been negotiated, and protocol feature bit VHOST_USER_PROTOCOL_F_SLAVE_REQ
       bit is present in VHOST_USER_GET_PROTOCOL_FEATURES.
 
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
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f26f11b..d06886b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -63,11 +63,13 @@ typedef enum VhostUserRequest {
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
 
@@ -105,6 +107,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        struct vhost_iotlb_msg iotlb;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -582,6 +585,31 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
     return 0;
 }
 
+static int vhost_user_iotlb_read(struct vhost_dev *dev, VhostUserMsg *msg)
+{
+    struct vhost_iotlb_msg *imsg = &msg->payload.iotlb;
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
+
 static void slave_read(void *opaque)
 {
     struct vhost_dev *dev = opaque;
@@ -611,6 +639,8 @@ static void slave_read(void *opaque)
     }
 
     switch (msg.request) {
+        ret = vhost_user_iotlb_read(dev, &msg);
+        break;
     default:
         error_report("Received unexpected msg type.");
         ret = -EINVAL;
@@ -848,6 +878,71 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
     return 0;
 }
 
+static int vhost_user_update_device_iotlb(struct vhost_dev *dev,
+                                          uint64_t iova, uint64_t uaddr,
+                                          uint64_t len,
+                                          IOMMUAccessFlags perm)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_IOTLB_MSG,
+        .size = sizeof(msg.payload.iotlb),
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .payload.iotlb = {
+            .iova = iova,
+            .uaddr = uaddr,
+            .size = len,
+            .type = VHOST_IOTLB_UPDATE,
+        },
+    };
+
+    switch (perm) {
+    case IOMMU_RO:
+        msg.payload.iotlb.perm = VHOST_ACCESS_RO;
+        break;
+    case IOMMU_WO:
+        msg.payload.iotlb.perm = VHOST_ACCESS_WO;
+        break;
+    case IOMMU_RW:
+        msg.payload.iotlb.perm = VHOST_ACCESS_RW;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    return process_message_reply(dev, msg.request);
+}
+
+static int vhost_user_invalidate_device_iotlb(struct vhost_dev *dev,
+                                              uint64_t iova, uint64_t len)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_IOTLB_MSG,
+        .size = sizeof(msg.payload.iotlb),
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .payload.iotlb = {
+            .iova = iova,
+            .size = len,
+            .type = VHOST_IOTLB_INVALIDATE,
+        },
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    return process_message_reply(dev, msg.request);
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
@@ -872,4 +967,7 @@ const VhostOps user_ops = {
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_backend_can_merge = vhost_user_can_merge,
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
+        .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
+        .vhost_update_device_iotlb = vhost_user_update_device_iotlb,
+        .vhost_invalidate_device_iotlb = vhost_user_invalidate_device_iotlb,
 };
-- 
2.9.3
