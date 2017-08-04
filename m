Received: from eggs.gnu.org ([2001:4830:134:3::10]:54628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UI-3T
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007Dx-9k
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45565 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-0007BC-V9
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:35 +0300
Message-Id: <20170804151440.320927-13-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 12/17] block/nbd-client: refactor nbd_co_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Reduce nesting, get rid of extra variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index b84cab4079..d6145c7db0 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -118,7 +118,6 @@ static int nbd_co_request(BlockDriverState *bs,
 {
     NBDClientSession *s = nbd_get_client_session(bs);
     int rc, ret, i;
-    NBDReply reply;
 
     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight == MAX_NBD_REQUESTS) {
@@ -171,20 +170,20 @@ static int nbd_co_request(BlockDriverState *bs,
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
-    reply = s->reply;
-    if (reply.handle != request->handle ||
-        !s->ioc) {
-        reply.error = EIO;
-    } else {
-        if (qiov && reply.error == 0) {
-            ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true,
-                          NULL);
-            if (ret != request->len) {
-                reply.error = EIO;
-            }
+    if (s->reply.handle != request->handle || !s->ioc) {
+        rc = -EIO;
+        goto out;
+    }
+
+    if (qiov && s->reply.error == 0) {
+        ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true, NULL);
+        if (ret != request->len) {
+            rc = -EIO;
+            goto out;
         }
     }
-    rc = -reply.error;
+
+    rc = -s->reply.error;
 
 out:
     /* Tell the read handler to read another header.  */
-- 
2.11.1
