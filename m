Received: from eggs.gnu.org ([2001:4830:134:3::10]:57715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpz-0006zo-Sz
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpw-00009v-PS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpw-000092-Gy
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J4Sh073873
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rspg0m8h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:19 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:16 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:38 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-5-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 04/13] 9pfs: introduce init_out/in_iov_from_pdu
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

Not all 9pfs transports share memory between request and response. For
those who don't, it is necessary to know how much memory is required in
the response.

Split the existing init_iov_from_pdu function in two:
init_out_iov_from_pdu (for writes) and init_in_iov_from_pdu (for reads).
init_in_iov_from_pdu takes an additional size parameter to specify the
memory required for the response message.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               |  6 +++++-
 hw/9pfs/9p.h               |  6 ++++--
 hw/9pfs/virtio-9p-device.c | 28 ++++++++++++++++++----------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f9acd632596f..97c2926aae50 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1652,7 +1652,11 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
     struct iovec *iov;
     unsigned int niov;
 
-    pdu->s->transport->init_iov_from_pdu(pdu, &iov, &niov, is_write);
+    if (is_write) {
+        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
+    } else {
+        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size);
+    }
 
     qemu_iovec_init_external(&elem, iov, niov);
     qemu_iovec_init(qiov, niov);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index c8c9aa89093a..4c4feafa2e97 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -349,8 +349,10 @@ struct V9fsTransport {
                                 va_list ap);
     ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
                                   va_list ap);
-    void        (*init_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
-                                     unsigned int *pniov, bool is_write);
+    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
+                                        unsigned int *pniov, size_t size);
+    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
+                                         unsigned int *pniov);
     void        (*push_and_notify)(V9fsPDU *pdu);
 };
 
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 273425b9d136..27a4a32f5c4c 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -171,26 +171,34 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
     return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
 }
 
-static void virtio_init_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                                     unsigned int *pniov, bool is_write)
+/* The size parameter is used by other transports. Do not drop it. */
+static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
+                                        unsigned int *pniov, size_t size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
 
-    if (is_write) {
-        *piov = elem->out_sg;
-        *pniov = elem->out_num;
-    } else {
-        *piov = elem->in_sg;
-        *pniov = elem->in_num;
-    }
+    *piov = elem->in_sg;
+    *pniov = elem->in_num;
+}
+
+static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
+                                         unsigned int *pniov)
+{
+    V9fsState *s = pdu->s;
+    V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
+    VirtQueueElement *elem = v->elems[pdu->idx];
+
+    *piov = elem->out_sg;
+    *pniov = elem->out_num;
 }
 
 static const struct V9fsTransport virtio_9p_transport = {
     .pdu_vmarshal = virtio_pdu_vmarshal,
     .pdu_vunmarshal = virtio_pdu_vunmarshal,
-    .init_iov_from_pdu = virtio_init_iov_from_pdu,
+    .init_in_iov_from_pdu = virtio_init_in_iov_from_pdu,
+    .init_out_iov_from_pdu = virtio_init_out_iov_from_pdu,
     .push_and_notify = virtio_9p_push_and_notify,
 };
 
-- 
2.7.4
