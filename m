Received: from eggs.gnu.org ([2001:4830:134:3::10]:42962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dk8eT-0003j2-48
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dk8eR-0005fO-V2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:51:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 22 Aug 2017 13:51:13 +0100
Message-Id: <20170822125113.5025-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd-client: avoid spurious qio_channel_yield()
 re-entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The following scenario leads to an assertion failure in
qio_channel_yield():

1. Request coroutine calls qio_channel_yield() successfully when sending
   would block on the socket.  It is now yielded.
2. nbd_read_reply_entry() calls nbd_recv_coroutines_enter_all() because
   nbd_receive_reply() failed.
3. Request coroutine is entered and returns from qio_channel_yield().
   Note that the socket fd handler has not fired yet so
   ioc->write_coroutine is still set.
4. Request coroutine attempts to send the request body with nbd_rwv()
   but the socket would still block.  qio_channel_yield() is called
   again and assert(!ioc->write_coroutine) is hit.

The problem is that nbd_read_reply_entry() does not distinguish between
request coroutines that are waiting to receive a reply and those that
are not.

This patch adds a per-request bool receiving flag so
nbd_read_reply_entry() can avoid spurious aio_wake() calls.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This should fix the issue that Dave is seeing but I'm concerned that
there are more problems in nbd-client.c.  We don't have good
abstractions for writing coroutine socket I/O code.  Something like Go's
channels would avoid manual low-level coroutine calls.  There is
currently no way to cancel qio_channel_yield() so requests doing I/O may
remain in-flight indefinitely and nbd-client.c doesn't join them...

 block/nbd-client.h |  7 ++++++-
 block/nbd-client.c | 35 ++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 1935ffbcaa..b435754b82 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -17,6 +17,11 @@
 
 #define MAX_NBD_REQUESTS    16
 
+typedef struct {
+    Coroutine *coroutine;
+    bool receiving;         /* waiting for read_reply_co? */
+} NBDClientRequest;
+
 typedef struct NBDClientSession {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
@@ -27,7 +32,7 @@ typedef struct NBDClientSession {
     Coroutine *read_reply_co;
     int in_flight;
 
-    Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
+    NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     bool quit;
 } NBDClientSession;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 422ecb4307..c2834f6b47 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -39,8 +39,10 @@ static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
     int i;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
-        if (s->recv_coroutine[i]) {
-            aio_co_wake(s->recv_coroutine[i]);
+        NBDClientRequest *req = &s->requests[i];
+
+        if (req->coroutine && req->receiving) {
+            aio_co_wake(req->coroutine);
         }
     }
 }
@@ -88,28 +90,28 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
          * one coroutine is called until the reply finishes.
          */
         i = HANDLE_TO_INDEX(s, s->reply.handle);
-        if (i >= MAX_NBD_REQUESTS || !s->recv_coroutine[i]) {
+        if (i >= MAX_NBD_REQUESTS ||
+            !s->requests[i].coroutine ||
+            !s->requests[i].receiving) {
             break;
         }
 
-        /* We're woken up by the recv_coroutine itself.  Note that there
+        /* We're woken up again by the request itself.  Note that there
          * is no race between yielding and reentering read_reply_co.  This
          * is because:
          *
-         * - if recv_coroutine[i] runs on the same AioContext, it is only
+         * - if the request runs on the same AioContext, it is only
          *   entered after we yield
          *
-         * - if recv_coroutine[i] runs on a different AioContext, reentering
+         * - if the request runs on a different AioContext, reentering
          *   read_reply_co happens through a bottom half, which can only
          *   run after we yield.
          */
-        aio_co_wake(s->recv_coroutine[i]);
+        aio_co_wake(s->requests[i].coroutine);
         qemu_coroutine_yield();
     }
 
-    if (ret < 0) {
-        s->quit = true;
-    }
+    s->quit = true;
     nbd_recv_coroutines_enter_all(s);
     s->read_reply_co = NULL;
 }
@@ -128,14 +130,17 @@ static int nbd_co_send_request(BlockDriverState *bs,
     s->in_flight++;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
-        if (s->recv_coroutine[i] == NULL) {
-            s->recv_coroutine[i] = qemu_coroutine_self();
+        if (s->requests[i].coroutine == NULL) {
             break;
         }
     }
 
     g_assert(qemu_in_coroutine());
     assert(i < MAX_NBD_REQUESTS);
+
+    s->requests[i].coroutine = qemu_coroutine_self();
+    s->requests[i].receiving = false;
+
     request->handle = INDEX_TO_HANDLE(s, i);
 
     if (s->quit) {
@@ -173,10 +178,13 @@ static void nbd_co_receive_reply(NBDClientSession *s,
                                  NBDReply *reply,
                                  QEMUIOVector *qiov)
 {
+    int i = HANDLE_TO_INDEX(s, request->handle);
     int ret;
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
+    s->requests[i].receiving = true;
     qemu_coroutine_yield();
+    s->requests[i].receiving = false;
     *reply = s->reply;
     if (reply->handle != request->handle || !s->ioc || s->quit) {
         reply->error = EIO;
@@ -186,6 +194,7 @@ static void nbd_co_receive_reply(NBDClientSession *s,
                           NULL);
             if (ret != request->len) {
                 reply->error = EIO;
+                s->quit = true;
             }
         }
 
@@ -200,7 +209,7 @@ static void nbd_coroutine_end(BlockDriverState *bs,
     NBDClientSession *s = nbd_get_client_session(bs);
     int i = HANDLE_TO_INDEX(s, request->handle);
 
-    s->recv_coroutine[i] = NULL;
+    s->requests[i].coroutine = NULL;
 
     /* Kick the read_reply_co to get the next reply.  */
     if (s->read_reply_co) {
-- 
2.13.5
