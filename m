Received: from eggs.gnu.org ([2001:4830:134:3::10]:35313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDGH-0004T3-OB
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDGC-0004Hp-W7
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDGC-0004E4-0a
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:36 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:34 +0800
Message-ID: <1505092240-10864-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 2/8] virtio-crypto: add session creation logic
 for mux mode
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

Adds the session creatation logic for MUX mode.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 hw/virtio/virtio-crypto.c | 79 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 19c82e0..78f75c2 100755
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
@@ -210,18 +215,24 @@ virtio_crypto_handle_close_session(VirtIOCrypto *vcrypto,
 static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
-    struct virtio_crypto_op_ctrl_req ctrl;
     VirtQueueElement *elem;
+    struct virtio_crypto_session_input input;
+    struct virtio_crypto_ctrl_header *generic_hdr;
+    union {
+        struct virtio_crypto_op_ctrl_req ctrl;
+        struct virtio_crypto_op_ctrl_req_mux mux_ctrl;
+    } req;
+
     struct iovec *in_iov;
     struct iovec *out_iov;
     unsigned in_num;
     unsigned out_num;
     uint32_t queue_id;
     uint32_t opcode;
-    struct virtio_crypto_session_input input;
     int64_t session_id;
     uint8_t status;
-    size_t s;
+    size_t s, exp_len;
+    void *sess;
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -239,25 +250,49 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         out_iov = elem->out_sg;
         in_num = elem->in_num;
         in_iov = elem->in_sg;
-        if (unlikely(iov_to_buf(out_iov, out_num, 0, &ctrl, sizeof(ctrl))
-                    != sizeof(ctrl))) {
+
+        if (virtio_crypto_in_mux_mode(vdev)) {
+            exp_len = sizeof(req.mux_ctrl);
+            generic_hdr = (struct virtio_crypto_ctrl_header *)(&req.mux_ctrl);
+        } else {
+            exp_len = sizeof(req.ctrl);
+            generic_hdr = (struct virtio_crypto_ctrl_header *)(&req.ctrl);
+        }
+
+        s = iov_to_buf(out_iov, out_num, 0, generic_hdr, exp_len);
+        if (unlikely(s != exp_len)) {
             virtio_error(vdev, "virtio-crypto request ctrl_hdr too short");
             virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             break;
         }
-        iov_discard_front(&out_iov, &out_num, sizeof(ctrl));
 
-        opcode = ldl_le_p(&ctrl.header.opcode);
-        queue_id = ldl_le_p(&ctrl.header.queue_id);
+        iov_discard_front(&out_iov, &out_num, exp_len);
+
+        opcode = ldl_le_p(&generic_hdr->opcode);
+        queue_id = ldl_le_p(&generic_hdr->queue_id);
 
         switch (opcode) {
         case VIRTIO_CRYPTO_CIPHER_CREATE_SESSION:
+            if (virtio_crypto_in_mux_mode(vdev)) {
+                sess = g_new0(struct virtio_crypto_sym_create_session_req, 1);
+                exp_len = sizeof(struct virtio_crypto_sym_create_session_req);
+                s = iov_to_buf(out_iov, out_num, 0, sess, exp_len);
+                if (unlikely(s != exp_len)) {
+                    virtio_error(vdev, "virtio-crypto request additional "
+                                 "parameters too short");
+                    virtqueue_detach_element(vq, elem, 0);
+                    break;
+                }
+                iov_discard_front(&out_iov, &out_num, exp_len);
+            } else {
+                sess = &req.ctrl.u.sym_create_session;
+            }
+
             memset(&input, 0, sizeof(input));
-            session_id = virtio_crypto_create_sym_session(vcrypto,
-                             &ctrl.u.sym_create_session,
-                             queue_id, opcode,
-                             out_iov, out_num);
+
+            session_id = virtio_crypto_create_sym_session(vcrypto, sess,
+                                    queue_id, opcode, out_iov, out_num);
             /* Serious errors, need to reset virtio crypto device */
             if (session_id == -EFAULT) {
                 virtqueue_detach_element(vq, elem, 0);
@@ -285,8 +320,23 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         case VIRTIO_CRYPTO_HASH_DESTROY_SESSION:
         case VIRTIO_CRYPTO_MAC_DESTROY_SESSION:
         case VIRTIO_CRYPTO_AEAD_DESTROY_SESSION:
+            if (virtio_crypto_in_mux_mode(vdev)) {
+                sess = g_new0(struct virtio_crypto_destroy_session_req, 1);
+                exp_len = sizeof(struct virtio_crypto_destroy_session_req);
+                s = iov_to_buf(out_iov, out_num, 0, sess, exp_len);
+                if (unlikely(s != exp_len)) {
+                    virtio_error(vdev, "virtio-crypto request additional "
+                                 "parameters too short");
+                    virtqueue_detach_element(vq, elem, 0);
+                    break;
+                }
+                iov_discard_front(&out_iov, &out_num, exp_len);
+            } else {
+                sess = &req.ctrl.u.destroy_session;
+            }
+
             status = virtio_crypto_handle_close_session(vcrypto,
-                   &ctrl.u.destroy_session, queue_id);
+                                                sess, queue_id);
             /* The status only occupy one byte, we can directly use it */
             s = iov_from_buf(in_iov, in_num, 0, &status, sizeof(status));
             if (unlikely(s != sizeof(status))) {
@@ -316,6 +366,9 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             break;
         } /* end switch case */
 
+        if (virtio_crypto_in_mux_mode(vdev)) {
+            g_free(sess);
+        }
         g_free(elem);
     } /* end for loop */
 }
-- 
1.8.3.1
