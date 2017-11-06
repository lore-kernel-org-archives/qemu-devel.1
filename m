Received: from eggs.gnu.org ([2001:4830:134:3::10]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLa-0006Gm-Ge
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLY-0008IT-2E
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLW-0008Ao-O8
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:23 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:59 +0800
Message-ID: <1509951422-20060-8-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 07/10] virtio-crypto: add stateless crypto
 request handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

We can support stateless crypto request now.
The stateless cipher request componet is:
 header + payload + key + iv + src_data + dst_data
and The algorithm chainning stateless request
component is:
 header + payload + key + auth_key + iv + aad + src_data +
 dst_data + hash_result

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
[simplify the code]
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 backends/cryptodev-builtin.c                   |   3 +-
 hw/virtio/virtio-crypto.c                      | 311 +++++++++++++++++++++++--
 include/standard-headers/linux/virtio_crypto.h | 161 +++++++++++++
 include/sysemu/cryptodev.h                     |   3 +
 4 files changed, 462 insertions(+), 16 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 657c0ba..6df23b9 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -91,7 +91,8 @@ static void cryptodev_builtin_init(
      * Why this value? Just avoid to overflow when
      * memory allocation for each crypto request.
      */
-    backend->conf.max_size = LONG_MAX - sizeof(CryptoDevBackendSymOpInfo);
+    backend->conf.max_size = LONG_MAX -
+                             sizeof(CryptoDevBackendSymStatelessInfo);
     backend->conf.max_cipher_key_len = CRYPTODEV_BUITLIN_MAX_CIPHER_KEY_LEN;
     backend->conf.max_auth_key_len = CRYPTODEV_BUITLIN_MAX_AUTH_KEY_LEN;
 
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 10a0c35..e46c4a3 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -38,6 +38,28 @@ static inline bool virtio_crypto_in_mux_mode(VirtIODevice *vdev)
     return virtio_vdev_has_feature(vdev, VIRTIO_CRYPTO_F_MUX_MODE);
 }
 
+static inline bool virtio_crypto_stateless_req(VirtIODevice *vdev,
+                                uint32_t opcode, uint32_t flag)
+{
+    if (!virtio_crypto_in_mux_mode(vdev)) {
+        return false;
+    }
+
+    switch (opcode) {
+    case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
+    case VIRTIO_CRYPTO_CIPHER_DECRYPT:
+        if (!virtio_vdev_has_feature(vdev,
+            VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE)) {
+            return false;
+        }
+        return (flag != VIRTIO_CRYPTO_FLAG_SESSION_MODE);
+    default:
+        break;
+    }
+
+    return false;
+}
+
 static int
 virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
            CryptoDevBackendSymSessionInfo *info,
