Received: from eggs.gnu.org ([2001:4830:134:3::10]:54632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UM-4U
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007DV-4W
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15385 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-0007Ac-JY
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:37 +0300
Message-Id: <20170804151440.320927-15-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 14/17] block/nbd-client: exit reply-reading
 coroutine on incorrect handle
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

Check reply-handle == request-handle in the same place, where
recv coroutine number is calculated from reply->handle and it's
correctness checked - in nbd_read_reply_entry.

Also finish nbd_read_reply_entry in case of reply-handle !=
request-handle in the same way as in case of incorrect reply-handle.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h | 1 +
 block/nbd-client.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 48e2559df6..aa36be8950 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -29,6 +29,7 @@ typedef struct NBDClientSession {
 
     struct {
         Coroutine *co;
+        NBDRequest *request;
     } requests[MAX_NBD_REQUESTS];
     NBDReply reply;
 } NBDClientSession;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 5eb126c399..0e12db4be3 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -88,7 +88,9 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
          * one coroutine is called until the reply finishes.
          */
         i = HANDLE_TO_INDEX(s, s->reply.handle);
-        if (i >= MAX_NBD_REQUESTS || !s->requests[i].co) {
+        if (i >= MAX_NBD_REQUESTS || !s->requests[i].co ||
+            s->reply.handle != s->requests[i].request->handle)
+        {
             break;
         }
 
@@ -135,6 +137,7 @@ static int nbd_co_request(BlockDriverState *bs,
     g_assert(qemu_in_coroutine());
     assert(i < MAX_NBD_REQUESTS);
     request->handle = INDEX_TO_HANDLE(s, i);
+    s->requests[i].request = request;
 
     if (!s->ioc) {
         qemu_co_mutex_unlock(&s->send_mutex);
@@ -170,11 +173,13 @@ static int nbd_co_request(BlockDriverState *bs,
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
-    if (s->reply.handle != request->handle || !s->ioc) {
+    if (!s->ioc || s->reply.handle == 0) {
         rc = -EIO;
         goto out;
     }
 
+    assert(s->reply.handle == request->handle);
+
     if (qiov && s->reply.error == 0) {
         ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true, NULL);
         if (ret != request->len) {
-- 
2.11.1
