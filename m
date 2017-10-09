Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq4-0000Uy-W2
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq1-0004do-0K
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:22417 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004ZC-JS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:09 +0300
Message-Id: <20171009172723.190282-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/7] block/nbd-client: exit reply-reading
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
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Check reply-handle == request-handle in the same place, where
recv coroutine number is calculated from reply->handle and it's
correctness checked - in nbd_read_reply_entry.

Also finish nbd_read_reply_entry in case of reply-handle !=
request-handle in the same way as in case of incorrect reply-handle.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h | 1 +
 block/nbd-client.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index b435754b82..b1900e6a6d 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -20,6 +20,7 @@
 typedef struct {
     Coroutine *coroutine;
     bool receiving;         /* waiting for read_reply_co? */
+    NBDRequest *request;
 } NBDClientRequest;
 
 typedef struct NBDClientSession {
diff --git a/block/nbd-client.c b/block/nbd-client.c
index acd8e5d007..5f241ecc22 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -92,7 +92,9 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         i = HANDLE_TO_INDEX(s, s->reply.handle);
         if (i >= MAX_NBD_REQUESTS ||
             !s->requests[i].coroutine ||
-            !s->requests[i].receiving) {
+            !s->requests[i].receiving ||
+            s->reply.handle != s->requests[i].request->handle)
+        {
             break;
         }
 
@@ -142,6 +144,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     s->requests[i].receiving = false;
 
     request->handle = INDEX_TO_HANDLE(s, i);
+    s->requests[i].request = request;
 
     if (s->quit) {
         rc = -EIO;
@@ -189,9 +192,10 @@ static int nbd_co_receive_reply(NBDClientSession *s,
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (s->reply.handle != request->handle || !s->ioc || s->quit) {
+    if (!s->ioc || s->quit) {
         ret = -EIO;
     } else {
+        assert(s->reply.handle == request->handle);
         ret = -s->reply.error;
         if (qiov && s->reply.error == 0) {
             assert(request->len == iov_size(qiov->iov, qiov->niov));
-- 
2.11.1
