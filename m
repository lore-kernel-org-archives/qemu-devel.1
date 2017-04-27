Received: from eggs.gnu.org ([2001:4830:134:3::10]:56694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3gSH-0007OI-Ab
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3gSC-0001Gr-D9
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:15:21 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:50760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3gSC-0001FF-6b
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:15:16 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 065B1EA37B
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 12:15:12 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 27 Apr 2017 12:15:10 +0200
Message-ID: <149328811036.1628.11119485249329354693.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] virtio-9p/xen-9p: move 9p specific bits to
 core 9p code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>

These bits aren't related to the transport so let's move them to the core
code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               |    8 +++++++-
 hw/9pfs/9p.h               |    2 +-
 hw/9pfs/virtio-9p-device.c |    8 +-------
 hw/9pfs/xen-9p-backend.c   |    6 +-----
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c80ba67389ce..b40001e3dea3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3446,12 +3446,16 @@ static inline bool is_read_only_op(V9fsPDU *pdu)
     }
 }
 
-void pdu_submit(V9fsPDU *pdu)
+void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
 {
     Coroutine *co;
     CoroutineEntry *handler;
     V9fsState *s = pdu->s;
 
+    pdu->size = le32_to_cpu(hdr->size_le);
+    pdu->id = hdr->id;
+    pdu->tag = le16_to_cpu(hdr->tag_le);
+
     if (pdu->id >= ARRAY_SIZE(pdu_co_handlers) ||
         (pdu_co_handlers[pdu->id] == NULL)) {
         handler = v9fs_op_not_supp;
@@ -3462,6 +3466,8 @@ void pdu_submit(V9fsPDU *pdu)
     if (is_ro_export(&s->ctx) && !is_read_only_op(pdu)) {
         handler = v9fs_fs_ro;
     }
+
+    qemu_co_queue_init(&pdu->complete);
     co = qemu_coroutine_create(handler, pdu);
     qemu_coroutine_enter(co);
 }
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5312d8a42405..c886ba78d2ee 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -347,7 +347,7 @@ ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...);
 ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...);
 V9fsPDU *pdu_alloc(V9fsState *s);
 void pdu_free(V9fsPDU *pdu);
-void pdu_submit(V9fsPDU *pdu);
+void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr);
 void v9fs_reset(V9fsState *s);
 
 struct V9fsTransport {
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 3782f437029b..245abd8aaef1 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -70,13 +70,7 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
             goto out_free_req;
         }
 
-        pdu->size = le32_to_cpu(out.size_le);
-
-        pdu->id = out.id;
-        pdu->tag = le16_to_cpu(out.tag_le);
-
-        qemu_co_queue_init(&pdu->complete);
-        pdu_submit(pdu);
+        pdu_submit(pdu, &out);
     }
 
     return;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 9c7f41af99da..c0b9d534298a 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -243,14 +243,10 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
 
     /* cannot fail, because we only handle one request per ring at a time */
     pdu = pdu_alloc(&ring->priv->state);
-    pdu->size = le32_to_cpu(h.size_le);
-    pdu->id = h.id;
-    pdu->tag = le32_to_cpu(h.tag_le);
     ring->out_size = le32_to_cpu(h.size_le);
     ring->out_cons = cons + le32_to_cpu(h.size_le);
 
-    qemu_co_queue_init(&pdu->complete);
-    pdu_submit(pdu);
+    pdu_submit(pdu, &h);
 
     return 0;
 }
