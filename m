Received: from eggs.gnu.org ([2001:4830:134:3::10]:37917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc3u-0003Cy-01
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc3p-0003oZ-Ar
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:43:14 -0500
Received: from [45.249.212.32] (port=41892 helo=huawei.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBc3o-0003oF-Ur
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:43:09 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:57 +0800
Message-ID: <1509951422-20060-6-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 05/10] virtio-crypto: add dataq operation logic
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

Adds dataq operation support for MUX mode.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 hw/virtio/virtio-crypto.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 828d7ef..10a0c35 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -663,6 +663,9 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     opcode = ldl_le_p(&hdr.opcode);
     session_id = ldq_le_p(&hdr.session_id);
 
+#define data_req_payload_size(vdev, req)                        \
+        (virtio_crypto_in_mux_mode((vdev)) ? sizeof((req)) :    \
+        VIRTIO_CRYPTO_DATA_REQ_PAYLOAD_SIZE_NONMUX)
     switch (opcode) {
     case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
     case VIRTIO_CRYPTO_CIPHER_DECRYPT:
@@ -671,7 +674,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
 
         iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
         /* The unused part of the req will be ingored */
-        s = VIRTIO_CRYPTO_DATA_REQ_PAYLOAD_SIZE_NONMUX;
+        s = data_req_payload_size(vdev, req);
         if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
             virtio_error(vdev, "virtio-crypto request additional "
                          "parameters too short");
@@ -718,6 +721,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
         virtio_crypto_req_complete(request, VIRTIO_CRYPTO_NOTSUPP);
         virtio_crypto_free_request(request);
     }
+#undef data_req_payload_size
 
     return 0;
 }
-- 
1.8.3.1
