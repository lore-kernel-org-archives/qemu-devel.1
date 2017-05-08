Received: from eggs.gnu.org ([2001:4830:134:3::10]:50777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0e-00035h-6E
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0Z-0004YG-HC
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0Y-0004XT-LT
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:19 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:17 +0800
Message-ID: <1494243504-127980-3-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 2/9] cryptodev: extract one util function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, pasic@linux.vnet.ibm.com, stefanha@redhat.com, luonengjun@huawei.com, cornelia.huck@de.ibm.com, linqiangmin@huawei.com, xin.zeng@intel.com, wu.wubin@huawei.com, Gonglei <arei.gonglei@huawei.com>

So that the new function can be used by both seesion creation
and the following stateless crypto operation.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 100 +++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 42 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 1fa2cab..abc2655 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -151,73 +151,56 @@ err:
    return -1;
 }
 
-static int cryptodev_builtin_create_cipher_session(
-                    CryptoDevBackendBuiltin *builtin,
+static int
+cryptodev_builtin_get_cipher_alg_mode(
                     CryptoDevBackendSymSessionInfo *sess_info,
+                    int *algo, int *mode,
                     Error **errp)
 {
-    int algo;
-    int mode;
-    QCryptoCipher *cipher;
-    int index;
-    CryptoDevBackendBuiltinSession *sess;
-
-    if (sess_info->op_type != VIRTIO_CRYPTO_SYM_OP_CIPHER) {
-        error_setg(errp, "Unsupported optype :%u", sess_info->op_type);
-        return -1;
-    }
-
-    index = cryptodev_builtin_get_unused_session_index(builtin);
-    if (index < 0) {
-        error_setg(errp, "Total number of sessions created exceeds %u",
-                  MAX_NUM_SESSIONS);
-        return -1;
-    }
-
     switch (sess_info->cipher_alg) {
     case VIRTIO_CRYPTO_CIPHER_AES_ECB:
-        mode = QCRYPTO_CIPHER_MODE_ECB;
-        algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
-                                                    mode, errp);
-        if (algo < 0)  {
+        *mode = QCRYPTO_CIPHER_MODE_ECB;
+        *algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
+                                               *mode, errp);
+        if (*algo < 0)  {
             return -1;
         }
         break;
     case VIRTIO_CRYPTO_CIPHER_AES_CBC:
-        mode = QCRYPTO_CIPHER_MODE_CBC;
-        algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
-                                                    mode, errp);
-        if (algo < 0)  {
+        *mode = QCRYPTO_CIPHER_MODE_CBC;
+        *algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
+                                               *mode, errp);
+        if (*algo < 0)  {
             return -1;
         }
         break;
     case VIRTIO_CRYPTO_CIPHER_AES_CTR:
-        mode = QCRYPTO_CIPHER_MODE_CTR;
-        algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
-                                                    mode, errp);
-        if (algo < 0)  {
+        *mode = QCRYPTO_CIPHER_MODE_CTR;
+        *algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
+                                              *mode, errp);
+        if (*algo < 0)  {
             return -1;
         }
         break;
     case VIRTIO_CRYPTO_CIPHER_AES_XTS:
-        mode = QCRYPTO_CIPHER_MODE_XTS;
-        algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
-                                                    mode, errp);
-        if (algo < 0)  {
+        *mode = QCRYPTO_CIPHER_MODE_XTS;
+        *algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
+                                               *mode, errp);
+        if (*algo < 0)  {
             return -1;
         }
         break;
     case VIRTIO_CRYPTO_CIPHER_3DES_ECB:
-        mode = QCRYPTO_CIPHER_MODE_ECB;
-        algo = QCRYPTO_CIPHER_ALG_3DES;
+        *mode = QCRYPTO_CIPHER_MODE_ECB;
+        *algo = QCRYPTO_CIPHER_ALG_3DES;
         break;
     case VIRTIO_CRYPTO_CIPHER_3DES_CBC:
-        mode = QCRYPTO_CIPHER_MODE_CBC;
-        algo = QCRYPTO_CIPHER_ALG_3DES;
+        *mode = QCRYPTO_CIPHER_MODE_CBC;
+        *algo = QCRYPTO_CIPHER_ALG_3DES;
         break;
     case VIRTIO_CRYPTO_CIPHER_3DES_CTR:
-        mode = QCRYPTO_CIPHER_MODE_CTR;
-        algo = QCRYPTO_CIPHER_ALG_3DES;
+        *mode = QCRYPTO_CIPHER_MODE_CTR;
+        *algo = QCRYPTO_CIPHER_ALG_3DES;
         break;
     default:
         error_setg(errp, "Unsupported cipher alg :%u",
@@ -225,6 +208,39 @@ static int cryptodev_builtin_create_cipher_session(
         return -1;
     }
 
+    return 0;
+}
+
+static int cryptodev_builtin_create_cipher_session(
+                    CryptoDevBackendBuiltin *builtin,
+                    CryptoDevBackendSymSessionInfo *sess_info,
+                    Error **errp)
+{
+    int algo;
+    int mode;
+    QCryptoCipher *cipher;
+    int index;
+    CryptoDevBackendBuiltinSession *sess;
+    int ret;
+
+    if (sess_info->op_type != VIRTIO_CRYPTO_SYM_OP_CIPHER) {
+        error_setg(errp, "Unsupported optype :%u", sess_info->op_type);
+        return -1;
+    }
+
+    index = cryptodev_builtin_get_unused_session_index(builtin);
+    if (index < 0) {
+        error_setg(errp, "Total number of sessions created exceeds %u",
+                  MAX_NUM_SESSIONS);
+        return -1;
+    }
+
+    ret = cryptodev_builtin_get_cipher_alg_mode(sess_info,
+                                                &algo, &mode, errp);
+    if (ret < 0) {
+        return -1;
+    }
+
     cipher = qcrypto_cipher_new(algo, mode,
                                sess_info->cipher_key,
                                sess_info->key_len,
-- 
1.8.3.1
