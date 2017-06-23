Received: from eggs.gnu.org ([2001:4830:134:3::10]:47570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dOILf-0002CM-P5
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dOILb-0008AU-Ap
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:43 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:35897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dOILb-00089f-2N
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:39 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9D0A2107B7A
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 08:45:37 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 23 Jun 2017 08:45:34 +0200
Message-ID: <149820033413.7187.1250602964263131431.stgit@bahia.lan>
In-Reply-To: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
References: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 4/4] 9pfs: handle transport errors in
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
index 8e5cac71eb60..6c92bad5b3b4 100644
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
