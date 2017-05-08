Received: from eggs.gnu.org ([2001:4830:134:3::10]:50692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0002xF-Nv
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0Q-0004VU-OY
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0P-0004UK-K1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:10 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:22 +0800
Message-ID: <1494243504-127980-8-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 7/9] virtio-crypto: add stateless crypto
 request handler
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

We can support stateless crypto request now.
The stateless cipher request componet is:
 header + key + iv + src_data + dst_data
and The algorithm chainning stateless request
component is:
 header + key + auth_key + iv + aad + src_data +
 dst_data + hash_result

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c |   3 +-
 hw/virtio/virtio-crypto.c    | 248 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 246 insertions(+), 5 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 7829999..40dc568 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -91,7 +91,8 @@ static void cryptodev_builtin_init(
      * Why this value? Just avoid to overflow when
      * memory allocation for each crypto request.
      */
-    backend->conf.max_size = LONG_MAX - sizeof(CryptoDevBackendSymOpInfo);
+    backend->conf.max_size = LONG_MAX -
+                    sizeof(CryptoDevBackendSymStatelessInfo);
     backend->conf.max_cipher_key_len = CRYPTODEV_BUITLIN_MAX_CIPHER_KEY_LEN;
     backend->conf.max_auth_key_len = CRYPTODEV_BUITLIN_MAX_AUTH_KEY_LEN;
 
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index c4b8a2c..5422f25 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -335,9 +335,10 @@ static void virtio_crypto_init_request(VirtIOCrypto *vcrypto, VirtQueue *vq,
 
 static void virtio_crypto_free_request(VirtIOCryptoReq *req)
 {
+    size_t max_len;
+
     if (req) {
         if (req->flags == CRYPTODEV_BACKEND_ALG_SYM) {
-            size_t max_len;
             CryptoDevBackendSymOpInfo *op_info = req->u.sym_op_info;
 
             max_len = op_info->iv_len +
@@ -349,6 +350,21 @@ static void virtio_crypto_free_request(VirtIOCryptoReq *req)
             /* Zeroize and free request data structure */
             memset(op_info, 0, sizeof(*op_info) + max_len);
             g_free(op_info);
+        } else if (req->flags == CRYPTODEV_BACKEND_ALG_SYM_STATELESS) {
+            CryptoDevBackendSymStatelessInfo *sym_stateless_info;
+
+            sym_stateless_info = req->u.sym_stateless_info;
+            max_len = sym_stateless_info->session_info.key_len +
+                sym_stateless_info->session_info.auth_key_len +
+                sym_stateless_info->op_info.iv_len +
+                sym_stateless_info->op_info.src_len +
+                sym_stateless_info->op_info.dst_len +
+                sym_stateless_info->op_info.aad_len +
+                sym_stateless_info->op_info.digest_result_len;
+            /* Zeroize and free request data structure */
+            memset(sym_stateless_info, 0,
+                sizeof(*sym_stateless_info) + max_len);
+            g_free(sym_stateless_info);
         }
         g_free(req);
     }
@@ -396,6 +412,9 @@ static void virtio_crypto_req_complete(VirtIOCryptoReq *req, uint8_t status)
     if (req->flags == CRYPTODEV_BACKEND_ALG_SYM) {
         virtio_crypto_sym_input_data_helper(vdev, req, status,
                                             req->u.sym_op_info);
+    } else if (req->flags == CRYPTODEV_BACKEND_ALG_SYM_STATELESS) {
+        virtio_crypto_sym_input_data_helper(vdev, req, status,
+                &req->u.sym_stateless_info->op_info);
     }
     stb_p(&req->in->status, status);
     virtqueue_push(req->vq, &req->elem, req->in_len);
@@ -570,6 +589,221 @@ virtio_crypto_handle_sym_req(VirtIOCrypto *vcrypto,
 }
 
 static int
+virtio_crypto_handle_sym_stateless_req(VirtIOCrypto *vcrypto,
+               struct virtio_crypto_sym_data_req_stateless *req,
+               CryptoDevBackendSymStatelessInfo **stateless_info,
+               struct iovec *iov, unsigned int out_num)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
+    CryptoDevBackendSymStatelessInfo *sym_stateless_info;
+
+    uint32_t op_type;
+    uint32_t src_len = 0, dst_len = 0;
+    uint32_t iv_len = 0;
+    uint32_t aad_len = 0, hash_result_len = 0;
+    uint32_t hash_start_src_offset = 0, len_to_hash = 0;
+    uint32_t cipher_start_src_offset = 0, len_to_cipher = 0;
+    uint32_t key_len = 0, auth_key_len = 0;
+
+    uint64_t max_len, curr_size = 0;
+    size_t s;
+
+    op_type = ldl_le_p(&req->op_type);
+
+    if (op_type == VIRTIO_CRYPTO_SYM_OP_CIPHER) {
+        key_len = ldl_le_p(&req->u.cipher.para.sess_para.keylen);
+        iv_len = ldl_le_p(&req->u.cipher.para.iv_len);
+        src_len = ldl_le_p(&req->u.cipher.para.src_data_len);
+        dst_len = ldl_le_p(&req->u.cipher.para.dst_data_len);
+    } else if (op_type == VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING) {
+        key_len = ldl_le_p(&req->u.chain.para.sess_para.cipher.keylen);
+        auth_key_len =
+            ldl_le_p(&req->u.chain.para.sess_para.hash.auth_key_len);
+        iv_len = ldl_le_p(&req->u.chain.para.iv_len);
+        src_len = ldl_le_p(&req->u.chain.para.src_data_len);
+        dst_len = ldl_le_p(&req->u.chain.para.dst_data_len);
+
+        aad_len = ldl_le_p(&req->u.chain.para.aad_len);
+        hash_result_len = ldl_le_p(&req->u.chain.para.hash_result_len);
+        hash_start_src_offset = ldl_le_p(
+                         &req->u.chain.para.hash_start_src_offset);
+        cipher_start_src_offset = ldl_le_p(
+                         &req->u.chain.para.cipher_start_src_offset);
+        len_to_cipher = ldl_le_p(&req->u.chain.para.len_to_cipher);
+        len_to_hash = ldl_le_p(&req->u.chain.para.len_to_hash);
+    } else {
+        /* VIRTIO_CRYPTO_SYM_OP_NONE */
+        error_report("virtio-crypto unsupported cipher type");
+        return -VIRTIO_CRYPTO_NOTSUPP;
+    }
+
+    if (key_len > vcrypto->conf.max_cipher_key_len) {
+        virtio_error(vdev,
+            "virtio-crypto length of cipher key is too big: %u", key_len);
+        return -EFAULT;
+    }
+
+    if (auth_key_len > vcrypto->conf.max_auth_key_len) {
+        virtio_error(vdev,
+         "virtio-crypto length of auth key is too big: %u", auth_key_len);
+        return -EFAULT;
+    }
+
+    max_len = (uint64_t)key_len + auth_key_len + iv_len + aad_len +
+                src_len + dst_len + hash_result_len;
+    if (unlikely(max_len > vcrypto->conf.max_size)) {
+        virtio_error(vdev, "virtio-crypto too big length");
+        return -EFAULT;
+    }
+
+    sym_stateless_info =
+            g_malloc0(sizeof(CryptoDevBackendSymStatelessInfo) + max_len);
+    sym_stateless_info->session_info.key_len = key_len;
+    sym_stateless_info->session_info.auth_key_len = auth_key_len;
+    sym_stateless_info->op_info.iv_len = iv_len;
+    sym_stateless_info->op_info.src_len = src_len;
+    sym_stateless_info->op_info.dst_len = dst_len;
+    sym_stateless_info->op_info.aad_len = aad_len;
+    sym_stateless_info->op_info.digest_result_len = hash_result_len;
+    sym_stateless_info->op_info.hash_start_src_offset =
+                                            hash_start_src_offset;
+    sym_stateless_info->op_info.len_to_hash = len_to_hash;
+    sym_stateless_info->op_info.cipher_start_src_offset =
+                                            cipher_start_src_offset;
+    sym_stateless_info->op_info.len_to_cipher = len_to_cipher;
+
+    sym_stateless_info->session_info.op_type =
+                    sym_stateless_info->op_info.op_type = op_type;
+    if (op_type == VIRTIO_CRYPTO_SYM_OP_CIPHER) {
+        sym_stateless_info->session_info.cipher_alg =
+                    ldl_le_p(&req->u.cipher.para.sess_para.algo);
+        sym_stateless_info->session_info.direction =
+                    ldl_le_p(&req->u.cipher.para.sess_para.op);
+    } else { /* It must be algorithm chain here */
+        sym_stateless_info->session_info.cipher_alg =
+                    ldl_le_p(&req->u.chain.para.sess_para.cipher.algo);
+        sym_stateless_info->session_info.direction =
+                    ldl_le_p(&req->u.chain.para.sess_para.cipher.op);
+        sym_stateless_info->session_info.hash_alg =
+                    ldl_le_p(&req->u.chain.para.sess_para.hash.algo);
+        sym_stateless_info->session_info.hash_mode =
+                    ldl_le_p(&req->u.chain.para.sess_para.hash.hash_mode);
+        sym_stateless_info->session_info.alg_chain_order =
+                    ldl_le_p(&req->u.chain.para.sess_para.alg_chain_order);
+    }
+
+    DPRINTF("cipher_alg=%" PRIu32 ", info->direction=%" PRIu32 "\n",
+            sym_stateless_info->session_info.cipher_alg,
+            sym_stateless_info->session_info.direction);
+    /* Begin to parse the buffer */
+
+    /*
+     * Cipher request components:
+     *   header + key + iv + src_data + dst_data
+     *
+     * Alg_chainning request components:
+     *   header + key + auth_key + iv + aad + src_data + dst_data + hash_result
+     */
+     if (key_len > 0) {
+        DPRINTF("key_len=%" PRIu32 "\n", key_len);
+        sym_stateless_info->session_info.cipher_key =
+                sym_stateless_info->op_info.data + curr_size;
+
+        s = iov_to_buf(iov, out_num, 0,
+            sym_stateless_info->session_info.cipher_key, key_len);
+        if (unlikely(s != key_len)) {
+            virtio_error(vdev, "virtio-crypto cipher key incorrect");
+            goto err;
+        }
+        iov_discard_front(&iov, &out_num, key_len);
+        curr_size += key_len;
+    }
+    if (auth_key_len > 0) {
+        DPRINTF("auth_key_len=%" PRIu32 "\n", auth_key_len);
+        sym_stateless_info->session_info.auth_key =
+                sym_stateless_info->op_info.data + curr_size;
+
+        s = iov_to_buf(iov, out_num, 0,
+            sym_stateless_info->session_info.auth_key, auth_key_len);
+        if (unlikely(s != auth_key_len)) {
+            virtio_error(vdev, "virtio-crypto auth key incorrect");
+            goto err;
+        }
+        iov_discard_front(&iov, &out_num, auth_key_len);
+        curr_size += auth_key_len;
+    }
+    if (iv_len > 0) {
+        DPRINTF("iv_len=%" PRIu32 "\n", iv_len);
+        sym_stateless_info->op_info.iv =
+            sym_stateless_info->op_info.data + curr_size;
+
+        s = iov_to_buf(iov, out_num, 0,
+            sym_stateless_info->op_info.iv, iv_len);
+        if (unlikely(s != iv_len)) {
+            virtio_error(vdev, "virtio-crypto iv incorrect");
+            goto err;
+        }
+        iov_discard_front(&iov, &out_num, iv_len);
+        curr_size += iv_len;
+    }
+
+    /* Handle additional authentication data if exists */
+    if (aad_len > 0) {
+        DPRINTF("aad_len=%" PRIu32 "\n", aad_len);
+        sym_stateless_info->op_info.aad_data =
+            sym_stateless_info->op_info.data + curr_size;
+
+        s = iov_to_buf(iov, out_num, 0,
+            sym_stateless_info->op_info.aad_data, aad_len);
+        if (unlikely(s != aad_len)) {
+            virtio_error(vdev, "virtio-crypto additional auth data incorrect");
+            goto err;
+        }
+        iov_discard_front(&iov, &out_num, aad_len);
+
+        curr_size += aad_len;
+    }
+    /* Handle the source data */
+    if (src_len > 0) {
+        DPRINTF("src_len=%" PRIu32 "\n", src_len);
+        sym_stateless_info->op_info.src =
+            sym_stateless_info->op_info.data + curr_size;
+
+        s = iov_to_buf(iov, out_num, 0,
+            sym_stateless_info->op_info.src, src_len);
+        if (unlikely(s != src_len)) {
+            virtio_error(vdev, "virtio-crypto source data incorrect");
+            goto err;
+        }
+        iov_discard_front(&iov, &out_num, src_len);
+
+        curr_size += src_len;
+    }
+
+    /* Handle the destination data */
+    sym_stateless_info->op_info.dst =
+        sym_stateless_info->op_info.data + curr_size;
+    curr_size += dst_len;
+
+    DPRINTF("dst_len=%" PRIu32 "\n", dst_len);
+
+    /* Handle the hash digest result */
+    if (hash_result_len > 0) {
+        DPRINTF("hash_result_len=%" PRIu32 "\n", hash_result_len);
+        sym_stateless_info->op_info.digest_result =
+            sym_stateless_info->op_info.data + curr_size;
+    }
+
+    *stateless_info = sym_stateless_info;
+
+    return 0;
+
+err:
+    g_free(sym_stateless_info);
+    return -EFAULT;
+}
+
+static int
 virtio_crypto_handle_request(VirtIOCryptoReq *request)
 {
     VirtIOCrypto *vcrypto = request->vcrypto;
@@ -591,6 +825,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     bool mux_mode_is_negotiated;
     struct virtio_crypto_op_header *header;
     bool is_stateless_req = false;
+    CryptoDevBackendSymStatelessInfo *stateless_info = NULL;
 
     if (elem->out_num < 1 || elem->in_num < 1) {
         virtio_error(vdev, "virtio-crypto dataq missing headers");
@@ -681,9 +916,10 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
                      * Handle stateless mode, that is
                      * header->flag == VIRTIO_CRYPTO_FLAG_STATELESS_MODE
                      */
-                    virtio_error(vdev,
-                        "virtio-crypto do not support stateless mode");
-                    return -1;
+                    ret = virtio_crypto_handle_sym_stateless_req(vcrypto,
+                            &req_mux.u.sym_stateless_req,
+                            &stateless_info,
+                            out_iov, out_num);
                 }
             }
         }
@@ -702,6 +938,10 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
                 /* Set request's parameter */
                 request->flags = CRYPTODEV_BACKEND_ALG_SYM;
                 request->u.sym_op_info = sym_op_info;
+            } else {
+                stateless_info->op_info.op_code = opcode;
+                request->flags = CRYPTODEV_BACKEND_ALG_SYM_STATELESS;
+                request->u.sym_stateless_info = stateless_info;
             }
 
             ret = cryptodev_backend_crypto_operation(vcrypto->cryptodev,
-- 
1.8.3.1
