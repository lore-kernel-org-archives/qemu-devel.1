Received: from eggs.gnu.org ([2001:4830:134:3::10]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Uf-AE
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTp-0004Fr-2m
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:32 +0300
Message-Id: <20180731173033.75467-10-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 09/10] block/nbd-client: nbd reconnect
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

Implement reconnect. To achieve this:

1. add new modes:
   connecting-wait: means, that reconnecting is in progress, and there
     were small number of reconnect attempts, so all requests are
     waiting for the connection.
   connecting-nowait: reconnecting is in progress, there were a lot of
     attempts of reconnect, all requests will return errors.

   two old modes are used too:
   connected: normal state
   quit: exiting after fatal error or on close

Possible transitions are:

   * -> quit
   connecting-* -> connected
   connecting-wait -> connecting-nowait (transition is done after
                      reconnect-delay seconds in connecting-wait mode)
   connected -> connecting-wait

2. Implement reconnect in connection_co. So, in connecting-* mode,
    connection_co, tries to reconnect unlimited times.

3. Retry nbd queries on channel error, if we are in connecting-wait
    state.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |   4 +
 block/nbd-client.c | 304 +++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 255 insertions(+), 53 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index ef8a6a9239..52e4ec66be 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -40,6 +40,10 @@ typedef struct NBDClientSession {
     Coroutine *connection_co;
     int in_flight;
     NBDClientState state;
+    bool receiving;
+    int connect_status;
+    Error *connect_err;
+    bool wait_in_flight;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 41e6e6e702..b09907096d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -34,10 +34,26 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
 
-/* @ret would be used for reconnect in future */
+static int nbd_client_connect(BlockDriverState *bs,
+                              SocketAddress *saddr,
+                              const char *export,
+                              QCryptoTLSCreds *tlscreds,
+                              const char *hostname,
+                              const char *x_dirty_bitmap,
+                              Error **errp);
+
 static void nbd_channel_error(NBDClientSession *s, int ret)
 {
-    s->state = NBD_CLIENT_QUIT;
+    if (ret == -EIO) {
+        if (s->state == NBD_CLIENT_CONNECTED) {
+            s->state = NBD_CLIENT_CONNECTING_WAIT;
+        }
+    } else {
+        if (s->state == NBD_CLIENT_CONNECTED) {
+            qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        }
+        s->state = NBD_CLIENT_QUIT;
+    }
 }
 
 static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
@@ -57,33 +73,151 @@ static void nbd_teardown_connection(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
 
-    assert(client->ioc);
-
-    /* finish any pending coroutines */
-    qio_channel_shutdown(client->ioc,
-                         QIO_CHANNEL_SHUTDOWN_BOTH,
-                         NULL);
+    if (client->state == NBD_CLIENT_CONNECTED) {
+        /* finish any pending coroutines */
+        assert(client->ioc);
+        qio_channel_shutdown(client->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    }
+    client->state = NBD_CLIENT_QUIT;
     BDRV_POLL_WHILE(bs, client->connection_co);
+}
+
+typedef struct NBDConnection {
+    BlockDriverState *bs;
+    SocketAddress *saddr;
+    const char *export;
+    QCryptoTLSCreds *tlscreds;
+    const char *hostname;
+    const char *x_dirty_bitmap;
+    uint32_t reconnect_delay;
+} NBDConnection;
+
+static bool nbd_client_connecting(NBDClientSession *client)
+{
+    return client->state == NBD_CLIENT_CONNECTING_WAIT ||
+           client->state == NBD_CLIENT_CONNECTING_NOWAIT;
+}
+
+static bool nbd_client_connecting_wait(NBDClientSession *client)
+{
+    return client->state == NBD_CLIENT_CONNECTING_WAIT;
+}
+
+static coroutine_fn void nbd_reconnect_attempt(NBDConnection *con)
+{
+    NBDClientSession *s = nbd_get_client_session(con->bs);
+    Error *local_err = NULL;
+
+    assert(nbd_client_connecting(s));
+
+    /* Wait completion of all in-flight requests */
+
+    qemu_co_mutex_lock(&s->send_mutex);
+
+    while (s->in_flight > 0) {
+        qemu_co_mutex_unlock(&s->send_mutex);
+        nbd_recv_coroutines_wake_all(s);
+        s->wait_in_flight = true;
+        qemu_coroutine_yield();
+        s->wait_in_flight = false;
+        qemu_co_mutex_lock(&s->send_mutex);
+    }
+
+    qemu_co_mutex_unlock(&s->send_mutex);
+
+    /* Now we are sure, that nobody accessing the channel now and nobody
+     * will try to access the channel, until we set state to CONNECTED
+     */
+
+    /* Finalize previous connection if any */
+    if (s->ioc) {
+        nbd_client_detach_aio_context(con->bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc = NULL;
+        object_unref(OBJECT(s->ioc));
+        s->ioc = NULL;
+    }
+
+    s->connect_status = nbd_client_connect(con->bs, con->saddr,
+                                           con->export, con->tlscreds,
+                                           con->hostname, con->x_dirty_bitmap,
+                                           &local_err);
+    error_free(s->connect_err);
+    s->connect_err = NULL;
+    error_propagate(&s->connect_err, local_err);
+    local_err = NULL;
 
-    nbd_client_detach_aio_context(bs);
-    object_unref(OBJECT(client->sioc));
-    client->sioc = NULL;
-    object_unref(OBJECT(client->ioc));
-    client->ioc = NULL;
+    if (s->connect_status == -EINVAL) {
+        /* Protocol error or something like this, go to NBD_CLIENT_QUIT */
+        nbd_channel_error(s, s->connect_status);
+        return;
+    }
+
+    if (s->connect_status < 0) {
+        /* failed attempt */
+        return;
+    }
+
+    /* successfully connected */
+    s->state = NBD_CLIENT_CONNECTED;
+    qemu_co_queue_restart_all(&s->free_sema);
+}
+
+static coroutine_fn void nbd_reconnect_loop(NBDConnection *con)
+{
+    NBDClientSession *s = nbd_get_client_session(con->bs);
+    uint64_t start_time_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    uint64_t delay_ns = con->reconnect_delay * 1000000000UL;
+    uint64_t timeout = 1000000000UL; /* 1 sec */
+    uint64_t max_timeout = 16000000000UL; /* 16 sec */
+
+    if (!nbd_client_connecting(s)) {
+        return;
+    }
+
+    nbd_reconnect_attempt(con);
+
+    while (nbd_client_connecting(s)) {
+        if (s->state == NBD_CLIENT_CONNECTING_WAIT &&
+            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay_ns)
+        {
+            s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+            qemu_co_queue_restart_all(&s->free_sema);
+        }
+
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, timeout);
+        if (timeout < max_timeout) {
+            timeout *= 2;
+        }
+
+        nbd_reconnect_attempt(con);
+    }
 }
 
 static coroutine_fn void nbd_connection_entry(void *opaque)
 {
-    NBDClientSession *s = opaque;
+    NBDConnection *con = opaque;
+    NBDClientSession *s = nbd_get_client_session(con->bs);
     uint64_t i;
     int ret = 0;
     Error *local_err = NULL;
 
     while (s->state != NBD_CLIENT_QUIT) {
+        if (nbd_client_connecting(s)) {
+            nbd_reconnect_loop(con);
+        }
+
+        if (s->state != NBD_CLIENT_CONNECTED) {
+            continue;
+        }
+
+        s->receiving = true;
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
+        s->receiving = false;
         if (local_err) {
             error_report_err(local_err);
+            local_err = NULL;
         }
         if (ret <= 0) {
             nbd_channel_error(s, ret ? ret : -EIO);
@@ -119,8 +253,18 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
+    qemu_co_queue_restart_all(&s->free_sema);
     nbd_recv_coroutines_wake_all(s);
     s->connection_co = NULL;
+    if (s->ioc) {
+        nbd_client_detach_aio_context(con->bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc = NULL;
+        object_unref(OBJECT(s->ioc));
+        s->ioc = NULL;
+    }
+
+    g_free(con);
 }
 
 static int nbd_co_send_request(BlockDriverState *bs,
@@ -131,7 +275,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     int rc, i = -1;
 
     qemu_co_mutex_lock(&s->send_mutex);
-    while (s->in_flight == MAX_NBD_REQUESTS) {
+    while (s->in_flight == MAX_NBD_REQUESTS || nbd_client_connecting_wait(s)) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }
 
@@ -182,7 +326,11 @@ err:
             s->requests[i].coroutine = NULL;
             s->in_flight--;
         }
-        qemu_co_queue_next(&s->free_sema);
+        if (s->in_flight == 0 && s->wait_in_flight) {
+            aio_co_wake(s->connection_co);
+        } else {
+            qemu_co_queue_next(&s->free_sema);
+        }
     }
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;
@@ -521,10 +669,13 @@ static coroutine_fn int nbd_co_receive_one_chunk(
         if (reply) {
             *reply = s->reply;
         }
-        s->reply.handle = 0;
     }
+    s->reply.handle = 0;
 
-    if (s->connection_co) {
+    if (s->connection_co && !s->wait_in_flight) {
+        /* We must check s->wait_in_flight, because we may entered by
+         * nbd_recv_coroutines_wake_all(), in this case we should not
+         * wake connection_co here, it will woken by last request. */
         aio_co_wake(s->connection_co);
     }
 
@@ -632,7 +783,11 @@ break_loop:
 
     qemu_co_mutex_lock(&s->send_mutex);
     s->in_flight--;
-    qemu_co_queue_next(&s->free_sema);
+    if (s->in_flight == 0 && s->wait_in_flight) {
+        aio_co_wake(s->connection_co);
+    } else {
+        qemu_co_queue_next(&s->free_sema);
+    }
     qemu_co_mutex_unlock(&s->send_mutex);
 
     return false;
@@ -781,16 +936,21 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
     } else {
         assert(request->type != NBD_CMD_WRITE);
     }
-    ret = nbd_co_send_request(bs, request, write_qiov);
-    if (ret < 0) {
-        return ret;
-    }
 
-    ret = nbd_co_receive_return_code(client, request->handle,
-                                     &request_ret, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-    }
+    do {
+        ret = nbd_co_send_request(bs, request, write_qiov);
+        if (ret < 0) {
+            continue;
+        }
+
+        ret = nbd_co_receive_return_code(client, request->handle,
+                                         &request_ret, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(client));
+
     return ret ? ret : request_ret;
 }
 
@@ -812,16 +972,21 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     if (!bytes) {
         return 0;
     }
-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        return ret;
-    }
 
-    ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
-                                       &request_ret, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-    }
+    do {
+        ret = nbd_co_send_request(bs, &request, NULL);
+        if (ret < 0) {
+            continue;
+        }
+
+        ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
+                                           &request_ret, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(client));
+
     return ret ? ret : request_ret;
 }
 
@@ -935,16 +1100,21 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
         return BDRV_BLOCK_DATA;
     }
 
