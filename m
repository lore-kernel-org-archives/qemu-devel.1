Received: from eggs.gnu.org ([2001:4830:134:3::10]:35245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG5-0004HC-KU
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG1-00046D-8N
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG0-00041Q-Jc
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:25 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:35 +0800
Message-ID: <1505092240-10864-4-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 3/8] virtio-crypto: add dataq operation logic for
 mux mode
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

Adds dataq operation support for MUX mode.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 hw/virtio/virtio-crypto.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 78f75c2..6076fb0 100755
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -629,7 +629,7 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
     VirtQueueElement *elem = &request->elem;
     int queue_index = virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
-    struct virtio_crypto_op_data_req req;
+    struct virtio_crypto_op_header *generic_hdr;
     int ret;
     struct iovec *in_iov;
     struct iovec *out_iov;
@@ -640,6 +640,12 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     uint64_t session_id;
     CryptoDevBackendSymOpInfo *sym_op_info = NULL;
     Error *local_err = NULL;
+    size_t s, exp_len;
+    void *body;
+    union {
+        struct virtio_crypto_op_data_req req;
+        struct virtio_crypto_op_data_req_mux mux_req;
+    } op;
 
     if (elem->out_num < 1 || elem->in_num < 1) {
         virtio_error(vdev, "virtio-crypto dataq missing headers");
@@ -650,12 +656,22 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     out_iov = elem->out_sg;
     in_num = elem->in_num;
     in_iov = elem->in_sg;
-    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
-                != sizeof(req))) {
+
+    if (virtio_crypto_in_mux_mode(vdev)) {
+        exp_len = sizeof(op.mux_req);
+        generic_hdr = (struct virtio_crypto_op_header *)(&op.mux_req);
+    } else {
+        exp_len = sizeof(op.req);
+        generic_hdr = (struct virtio_crypto_op_header *)(&op.req);
+    }
+
+    s = iov_to_buf(out_iov, out_num, 0, generic_hdr, exp_len);
+    if (unlikely(s != exp_len)) {
         virtio_error(vdev, "virtio-crypto request outhdr too short");
         return -1;
     }
-    iov_discard_front(&out_iov, &out_num, sizeof(req));
+
+    iov_discard_front(&out_iov, &out_num, exp_len);
 
     if (in_iov[in_num - 1].iov_len <
             sizeof(struct virtio_crypto_inhdr)) {
@@ -676,16 +692,27 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)
     request->in_num = in_num;
     request->in_iov = in_iov;
 
-    opcode = ldl_le_p(&req.header.opcode);
-    session_id = ldq_le_p(&req.header.session_id);
+    opcode = ldl_le_p(&generic_hdr->opcode);
+    session_id = ldq_le_p(&generic_hdr->session_id);
 
     switch (opcode) {
     case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
     case VIRTIO_CRYPTO_CIPHER_DECRYPT:
-        ret = virtio_crypto_handle_sym_req(vcrypto,
-                         &req.u.sym_req,
-                         &sym_op_info,
-                         out_iov, out_num);
+        if (virtio_crypto_in_mux_mode(vdev)) {
+            body = g_new0(struct virtio_crypto_sym_data_req, 1);
+            exp_len = sizeof(struct virtio_crypto_sym_data_req);
+            s = iov_to_buf(out_iov, out_num, 0, body, exp_len);
+            if (unlikely(s != exp_len)) {
+                g_free(body);
+                return -1;
+            }
+            iov_discard_front(&out_iov, &out_num, exp_len);
+        } else {
+            body = &op.req.u.sym_req;
+        }
+
+        ret = virtio_crypto_handle_sym_req(vcrypto, body,
+                         &sym_op_info, out_iov, out_num);
         /* Serious errors, need to reset virtio crypto device */
         if (ret == -EFAULT) {
             return -1;
-- 
1.8.3.1
