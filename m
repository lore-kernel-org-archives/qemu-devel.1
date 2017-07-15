Received: from eggs.gnu.org ([2001:4830:134:3::10]:45811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKD2-0000pR-HE
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKCz-0005RB-MS
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:22:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKCy-0005Pw-QP
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:21:57 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 15 Jul 2017 18:21:10 +0800
Message-ID: <1500114070-181004-4-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
References: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 3/3] cryptodev-vhost-user: add crypto session
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, roy.fan.zhang@intel.com, xin.zeng@intel.com, linqiangmin@huawei.com, marcandre.lureau@redhat.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, jianjay.zhou@huawei.com, Gonglei <arei.gonglei@huawei.com>

Introduce two vhost-user meassges: VHOST_USER_CREATE_CRYPTO_SESSION
and VHOST_USER_CLOSE_CRYPTO_SESSION. At this point, the QEMU side
support crypto operation in cryptodev host-user backend.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Zhoujian <jianjay.zhou@huawei.com>
---
 backends/cryptodev-vhost-user.c   | 50 +++++++++++++++++-----
 docs/interop/vhost-user.txt       | 19 +++++++++
 hw/virtio/vhost-user.c            | 89 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  8 ++++
 4 files changed, 155 insertions(+), 11 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 0b1f049..3d000e4 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -233,7 +233,26 @@ static int64_t cryptodev_vhost_user_sym_create_session(
            CryptoDevBackendSymSessionInfo *sess_info,
            uint32_t queue_index, Error **errp)
 {
-    return 0;
+     CryptoDevBackendClient *cc =
+                   backend->conf.peers.ccs[queue_index];
+     CryptoDevBackendVhost *vhost_crypto;
+     uint64_t session_id = 0;
+     int ret;
+
+     vhost_crypto = cryptodev_vhost_user_get_vhost(cc,
+                                               backend, queue_index);
+     if (vhost_crypto) {
+         struct vhost_dev *dev = &(vhost_crypto->dev);
+         ret = dev->vhost_ops->vhost_crypto_create_session(dev,
+                                                        sess_info,
+                                                        &session_id);
+         if (ret < 0) {
+             return -1;
+         } else {
+             return session_id;
+         }
+     }
+     return -1;
 }
 
 static int cryptodev_vhost_user_sym_close_session(
@@ -241,15 +260,24 @@ static int cryptodev_vhost_user_sym_close_session(
            uint64_t session_id,
            uint32_t queue_index, Error **errp)
 {
-    return 0;
-}
-
-static int cryptodev_vhost_user_sym_operation(
-                 CryptoDevBackend *backend,
-                 CryptoDevBackendSymOpInfo *op_info,
-                 uint32_t queue_index, Error **errp)
-{
-    return VIRTIO_CRYPTO_OK;
+    CryptoDevBackendClient *cc =
+                  backend->conf.peers.ccs[queue_index];
+    CryptoDevBackendVhost *vhost_crypto;
+    int ret;
+
+    vhost_crypto = cryptodev_vhost_user_get_vhost(cc,
+                                              backend, queue_index);
+    if (vhost_crypto) {
+        struct vhost_dev *dev = &(vhost_crypto->dev);
+        ret = dev->vhost_ops->vhost_crypto_close_session(dev,
+                                                       session_id);
+        if (ret < 0) {
+            return -1;
+        } else {
+            return 0;
+        }
+    }
+    return -1;
 }
 
 static void cryptodev_vhost_user_cleanup(
@@ -328,7 +356,7 @@ cryptodev_vhost_user_class_init(ObjectClass *oc, void *data)
     bc->cleanup = cryptodev_vhost_user_cleanup;
     bc->create_session = cryptodev_vhost_user_sym_create_session;
     bc->close_session = cryptodev_vhost_user_sym_close_session;
-    bc->do_sym_op = cryptodev_vhost_user_sym_operation;
+    bc->do_sym_op = NULL;
 }
 
 static const TypeInfo cryptodev_vhost_user_info = {
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 481ab56..165b37ff 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -580,6 +580,25 @@ Master message types
       This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
       has been successfully negotiated.
 
+ * VHOST_USER_CREATE_CRYPTO_SESSION
+
+      Id: 23
+      Equivalent ioctl: N/A
+      Master payload: crypto session description
+      Slave payload: crypto session description
+
+      Create a session for crypto operation. The server side must return the
+      session id, 0 or positive for success, negative for failure.
+
+ * VHOST_USER_CLOSE_CRYPTO_SESSION
+
+      Id: 24
+      Equivalent ioctl: N/A
+      Master payload: u64
+
+      Close a session for crypto operation which was previously
+      created by VHOST_USER_CREATE_CRYPTO_SESSION.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2203011..a74f5fe 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
+#include "sysemu/cryptodev.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -63,6 +64,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_NET_SET_MTU = 20,
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
     VHOST_USER_IOTLB_MSG = 22,
+    VHOST_USER_CREATE_CRYPTO_SESSION = 23,
+    VHOST_USER_CLOSE_CRYPTO_SESSION = 24,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -90,6 +93,17 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
 
+#define VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN    512
+#define VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN  64
+
+typedef struct VhostUserCryptoSession {
+    /* session id for success, -1 on errors */
+    int64_t session_id;
+    CryptoDevBackendSymSessionInfo session_setup_data;
+    uint8_t key[VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN];
+    uint8_t auth_key[VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN];
+} VhostUserCryptoSession;
+
 typedef struct VhostUserMsg {
     VhostUserRequest request;
 
@@ -107,6 +121,7 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
+        VhostUserCryptoSession session;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -903,6 +918,78 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
     /* No-op as the receive channel is not dedicated to IOTLB messages. */
 }
 
+static int vhost_user_crypto_create_session(struct vhost_dev *dev,
+                              void *session_info,
+                              uint64_t *session_id)
+{
+    CryptoDevBackendSymSessionInfo *sess_info = session_info;
+    VhostUserMsg msg = {
+        .request = VHOST_USER_CREATE_CRYPTO_SESSION,
+        .flags = VHOST_USER_VERSION,
+        .size = sizeof(msg.payload.session),
+    };
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    memcpy(&msg.payload.session.session_setup_data, sess_info,
+              sizeof(CryptoDevBackendSymSessionInfo));
+    if (sess_info->key_len) {
+        memcpy(&msg.payload.session.key, sess_info->cipher_key,
+               sess_info->key_len);
+    }
+    if (sess_info->auth_key_len > 0) {
+        memcpy(&msg.payload.session.auth_key, sess_info->auth_key,
+               sess_info->auth_key_len);
+    }
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        error_report("vhost_user_write() return -1, create session failed");
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        error_report("vhost_user_read() return -1, create session failed");
+        return -1;
+    }
+
+    if (msg.request != VHOST_USER_CREATE_CRYPTO_SESSION) {
+        error_report("Received unexpected msg type. Expected %d received %d",
+                     VHOST_USER_CREATE_CRYPTO_SESSION, msg.request);
+        return -1;
+    }
+
+    if (msg.size != sizeof(msg.payload.session)) {
+        error_report("Received bad msg size.");
+        return -1;
+    }
+
+    if (msg.payload.session.session_id < 0) {
+        error_report("Bad session id: %" PRId64 "",
+                              msg.payload.session.session_id);
+        return -1;
+    }
+    *session_id = msg.payload.session.session_id;
+
+    return 0;
+}
+
+static int
+vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_CLOSE_CRYPTO_SESSION,
+        .flags = VHOST_USER_VERSION,
+        .size = sizeof(msg.payload.u64),
+    };
+    msg.payload.u64 = session_id;
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        error_report("vhost_user_write() return -1, close session failed");
+        return -1;
+    }
+
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
@@ -929,4 +1016,6 @@ const VhostOps user_ops = {
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
         .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
+        .vhost_crypto_create_session = vhost_user_crypto_create_session,
+        .vhost_crypto_close_session = vhost_user_crypto_close_session,
 };
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a7a5f22..21d9479 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -85,6 +85,12 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
 typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg);
 
+typedef int (*vhost_crypto_create_session_op)(struct vhost_dev *dev,
+                                      void *session_info,
+                                      uint64_t *session_id);
+typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
+                                      uint64_t session_id);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -118,6 +124,8 @@ typedef struct VhostOps {
     vhost_vsock_set_running_op vhost_vsock_set_running;
     vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
     vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
+    vhost_crypto_create_session_op vhost_crypto_create_session;
+    vhost_crypto_close_session_op vhost_crypto_close_session;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
1.8.3.1
