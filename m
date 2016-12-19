Received: from eggs.gnu.org ([2001:4830:134:3::10]:53632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr03-0002vL-AX
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr01-0004ax-O4
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr01-0004Vl-DS
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:37 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:44 +0800
Message-Id: <1482127152-84732-10-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 09/37] vhost-pci-slave/msg:
 VHOST_USER_GET_PROTOCOL_FEATURES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

Add a new protocol feature, VHOST_USER_PROTOCOL_F_VHOST_PCI. This
feature indicates the support of the vhost-pci extension for inter-vm
communiaction.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c    | 16 ++++++++++++++++
 include/hw/virtio/vhost-user.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 68ab4ec..05255d1 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -62,6 +62,16 @@ static void vp_slave_event(void *opaque, int event)
     }
 }
 
+static int vp_slave_get_protocol_features(CharBackend *chr_be,
+                                          VhostUserMsg *msg)
+{
+    msg->payload.u64 = VHOST_USER_PROTOCOL_FEATURES;
+    msg->size = sizeof(msg->payload.u64);
+    msg->flags |= VHOST_USER_REPLY_MASK;
+
+    return vp_slave_write(chr_be, msg);
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -105,6 +115,12 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_FEATURES:
         vp_slave_set_features(&msg);
         break;
+    case VHOST_USER_GET_PROTOCOL_FEATURES:
+        ret = vp_slave_get_protocol_features(chr_be, &msg);
+        if (ret < 0) {
+            goto err_handling;
+        }
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 8d43ffc..ad5eac9 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -11,12 +11,18 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
     VHOST_USER_PROTOCOL_F_RARP = 2,
     VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_VHOST_PCI = 4,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
 
 #define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
 
+#define VHOST_USER_PROTOCOL_FEATURES ((1ULL << VHOST_USER_PROTOCOL_F_MQ) | \
+                               (1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD) | \
+                                    (1ULL << VHOST_USER_PROTOCOL_F_RARP) | \
+                              (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI))
+
 typedef enum VhostUserRequest {
     VHOST_USER_NONE = 0,
     VHOST_USER_GET_FEATURES = 1,
-- 
2.7.4
