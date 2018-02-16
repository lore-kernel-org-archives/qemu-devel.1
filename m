Received: from eggs.gnu.org ([2001:4830:134:3::10]:43038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp8-0002RU-2y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp4-0007hR-VB
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1emjp4-0007gR-Q3
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 246A04040858
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:29:21 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 16 Feb 2018 18:29:07 +0100
Message-Id: <20180216172910.8549-3-maxime.coquelin@redhat.com>
In-Reply-To: <20180216172910.8549-1-maxime.coquelin@redhat.com>
References: <20180216172910.8549-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC 2/5] vhost-user: Introduce new request to send
 virtio device status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch implements the .vhost_set_virtio_status() backend
callback for user backend by intooducing a new vhost-user
VHOST_USER_SET_VIRTIO_STATUS request.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 docs/interop/vhost-user.txt | 14 ++++++++++++++
 hw/virtio/vhost-user.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 9fcf48d611..daa452bd36 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -368,6 +368,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
+#define VHOST_USER_PROTOCOL_F_VIRTIO_STATUS  7
 
 Master message types
 --------------------
@@ -663,6 +664,19 @@ Master message types
       field, and slaves MUST NOT accept SET_CONFIG for read-only
       configuration space fields unless the live migration bit is set.
 
+* VHOST_USER_SET_VIRTIO_STATUS
+
+      Id: 26
+      Equivalent ioctl: N/A
+      Master payload: u64
+      Slave payload: N/A
+
+      Sent by the vhost-user master to notify of virtio device status change.
+      The payload is a u64 representing the virtio device status as defined in
+      the virtio specification.
+      The request should be sent only when VHOST_USER_PROTOCOL_F_VIRTIO_STATUS
+      protocol feature has been negotiated.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6eb97980ad..519646799b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -39,6 +39,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_VIRTIO_STATUS = 7,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -72,6 +73,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENDIAN = 23,
     VHOST_USER_GET_CONFIG = 24,
     VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_SET_VIRTIO_STATUS = 26,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -1054,6 +1056,38 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
     return 0;
 }
 
+static int vhost_user_set_virtio_status(struct vhost_dev *dev, uint8_t status)
+{
+    bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_SET_VIRTIO_STATUS,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = sizeof(msg.payload.u64),
+        .payload.u64 = status,
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_VIRTIO_STATUS)) {
+        return 0;
+    }
+
+    if (reply_supported) {
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
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
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
@@ -1082,4 +1116,5 @@ const VhostOps user_ops = {
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
         .vhost_get_config = vhost_user_get_config,
         .vhost_set_config = vhost_user_set_config,
+        .vhost_set_virtio_status = vhost_user_set_virtio_status,
 };
-- 
2.14.3
