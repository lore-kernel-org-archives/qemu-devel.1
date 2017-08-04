Received: from eggs.gnu.org ([2001:4830:134:3::10]:54629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UJ-3V
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJK-0007Cc-RL
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:8392 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-00078W-ED
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:36 +0300
Message-Id: <20170804151440.320927-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 13/17] block/nbd-client: refactor
 NBDClientSession.recv_coroutine
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

Move from recv_coroutine[i] to requests[i].co. This is needed for
further refactoring, new fields will be added to created structure.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  4 +++-
 block/nbd-client.c | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index df80771357..48e2559df6 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -27,7 +27,9 @@ typedef struct NBDClientSession {
     Coroutine *read_reply_co;
     int in_flight;
 
-    Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
+    struct {
+        Coroutine *co;
+    } requests[MAX_NBD_REQUESTS];
     NBDReply reply;
 } NBDClientSession;
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index d6145c7db0..5eb126c399 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -39,8 +39,8 @@ static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
     int i;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
-        if (s->recv_coroutine[i]) {
-            aio_co_wake(s->recv_coroutine[i]);
+        if (s->requests[i].co) {
+            aio_co_wake(s->requests[i].co);
         }
     }
 }
@@ -88,22 +88,22 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
          * one coroutine is called until the reply finishes.
          */
         i = HANDLE_TO_INDEX(s, s->reply.handle);
-        if (i >= MAX_NBD_REQUESTS || !s->recv_coroutine[i]) {
+        if (i >= MAX_NBD_REQUESTS || !s->requests[i].co) {
             break;
         }
 
-        /* We're woken up by the recv_coroutine itself.  Note that there
+        /* We're woken up by the receiving coroutine itself.  Note that there
          * is no race between yielding and reentering read_reply_co.  This
          * is because:
          *
-         * - if recv_coroutine[i] runs on the same AioContext, it is only
+         * - if requests[i].co runs on the same AioContext, it is only
          *   entered after we yield
          *
-         * - if recv_coroutine[i] runs on a different AioContext, reentering
+         * - if requests[i].co runs on a different AioContext, reentering
          *   read_reply_co happens through a bottom half, which can only
          *   run after we yield.
          */
-        aio_co_wake(s->recv_coroutine[i]);
+        aio_co_wake(s->requests[i].co);
         qemu_coroutine_yield();
     }
 
@@ -126,8 +126,8 @@ static int nbd_co_request(BlockDriverState *bs,
     s->in_flight++;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
-        if (s->recv_coroutine[i] == NULL) {
-            s->recv_coroutine[i] = qemu_coroutine_self();
+        if (s->requests[i].co == NULL) {
+            s->requests[i].co = qemu_coroutine_self();
             break;
         }
     }
@@ -189,7 +189,7 @@ out:
     /* Tell the read handler to read another header.  */
     s->reply.handle = 0;
 
-    s->recv_coroutine[i] = NULL;
+    s->requests[i].co = NULL;
 
     /* Kick the read_reply_co to get the next reply.  */
     if (s->read_reply_co) {
-- 
2.11.1
