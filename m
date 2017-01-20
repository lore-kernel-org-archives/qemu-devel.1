Received: from eggs.gnu.org ([2001:4830:134:3::10]:45364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHr-00039Y-BY
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHm-0003Ai-UO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHm-0003AQ-Ks
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:34 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7A4B33C151
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:12 +0100
Message-Id: <20170120164322.21851-8-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/17] nbd: convert to use qio_channel_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com

In the client, read the reply headers from a coroutine, switching the
read side between the "read header" coroutine and the I/O coroutine that
reads the body of the reply.

In the server, if the server can read more requests it will create a new
"read request" coroutine as soon as a request has been read.  Otherwise,
the new coroutine is created in nbd_request_put.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2:
        allow NULL s->read_reply_co [Fam]
        converted NBD server to qio_channel_yield too [Fam]

 block/nbd-client.c | 108 +++++++++++++++++++++--------------------------------
 block/nbd-client.h |   2 +-
 nbd/client.c       |   2 +-
 nbd/common.c       |   9 +----
 nbd/server.c       |  94 ++++++++++++++--------------------------------
 5 files changed, 74 insertions(+), 141 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 06f1532..6ea54f9 100644
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
+static coroutine_fn void nbd_read_reply_entry(void *opaque)
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
-
-    if (s->recv_coroutine[i]) {
-        qemu_coroutine_enter(s->recv_coroutine[i]);
-        return;
-    }
 
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
@@ -209,13 +181,19 @@ static void nbd_coroutine_start(NBDClientSession *s,
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
+    s->in_flight--;
+    qemu_co_queue_next(&s->free_sema);
+
+    /* Kick the read_reply_co to get the next reply.  */
+    if (s->read_reply_co) {
+        aio_co_wake(s->read_reply_co);
     }
 }
 
@@ -241,7 +219,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, qiov);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -271,7 +249,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -306,7 +284,7 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -331,7 +309,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(client, &request);
+    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }
 
@@ -357,23 +335,23 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
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
+    qio_channel_detach_aio_context(QIO_CHANNEL(client->sioc));
 }
 
 void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
-    aio_set_fd_handler(new_context, nbd_get_client_session(bs)->sioc->fd,
-                       false, nbd_reply_ready, NULL, NULL, bs);
+    NBDClientSession *client = nbd_get_client_session(bs);
+    qio_channel_attach_aio_context(QIO_CHANNEL(client->sioc), new_context);
+    aio_co_schedule(new_context, client->read_reply_co);
 }
 
 void nbd_client_close(BlockDriverState *bs)
@@ -434,7 +412,7 @@ int nbd_client_init(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-
+    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
diff --git a/block/nbd-client.h b/block/nbd-client.h
index f8d6006..8cdfc92 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -25,7 +25,7 @@ typedef struct NBDClientSession {
 
     CoMutex send_mutex;
     CoQueue free_sema;
-    Coroutine *send_coroutine;
+    Coroutine *read_reply_co;
     int in_flight;
 
     Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
diff --git a/nbd/client.c b/nbd/client.c
index ffb0743..5c9dee3 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -778,7 +778,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
     ssize_t ret;
 
     ret = read_sync(ioc, buf, sizeof(buf));
-    if (ret < 0) {
+    if (ret <= 0) {
         return ret;
     }
 
diff --git a/nbd/common.c b/nbd/common.c
index b583a4f..805dbdc 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -43,14 +43,7 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
         }
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
-                /* XXX figure out if we can create a variant on
-                 * qio_channel_yield() that works with AIO contexts
-                 * and consider using that in this branch */
-                qemu_coroutine_yield();
-            } else if (done) {
-                /* XXX this is needed by nbd_reply_ready.  */
-                qio_channel_wait(ioc,
-                                 do_read ? G_IO_IN : G_IO_OUT);
+                qio_channel_yield(ioc, do_read ? G_IO_IN : G_IO_OUT);
             } else {
                 return -EAGAIN;
             }
diff --git a/nbd/server.c b/nbd/server.c
index efe5cb8..1130055 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -95,8 +95,6 @@ struct NBDClient {
     CoMutex send_lock;
     Coroutine *send_coroutine;
 
-    bool can_read;
-
     QTAILQ_ENTRY(NBDClient) next;
     int nb_requests;
     bool closing;
@@ -104,9 +102,7 @@ struct NBDClient {
 
 /* That's all folks */
 
-static void nbd_set_handlers(NBDClient *client);
-static void nbd_unset_handlers(NBDClient *client);
-static void nbd_update_can_read(NBDClient *client);
+static void nbd_client_receive_next_request(NBDClient *client);
 
 static gboolean nbd_negotiate_continue(QIOChannel *ioc,
                                        GIOCondition condition,
@@ -785,7 +781,7 @@ void nbd_client_put(NBDClient *client)
          */
         assert(client->closing);
 
-        nbd_unset_handlers(client);
+        qio_channel_detach_aio_context(client->ioc);
         object_unref(OBJECT(client->sioc));
         object_unref(OBJECT(client->ioc));
         if (client->tlscreds) {
@@ -826,7 +822,6 @@ static NBDRequestData *nbd_request_get(NBDClient *client)
 
     assert(client->nb_requests <= MAX_NBD_REQUESTS - 1);
     client->nb_requests++;
-    nbd_update_can_read(client);
 
     req = g_new0(NBDRequestData, 1);
     nbd_client_get(client);
@@ -844,7 +839,8 @@ static void nbd_request_put(NBDRequestData *req)
     g_free(req);
 
     client->nb_requests--;
-    nbd_update_can_read(client);
+    nbd_client_receive_next_request(client);
+
     nbd_client_put(client);
 }
 
@@ -858,7 +854,13 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
     exp->ctx = ctx;
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        nbd_set_handlers(client);
+        qio_channel_attach_aio_context(client->ioc, ctx);
+        if (client->recv_coroutine) {
+            aio_co_schedule(ctx, client->recv_coroutine);
+        }
+        if (client->send_coroutine) {
+            aio_co_schedule(ctx, client->send_coroutine);
+        }
     }
 }
 
@@ -870,7 +872,7 @@ static void blk_aio_detach(void *opaque)
     TRACE("Export %s: Detaching clients from AIO context %p\n", exp->name, exp->ctx);
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        nbd_unset_handlers(client);
+        qio_channel_detach_aio_context(client->ioc);
     }
 
     exp->ctx = NULL;
@@ -1045,7 +1047,6 @@ static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
     g_assert(qemu_in_coroutine());
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
-    nbd_set_handlers(client);
 
     if (!len) {
         rc = nbd_send_reply(client->ioc, reply);
@@ -1062,7 +1063,6 @@ static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
     }
 
     client->send_coroutine = NULL;
-    nbd_set_handlers(client);
     qemu_co_mutex_unlock(&client->send_lock);
     return rc;
 }
