Received: from eggs.gnu.org ([2001:4830:134:3::10]:40330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtm-0005yj-C7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtj-0001OQ-Oc
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVbtj-0001OG-FX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:03:07 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 13:02:37 +0200
Message-Id: <20170713110237.6712-9-lprosek@redhat.com>
In-Reply-To: <20170713110237.6712-1-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/8] virtio-crypto: use virtqueue_error for
 errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

virtqueue_error includes queue index in the error output and is preferred
for errors that pertain to a virtqueue rather than to the device as a whole.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/virtio/virtio-crypto.c | 56 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 0353eb6..08e6c03 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -35,6 +35,7 @@ static inline int virtio_crypto_vq2q(int queue_index)
 
 static int
 virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
+           VirtQueue *ctrl_vq,
            CryptoDevBackendSymSessionInfo *info,
            struct virtio_crypto_cipher_session_para *cipher_para,
            struct iovec **iov, unsigned int *out_num)
@@ -61,7 +62,7 @@ virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
         info->cipher_key = g_malloc(info->key_len);
         s = iov_to_buf(*iov, num, 0, info->cipher_key, info->key_len);
         if (unlikely(s != info->key_len)) {
-            virtio_error(vdev, "virtio-crypto cipher key incorrect");
+            virtqueue_error(ctrl_vq, "virtio-crypto cipher key incorrect");
             return -EFAULT;
         }
         iov_discard_front(iov, &num, info->key_len);
