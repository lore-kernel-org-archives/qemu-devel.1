Received: from eggs.gnu.org ([209.51.188.92]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYSC-0007Ti-Lu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYSA-0002zo-LH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  1 Feb 2019 16:01:38 +0300
Message-Id: <20190201130138.94525-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190201130138.94525-1-vsementsov@virtuozzo.com>
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 6/6] block/nbd-client: rename read_reply_co
 to connection_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

This coroutine will serve nbd reconnects, so, rename it to be something
more generic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.h |  4 ++--
 block/nbd-client.c | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 2f047ba614..d990207a5c 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -20,7 +20,7 @@
 typedef struct {
     Coroutine *coroutine;
     uint64_t offset;        /* original offset of the request */
-    bool receiving;         /* waiting for read_reply_co? */
+    bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;
 
 typedef struct NBDClientSession {
@@ -30,7 +30,7 @@ typedef struct NBDClientSession {
 
     CoMutex send_mutex;
     CoQueue free_sema;
-    Coroutine *read_reply_co;
+    Coroutine *connection_co;
     int in_flight;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
diff --git a/block/nbd-client.c b/block/nbd-client.c
index d8bf1bbb8b..d9e33751ad 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -59,7 +59,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     qio_channel_shutdown(client->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    BDRV_POLL_WHILE(bs, client->read_reply_co);
+    BDRV_POLL_WHILE(bs, client->connection_co);
 
     nbd_client_detach_aio_context(bs);
     object_unref(OBJECT(client->sioc));
@@ -68,7 +68,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     client->ioc = NULL;
 }
 
-static coroutine_fn void nbd_read_reply_entry(void *opaque)
+static coroutine_fn void nbd_connection_entry(void *opaque)
 {
     NBDClientSession *s = opaque;
     uint64_t i;
@@ -100,14 +100,14 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         }
 
         /* We're woken up again by the request itself.  Note that there
-         * is no race between yielding and reentering read_reply_co.  This
+         * is no race between yielding and reentering connection_co.  This
          * is because:
          *
          * - if the request runs on the same AioContext, it is only
          *   entered after we yield
          *
          * - if the request runs on a different AioContext, reentering
-         *   read_reply_co happens through a bottom half, which can only
+         *   connection_co happens through a bottom half, which can only
          *   run after we yield.
          */
         aio_co_wake(s->requests[i].coroutine);
@@ -116,7 +116,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
 
     s->quit = true;
     nbd_recv_coroutines_wake_all(s);
-    s->read_reply_co = NULL;
+    s->connection_co = NULL;
 }
 
 static int nbd_co_send_request(BlockDriverState *bs,
@@ -420,7 +420,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }
     *request_ret = 0;
 
-    /* Wait until we're woken up by nbd_read_reply_entry.  */
+    /* Wait until we're woken up by nbd_connection_entry.  */
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
@@ -495,7 +495,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
 }
 
 /* nbd_co_receive_one_chunk
- * Read reply, wake up read_reply_co and set s->quit if needed.
+ * Read reply, wake up connection_co and set s->quit if needed.
  * Return value is a fatal error code or normal nbd reply error code
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
@@ -509,15 +509,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
     if (ret < 0) {
         s->quit = true;
     } else {
-        /* For assert at loop start in nbd_read_reply_entry */
+        /* For assert at loop start in nbd_connection_entry */
         if (reply) {
             *reply = s->reply;
         }
         s->reply.handle = 0;
     }
 
-    if (s->read_reply_co) {
-        aio_co_wake(s->read_reply_co);
+    if (s->connection_co) {
+        aio_co_wake(s->connection_co);
     }
 
     return ret;
@@ -970,7 +970,7 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
-    aio_co_schedule(new_context, client->read_reply_co);
+    aio_co_schedule(new_context, client->connection_co);
 }
 
 void nbd_client_close(BlockDriverState *bs)
@@ -1077,7 +1077,7 @@ static int nbd_client_connect(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, client);
+    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
-- 
2.18.0
