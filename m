Received: from eggs.gnu.org ([2001:4830:134:3::10]:35256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG6-0004HM-30
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG3-00046m-BO
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG2-00044Z-D3
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:27 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:39 +0800
Message-ID: <1505092240-10864-8-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 7/8] cryptodev-builtin: add stateless cipher
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds stateless cipher support for builtin-backend

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
[simplify the code & correct the return value]
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 backends/cryptodev-builtin.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index ab3d88d..1152ea2 100755
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -335,6 +335,13 @@ static int cryptodev_builtin_sym_operation(
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
+    if (op_info->op_code != VIRTIO_CRYPTO_CIPHER_ENCRYPT &&
+        op_info->op_code != VIRTIO_CRYPTO_CIPHER_DECRYPT) {
+        error_setg(errp,
+               "Unsupported op code: %u", op_info->op_code);
+        return -VIRTIO_CRYPTO_NOTSUPP;
+    }
+
     sess = builtin->sessions[op_info->session_id];
 
     if (op_info->iv_len > 0) {
@@ -389,6 +396,84 @@ static void cryptodev_builtin_cleanup(
     cryptodev_backend_set_ready(backend, false);
 }
 
+static int
+cryptodev_builtin_sym_stateless_operation(
+                 CryptoDevBackend *backend,
+                 CryptoDevBackendSymStatelessInfo *op_info,
+                 uint32_t queue_index, Error **errp)
+{
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
+        return -VIRTIO_CRYPTO_NOTSUPP;
+    }
+
+    switch (sym_op_info->op_code) {
+    case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
+    case VIRTIO_CRYPTO_CIPHER_DECRYPT:
+        ret = cryptodev_builtin_get_cipher_alg_mode(sess_info,
+                                                &algo, &mode, errp);
+        if (ret < 0) {
+            return -VIRTIO_CRYPTO_NOTSUPP;
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
+        return -VIRTIO_CRYPTO_NOTSUPP;
+    }
+
+    ret = VIRTIO_CRYPTO_OK;
+
+out:
+    qcrypto_cipher_free(cipher);
+    return ret;
+}
+
 static void
 cryptodev_builtin_class_init(ObjectClass *oc, void *data)
 {
@@ -399,6 +484,7 @@ cryptodev_builtin_class_init(ObjectClass *oc, void *data)
     bc->create_session = cryptodev_builtin_sym_create_session;
     bc->close_session = cryptodev_builtin_sym_close_session;
     bc->do_sym_op = cryptodev_builtin_sym_operation;
+    bc->do_sym_stateless_op = cryptodev_builtin_sym_stateless_operation;
 }
 
 static const TypeInfo cryptodev_builtin_info = {
-- 
1.8.3.1
