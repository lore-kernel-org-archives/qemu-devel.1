Received: from eggs.gnu.org ([2001:4830:134:3::10]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpx-0006y0-3w
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpu-000080-0F
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpt-00007P-Ma
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:17 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J4tH002201
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:16 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rvpt1n8x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:16 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:14 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:36 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-3-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 02/13] 9pfs: introduce transport specific
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>

From: Stefano Stabellini <sstabellini@kernel.org>

Don't call virtio functions from 9pfs generic code, use generic function
callbacks instead.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               |  8 ++++----
 hw/9pfs/9p.h               | 19 +++++++++++++++++++
 hw/9pfs/virtio-9p-device.c | 24 +++++++++++++++++-------
 hw/9pfs/virtio-9p.h        |  9 ---------
 4 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 6bd364f6a0d1..3f5647aa5680 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -47,7 +47,7 @@ ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    ret = virtio_pdu_vmarshal(pdu, offset, fmt, ap);
+    ret = pdu->s->transport->pdu_vmarshal(pdu, offset, fmt, ap);
     va_end(ap);
 
     return ret;
@@ -59,7 +59,7 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    ret = virtio_pdu_vunmarshal(pdu, offset, fmt, ap);
+    ret = pdu->s->transport->pdu_vunmarshal(pdu, offset, fmt, ap);
     va_end(ap);
 
     return ret;
@@ -67,7 +67,7 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
 
 static void pdu_push_and_notify(V9fsPDU *pdu)
 {
-    virtio_9p_push_and_notify(pdu);
+    pdu->s->transport->push_and_notify(pdu);
 }
 
 static int omode_to_uflags(int8_t mode)
@@ -1751,7 +1751,7 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
     struct iovec *iov;
     unsigned int niov;
 
-    virtio_init_iov_from_pdu(pdu, &iov, &niov, is_write);
+    pdu->s->transport->init_iov_from_pdu(pdu, &iov, &niov, is_write);
 
     qemu_iovec_init_external(&elem, iov, niov);
     qemu_iovec_init(qiov, niov);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 07cee01abac3..c8c9aa89093a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -230,6 +230,7 @@ typedef struct V9fsState
     enum p9_proto_version proto_version;
     int32_t msize;
     V9fsPDU pdus[MAX_REQ];
+    const struct V9fsTransport *transport;
     /*
      * lock ensuring atomic path update
      * on rename.
@@ -343,4 +344,22 @@ void pdu_free(V9fsPDU *pdu);
 void pdu_submit(V9fsPDU *pdu);
 void v9fs_reset(V9fsState *s);
 
+struct V9fsTransport {
+    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
+                                va_list ap);
+    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
+                                  va_list ap);
+    void        (*init_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
+                                     unsigned int *pniov, bool is_write);
+    void        (*push_and_notify)(V9fsPDU *pdu);
+};
+
+static inline int v9fs_register_transport(V9fsState *s,
+        const struct V9fsTransport *t)
+{
+    assert(!s->transport);
+    s->transport = t;
+    return 0;
+}
+
 #endif
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 1782e4a2277f..273425b9d136 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -20,7 +20,9 @@
 #include "hw/virtio/virtio-access.h"
 #include "qemu/iov.h"
 
-void virtio_9p_push_and_notify(V9fsPDU *pdu)
+static const struct V9fsTransport virtio_9p_transport;
+
+static void virtio_9p_push_and_notify(V9fsPDU *pdu)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -126,6 +128,7 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
     v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
     virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
     v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
+    v9fs_register_transport(s, &virtio_9p_transport);
 
 out:
     return;
@@ -148,8 +151,8 @@ static void virtio_9p_reset(VirtIODevice *vdev)
     v9fs_reset(&v->state);
 }
 
-ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
-                            const char *fmt, va_list ap)
+static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
+                                   const char *fmt, va_list ap)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -158,8 +161,8 @@ ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
     return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
 }
 
-ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
-                              const char *fmt, va_list ap)
+static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
+                                     const char *fmt, va_list ap)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -168,8 +171,8 @@ ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
     return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
 }
 
-void virtio_init_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                              unsigned int *pniov, bool is_write)
+static void virtio_init_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
+                                     unsigned int *pniov, bool is_write)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -184,6 +187,13 @@ void virtio_init_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     }
 }
 
+static const struct V9fsTransport virtio_9p_transport = {
+    .pdu_vmarshal = virtio_pdu_vmarshal,
+    .pdu_vunmarshal = virtio_pdu_vunmarshal,
+    .init_iov_from_pdu = virtio_init_iov_from_pdu,
+    .push_and_notify = virtio_9p_push_and_notify,
+};
+
 /* virtio-9p device */
 
 static const VMStateDescription vmstate_virtio_9p = {
diff --git a/hw/9pfs/virtio-9p.h b/hw/9pfs/virtio-9p.h
index 52c4b9df51ca..e763da2c02bf 100644
--- a/hw/9pfs/virtio-9p.h
+++ b/hw/9pfs/virtio-9p.h
@@ -14,15 +14,6 @@ typedef struct V9fsVirtioState
     V9fsState state;
 } V9fsVirtioState;
 
-void virtio_9p_push_and_notify(V9fsPDU *pdu);
-
-ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
-                            const char *fmt, va_list ap);
-ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
-                              const char *fmt, va_list ap);
-void virtio_init_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                              unsigned int *pniov, bool is_write);
-
 #define TYPE_VIRTIO_9P "virtio-9p-device"
 #define VIRTIO_9P(obj) \
         OBJECT_CHECK(V9fsVirtioState, (obj), TYPE_VIRTIO_9P)
-- 
2.7.4
