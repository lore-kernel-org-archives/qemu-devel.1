Received: from eggs.gnu.org ([2001:4830:134:3::10]:43701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKUYM-0001jN-2P
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKUYK-0006Ie-3L
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cKUYJ-0006Hi-R5
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:26:48 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 094CB3D951
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 18:26:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Dec 2016 19:26:41 +0100
Message-Id: <20161223182641.2718-4-pbonzini@redhat.com>
In-Reply-To: <20161223182641.2718-1-pbonzini@redhat.com>
References: <20161223182641.2718-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] nbd: do not block on partial reply header
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Read the replies from a coroutine.  qio_channel_yield is used so that
the right coroutine is restarted automatically, eliminating the need
for send_coroutine in NBDClientSession.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c | 108 +++++++++++++++++++++--------------------------------
 1 file changed, 42 insertions(+), 66 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 06f1532..a3c2c19 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -33,8 +33,9 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)bs))
 
-static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
+static void nbd_recv_coroutines_enter_all(BlockDriverState *bs)
 {
+    NBDClientSession *s = nbd_get_client_session(bs);
     int i;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
@@ -42,6 +43,7 @@ static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
             qemu_coroutine_enter(s->recv_coroutine[i]);
         }
     }
+    BDRV_POLL_WHILE(bs, s->read_reply_co);
 }
 
 static void nbd_teardown_connection(BlockDriverState *bs)
@@ -56,7 +58,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     qio_channel_shutdown(client->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    nbd_recv_coroutines_enter_all(client);
+    nbd_recv_coroutines_enter_all(bs);
 
     nbd_client_detach_aio_context(bs);
     object_unref(OBJECT(client->sioc));
@@ -65,54 +67,34 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     client->ioc = NULL;
 }
 
-static void nbd_reply_ready(void *opaque)
+static void nbd_read_reply_entry(void *opaque)
 {
-    BlockDriverState *bs = opaque;
-    NBDClientSession *s = nbd_get_client_session(bs);
+    NBDClientSession *s = opaque;
     uint64_t i;
     int ret;
 
-    if (!s->ioc) { /* Already closed */
-        return;
-    }
-
-    if (s->reply.handle == 0) {
-        /* No reply already in flight.  Fetch a header.  It is possible
-         * that another thread has done the same thing in parallel, so
-         * the socket is not readable anymore.
-         */
+    for (;;) {
+        assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply);
-        if (ret == -EAGAIN) {
-            return;
-        }
         if (ret < 0) {
-            s->reply.handle = 0;
-            goto fail;
+            break;
         }
-    }
-
-    /* There's no need for a mutex on the receive side, because the
-     * handler acts as a synchronization point and ensures that only
-     * one coroutine is called until the reply finishes.  */
-    i = HANDLE_TO_INDEX(s, s->reply.handle);
-    if (i >= MAX_NBD_REQUESTS) {
-        goto fail;
-    }
 
-    if (s->recv_coroutine[i]) {
-        qemu_coroutine_enter(s->recv_coroutine[i]);
-        return;
-    }
-
-fail:
-    nbd_teardown_connection(bs);
-}
+        /* There's no need for a mutex on the receive side, because the
+         * handler acts as a synchronization point and ensures that only
+         * one coroutine is called until the reply finishes.
+         */
+        i = HANDLE_TO_INDEX(s, s->reply.handle);
+        if (i >= MAX_NBD_REQUESTS || !s->recv_coroutine[i]) {
+            break;
+        }
 
-static void nbd_restart_write(void *opaque)
-{
-    BlockDriverState *bs = opaque;
+        aio_co_wake(s->recv_coroutine[i]);
 
-    qemu_coroutine_enter(nbd_get_client_session(bs)->send_coroutine);
+        /* We're woken up by the recv_coroutine itself.  */
+        qemu_coroutine_yield();
+    }
+    s->read_reply_co = NULL;
 }
 
 static int nbd_co_send_request(BlockDriverState *bs,
@@ -120,7 +102,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
                                QEMUIOVector *qiov)
 {
     NBDClientSession *s = nbd_get_client_session(bs);
-    AioContext *aio_context;
     int rc, ret, i;
 
     qemu_co_mutex_lock(&s->send_mutex);
@@ -141,11 +122,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
         return -EPIPE;
     }
 
-    s->send_coroutine = qemu_coroutine_self();
-    aio_context = bdrv_get_aio_context(bs);
-
-    aio_set_fd_handler(aio_context, s->sioc->fd, false,
-                       nbd_reply_ready, nbd_restart_write, NULL, bs);
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
@@ -160,9 +136,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
     } else {
         rc = nbd_send_request(s->ioc, request);
     }
-    aio_set_fd_handler(aio_context, s->sioc->fd, false,
-                       nbd_reply_ready, NULL, NULL, bs);
-    s->send_coroutine = NULL;
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;
 }
@@ -174,8 +147,7 @@ static void nbd_co_receive_reply(NBDClientSession *s,
 {
     int ret;
 
-    /* Wait until we're woken up by the read handler.  TODO: perhaps
-     * peek at the next reply and avoid yielding if it's ours?  */
+    /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
     *reply = s->reply;
     if (reply->handle != request->handle ||
@@ -209,14 +181,18 @@ static void nbd_coroutine_start(NBDClientSession *s,
     /* s->recv_coroutine[i] is set as soon as we get the send_lock.  */
 }
 
-static void nbd_coroutine_end(NBDClientSession *s,
+static void nbd_coroutine_end(BlockDriverState *bs,
                               NBDRequest *request)
 {
+    NBDClientSession *s = nbd_get_client_session(bs);
     int i = HANDLE_TO_INDEX(s, request->handle);
+
     s->recv_coroutine[i] = NULL;
-    if (s->in_flight-- == MAX_NBD_REQUESTS) {
-        qemu_co_queue_next(&s->free_sema);
-    }
+
+    /* Kick the read_reply_co to get the next reply.  */
+    aio_co_wake(s->read_reply_co);
+    s->in_flight--;
+    qemu_co_queue_next(&s->free_sema);
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
@@ -241,7 +217,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, qiov);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -271,7 +247,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -306,7 +282,7 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -331,7 +307,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -357,23 +333,23 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 
 }
 
 void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
-    aio_set_fd_handler(bdrv_get_aio_context(bs),
-                       nbd_get_client_session(bs)->sioc->fd,
-                       false, NULL, NULL, NULL, NULL);
+    NBDClientSession *client = nbd_get_client_session(bs);
+    qio_channel_set_aio_context(QIO_CHANNEL(client->sioc), NULL);
 }
 
 void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
-    aio_set_fd_handler(new_context, nbd_get_client_session(bs)->sioc->fd,
-                       false, nbd_reply_ready, NULL, NULL, bs);
+    NBDClientSession *client = nbd_get_client_session(bs);
+    qio_channel_set_aio_context(QIO_CHANNEL(client->sioc), new_context);
+    aio_co_schedule(new_context, client->read_reply_co);
 }
 
 void nbd_client_close(BlockDriverState *bs)
@@ -434,7 +410,7 @@ int nbd_client_init(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-
+    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
-- 
2.9.3
