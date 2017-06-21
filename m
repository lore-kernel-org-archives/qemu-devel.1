Received: from eggs.gnu.org ([2001:4830:134:3::10]:54186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNje4-0002lf-Lq
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNje1-00040l-9t
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:42:24 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:60384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNje0-0003zr-Vq
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:42:21 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7D595107C37
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 19:42:19 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 21 Jun 2017 19:42:15 +0200
Message-ID: <149806693574.3840.9096786036333390842.stgit@bahia.lan>
In-Reply-To: <149806690313.3840.13274158676579302242.stgit@bahia.lan>
References: <149806690313.3840.13274158676579302242.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 3/4] virtio-9p: break device if buffers are
 misconfigured
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

The 9P protocol is transport agnostic: if the guest misconfigured the
buffers, the best we can do is to set the broken flag on the device.

We check if the transport isn't broken already to avoid printing extra
error messages.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               |    2 +-
 hw/9pfs/9p.h               |    2 +-
 hw/9pfs/virtio-9p-device.c |   45 ++++++++++++++++++++++++++++++++++++++++----
 hw/9pfs/xen-9p-backend.c   |    3 ++-
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 96d268334865..da0d6da65b45 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1664,7 +1664,7 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
     unsigned int niov;
 
     if (is_write) {
-        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
+        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size + skip);
     } else {
         pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
     }
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index aac1b0b2ce3d..d1cfeaf10e4f 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -363,7 +363,7 @@ struct V9fsTransport {
     void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                         unsigned int *pniov, size_t size);
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
-                                         unsigned int *pniov);
+                                         unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
 };
 
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 1a68c1622d3a..873f42e24818 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -146,8 +146,18 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    int ret;
 
-    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
+    ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
+    if (ret < 0) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(v);
+
+        if (!vdev->broken) {
+            virtio_error(vdev, "Failed to encode VirtFS reply type %d",
+                         pdu->id + 1);
+        }
+    }
+    return ret;
 }
 
 static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
@@ -156,28 +166,55 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    int ret;
 
-    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
+    ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
+    if (ret < 0) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(v);
+
+        if (!vdev->broken) {
+            virtio_error(vdev, "Failed to decode VirtFS request type %d",
+                         pdu->id);
+        }
+    }
+    return ret;
 }
 
-/* The size parameter is used by other transports. Do not drop it. */
 static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
                                         unsigned int *pniov, size_t size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    size_t buf_size = iov_size(elem->in_sg, elem->in_num);
+
+    if (buf_size < size) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(v);
+
+        virtio_error(vdev,
+                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
+                     pdu->id + 1, size, buf_size);
+    }
 
     *piov = elem->in_sg;
     *pniov = elem->in_num;
 }
 
 static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                                         unsigned int *pniov)
+                                         unsigned int *pniov, size_t size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    size_t buf_size = iov_size(elem->out_sg, elem->out_num);
+
+    if (buf_size < size) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(v);
+
+        virtio_error(vdev,
+                     "VirtFS request type %d needs %zu bytes, buffer has %zu",
+                     pdu->id, size, buf_size);
+    }
 
     *piov = elem->out_sg;
     *pniov = elem->out_num;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 922cc967be63..a82cf817fe45 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -147,7 +147,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
 
 static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
                                            struct iovec **piov,
-                                           unsigned int *pniov)
+                                           unsigned int *pniov,
+                                           size_t size)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
