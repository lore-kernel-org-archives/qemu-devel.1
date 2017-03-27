Received: from eggs.gnu.org ([2001:4830:134:3::10]:53515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYjE-0003AK-2K
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYjA-00014b-Vo
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:52 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:34695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csYjA-00014I-N6
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:48 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9EE6577307
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:46:46 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Mar 2017 19:46:42 +0200
Message-ID: <149063680216.4447.10660696756972719425.stgit@bahia.lan>
In-Reply-To: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 5/5] 9pfs: handle broken transport
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

The 9p protocol is transport agnostic: if an error occurs when copying data
to/from the client, this should be handled by the transport layer [1] and
the 9p server should simply stop processing requests [2].

[1] can be implemented in the transport marshal/unmarshal handlers. In the
case of virtio, this means calling virtio_error() to inform the guest that
the device isn't functional anymore.

[2] means that the pdu_complete() function shouldn't send a reply back to
the client if the transport had a failure. This cannot be decided using the
current error path though, since we cannot discriminate if the error comes
from the transport or the backend. This patch hence introduces a flag in
the 9pfs state to record that the transport is broken. The device needs to
be reset for the flag to be unset.

This fixes Coverity issue CID 1348518.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               |   36 ++++++++++++++++++++++++++++--------
 hw/9pfs/9p.h               |    1 +
 hw/9pfs/virtio-9p-device.c |   16 ++++++++++++++--
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 09a8c79cf781..79d8292e9a7a 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -50,6 +50,9 @@ ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     ret = pdu->s->transport->pdu_vmarshal(pdu, offset, fmt, ap);
     va_end(ap);
 
+    if (ret < 0) {
+        pdu->s->transport_broken = true;
+    }
     return ret;
 }
 
@@ -62,6 +65,9 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     ret = pdu->s->transport->pdu_vunmarshal(pdu, offset, fmt, ap);
     va_end(ap);
 
+    if (ret < 0) {
+        pdu->s->transport_broken = true;
+    }
     return ret;
 }
 
@@ -623,15 +629,15 @@ void pdu_free(V9fsPDU *pdu)
     QLIST_INSERT_HEAD(&s->free_list, pdu, next);
 }
 
-/*
- * We don't do error checking for pdu_marshal/unmarshal here
- * because we always expect to have enough space to encode
- * error details
- */
 static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
 {
     int8_t id = pdu->id + 1; /* Response */
     V9fsState *s = pdu->s;
+    int ret;
+
+    if (s->transport_broken) {
+        goto out_complete;
+    }
 
     if (len < 0) {
         int err = -len;
@@ -643,11 +649,19 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
             str.data = strerror(err);
             str.size = strlen(str.data);
 
-            len += pdu_marshal(pdu, len, "s", &str);
+            ret = pdu_marshal(pdu, len, "s", &str);
+            if (ret < 0) {
+                goto out_complete;
+            }
+            len += ret;
             id = P9_RERROR;
         }
 
-        len += pdu_marshal(pdu, len, "d", err);
+        ret = pdu_marshal(pdu, len, "d", err);
+        if (ret < 0) {
+            goto out_complete;
+        }
+        len += ret;
 
         if (s->proto_version == V9FS_PROTO_2000L) {
             id = P9_RLERROR;
@@ -656,7 +670,10 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
     }
 
     /* fill out the header */
-    pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag);
+    ret = pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag);
+    if (ret < 0) {
+        goto out_complete;
+    }
 
     /* keep these in sync */
     pdu->size = len;
@@ -664,6 +681,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
 
     pdu->s->transport->push_and_notify(pdu);
 
+out_complete:
     /* Now wakeup anybody waiting in flush for this request */
     if (!qemu_co_queue_next(&pdu->complete)) {
         pdu_free(pdu);
@@ -3593,6 +3611,8 @@ void v9fs_reset(V9fsState *s)
     while (!data.done) {
         aio_poll(qemu_get_aio_context(), true);
     }
+
+    s->transport_broken = false;
 }
 
 static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b7e836251e13..523abdb0a582 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -240,6 +240,7 @@ typedef struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
+    bool transport_broken;
 } V9fsState;
 
 /* 9p2000.L open flags */
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 873b22baf0f9..6ea9acfc28a9 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -172,8 +172,14 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    int ret;
 
-    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
+    ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
+    if (ret < 0) {
+        virtio_9p_error(v, pdu->idx,
+                        "Failed to marshal VirtFS reply type %d", pdu->id);
+    }
+    return ret;
 }
 
 static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
@@ -182,8 +188,14 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
+    int ret;
 
-    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
+    ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
+    if (ret < 0) {
+        virtio_9p_error(v, pdu->idx,
+                        "Failed to unmarshal VirtFS request type %d", pdu->id);
+    }
+    return ret;
 }
 
 /* The size parameter is used by other transports. Do not drop it. */
