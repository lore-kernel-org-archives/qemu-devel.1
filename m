Received: from eggs.gnu.org ([2001:4830:134:3::10]:39605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dLBMh-0001nt-O4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dLBMd-0003aU-KM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:41:55 -0400
Received: from [62.254.189.133] (port=39900 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dLBMc-0003Ul-JP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:41:51 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 14 Jun 2017 17:41:26 +0100
Message-Id: <1497458486-15673-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH] vhost-user: support cross-endianess negatiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Felipe Franciosi <felipe@nutanix.com>, Mike Cui <cui@nutanix.com>

Currently, vhost-user does not implement any means for notifying the
backend about guest endianess. This commit introduces a new message
called VHOST_USER_SET_VRING_ENDIAN which is analogous to the ioctl()
called VHOST_SET_VRING_ENDIAN used for kernel vhost backends. Such
message is necessary for backends supporting legacy (pre-1.0) virtio
devices running in big-endian guests.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Mike Cui <cui@nutanix.com>
---
 docs/specs/vhost-user.txt | 14 ++++++++++++++
 hw/virtio/vhost-user.c    | 23 +++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
index 481ab56..eafbed9 100644
--- a/docs/specs/vhost-user.txt
+++ b/docs/specs/vhost-user.txt
@@ -326,6 +326,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
+#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
 
 Master message types
 --------------------
@@ -580,6 +581,19 @@ Master message types
       This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
       has been successfully negotiated.
 
+ * VHOST_USER_SET_VRING_ENDIAN
+
+      Id: 22
+      Equivalent ioctl: VHOST_SET_VRING_ENDIAN
+      Master payload: vring state description
+
+      Set the endianess of a VQ for legacy devices. Big-endian is indicated
+      with state.num set to true, and little-endian is indicated with state.num
+      set to false.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
+      has been negotiated.
+
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 958ee09..006af1c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -33,6 +33,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -63,6 +64,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_NET_SET_MTU = 20,
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
     VHOST_USER_IOTLB_MSG = 22,
+    VHOST_USER_SET_VRING_ENDIAN = 23,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -367,8 +369,25 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
 static int vhost_user_set_vring_endian(struct vhost_dev *dev,
                                        struct vhost_vring_state *ring)
 {
-    error_report("vhost-user trying to send unhandled ioctl");
-    return -1;
+    bool cross_endian = virtio_has_feature(dev->protocol_features,
+                                           VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
+    VhostUserMsg msg = {
+        .request = VHOST_USER_SET_VRING_ENDIAN,
+        .flags = VHOST_USER_VERSION,
+        .payload.state = *ring,
+        .size = sizeof(msg.payload.state),
+    };
+
+    if (!cross_endian) {
+        error_report("vhost-user trying to send unhandled ioctl");
+        return -1;
+    }
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    return 0;
 }
 
 static int vhost_set_vring(struct vhost_dev *dev,
-- 
1.9.5
