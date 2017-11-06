Received: from eggs.gnu.org ([2001:4830:134:3::10]:49745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLW-0006FG-Fz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLR-00084d-Pj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLR-00080O-6W
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:17 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:55 +0800
Message-ID: <1509951422-20060-4-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 03/10] virtio-crypto: remove queue_id field in
 ctrl header
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

The queue_id is needless bacause we can get the info from
VirtQueue->queue_index.

For existing frontend driver, this field is always zero,
so we can just mark this field as reserved and ingore its
value.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 hw/virtio/virtio-crypto.c                      | 8 +++-----
 include/standard-headers/linux/virtio_crypto.h | 3 +--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 04c34d8..9ffe26d 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -221,7 +221,6 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
     struct iovec *out_iov;
     unsigned in_num;
     unsigned out_num;
-    uint32_t queue_id;
     uint32_t opcode;
     struct virtio_crypto_session_input input;
     int64_t session_id;
@@ -258,7 +257,6 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         iov_discard_front(&out_iov, &out_num, s);
 
         opcode = ldl_le_p(&hdr.opcode);
-        queue_id = ldl_le_p(&hdr.queue_id);
 
         switch (opcode) {
         case VIRTIO_CRYPTO_CIPHER_CREATE_SESSION:
@@ -277,8 +275,8 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
             memset(&input, 0, sizeof(input));
             session_id = virtio_crypto_create_sym_session(vcrypto,
-                                            &req, queue_id, opcode,
-                                            out_iov, out_num);
+                                            &req, virtio_get_queue_index(vq),
+                                            opcode, out_iov, out_num);
             /* Serious errors, need to reset virtio crypto device */
             if (session_id == -EFAULT) {
                 virtqueue_detach_element(vq, elem, 0);
@@ -321,7 +319,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             }
 
             status = virtio_crypto_handle_close_session(vcrypto,
-                                                &req, queue_id);
+                                         &req, virtio_get_queue_index(vq));
             /* The status only occupy one byte, we can directly use it */
             s = iov_from_buf(in_iov, in_num, 0, &status, sizeof(status));
             if (unlikely(s != sizeof(status))) {
diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 8793be6..5e586e5 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -67,8 +67,7 @@ struct virtio_crypto_ctrl_header {
 	uint32_t opcode;
 	uint32_t algo;
 	uint32_t flag;
-	/* data virtqueue id */
-	uint32_t queue_id;
+	uint32_t reserved;
 };
 
 struct virtio_crypto_cipher_session_para {
-- 
1.8.3.1
