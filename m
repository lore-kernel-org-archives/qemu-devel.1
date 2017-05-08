Received: from eggs.gnu.org ([2001:4830:134:3::10]:50815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h10-0003LP-7s
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0v-0004by-Kg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0v-0004bB-0Q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:41 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:19 +0800
Message-ID: <1494243504-127980-5-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 4/9] cryptodev-builtin: realize stateless
 operation function
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

At this point, the stateless crypto operation for
cryptodev-builtin backend works.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 1e72985..7829999 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -401,7 +401,76 @@ cryptodev_builtin_sym_stateless_operation(
                  CryptoDevBackendSymStatelessInfo *op_info,
                  uint32_t queue_index, Error **errp)
 {
-    return -VIRTIO_CRYPTO_ERR;
+    CryptoDevBackendSymSessionInfo *sess_info;
+    CryptoDevBackendSymOpInfo *sym_op_info;
+    int algo, mode;
+    int ret;
+    QCryptoCipher *cipher = NULL;
+
+    sess_info = &op_info->session_info;
+    sym_op_info = &op_info->op_info;
+
+    if (sess_info->op_type != VIRTIO_CRYPTO_SYM_OP_CIPHER) {
+        error_setg(errp, "Unsupported op_type: %u", sess_info->op_type);
+        return -VIRTIO_CRYPTO_ERR;
+    }
+
+    switch (sym_op_info->op_code) {
+    case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
+    case VIRTIO_CRYPTO_CIPHER_DECRYPT:
+        ret = cryptodev_builtin_get_cipher_alg_mode(sess_info,
+                                                &algo, &mode, errp);
+        if (ret < 0) {
+            return -VIRTIO_CRYPTO_ERR;
+        }
+
+        cipher = qcrypto_cipher_new(algo, mode,
+                                   sess_info->cipher_key,
+                                   sess_info->key_len,
+                                   errp);
+        if (!cipher) {
+            return -VIRTIO_CRYPTO_ERR;
+        }
+
+        if (sym_op_info->iv_len > 0) {
+            ret = qcrypto_cipher_setiv(cipher, sym_op_info->iv,
+                                       sym_op_info->iv_len, errp);
+            if (ret < 0) {
+                ret = -VIRTIO_CRYPTO_ERR;
+                goto out;
+            }
+        }
+
+        if (sess_info->direction == VIRTIO_CRYPTO_OP_ENCRYPT) {
+            ret = qcrypto_cipher_encrypt(cipher, sym_op_info->src,
+                                         sym_op_info->dst,
+                                         sym_op_info->src_len, errp);
+            if (ret < 0) {
+                ret = -VIRTIO_CRYPTO_ERR;
+                goto out;
+            }
+        } else {
+            ret = qcrypto_cipher_decrypt(cipher, sym_op_info->src,
+                                         sym_op_info->dst,
+                                         sym_op_info->src_len, errp);
+            if (ret < 0) {
+                ret = -VIRTIO_CRYPTO_ERR;
+                goto out;
+            }
+        }
+        break;
+
+    default:
+        error_setg(errp, "Unsupported op_code: %" PRIu32 "",
+                   sym_op_info->op_code);
+        return -VIRTIO_CRYPTO_ERR;
+    }
+
+    ret = VIRTIO_CRYPTO_OK;
+
+out:
+    qcrypto_cipher_free(cipher);
+    return ret;
 }
 
 static void
-- 
1.8.3.1
