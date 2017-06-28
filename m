Received: from eggs.gnu.org ([2001:4830:134:3::10]:40329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQJpX-0007Mc-Pk
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQJpU-0004Fg-Ol
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:44:55 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:59129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQJpU-0004F5-Gv
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:44:52 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 236C910DD66
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 22:44:51 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 28 Jun 2017 22:44:47 +0200
Message-ID: <149868268758.23385.1547307280569014820.stgit@bahia.lan>
In-Reply-To: <149868263738.23385.16723444264552987199.stgit@bahia.lan>
References: <149868263738.23385.16723444264552987199.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 5/5] 9pfs: handle transport errors in
 pdu_complete()
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

Contrary to what is written in the comment, a buggy guest can misconfigure
the transport buffers and pdu_marshal() may return an error.  If this ever
happens, it is up to the transport layer to handle the situation (9P is
transport agnostic).

This fixes Coverity issue CID1348518.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index da0d6da65b45..f7871e6f3e5a 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -624,15 +624,11 @@ void pdu_free(V9fsPDU *pdu)
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
 
     if (len < 0) {
         int err = -len;
@@ -644,11 +640,19 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
             str.data = strerror(err);
             str.size = strlen(str.data);
 
-            len += pdu_marshal(pdu, len, "s", &str);
+            ret = pdu_marshal(pdu, len, "s", &str);
+            if (ret < 0) {
+                goto out_notify;
+            }
+            len += ret;
             id = P9_RERROR;
         }
 
-        len += pdu_marshal(pdu, len, "d", err);
+        ret = pdu_marshal(pdu, len, "d", err);
+        if (ret < 0) {
+            goto out_notify;
+        }
+        len += ret;
 
         if (s->proto_version == V9FS_PROTO_2000L) {
             id = P9_RLERROR;
@@ -657,12 +661,15 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
     }
 
     /* fill out the header */
-    pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag);
+    if (pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag) < 0) {
+        goto out_notify;
+    }
 
     /* keep these in sync */
     pdu->size = len;
     pdu->id = id;
 
+out_notify:
     pdu->s->transport->push_and_notify(pdu);
 
     /* Now wakeup anybody waiting in flush for this request */
