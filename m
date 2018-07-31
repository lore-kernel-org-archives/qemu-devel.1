Received: from eggs.gnu.org ([2001:4830:134:3::10]:36934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Ug-AN
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTp-0004Fv-34
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:30 +0300
Message-Id: <20180731173033.75467-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 07/10] block/nbd-client: rename
 read_reply_co to connection_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This coroutine will serve nbd reconnects, so, rename it to be something
more generic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  4 ++--
 block/nbd-client.c | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 5367425774..e7bda4d3c4 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -20,7 +20,7 @@
 typedef struct {
     Coroutine *coroutine;
     uint64_t offset;        /* original offset of the request */
-    bool receiving;         /* waiting for read_reply_co? */
+    bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;
 
 typedef enum NBDClientState {
@@ -37,7 +37,7 @@ typedef struct NBDClientSession {
 
     CoMutex send_mutex;
     CoQueue free_sema;
-    Coroutine *read_reply_co;
+    Coroutine *connection_co;
     int in_flight;
     NBDClientState state;
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index a91fd3ea3e..c184a9f0e9 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -63,7 +63,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     qio_channel_shutdown(client->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    BDRV_POLL_WHILE(bs, client->read_reply_co);
+    BDRV_POLL_WHILE(bs, client->connection_co);
 
     nbd_client_detach_aio_context(bs);
     object_unref(OBJECT(client->sioc));
@@ -72,7 +72,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     client->ioc = NULL;
 }
 
-static coroutine_fn void nbd_read_reply_entry(void *opaque)
+static coroutine_fn void nbd_connection_entry(void *opaque)
 {
     NBDClientSession *s = opaque;
     uint64_t i;
@@ -105,14 +105,14 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
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
@@ -120,7 +120,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     }
 
     nbd_recv_coroutines_wake_all(s);
-    s->read_reply_co = NULL;
+    s->connection_co = NULL;
 }
 
 static int nbd_co_send_request(BlockDriverState *bs,
@@ -428,7 +428,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }
     *request_ret = 0;
 
-    /* Wait until we're woken up by nbd_read_reply_entry.  */
+    /* Wait until we're woken up by nbd_connection_entry.  */
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
@@ -503,7 +503,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
 }
 
 /* nbd_co_receive_one_chunk
- * Read reply, wake up read_reply_co and set s->quit if needed.
+ * Read reply, wake up connection_co and set s->quit if needed.
  * Return value is a fatal error code or normal nbd reply error code
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
@@ -517,15 +517,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
     if (ret < 0) {
         nbd_channel_error(s, ret);
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
@@ -966,7 +966,7 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
-    aio_co_schedule(new_context, client->read_reply_co);
+    aio_co_schedule(new_context, client->connection_co);
 }
 
 void nbd_client_close(BlockDriverState *bs)
@@ -1066,7 +1066,7 @@ static int nbd_client_connect(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, client);
+    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
-- 
2.11.1