-    ret = nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        return ret;
-    }
+    do {
+        ret = nbd_co_send_request(bs, &request, NULL);
+        if (ret < 0) {
+            continue;
+        }
+
+        ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
+                                               &extent, &request_ret,
+                                               &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(client));
 
-    ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
-                                           &extent, &request_ret, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-    }
     if (ret < 0 || request_ret < 0) {
         return ret ? ret : request_ret;
     }
@@ -966,7 +1136,15 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
-    aio_co_schedule(new_context, client->connection_co);
+    if (client->receiving) {
+        /* We schedule connection_co only if it is waiting for read from the
+         * channel. We should not schedule it if it is some other yield, and if
+         * it is currently executing (we call nbd_client_attach_aio_context from
+         * connection code).
+         */
+
+        aio_co_schedule(new_context, client->connection_co);
+    }
 }
 
 void nbd_client_close(BlockDriverState *bs)
@@ -974,9 +1152,9 @@ void nbd_client_close(BlockDriverState *bs)
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = { .type = NBD_CMD_DISC };
 
-    assert(client->ioc);
-
-    nbd_send_request(client->ioc, &request);
+    if (client->ioc) {
+        nbd_send_request(client->ioc, &request);
+    }
 
     nbd_teardown_connection(bs);
 }
@@ -1066,7 +1244,6 @@ static int nbd_client_connect(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
@@ -1082,11 +1259,32 @@ int nbd_client_init(BlockDriverState *bs,
                     uint32_t reconnect_delay,
                     Error **errp)
 {
+    int ret;
     NBDClientSession *client = nbd_get_client_session(bs);
+    NBDConnection *con;
 
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
 
-    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
-                              x_dirty_bitmap, errp);
+    ret = nbd_client_connect(bs, saddr, export, tlscreds, hostname,
+                             x_dirty_bitmap, errp);
+    if (ret < 0) {
+        return ret;
+    }
+    /* successfully connected */
+    client->state = NBD_CLIENT_CONNECTED;
+
+    con = g_new(NBDConnection, 1);
+    con->bs = bs;
+    con->saddr = saddr;
+    con->export = export;
+    con->tlscreds = tlscreds;
+    con->hostname = hostname;
+    con->x_dirty_bitmap = x_dirty_bitmap;
+    con->reconnect_delay = reconnect_delay;
+
+    client->connection_co = qemu_coroutine_create(nbd_connection_entry, con);
+    aio_co_schedule(bdrv_get_aio_context(bs), client->connection_co);
+
+    return 0;
 }
-- 
2.11.1
