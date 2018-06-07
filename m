Received: from eggs.gnu.org ([2001:4830:134:3::10]:34220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fQyUs-0008B5-DO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fQyUo-00084D-MS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:14:50 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Jun 2018 20:14:38 +0300
Message-Id: <20180607171441.64079-9-vsementsov@virtuozzo.com>
In-Reply-To: <20180607171441.64079-1-vsementsov@virtuozzo.com>
References: <20180607171441.64079-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 08/11] block/nbd-client: move connecting to
 connection_co
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

As a first step to nbd reconnect, move connection to connection_co
coroutine.

The key point in this patch is nbd_client_attach_aio_context() change:
We schedule to connection_co only if it is waiting for read from the
channel. We should not schedule it if it is some other yield, and if
it is currently executing (we call nbd_client_attach_aio_context from
connection code).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  3 +++
 block/nbd-client.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 7cb31e72e6..f6c8052573 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -41,6 +41,9 @@ typedef struct NBDClientSession {
     Coroutine *connection_co;
     int in_flight;
     NBDClientState state;
+    bool receiving;
+    int connect_status;
+    Error *connect_err;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 97bbb4339a..b74b964041 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -34,6 +34,13 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
 
+static int nbd_client_connect(BlockDriverState *bs,
+                              SocketAddress *saddr,
+                              const char *export,
+                              QCryptoTLSCreds *tlscreds,
+                              const char *hostname,
+                              Error **errp);
+
 /* @ret would be used for reconnect in future */
 static void nbd_channel_error(NBDClientSession *s, int ret)
 {
@@ -63,6 +70,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     qio_channel_shutdown(client->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
+    client->state = NBD_CLIENT_QUIT;
     BDRV_POLL_WHILE(bs, client->connection_co);
 
     nbd_client_detach_aio_context(bs);
@@ -72,16 +80,38 @@ static void nbd_teardown_connection(BlockDriverState *bs)
     client->ioc = NULL;
 }
 
+typedef struct NBDConnection {
+    BlockDriverState *bs;
+    SocketAddress *saddr;
+    const char *export;
+    QCryptoTLSCreds *tlscreds;
+    const char *hostname;
+} NBDConnection;
+
 static coroutine_fn void nbd_connection_entry(void *opaque)
 {
-    NBDClientSession *s = opaque;
+    NBDConnection *con = opaque;
+    NBDClientSession *s = nbd_get_client_session(con->bs);
     uint64_t i;
     int ret = 0;
     Error *local_err = NULL;
 
+    s->connect_status = nbd_client_connect(con->bs, con->saddr,
+                                           con->export, con->tlscreds,
+                                           con->hostname, &s->connect_err);
+    if (s->connect_status < 0) {
+        nbd_channel_error(s, s->connect_status);
+        return;
+    }
+
+    /* successfully connected */
+    s->state = NBD_CLIENT_CONNECTED;
+
     while (s->state != NBD_CLIENT_QUIT) {
         assert(s->reply.handle == 0);
+        s->receiving = true;
         ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
+        s->receiving = false;
         if (local_err) {
             error_report_err(local_err);
         }
@@ -964,7 +994,9 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
-    aio_co_schedule(new_context, client->connection_co);
+    if (client->receiving) {
+        aio_co_schedule(new_context, client->connection_co);
+    }
 }
 
 void nbd_client_close(BlockDriverState *bs)
@@ -1061,7 +1093,6 @@ static int nbd_client_connect(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
@@ -1076,9 +1107,28 @@ int nbd_client_init(BlockDriverState *bs,
                     Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
+    NBDConnection *con = g_new(NBDConnection, 1);
+
+    con->bs = bs;
+    con->saddr = saddr;
+    con->export = export;
+    con->tlscreds = tlscreds;
+    con->hostname = hostname;
 
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
+    client->state = NBD_CLIENT_CONNECTING_INIT;
 
-    return nbd_client_connect(bs, saddr, export, tlscreds, hostname, errp);
+    client->connection_co = qemu_coroutine_create(nbd_connection_entry, con);
+    aio_co_schedule(bdrv_get_aio_context(bs), client->connection_co);
+    BDRV_POLL_WHILE(bs, client->state == NBD_CLIENT_CONNECTING_INIT);
+
+    if (client->state != NBD_CLIENT_CONNECTED) {
+        assert(client->connect_status < 0 && client->connect_err);
+        error_propagate(errp, client->connect_err);
+        client->connect_err = NULL;
+        return client->connect_status;
+    }
+
+    return 0;
 }
-- 
2.11.1
