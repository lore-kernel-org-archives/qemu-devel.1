Received: from eggs.gnu.org ([2001:4830:134:3::10]:56165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1exwU1-0006Wv-QT
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1exwTy-0001o8-IS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:43092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david.vrabel@nutanix.com>)
	id 1exwTy-0001mq-C5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:54 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2JF9JcA023321
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:13:52 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
	(mail-sn1nam02lp0021.outbound.protection.outlook.com [216.32.180.21])
	by mx0b-002c1b01.pphosted.com with ESMTP id 2gtdrf06f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:13:52 -0700
From: David Vrabel <david.vrabel@nutanix.com>
Date: Mon, 19 Mar 2018 15:13:26 +0000
Message-Id: <20180319151327.17989-2-david.vrabel@nutanix.com>
In-Reply-To: <20180319151327.17989-1-david.vrabel@nutanix.com>
References: <20180319151327.17989-1-david.vrabel@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] vhost-user: add VHOST_USER_RESET_DEVICE to
 reset devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Vrabel <david.vrabel@nutanix.com>

Add a VHOST_USER_RESET_DEVICE message which will reset the vhost user
backend. Disabling all rings, and resetting all internal state, ready
for the backend to be reinitialized.

A backend has to report it supports this features with the
VHOST_USER_PROTOCOL_F_RESET_DEVICE protocol feature bit. If it does
so, the new message is used instead of sending a RESET_OWNER which has
had inconsistent implementations.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
---
 docs/interop/vhost-user.txt | 16 ++++++++++++++++
 hw/virtio/vhost-user.c      |  8 +++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index cb3a7595aa..c5faa9fff8 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -369,6 +369,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
 #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
+#define VHOST_USER_PROTOCOL_F_RESET_DEVICE   8
 
 Master message types
 --------------------
@@ -689,6 +690,21 @@ Master message types
      feature has been successfully negotiated.
      It's a required feature for crypto devices.
 
+ * VHOST_USER_RESET_DEVICE
+
+      Id: 28
+      Equivalent ioctl: N/A
+      Master payload: N/A
+      Slave payload: N/A
+
+      Ask the vhost user backend to disable all rings and reset all
+      internal device state to the initial state, ready to be
+      reinitialized. The backend retains ownership of the device
+      throughout the reset operation.
+
+      Only valid if the VHOST_USER_PROTOCOL_F_RESET_DEVICE protocol
+      feature is set by the backend.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 41ff5cff41..67207bfe8a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -41,6 +41,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
     VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 8,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -76,6 +77,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_CONFIG = 25,
     VHOST_USER_CREATE_CRYPTO_SESSION = 26,
     VHOST_USER_CLOSE_CRYPTO_SESSION = 27,
+    VHOST_USER_RESET_DEVICE = 28,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -641,10 +643,14 @@ static int vhost_user_set_owner(struct vhost_dev *dev)
 static int vhost_user_reset_device(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
-        .hdr.request = VHOST_USER_RESET_OWNER,
         .hdr.flags = VHOST_USER_VERSION,
     };
 
+    msg.hdr.request = virtio_has_feature(dev->protocol_features,
+                                         VHOST_USER_PROTOCOL_F_RESET_DEVICE)
+        ? VHOST_USER_RESET_DEVICE
+        : VHOST_USER_RESET_OWNER;
+
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
         return -1;
     }
-- 
2.11.0
