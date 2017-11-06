Received: from eggs.gnu.org ([2001:4830:134:3::10]:37918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc3u-0003Cz-0W
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc3p-0003on-Ci
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:43:14 -0500
Received: from [45.249.212.32] (port=41900 helo=huawei.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc3p-0003oI-0d
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:43:09 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:54 +0800
Message-ID: <1509951422-20060-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 02/10] virtio-crypto: add session creation logic
 for mux mode
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

Adds some macros about the features of multiplexing
mode and supports the session create for this mode.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 hw/virtio/virtio-crypto.c                      | 13 +++++++++++--
 include/standard-headers/linux/virtio_crypto.h |  7 +++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index c7f6cc4..04c34d8 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -33,6 +33,11 @@ static inline int virtio_crypto_vq2q(int queue_index)
     return queue_index;
 }
 
+static inline bool virtio_crypto_in_mux_mode(VirtIODevice *vdev)
+{
+    return virtio_vdev_has_feature(vdev, VIRTIO_CRYPTO_F_MUX_MODE);
+}
+
 static int
 virtio_crypto_cipher_session_helper(VirtIODevice *vdev,
            CryptoDevBackendSymSessionInfo *info,
@@ -223,6 +228,9 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
     uint8_t status;
     size_t s;
 
+#define ctrl_req_payload_size(vdev, req)                        \
+        (virtio_crypto_in_mux_mode((vdev)) ? sizeof((req)) :    \
+        VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX)
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
@@ -259,7 +267,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
             iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
             /* The unused part of the req will be ingored */
-            s = VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX;
+            s = ctrl_req_payload_size(vdev, req);
             if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
                 virtio_error(vdev, "virtio-crypto request additional "
                              "parameters too short");
@@ -304,7 +312,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
             iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
             /* The unused part of the req will be ingored */
-            s = VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX;
+            s = ctrl_req_payload_size(vdev, req);
             if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
                 virtio_error(vdev, "virtio-crypto request additional "
                              "parameters too short");
@@ -346,6 +354,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
         g_free(elem);
     } /* end for loop */
+#undef ctrl_req_payload_size
 }
 
 static void virtio_crypto_init_request(VirtIOCrypto *vcrypto, VirtQueue *vq,
diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 6677c82..8793be6 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -38,6 +38,13 @@
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
 
+/* The features for virtio crypto device */
+#define VIRTIO_CRYPTO_F_MUX_MODE                0
+#define VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE   1
+#define VIRTIO_CRYPTO_F_HASH_STATELESS_MODE     2
+#define VIRTIO_CRYPTO_F_MAC_STATELESS_MODE      3
+#define VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE     4
+
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
 struct virtio_crypto_ctrl_header {
-- 
1.8.3.1