@@ -370,9 +392,10 @@ static void virtio_crypto_init_request(VirtIOCrypto *vcrypto, VirtQueue *vq,
 
 static void virtio_crypto_free_request(VirtIOCryptoReq *req)
 {
+    size_t max_len;
+
     if (req) {
         if (req->flags == CRYPTODEV_BACKEND_ALG_SYM) {
-            size_t max_len;
             CryptoDevBackendSymOpInfo *op_info = req->u.sym_op_info;
 
             max_len = op_info->iv_len +
@@ -384,6 +407,21 @@ static void virtio_crypto_free_request(VirtIOCryptoReq *req)
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
@@ -431,6 +469,9 @@ static void virtio_crypto_req_complete(VirtIOCryptoReq *req, uint8_t status)
     if (req->flags == CRYPTODEV_BACKEND_ALG_SYM) {
         virtio_crypto_sym_input_data_helper(vdev, req, status,
                                             req->u.sym_op_info);
+    } else if (req->flags == CRYPTODEV_BACKEND_ALG_SYM_STATELESS) {
+        virtio_crypto_sym_input_data_helper(vdev, req, status,
+                        &req->u.sym_stateless_info->op_info);
     }
     stb_p(&req->in->status, status);
     virtqueue_push(req->vq, &req->elem, req->in_len);
@@ -605,6 +646,221 @@ virtio_crypto_handle_sym_req(VirtIOCrypto *vcrypto,
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
@@ -620,7 +876,10 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     uint32_t opcode;
     uint8_t status = VIRTIO_CRYPTO_ERR;
     uint64_t session_id;
-    CryptoDevBackendSymOpInfo *sym_op_info = NULL;
+    union {
+        CryptoDevBackendSymOpInfo *sym_op_info;
+        CryptoDevBackendSymStatelessInfo *stateless_info;
+    } info;
     Error *local_err = NULL;
     size_t s;
 
@@ -663,27 +922,41 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     opcode = ldl_le_p(&hdr.opcode);
     session_id = ldq_le_p(&hdr.session_id);
 
-#define data_req_payload_size(vdev, req)                        \
-        (virtio_crypto_in_mux_mode((vdev)) ? sizeof((req)) :    \
+#define data_req_payload_size(vdev, base)                \
+        (virtio_crypto_in_mux_mode((vdev)) ? (base) :    \
         VIRTIO_CRYPTO_DATA_REQ_PAYLOAD_SIZE_NONMUX)
     switch (opcode) {
     case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
     case VIRTIO_CRYPTO_CIPHER_DECRYPT:
     {
-        struct virtio_crypto_sym_data_req req;
-
-        iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
+        bool is_stateless;
+        size_t base;
+        union {
+            struct virtio_crypto_sym_data_req req;
+            struct virtio_crypto_sym_data_req_stateless stateless_req;
+        } u_req;
+
+        is_stateless = virtio_crypto_stateless_req(vdev, opcode, hdr.flag);
+        base = is_stateless ? sizeof(u_req.stateless_req) : sizeof(u_req.req);
+        iov_to_buf(out_iov, out_num, 0, &u_req, base);
         /* The unused part of the req will be ingored */
-        s = data_req_payload_size(vdev, req);
+        s = data_req_payload_size(vdev, base);
         if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
             virtio_error(vdev, "virtio-crypto request additional "
                          "parameters too short");
             return -1;
         }
 
-        ret = virtio_crypto_handle_sym_req(vcrypto, &req,
-                                           &sym_op_info,
-                                           out_iov, out_num);
+        if (is_stateless) {
+            ret = virtio_crypto_handle_sym_stateless_req(vcrypto,
+                                               &u_req.stateless_req,
+                                               &info.stateless_info,
+                                               out_iov, out_num);
+        } else {
+            ret = virtio_crypto_handle_sym_req(vcrypto, &u_req.req,
+                                               &info.sym_op_info,
+                                               out_iov, out_num);
+        }
         /* Serious errors, need to reset virtio crypto device */
         if (ret == -EFAULT) {
             return -1;
@@ -691,11 +964,19 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
             virtio_crypto_req_complete(request, VIRTIO_CRYPTO_NOTSUPP);
             virtio_crypto_free_request(request);
         } else {
-            sym_op_info->session_id = session_id;
+            if (is_stateless) {
+                info.stateless_info->op_info.op_code = opcode;
+                request->flags = CRYPTODEV_BACKEND_ALG_SYM_STATELESS;
+                request->u.sym_stateless_info = info.stateless_info;
+            } else {
+                info.sym_op_info->op_code = opcode;
+                session_id = ldq_le_p(&hdr.session_id);
+                info.sym_op_info->session_id = session_id;
+                /* Set request's parameter */
+                request->flags = CRYPTODEV_BACKEND_ALG_SYM;
+                request->u.sym_op_info = info.sym_op_info;
+            }
 
-            /* Set request's parameter */
-            request->flags = CRYPTODEV_BACKEND_ALG_SYM;
-            request->u.sym_op_info = sym_op_info;
             ret = cryptodev_backend_crypto_operation(vcrypto->cryptodev,
                                     request, queue_index, &local_err);
             if (ret < 0) {
diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 81357e5..285914d 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -260,6 +260,7 @@ struct virtio_crypto_op_header {
 	uint32_t algo;
 	/* session_id should be service-specific algorithms */
 	uint64_t session_id;
+#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
 	/* control flag to control the request */
 	uint32_t flag;
 	uint32_t padding;
@@ -381,6 +382,166 @@ struct virtio_crypto_aead_data_req {
 
 #define VIRTIO_CRYPTO_DATA_REQ_PAYLOAD_SIZE_NONMUX 48
 
+struct virtio_crypto_cipher_para_stateless {
+   struct {
+       /* See VIRTIO_CRYPTO_CIPHER* above */
+       uint32_t algo;
+       /* length of key */
+       uint32_t keylen;
+
+       /* See VIRTIO_CRYPTO_OP_* above */
+       uint32_t op;
+   } sess_para;
+
+   /*
+    * Byte Length of valid IV/Counter
+    */
+   uint32_t iv_len;
+   /* length of source data */
+   uint32_t src_data_len;
+   /* length of dst data */
+   uint32_t dst_data_len;
+};
+
+struct virtio_crypto_alg_chain_data_para_stateless {
+   struct {
+       /* See VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_* above */
+       uint32_t alg_chain_order;
+       /* length of the additional authenticated data in bytes */
+       uint32_t aad_len;
+
+       struct {
+           /* See VIRTIO_CRYPTO_CIPHER* above */
+           uint32_t algo;
+           /* length of key */
+           uint32_t keylen;
+           /* See VIRTIO_CRYPTO_OP_* above */
+           uint32_t op;
+       } cipher;
+
+       struct {
+           /* See VIRTIO_CRYPTO_HASH_* or _MAC_* above */
+           uint32_t algo;
+           /* length of authenticated key */
+           uint32_t auth_key_len;
+           /* See VIRTIO_CRYPTO_SYM_HASH_MODE_* above */
+           uint32_t hash_mode;
+       } hash;
+   } sess_para;
+
+   uint32_t iv_len;
+   /* Length of source data */
+   uint32_t src_data_len;
+   /* Length of destination data */
+   uint32_t dst_data_len;
+   /* Starting point for cipher processing in source data */
+   uint32_t cipher_start_src_offset;
+   /* Length of the source data that the cipher will be computed on */
+   uint32_t len_to_cipher;
+   /* Starting point for hash processing in source data */
+   uint32_t hash_start_src_offset;
+   /* Length of the source data that the hash will be computed on */
+   uint32_t len_to_hash;
+   /* Length of the additional auth data */
+   uint32_t aad_len;
+   /* Length of the hash result */
+   uint32_t hash_result_len;
+   uint32_t reserved;
+};
+
+struct virtio_crypto_hash_para_stateless {
+   struct {
+       /* See VIRTIO_CRYPTO_HASH_* above */
+       uint32_t algo;
+   } sess_para;
+
+   /* length of source data */
+   uint32_t src_data_len;
+   /* hash result length */
+   uint32_t hash_result_len;
+   uint32_t reserved;
+};
+
+struct virtio_crypto_mac_para_stateless {
+   struct {
+       /* See VIRTIO_CRYPTO_MAC_* above */
+       uint32_t algo;
+       /* length of authenticated key */
+       uint32_t auth_key_len;
+   } sess_para;
+
+   /* length of source data */
+   uint32_t src_data_len;
+   /* hash result length */
+   uint32_t hash_result_len;
+};
+
+struct virtio_crypto_aead_para_stateless {
+   struct {
+       /* See VIRTIO_CRYPTO_AEAD_* above */
+       uint32_t algo;
+       /* length of key */
+       uint32_t key_len;
+       /* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+       uint32_t op;
+   } sess_para;
+
+   /*
+    * Byte Length of valid IV data pointed to by the below iv_addr
+    * parameter.
+    */
+   uint32_t iv_len;
+   /* Authentication tag length */
+   uint32_t tag_len;
+   /* length of the additional authenticated data (AAD) in bytes */
+   uint32_t aad_len;
+   /* length of source data */
+   uint32_t src_data_len;
+   /* length of dst data, it should be at least src_data_len + tag_len */
+   uint32_t dst_data_len;
+};
+
+struct virtio_crypto_cipher_data_req_stateless {
+   /* Device-readable part */
+   struct virtio_crypto_cipher_para_stateless para;
+   uint8_t padding[48];
+};
+
+struct virtio_crypto_hash_data_req_stateless {
+   /* Device-readable part */
+   struct virtio_crypto_hash_para_stateless para;
+   uint8_t padding[64];
+};
+
+struct virtio_crypto_mac_data_req_stateless {
+   /* Device-readable part */
+   struct virtio_crypto_mac_para_stateless para;
+   uint8_t padding[64];
+};
+
+struct virtio_crypto_alg_chain_data_req_stateless {
+   /* Device-readable part */
+   struct virtio_crypto_alg_chain_data_para_stateless para;
+};
+
+struct virtio_crypto_sym_data_req_stateless {
+   union {
+       struct virtio_crypto_cipher_data_req_stateless cipher;
+       struct virtio_crypto_alg_chain_data_req_stateless chain;
+       uint8_t padding[72];
+   } u;
+
+   /* See above VIRTIO_CRYPTO_SYM_OP_* */
+   uint32_t op_type;
+   uint32_t padding;
+};
+
+struct virtio_crypto_aead_data_req_stateless {
+   /* Device-readable part */
+   struct virtio_crypto_aead_para_stateless para;
+   uint8_t padding[48];
+};
+
 #define VIRTIO_CRYPTO_OK        0
 #define VIRTIO_CRYPTO_ERR       1
 #define VIRTIO_CRYPTO_BADMSG    2
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index aa2fcd8..9f83082 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -103,6 +103,7 @@ typedef struct CryptoDevBackendSymSessionInfo {
  *
  * @session_id: session index which was previously
  *              created by cryptodev_backend_sym_create_session()
+ * @op_code: operation code (refer to virtio_crypto.h)
  * @aad_len: byte length of additional authenticated data
  * @iv_len: byte length of initialization vector or counter
  * @src_len: byte length of source data
@@ -129,6 +130,8 @@ typedef struct CryptoDevBackendSymSessionInfo {
  */
 typedef struct CryptoDevBackendSymOpInfo {
     uint64_t session_id;
+    /* corresponding with virtio crypto spec */
+    uint32_t op_code;
     uint32_t aad_len;
     uint32_t iv_len;
     uint32_t src_len;
-- 
1.8.3.1
