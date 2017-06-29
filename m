Received: from eggs.gnu.org ([2001:4830:134:3::10]:55018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZkF-0003ML-Sa
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZkB-0002w3-0S
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35813
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQZkA-0002vr-Q0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TDcxKd008927
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcsuw5pnc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:25 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 29 Jun 2017 14:44:23 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Jun 2017 15:43:49 +0200
In-Reply-To: <1498743831-28676-1-git-send-email-groug@kaod.org>
References: <1498743831-28676-1-git-send-email-groug@kaod.org>
Message-Id: <1498743831-28676-7-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 6/8] virtio-9p: break device if buffers are
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The 9P protocol is transport agnostic: if the guest misconfigured the
buffers, the best we can do is to set the broken flag on the device.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               |  2 +-
 hw/9pfs/9p.h               |  2 +-
 hw/9pfs/virtio-9p-device.c | 40 ++++++++++++++++++++++++++++++++++++----
 hw/9pfs/xen-9p-backend.c   |  3 ++-
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index a0ae98f7ca6f..8e5cac71eb60 100644
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
index 1a68c1622d3a..62650b0a6b99 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -146,8 +146,16 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    ssize_t ret;
 
-    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
+    ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
+    if (ret < 0) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(v);
+
+        virtio_error(vdev, "Failed to encode VirtFS reply type %d",
+                     pdu->id + 1);
+    }
+    return ret;
 }
 
 static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
@@ -156,28 +164,52 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    ssize_t ret;
+
+    ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
+    if (ret < 0) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(v);
 
-    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
+        virtio_error(vdev, "Failed to decode VirtFS request type %d", pdu->id);
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
-- 
2.7.5
