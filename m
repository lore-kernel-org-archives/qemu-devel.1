Received: from eggs.gnu.org ([2001:4830:134:3::10]:53212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUM-0007PG-LI
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUL-00085r-LU
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUL-0007ss-Df
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:13 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:19 +0800
Message-Id: <1481971427-11094-10-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 09/37] vhost-pci-slave/msg:
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
 hw/virtio/vhost-pci-slave.c    | 14 ++++++++++++++
 include/hw/virtio/vhost-user.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index bc6120c..ac9deae 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -67,6 +67,15 @@ static void vp_slave_event(void *opaque, int event)
     }
 }
 
+static int vp_slave_get_protocol_features(CharBackend *chr_be, VhostUserMsg *msg)
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
@@ -108,6 +117,11 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_FEATURES:
         vp_slave_set_features(&msg);
         break;
+    case VHOST_USER_GET_PROTOCOL_FEATURES:
+        ret = vp_slave_get_protocol_features(chr_be, &msg);
+        if (ret < 0)
+            goto err_handling;
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index c189b26..a303513 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -11,12 +11,18 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
     VHOST_USER_PROTOCOL_F_RARP = 2,
     VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_VHOST_PCI =4,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
 
 #define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
 
+#define VHOST_USER_PROTOCOL_FEATURES ((1ULL << VHOST_USER_PROTOCOL_F_MQ) | \
+                                      (1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD) | \
+                                      (1ULL << VHOST_USER_PROTOCOL_F_RARP)) | \
+                                      (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI)
+
 typedef enum VhostUserRequest {
     VHOST_USER_NONE = 0,
     VHOST_USER_GET_FEATURES = 1,
-- 
2.7.4
