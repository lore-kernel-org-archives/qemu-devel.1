Received: from eggs.gnu.org ([2001:4830:134:3::10]:35821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerF-00010k-GV
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerE-0004dn-GC
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcerE-0004dC-6t
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:40 -0400
Date: Wed, 2 Aug 2017 00:37:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-4-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] vhost-user: fix legacy cross-endian
 configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Felipe Franciosi <felipe@nutanix.com>, Mike Cui <cui@nutanix.com>

From: Felipe Franciosi <felipe@nutanix.com>

Currently, vhost-user does not implement any means for notifying the
backend about guest endianess. This commit introduces a new message
called VHOST_USER_SET_VRING_ENDIAN which is analogous to the ioctl()
called VHOST_SET_VRING_ENDIAN used for kernel vhost backends. Such
message is necessary for backends supporting legacy (pre-1.0) virtio
devices running in big-endian guests.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Mike Cui <cui@nutanix.com>
---
 docs/interop/vhost-user.txt | 16 ++++++++++++++++
 hw/virtio/vhost-user.c      | 23 +++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 481ab56..954771d 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -326,6 +326,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
+#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
 
 Master message types
 --------------------
@@ -580,6 +581,21 @@ Master message types
       This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
       has been successfully negotiated.
 
+ * VHOST_USER_SET_VRING_ENDIAN
+
+      Id: 23
+      Equivalent ioctl: VHOST_SET_VRING_ENDIAN
+      Master payload: vring state description
+
+      Set the endianess of a VQ for legacy devices. Little-endian is indicated
+      with state.num set to 0 and big-endian is indicated with state.num set
+      to 1. Other values are invalid.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
+      has been negotiated.
+      Backends that negotiated this feature should handle both endianesses
+      and expect this message once (per VQ) during device configuration
+      (ie. before the master starts the VQ).
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2203011..093675e 100644
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
MST
