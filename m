Received: from eggs.gnu.org ([2001:4830:134:3::10]:50686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0002xA-Fh
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0O-0004Uj-Pr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0N-0004Sy-W0
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:08 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:21 +0800
Message-ID: <1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 6/9] virtio-crypto: rework
 virtio_crypto_handle_request
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

According to the new spec, we should use different
requst structure to store the data request based
on whether VIRTIO_CRYPTO_F_MUX_MODE feature bit is
negotiated or not.

In this patch, we havn't supported stateless mode
yet. The device reportes an error if both
VIRTIO_CRYPTO_F_MUX_MODE and VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE
are negotiated, meanwhile the header.flag doesn't set
to VIRTIO_CRYPTO_FLAG_SESSION_MODE.

Let's handle this scenario in the following patches.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c | 83 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 0353eb6..c4b8a2c 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -577,6 +577,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     VirtQueueElement *elem = &request->elem;
     int queue_index = virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
     struct virtio_crypto_op_data_req req;
+    struct virtio_crypto_op_data_req_mux req_mux;
     int ret;
     struct iovec *in_iov;
     struct iovec *out_iov;
@@ -587,6 +588,9 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     uint64_t session_id;
     CryptoDevBackendSymOpInfo *sym_op_info = NULL;
     Error *local_err = NULL;
+    bool mux_mode_is_negotiated;
+    struct virtio_crypto_op_header *header;
+    bool is_stateless_req = false;
 
     if (elem->out_num < 1 || elem->in_num < 1) {
         virtio_error(vdev, "virtio-crypto dataq missing headers");
@@ -597,12 +601,28 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     out_iov = elem->out_sg;
     in_num = elem->in_num;
     in_iov = elem->in_sg;
-    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
-                != sizeof(req))) {
-        virtio_error(vdev, "virtio-crypto request outhdr too short");
-        return -1;
+
+    mux_mode_is_negotiated =
+        virtio_vdev_has_feature(vdev, VIRTIO_CRYPTO_F_MUX_MODE);
+    if (!mux_mode_is_negotiated) {
+        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
+                    != sizeof(req))) {
+            virtio_error(vdev, "virtio-crypto request outhdr too short");
+            return -1;
+        }
+        iov_discard_front(&out_iov, &out_num, sizeof(req));
+
+        header = &req.header;
+    } else {
+        if (unlikely(iov_to_buf(out_iov, out_num, 0, &req_mux,
+                sizeof(req_mux)) != sizeof(req_mux))) {
+            virtio_error(vdev, "virtio-crypto request outhdr too short");
+            return -1;
+        }
+        iov_discard_front(&out_iov, &out_num, sizeof(req_mux));
+
+        header = &req_mux.header;
     }
-    iov_discard_front(&out_iov, &out_num, sizeof(req));
 
     if (in_iov[in_num - 1].iov_len <
             sizeof(struct virtio_crypto_inhdr)) {
@@ -623,16 +643,51 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     request->in_num = in_num;
     request->in_iov = in_iov;
 
-    opcode = ldl_le_p(&req.header.opcode);
-    session_id = ldq_le_p(&req.header.session_id);
+    opcode = ldl_le_p(&header->opcode);
 
     switch (opcode) {
     case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
     case VIRTIO_CRYPTO_CIPHER_DECRYPT:
-        ret = virtio_crypto_handle_sym_req(vcrypto,
+        if (!mux_mode_is_negotiated) {
+            ret = virtio_crypto_handle_sym_req(vcrypto,
                          &req.u.sym_req,
                          &sym_op_info,
                          out_iov, out_num);
+        } else {
+            if (!virtio_vdev_has_feature(vdev,
+                    VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE)) {
+                /*
+                 * If the VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE is not
+                 * negotiated, the driver MUST use the session mode
+                 */
+                ret = virtio_crypto_handle_sym_req(vcrypto,
+                         &req_mux.u.sym_req.data,
+                         &sym_op_info,
+                         out_iov, out_num);
+            } else {
+                /*
+                 * If the VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE is
+                 * negotiated, the device MUST parse header.flag
+                 * in order to decide which mode the driver uses.
+                 */
+                if (header->flag == VIRTIO_CRYPTO_FLAG_SESSION_MODE) {
+                    ret = virtio_crypto_handle_sym_req(vcrypto,
+                         &req_mux.u.sym_req.data,
+                         &sym_op_info,
+                         out_iov, out_num);
+                } else {
+                    is_stateless_req = true;
+                    /*
+                     * Handle stateless mode, that is
+                     * header->flag == VIRTIO_CRYPTO_FLAG_STATELESS_MODE
+                     */
+                    virtio_error(vdev,
+                        "virtio-crypto do not support stateless mode");
+                    return -1;
+                }
+            }
+        }
+
         /* Serious errors, need to reset virtio crypto device */
         if (ret == -EFAULT) {
             return -1;
@@ -640,11 +695,15 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
             virtio_crypto_req_complete(request, VIRTIO_CRYPTO_NOTSUPP);
             virtio_crypto_free_request(request);
         } else {
-            sym_op_info->session_id = session_id;
+            if (!is_stateless_req) {
+                sym_op_info->op_code = opcode;
+                session_id = ldq_le_p(&header->session_id);
+                sym_op_info->session_id = session_id;
+                /* Set request's parameter */
+                request->flags = CRYPTODEV_BACKEND_ALG_SYM;
+                request->u.sym_op_info = sym_op_info;
+            }
 
-            /* Set request's parameter */
-            request->flags = CRYPTODEV_BACKEND_ALG_SYM;
-            request->u.sym_op_info = sym_op_info;
             ret = cryptodev_backend_crypto_operation(vcrypto->cryptodev,
                                     request, queue_index, &local_err);
             if (ret < 0) {
-- 
1.8.3.1
