Received: from eggs.gnu.org ([2001:4830:134:3::10]:53218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYik-0002n2-8c
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYih-0000hS-6S
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:22 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:54565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csYig-0000h3-VD
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:19 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9DDCA76A05
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:46:17 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Mar 2017 19:46:12 +0200
Message-ID: <149063677290.4447.3976316489902712200.stgit@bahia.lan>
In-Reply-To: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/5] virtio-9p: factor out virtio_9p_error_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

When an unrecoverable is hit, we need to set the broken flag of the virtio
device, detach the queue element and free it. This is currently open coded
in handle_9p_output(). It is fine since this is the only function that can
set the broken flag. But if we want to be able to do this from other places,
we must consolidate the logic in a helper.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/virtio-9p-device.c |   45 +++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 27a4a32f5c4c..873b22baf0f9 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -22,21 +22,42 @@
 
 static const struct V9fsTransport virtio_9p_transport;
 
+static void virtio_9p_free_element(V9fsVirtioState *v, unsigned int idx)
+{
+    VirtQueueElement **pelem = &v->elems[idx];
+    g_free(*pelem);
+    *pelem = NULL;
+}
+
 static void virtio_9p_push_and_notify(V9fsPDU *pdu)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
-    VirtQueueElement *elem = v->elems[pdu->idx];
 
     /* push onto queue and notify */
-    virtqueue_push(v->vq, elem, pdu->size);
-    g_free(elem);
-    v->elems[pdu->idx] = NULL;
+    virtqueue_push(v->vq, v->elems[pdu->idx], pdu->size);
+    virtio_9p_free_element(v, pdu->idx);
 
     /* FIXME: we should batch these completions */
     virtio_notify(VIRTIO_DEVICE(v), v->vq);
 }
 
+static void virtio_9p_error_err(V9fsVirtioState *v, unsigned int idx,
+                                Error *err)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(v);
+
+    virtio_error_err(vdev, err);
+    virtqueue_detach_element(v->vq, v->elems[idx], 0);
+    virtio_9p_free_element(v, idx);
+}
+
+#define virtio_9p_error(v, idx, ...) { \
+    Error *err = NULL;                 \
+    error_setg(&err, ## __VA_ARGS__);  \
+    virtio_9p_error_err(v, idx, err);  \
+}
+
 static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     V9fsVirtioState *v = (V9fsVirtioState *)vdev;
@@ -56,22 +77,19 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
         if (!elem) {
             goto out_free_pdu;
         }
+        v->elems[pdu->idx] = elem;
 
         if (elem->in_num == 0) {
-            virtio_error(vdev,
-                         "The guest sent a VirtFS request without space for "
-                         "the reply");
-            goto out_free_req;
+            virtio_9p_error(v, pdu->idx, "The guest sent a VirtFS request without space for the reply");
+            goto out_free_pdu;
         }
         QEMU_BUILD_BUG_ON(sizeof(out) != 7);
 
-        v->elems[pdu->idx] = elem;
         len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                          &out, sizeof(out));
         if (len != sizeof(out)) {
-            virtio_error(vdev, "The guest sent a malformed VirtFS request: "
-                         "header size is %zd, should be 7", len);
-            goto out_free_req;
+            virtio_9p_error(v, pdu->idx, "The guest sent a malformed VirtFS request: header size is %zd, should be 7", len);
+            goto out_free_pdu;
         }
 
         pdu->size = le32_to_cpu(out.size_le);
@@ -85,9 +103,6 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
 
     return;
 
-out_free_req:
-    virtqueue_detach_element(vq, elem, 0);
-    g_free(elem);
 out_free_pdu:
     pdu_free(pdu);
 }
