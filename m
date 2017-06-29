Received: from eggs.gnu.org ([2001:4830:134:3::10]:55039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZkK-0003QZ-Tg
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZkG-0002xh-1K
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQZkF-0002xG-Ro
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TDcuNY111243
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:31 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1mfka6h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:30 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 29 Jun 2017 14:44:29 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Jun 2017 15:43:51 +0200
In-Reply-To: <1498743831-28676-1-git-send-email-groug@kaod.org>
References: <1498743831-28676-1-git-send-email-groug@kaod.org>
Message-Id: <1498743831-28676-9-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 8/8] 9pfs: handle transport errors in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Contrary to what is written in the comment, a buggy guest can misconfigure
the transport buffers and pdu_marshal() may return an error.  If this ever
happens, it is up to the transport layer to handle the situation (9P is
transport agnostic).

This fixes Coverity issue CID1348518.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/9pfs/9p.c | 23 +++++++++++++++--------
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
-- 
2.7.5
