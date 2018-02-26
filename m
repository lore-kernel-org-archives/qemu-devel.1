Received: from eggs.gnu.org ([2001:4830:134:3::10]:47045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eqHtT-0007V5-4m
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eqHtR-0008LS-Dm
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:35 -0500
Received: from [45.249.212.35] (port=48989 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eqHtP-0008Ip-Bl
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:28:33 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Mon, 26 Feb 2018 20:27:36 +0800
Message-ID: <ad4cdb97930343f11a31f852518e3c23a027157d.1519647019.git.arei.gonglei@huawei.com>
In-Reply-To: <cover.1519647019.git.arei.gonglei@huawei.com>
References: <cover.1519647019.git.arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com

From: Gonglei <arei.gonglei@huawei.com>

Introduce two vhost-user meassges: VHOST_USER_CREATE_CRYPTO_SESSION
and VHOST_USER_CLOSE_CRYPTO_SESSION. At this point, the QEMU side
support crypto operation in cryptodev host-user backend.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 backends/cryptodev-vhost-user.c   |  48 ++++++++++++++----
 docs/interop/vhost-user.txt       |  26 ++++++++++
 hw/virtio/vhost-user.c            | 104 ++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |   8 +++
 4 files changed, 175 insertions(+), 11 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 151a0e6..9cd06c4 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -231,7 +231,25 @@ static int64_t cryptodev_vhost_user_sym_create_session(
            CryptoDevBackendSymSessionInfo *sess_info,
            uint32_t queue_index, Error **errp)
 {
-    return 0;
+    CryptoDevBackendClient *cc =
+                   backend->conf.peers.ccs[queue_index];
+    CryptoDevBackendVhost *vhost_crypto;
+    uint64_t session_id = 0;
+    int ret;
+
+    vhost_crypto = cryptodev_vhost_user_get_vhost(cc, backend, queue_index);
+    if (vhost_crypto) {
+        struct vhost_dev *dev = &(vhost_crypto->dev);
+        ret = dev->vhost_ops->vhost_crypto_create_session(dev,
+                                                          sess_info,
+                                                          &session_id);
+        if (ret < 0) {
+            return -1;
+        } else {
+            return session_id;
+        }
+    }
+    return -1;
 }
 
 static int cryptodev_vhost_user_sym_close_session(
@@ -239,15 +257,23 @@ static int cryptodev_vhost_user_sym_close_session(
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
+    vhost_crypto = cryptodev_vhost_user_get_vhost(cc, backend, queue_index);
+    if (vhost_crypto) {
+        struct vhost_dev *dev = &(vhost_crypto->dev);
+        ret = dev->vhost_ops->vhost_crypto_close_session(dev,
+                                                         session_id);
+        if (ret < 0) {
+            return -1;
+        } else {
+            return 0;
+        }
+    }
+    return -1;
 }
 
 static void cryptodev_vhost_user_cleanup(
@@ -326,7 +352,7 @@ cryptodev_vhost_user_class_init(ObjectClass *oc, void *data)
     bc->cleanup = cryptodev_vhost_user_cleanup;
     bc->create_session = cryptodev_vhost_user_sym_create_session;
     bc->close_session = cryptodev_vhost_user_sym_close_session;
-    bc->do_sym_op = cryptodev_vhost_user_sym_operation;
+    bc->do_sym_op = NULL;
 }
 
 static const TypeInfo cryptodev_vhost_user_info = {
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 9fcf48d..cb3a759 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -368,6 +368,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
+#define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
 
 Master message types
 --------------------
@@ -663,6 +664,31 @@ Master message types
       field, and slaves MUST NOT accept SET_CONFIG for read-only
       configuration space fields unless the live migration bit is set.
 
+* VHOST_USER_CREATE_CRYPTO_SESSION
+
+     Id: 26
+     Equivalent ioctl: N/A
+     Master payload: crypto session description
+     Slave payload: crypto session description
+
+     Create a session for crypto operation. The server side must return the
+     session id, 0 or positive for success, negative for failure.
+     This request should be sent only when VHOST_USER_PROTOCOL_F_CRYPTO_SESSION
+     feature has been successfully negotiated.
+     It's a required feature for crypto devices.
+
+* VHOST_USER_CLOSE_CRYPTO_SESSION
+
+     Id: 27
+     Equivalent ioctl: N/A
+     Master payload: u64
+
+     Close a session for crypto operation which was previously
+     created by VHOST_USER_CREATE_CRYPTO_SESSION.
+     This request should be sent only when VHOST_USER_PROTOCOL_F_CRYPTO_SESSION
+     feature has been successfully negotiated.
+     It's a required feature for crypto devices.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6eb9798..41ff5cf 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
+#include "sysemu/cryptodev.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -39,6 +40,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -72,6 +74,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENDIAN = 23,
     VHOST_USER_GET_CONFIG = 24,
     VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_CREATE_CRYPTO_SESSION = 26,
+    VHOST_USER_CLOSE_CRYPTO_SESSION = 27,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -107,6 +111,17 @@ typedef struct VhostUserConfig {
     uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
 } VhostUserConfig;
 
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
 static VhostUserConfig c __attribute__ ((unused));
 #define VHOST_USER_CONFIG_HDR_SIZE (sizeof(c.offset) \
                                    + sizeof(c.size) \
@@ -132,6 +147,7 @@ typedef union {
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
+        VhostUserCryptoSession session;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -1054,6 +1070,92 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
     return 0;
 }
 
+static int vhost_user_crypto_create_session(struct vhost_dev *dev,
+                                            void *session_info,
+                                            uint64_t *session_id)
+{
+    bool crypto_session = virtio_has_feature(dev->protocol_features,
+                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
+    CryptoDevBackendSymSessionInfo *sess_info = session_info;
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_CREATE_CRYPTO_SESSION,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = sizeof(msg.payload.session),
+    };
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    if (!crypto_session) {
+        error_report("vhost-user trying to send unhandled ioctl");
+        return -1;
+    }
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
+    if (msg.hdr.request != VHOST_USER_CREATE_CRYPTO_SESSION) {
+        error_report("Received unexpected msg type. Expected %d received %d",
+                     VHOST_USER_CREATE_CRYPTO_SESSION, msg.hdr.request);
+        return -1;
+    }
+
+    if (msg.hdr.size != sizeof(msg.payload.session)) {
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
+    bool crypto_session = virtio_has_feature(dev->protocol_features,
+                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_CLOSE_CRYPTO_SESSION,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = sizeof(msg.payload.u64),
+    };
+    msg.payload.u64 = session_id;
+
+    if (!crypto_session) {
+        error_report("vhost-user trying to send unhandled ioctl");
+        return -1;
+    }
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
@@ -1082,4 +1184,6 @@ const VhostOps user_ops = {
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
         .vhost_get_config = vhost_user_get_config,
         .vhost_set_config = vhost_user_set_config,
+        .vhost_crypto_create_session = vhost_user_crypto_create_session,
+        .vhost_crypto_close_session = vhost_user_crypto_close_session,
 };
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 592254f..5dac61f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -95,6 +95,12 @@ typedef int (*vhost_set_config_op)(struct vhost_dev *dev, const uint8_t *data,
 typedef int (*vhost_get_config_op)(struct vhost_dev *dev, uint8_t *config,
                                    uint32_t config_len);
 
+typedef int (*vhost_crypto_create_session_op)(struct vhost_dev *dev,
+                                              void *session_info,
+                                              uint64_t *session_id);
+typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
+                                             uint64_t session_id);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -130,6 +136,8 @@ typedef struct VhostOps {
     vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
     vhost_get_config_op vhost_get_config;
     vhost_set_config_op vhost_set_config;
+    vhost_crypto_create_session_op vhost_crypto_create_session;
+    vhost_crypto_close_session_op vhost_crypto_close_session;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
1.8.3.1
