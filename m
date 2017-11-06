Received: from eggs.gnu.org ([2001:4830:134:3::10]:49825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLe-0006Ii-CR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLd-0008V2-8a
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLc-0008Ot-MG
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:29 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:56 +0800
Message-ID: <1509951422-20060-5-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 04/10] virtio-crypto: remove
 virtio_crypto_op_data_req structure
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

The struct virtio_crypto_op_data_req is not needed, we can
use 'header + payload' instead. This makes the code simpler
to add MUX-mode support in the next patch.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 hw/virtio/virtio-crypto.c                      | 34 ++++++++++++++++++--------
 include/standard-headers/linux/virtio_crypto.h | 13 +---------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 9ffe26d..828d7ef 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -611,7 +611,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
     VirtQueueElement *elem = &request->elem;
     int queue_index = virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
-    struct virtio_crypto_op_data_req req;
+    struct virtio_crypto_op_header hdr;
     int ret;
     struct iovec *in_iov;
     struct iovec *out_iov;
@@ -622,6 +622,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     uint64_t session_id;
     CryptoDevBackendSymOpInfo *sym_op_info = NULL;
     Error *local_err = NULL;
+    size_t s;
 
     if (elem->out_num < 1 || elem->in_num < 1) {
         virtio_error(vdev, "virtio-crypto dataq missing headers");
@@ -632,12 +633,13 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     out_iov = elem->out_sg;
     in_num = elem->in_num;
     in_iov = elem->in_sg;
-    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
-                != sizeof(req))) {
+
+    s = sizeof(hdr);
+    if (unlikely(s != iov_to_buf(out_iov, out_num, 0, &hdr, s))) {
         virtio_error(vdev, "virtio-crypto request outhdr too short");
         return -1;
     }
-    iov_discard_front(&out_iov, &out_num, sizeof(req));
+    iov_discard_front(&out_iov, &out_num, s);
 
     if (in_iov[in_num - 1].iov_len <
             sizeof(struct virtio_crypto_inhdr)) {
@@ -658,16 +660,27 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     request->in_num = in_num;
     request->in_iov = in_iov;
 
-    opcode = ldl_le_p(&req.header.opcode);
-    session_id = ldq_le_p(&req.header.session_id);
+    opcode = ldl_le_p(&hdr.opcode);
+    session_id = ldq_le_p(&hdr.session_id);
 
     switch (opcode) {
     case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
     case VIRTIO_CRYPTO_CIPHER_DECRYPT:
-        ret = virtio_crypto_handle_sym_req(vcrypto,
-                         &req.u.sym_req,
-                         &sym_op_info,
-                         out_iov, out_num);
+    {
+        struct virtio_crypto_sym_data_req req;
+
+        iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
+        /* The unused part of the req will be ingored */
+        s = VIRTIO_CRYPTO_DATA_REQ_PAYLOAD_SIZE_NONMUX;
+        if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
+            virtio_error(vdev, "virtio-crypto request additional "
+                         "parameters too short");
+            return -1;
+        }
+
+        ret = virtio_crypto_handle_sym_req(vcrypto, &req,
+                                           &sym_op_info,
+                                           out_iov, out_num);
         /* Serious errors, need to reset virtio crypto device */
         if (ret == -EFAULT) {
             return -1;
@@ -694,6 +707,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
             virtio_crypto_free_request(request);
         }
         break;
+    }
     case VIRTIO_CRYPTO_HASH:
     case VIRTIO_CRYPTO_MAC:
     case VIRTIO_CRYPTO_AEAD_ENCRYPT:
diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 5e586e5..81357e5 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -379,18 +379,7 @@ struct virtio_crypto_aead_data_req {
 	uint8_t padding[32];
 };
 
-/* The request of the data virtqueue's packet */
-struct virtio_crypto_op_data_req {
-	struct virtio_crypto_op_header header;
-
-	union {
-		struct virtio_crypto_sym_data_req  sym_req;
-		struct virtio_crypto_hash_data_req hash_req;
-		struct virtio_crypto_mac_data_req mac_req;
-		struct virtio_crypto_aead_data_req aead_req;
-		uint8_t padding[48];
-	} u;
-};
+#define VIRTIO_CRYPTO_DATA_REQ_PAYLOAD_SIZE_NONMUX 48
 
 #define VIRTIO_CRYPTO_OK        0
 #define VIRTIO_CRYPTO_ERR       1
-- 
1.8.3.1
