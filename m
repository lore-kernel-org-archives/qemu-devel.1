Received: from eggs.gnu.org ([2001:4830:134:3::10]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLY-0006FV-5Z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLW-0008Gw-VL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLW-0008AE-5w
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:22 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:53 +0800
Message-ID: <1509951422-20060-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 01/10] virtio-crypto: remove
 virtio_crypto_op_ctrl_req structure
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

The struct virtio_crypto_op_ctrl_req is not needed, we can
use 'header + payload' instead as suggested by Halil. This
can makes the code simpler to add MUX-mode support in the
next patch.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 hw/virtio/virtio-crypto.c                      | 48 ++++++++++++++++++++------
 include/standard-headers/linux/virtio_crypto.h | 19 +---------
 2 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 19c82e0..c7f6cc4 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -210,7 +210,7 @@ virtio_crypto_handle_close_session(VirtIOCrypto *vcrypto,
 static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
-    struct virtio_crypto_op_ctrl_req ctrl;
+    struct virtio_crypto_ctrl_header hdr;
     VirtQueueElement *elem;
     struct iovec *in_iov;
     struct iovec *out_iov;
@@ -239,25 +239,38 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         out_iov = elem->out_sg;
         in_num = elem->in_num;
         in_iov = elem->in_sg;
-        if (unlikely(iov_to_buf(out_iov, out_num, 0, &ctrl, sizeof(ctrl))
-                    != sizeof(ctrl))) {
+
+        s = sizeof(hdr);
+        if (unlikely(s != iov_to_buf(out_iov, out_num, 0, &hdr, s))) {
             virtio_error(vdev, "virtio-crypto request ctrl_hdr too short");
             virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             break;
         }
-        iov_discard_front(&out_iov, &out_num, sizeof(ctrl));
+        iov_discard_front(&out_iov, &out_num, s);
 
-        opcode = ldl_le_p(&ctrl.header.opcode);
-        queue_id = ldl_le_p(&ctrl.header.queue_id);
+        opcode = ldl_le_p(&hdr.opcode);
+        queue_id = ldl_le_p(&hdr.queue_id);
 
         switch (opcode) {
         case VIRTIO_CRYPTO_CIPHER_CREATE_SESSION:
+        {
+            struct virtio_crypto_sym_create_session_req req;
+
+            iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
+            /* The unused part of the req will be ingored */
+            s = VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX;
+            if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
+                virtio_error(vdev, "virtio-crypto request additional "
+                             "parameters too short");
+                virtqueue_detach_element(vq, elem, 0);
+                break;
+            }
+
             memset(&input, 0, sizeof(input));
             session_id = virtio_crypto_create_sym_session(vcrypto,
-                             &ctrl.u.sym_create_session,
-                             queue_id, opcode,
-                             out_iov, out_num);
+                                            &req, queue_id, opcode,
+                                            out_iov, out_num);
             /* Serious errors, need to reset virtio crypto device */
             if (session_id == -EFAULT) {
                 virtqueue_detach_element(vq, elem, 0);
@@ -281,12 +294,26 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             virtqueue_push(vq, elem, sizeof(input));
             virtio_notify(vdev, vq);
             break;
+        }
         case VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION:
         case VIRTIO_CRYPTO_HASH_DESTROY_SESSION:
         case VIRTIO_CRYPTO_MAC_DESTROY_SESSION:
         case VIRTIO_CRYPTO_AEAD_DESTROY_SESSION:
+        {
+            struct virtio_crypto_destroy_session_req req;
+
+            iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
+            /* The unused part of the req will be ingored */
+            s = VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX;
+            if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
+                virtio_error(vdev, "virtio-crypto request additional "
+                             "parameters too short");
+                virtqueue_detach_element(vq, elem, 0);
+                break;
+            }
+
             status = virtio_crypto_handle_close_session(vcrypto,
-                   &ctrl.u.destroy_session, queue_id);
+                                                &req, queue_id);
             /* The status only occupy one byte, we can directly use it */
             s = iov_from_buf(in_iov, in_num, 0, &status, sizeof(status));
             if (unlikely(s != sizeof(status))) {
@@ -297,6 +324,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             virtqueue_push(vq, elem, sizeof(status));
             virtio_notify(vdev, vq);
             break;
+        }
         case VIRTIO_CRYPTO_HASH_CREATE_SESSION:
         case VIRTIO_CRYPTO_MAC_CREATE_SESSION:
         case VIRTIO_CRYPTO_AEAD_CREATE_SESSION:
diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 5ff0b4e..6677c82 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -234,24 +234,7 @@ struct virtio_crypto_destroy_session_req {
 	uint8_t padding[48];
 };
 
-/* The request of the control virtqueue's packet */
-struct virtio_crypto_op_ctrl_req {
-	struct virtio_crypto_ctrl_header header;
-
-	union {
-		struct virtio_crypto_sym_create_session_req
-			sym_create_session;
-		struct virtio_crypto_hash_create_session_req
-			hash_create_session;
-		struct virtio_crypto_mac_create_session_req
-			mac_create_session;
-		struct virtio_crypto_aead_create_session_req
-			aead_create_session;
-		struct virtio_crypto_destroy_session_req
-			destroy_session;
-		uint8_t padding[56];
-	} u;
-};
+#define VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX 56
 
 struct virtio_crypto_op_header {
 #define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
-- 
1.8.3.1