@@ -1079,9 +1079,7 @@ static ssize_t nbd_co_receive_request(NBDRequestData *req,
     ssize_t rc;
 
     g_assert(qemu_in_coroutine());
-    client->recv_coroutine = qemu_coroutine_self();
-    nbd_update_can_read(client);
-
+    assert(client->recv_coroutine == qemu_coroutine_self());
     rc = nbd_receive_request(client->ioc, request);
     if (rc < 0) {
         if (rc != -EAGAIN) {
@@ -1163,23 +1161,25 @@ static ssize_t nbd_co_receive_request(NBDRequestData *req,
 
 out:
     client->recv_coroutine = NULL;
-    nbd_update_can_read(client);
+    nbd_client_receive_next_request(client);
 
     return rc;
 }
 
-static void nbd_trip(void *opaque)
+/* Owns a reference to the NBDClient passed as opaque.  */
+static coroutine_fn void nbd_trip(void *opaque)
 {
     NBDClient *client = opaque;
     NBDExport *exp = client->exp;
     NBDRequestData *req;
-    NBDRequest request;
+    NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
     NBDReply reply;
     ssize_t ret;
     int flags;
 
     TRACE("Reading request.");
     if (client->closing) {
+        nbd_client_put(client);
         return;
     }
 
@@ -1338,60 +1338,21 @@ static void nbd_trip(void *opaque)
 
 done:
     nbd_request_put(req);
+    nbd_client_put(client);
     return;
 
 out:
     nbd_request_put(req);
     client_close(client);
+    nbd_client_put(client);
 }
 
-static void nbd_read(void *opaque)
-{
-    NBDClient *client = opaque;
-
-    if (client->recv_coroutine) {
-        qemu_coroutine_enter(client->recv_coroutine);
-    } else {
-        qemu_coroutine_enter(qemu_coroutine_create(nbd_trip, client));
-    }
-}
-
-static void nbd_restart_write(void *opaque)
-{
-    NBDClient *client = opaque;
-
-    qemu_coroutine_enter(client->send_coroutine);
-}
-
-static void nbd_set_handlers(NBDClient *client)
-{
-    if (client->exp && client->exp->ctx) {
-        aio_set_fd_handler(client->exp->ctx, client->sioc->fd, true,
-                           client->can_read ? nbd_read : NULL,
-                           client->send_coroutine ? nbd_restart_write : NULL,
-                           NULL, client);
-    }
-}
-
-static void nbd_unset_handlers(NBDClient *client)
-{
-    if (client->exp && client->exp->ctx) {
-        aio_set_fd_handler(client->exp->ctx, client->sioc->fd, true, NULL,
-                           NULL, NULL, NULL);
-    }
-}
-
-static void nbd_update_can_read(NBDClient *client)
+static void nbd_client_receive_next_request(NBDClient *client)
 {
-    bool can_read = client->recv_coroutine ||
-                    client->nb_requests < MAX_NBD_REQUESTS;
-
-    if (can_read != client->can_read) {
-        client->can_read = can_read;
-        nbd_set_handlers(client);
-
-        /* There is no need to invoke aio_notify(), since aio_set_fd_handler()
-         * in nbd_set_handlers() will have taken care of that */
+    if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS) {
+        nbd_client_get(client);
+        client->recv_coroutine = qemu_coroutine_create(nbd_trip, client);
+        aio_co_schedule(client->exp->ctx, client->recv_coroutine);
     }
 }
 
@@ -1409,11 +1370,13 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
         goto out;
     }
     qemu_co_mutex_init(&client->send_lock);
-    nbd_set_handlers(client);
 
     if (exp) {
         QTAILQ_INSERT_TAIL(&exp->clients, client, next);
     }
+
+    nbd_client_receive_next_request(client);
+
 out:
     g_free(data);
 }
@@ -1439,7 +1402,6 @@ void nbd_client_new(NBDExport *exp,
     object_ref(OBJECT(client->sioc));
     client->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(client->ioc));
-    client->can_read = true;
     client->close = close_fn;
 
     data->client = client;
-- 
2.9.3