@@ -73,6 +74,7 @@ virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
 
 static int64_t
 virtio_crypto_create_sym_session(VirtIOCrypto *vcrypto,
+               VirtQueue *ctrl_vq,
                struct virtio_crypto_sym_create_session_req *sess_req,
                uint32_t queue_id,
                uint32_t opcode,
@@ -92,7 +94,7 @@ virtio_crypto_create_sym_session(VirtIOCrypto *vcrypto,
     info.op_code = opcode;
 
     if (op_type == VIRTIO_CRYPTO_SYM_OP_CIPHER) {
-        ret = virtio_crypto_cipher_session_helper(vdev, &info,
+        ret = virtio_crypto_cipher_session_helper(vdev, ctrl_vq, &info,
                            &sess_req->u.cipher.para,
                            &iov, &out_num);
         if (ret < 0) {
@@ -101,7 +103,7 @@ virtio_crypto_create_sym_session(VirtIOCrypto *vcrypto,
     } else if (op_type == VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING) {
         size_t s;
         /* cipher part */
-        ret = virtio_crypto_cipher_session_helper(vdev, &info,
+        ret = virtio_crypto_cipher_session_helper(vdev, ctrl_vq, &info,
                            &sess_req->u.chain.para.cipher_param,
                            &iov, &out_num);
         if (ret < 0) {
@@ -131,7 +133,7 @@ virtio_crypto_create_sym_session(VirtIOCrypto *vcrypto,
                 s = iov_to_buf(iov, out_num, 0, info.auth_key,
                                info.auth_key_len);
                 if (unlikely(s != info.auth_key_len)) {
-                    virtio_error(vdev,
+                    virtqueue_error(ctrl_vq,
                           "virtio-crypto authenticated key incorrect");
                     ret = -EFAULT;
                     goto err;
@@ -229,7 +231,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             break;
         }
         if (elem->out_num < 1 || elem->in_num < 1) {
-            virtio_error(vdev, "virtio-crypto ctrl missing headers");
+            virtqueue_error(vq, "virtio-crypto ctrl missing headers");
             virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             break;
@@ -241,7 +243,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         in_iov = elem->in_sg;
         if (unlikely(iov_to_buf(out_iov, out_num, 0, &ctrl, sizeof(ctrl))
                     != sizeof(ctrl))) {
-            virtio_error(vdev, "virtio-crypto request ctrl_hdr too short");
+            virtqueue_error(vq, "virtio-crypto request ctrl_hdr too short");
             virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             break;
@@ -254,7 +256,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         switch (opcode) {
         case VIRTIO_CRYPTO_CIPHER_CREATE_SESSION:
             memset(&input, 0, sizeof(input));
-            session_id = virtio_crypto_create_sym_session(vcrypto,
+            session_id = virtio_crypto_create_sym_session(vcrypto, vq,
                              &ctrl.u.sym_create_session,
                              queue_id, opcode,
                              out_iov, out_num);
@@ -274,7 +276,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
             s = iov_from_buf(in_iov, in_num, 0, &input, sizeof(input));
             if (unlikely(s != sizeof(input))) {
-                virtio_error(vdev, "virtio-crypto input incorrect");
+                virtqueue_error(vq, "virtio-crypto input incorrect");
                 virtqueue_detach_element(vq, elem, 0);
                 break;
             }
@@ -290,7 +292,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             /* The status only occupy one byte, we can directly use it */
             s = iov_from_buf(in_iov, in_num, 0, &status, sizeof(status));
             if (unlikely(s != sizeof(status))) {
-                virtio_error(vdev, "virtio-crypto status incorrect");
+                virtqueue_error(vq, "virtio-crypto status incorrect");
                 virtqueue_detach_element(vq, elem, 0);
                 break;
             }
@@ -306,7 +308,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             stl_le_p(&input.status, VIRTIO_CRYPTO_NOTSUPP);
             s = iov_from_buf(in_iov, in_num, 0, &input, sizeof(input));
             if (unlikely(s != sizeof(input))) {
-                virtio_error(vdev, "virtio-crypto input incorrect");
+                virtqueue_error(vq, "virtio-crypto input incorrect");
                 virtqueue_detach_element(vq, elem, 0);
                 break;
             }
@@ -370,7 +372,7 @@ virtio_crypto_sym_input_data_helper(VirtIODevice *vdev,
     /* Save the cipher result */
     s = iov_from_buf(req->in_iov, req->in_num, 0, sym_op_info->dst, len);
     if (s != len) {
-        virtio_error(vdev, "virtio-crypto dest data incorrect");
+        virtqueue_error(req->vq, "virtio-crypto dest data incorrect");
         return;
     }
 
@@ -383,7 +385,7 @@ virtio_crypto_sym_input_data_helper(VirtIODevice *vdev,
                          sym_op_info->digest_result,
                          sym_op_info->digest_result_len);
         if (s != sym_op_info->digest_result_len) {
-            virtio_error(vdev, "virtio-crypto digest result incorrect");
+            virtqueue_error(req->vq, "virtio-crypto digest result incorrect");
         }
     }
 }
@@ -414,12 +416,13 @@ virtio_crypto_get_request(VirtIOCrypto *s, VirtQueue *vq)
 }
 
 static CryptoDevBackendSymOpInfo *
-virtio_crypto_sym_op_helper(VirtIODevice *vdev,
+virtio_crypto_sym_op_helper(VirtIOCryptoReq *request,
            struct virtio_crypto_cipher_para *cipher_para,
            struct virtio_crypto_alg_chain_data_para *alg_chain_para,
            struct iovec *iov, unsigned int out_num)
 {
-    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(request->vcrypto);
+    VirtQueue *vq = request->vq;
     CryptoDevBackendSymOpInfo *op_info;
     uint32_t src_len = 0, dst_len = 0;
     uint32_t iv_len = 0;
@@ -454,7 +457,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
 
     max_len = (uint64_t)iv_len + aad_len + src_len + dst_len + hash_result_len;
     if (unlikely(max_len > vcrypto->conf.max_size)) {
-        virtio_error(vdev, "virtio-crypto too big length");
+        virtqueue_error(vq, "virtio-crypto too big length");
         return NULL;
     }
 
@@ -475,7 +478,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
 
         s = iov_to_buf(iov, out_num, 0, op_info->iv, op_info->iv_len);
         if (unlikely(s != op_info->iv_len)) {
-            virtio_error(vdev, "virtio-crypto iv incorrect");
+            virtqueue_error(vq, "virtio-crypto iv incorrect");
             goto err;
         }
         iov_discard_front(&iov, &out_num, op_info->iv_len);
@@ -489,7 +492,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
 
         s = iov_to_buf(iov, out_num, 0, op_info->aad_data, op_info->aad_len);
         if (unlikely(s != op_info->aad_len)) {
-            virtio_error(vdev, "virtio-crypto additional auth data incorrect");
+            virtqueue_error(vq, "virtio-crypto additional auth data incorrect");
             goto err;
         }
         iov_discard_front(&iov, &out_num, op_info->aad_len);
@@ -504,7 +507,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
 
         s = iov_to_buf(iov, out_num, 0, op_info->src, op_info->src_len);
         if (unlikely(s != op_info->src_len)) {
-            virtio_error(vdev, "virtio-crypto source data incorrect");
+            virtqueue_error(vq, "virtio-crypto source data incorrect");
             goto err;
         }
         iov_discard_front(&iov, &out_num, op_info->src_len);
@@ -532,26 +535,25 @@ err:
 }
 
 static int
-virtio_crypto_handle_sym_req(VirtIOCrypto *vcrypto,
+virtio_crypto_handle_sym_req(VirtIOCryptoReq *request,
                struct virtio_crypto_sym_data_req *req,
                CryptoDevBackendSymOpInfo **sym_op_info,
                struct iovec *iov, unsigned int out_num)
 {
-    VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
     uint32_t op_type;
     CryptoDevBackendSymOpInfo *op_info;
 
     op_type = ldl_le_p(&req->op_type);
 
     if (op_type == VIRTIO_CRYPTO_SYM_OP_CIPHER) {
-        op_info = virtio_crypto_sym_op_helper(vdev, &req->u.cipher.para,
+        op_info = virtio_crypto_sym_op_helper(request, &req->u.cipher.para,
                                               NULL, iov, out_num);
         if (!op_info) {
             return -EFAULT;
         }
         op_info->op_type = op_type;
     } else if (op_type == VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING) {
-        op_info = virtio_crypto_sym_op_helper(vdev, NULL,
+        op_info = virtio_crypto_sym_op_helper(request, NULL,
                                               &req->u.chain.para,
                                               iov, out_num);
         if (!op_info) {
@@ -573,7 +575,7 @@ static int
 virtio_crypto_handle_request(VirtIOCryptoReq *request)
 {
     VirtIOCrypto *vcrypto = request->vcrypto;
-    VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
+    VirtQueue *vq = request->vq;
     VirtQueueElement *elem = &request->elem;
     int queue_index = virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
     struct virtio_crypto_op_data_req req;
@@ -589,7 +591,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     Error *local_err = NULL;
 
     if (elem->out_num < 1 || elem->in_num < 1) {
-        virtio_error(vdev, "virtio-crypto dataq missing headers");
+        virtqueue_error(vq, "virtio-crypto dataq missing headers");
         return -1;
     }
 
@@ -599,14 +601,14 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     in_iov = elem->in_sg;
     if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
                 != sizeof(req))) {
-        virtio_error(vdev, "virtio-crypto request outhdr too short");
+        virtqueue_error(vq, "virtio-crypto request outhdr too short");
         return -1;
     }
     iov_discard_front(&out_iov, &out_num, sizeof(req));
 
     if (in_iov[in_num - 1].iov_len <
             sizeof(struct virtio_crypto_inhdr)) {
-        virtio_error(vdev, "virtio-crypto request inhdr too short");
+        virtqueue_error(vq, "virtio-crypto request inhdr too short");
         return -1;
     }
     /* We always touch the last byte, so just see how big in_iov is. */
@@ -629,7 +631,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     switch (opcode) {
     case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
     case VIRTIO_CRYPTO_CIPHER_DECRYPT:
-        ret = virtio_crypto_handle_sym_req(vcrypto,
+        ret = virtio_crypto_handle_sym_req(request,
                          &req.u.sym_req,
                          &sym_op_info,
                          out_iov, out_num);
-- 
2.9.3
