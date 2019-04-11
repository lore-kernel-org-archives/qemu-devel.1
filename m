Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F2C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521262084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521262084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdWF-0006Ix-DG
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:29:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTo-0004ZZ-Co
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003c4-Rn
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:16 -0400
Received: from relay.sw.ru ([185.231.240.75]:59366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTl-0003Zy-9h; Thu, 11 Apr 2019 13:27:13 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTj-00044D-8X; Thu, 11 Apr 2019 20:27:11 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 11 Apr 2019 20:27:08 +0300
Message-Id: <20190411172709.205032-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411172708.N_L2OcT6Ekdo64MDlIFKQU0tjB3SbJiBm4Qyfivb4x4@z>

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
 block/nbd-client.h |   7 +
 block/nbd-client.c | 336 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 273 insertions(+), 70 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 91a6b32bdd..f366c90e5e 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -24,6 +24,8 @@ typedef struct {
 } NBDClientRequest;
 
 typedef enum NBDClientState {
+    NBD_CLIENT_CONNECTING_WAIT,
+    NBD_CLIENT_CONNECTING_NOWAIT,
     NBD_CLIENT_CONNECTED,
     NBD_CLIENT_QUIT
 } NBDClientState;
@@ -38,10 +40,15 @@ typedef struct NBDClientSession {
     Coroutine *connection_co;
     int in_flight;
     NBDClientState state;
+    int connect_status;
+    Error *connect_err;
+    bool wait_in_flight;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     BlockDriverState *bs;
+
+    uint32_t reconnect_delay;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1359aff162..b829a1a1bd 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Block driver for  NBD
  *
+ * Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
  * Copyright (C) 2016 Red Hat, Inc.
  * Copyright (C) 2008 Bull S.A.S.
  *     Author: Laurent Vivier <Laurent.Vivier@bull.net>
@@ -36,10 +37,27 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
 
-/* @ret will be used for reconnect in future */
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
+            s->state = s->reconnect_delay ? NBD_CLIENT_CONNECTING_WAIT :
+                                            NBD_CLIENT_CONNECTING_NOWAIT;
+        }
+    } else {
+        if (s->state == NBD_CLIENT_CONNECTED) {
+            qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        }
+        s->state = NBD_CLIENT_QUIT;
+    }
 }
 
 static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
@@ -59,24 +77,133 @@ static void nbd_teardown_connection(BlockDriverState *bs)
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
+    if (client->connection_co) {
+        qemu_co_sleep_wake(client->connection_co);
+    }
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
+    if (!nbd_client_connecting(s)) {
+        return;
+    }
+    assert(nbd_client_connecting(s));
+
+    /* Wait completion of all in-flight requests */
+
+    qemu_co_mutex_lock(&s->send_mutex);
 
-    nbd_client_detach_aio_context(bs);
-    object_unref(OBJECT(client->sioc));
-    client->sioc = NULL;
-    object_unref(OBJECT(client->ioc));
-    client->ioc = NULL;
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
+    if (!nbd_client_connecting(s)) {
+        return;
+    }
+
+    /*
+     * Now we are sure, that nobody accessing the channel now and nobody
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
+    uint64_t delay_ns = s->reconnect_delay * 1000000000UL;
+    uint64_t timeout = 1000000000UL; /* 1 sec */
+    uint64_t max_timeout = 16000000000UL; /* 16 sec */
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
+        bdrv_dec_in_flight(con->bs);
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, timeout);
+        bdrv_inc_in_flight(con->bs);
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
@@ -91,16 +218,25 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
          * Therefore we keep an additional in_flight reference all the time and
          * only drop it temporarily here.
          */
+
+        if (nbd_client_connecting(s)) {
+            nbd_reconnect_loop(con);
+        }
+
+        if (s->state != NBD_CLIENT_CONNECTED) {
+            continue;
+        }
+
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err);
-
         if (local_err) {
             trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_err));
             error_free(local_err);
+            local_err = NULL;
         }
         if (ret <= 0) {
             nbd_channel_error(s, ret ? ret : -EIO);
-            break;
+            continue;
         }
 
         /* There's no need for a mutex on the receive side, because the
@@ -114,7 +250,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
             (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
         {
             nbd_channel_error(s, -EINVAL);
-            break;
+            continue;
         }
 
         /* We're woken up again by the request itself.  Note that there
@@ -132,10 +268,21 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
+    qemu_co_queue_restart_all(&s->free_sema);
     nbd_recv_coroutines_wake_all(s);
     bdrv_dec_in_flight(s->bs);
 
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
+
     aio_wait_kick();
 }
 
@@ -147,7 +294,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     int rc, i = -1;
 
     qemu_co_mutex_lock(&s->send_mutex);
-    while (s->in_flight == MAX_NBD_REQUESTS) {
+    while (s->in_flight == MAX_NBD_REQUESTS || nbd_client_connecting_wait(s)) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }
 
@@ -198,7 +345,11 @@ err:
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
@@ -577,10 +728,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
         if (reply) {
             *reply = s->reply;
         }
-        s->reply.handle = 0;
     }
+    s->reply.handle = 0;
 
-    if (s->connection_co) {
+    if (s->connection_co && !s->wait_in_flight) {
+        /*
+         * We must check s->wait_in_flight, because we may entered by
+         * nbd_recv_coroutines_wake_all(), in this case we should not
+         * wake connection_co here, it will woken by last request.
+         */
         aio_co_wake(s->connection_co);
     }
 
@@ -688,7 +844,11 @@ break_loop:
 
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
@@ -832,20 +992,26 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
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
-        trace_nbd_co_request_fail(request->from, request->len, request->handle,
-                                  request->flags, request->type,
-                                  nbd_cmd_lookup(request->type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
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
+            trace_nbd_co_request_fail(request->from, request->len,
+                                      request->handle, request->flags,
+                                      request->type,
+                                      nbd_cmd_lookup(request->type),
+                                      ret, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(client));
+
     return ret ? ret : request_ret;
 }
 
@@ -886,20 +1052,24 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
         request.len -= slop;
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
+        ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
+                                           &request_ret, &local_err);
+        if (local_err) {
+            trace_nbd_co_request_fail(request.from, request.len, request.handle,
+                                      request.flags, request.type,
+                                      nbd_cmd_lookup(request.type),
+                                      ret, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(client));
 
-    ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
-                                       &request_ret, &local_err);
-    if (local_err) {
-        trace_nbd_co_request_fail(request.from, request.len, request.handle,
-                                  request.flags, request.type,
-                                  nbd_cmd_lookup(request.type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
     return ret ? ret : request_ret;
 }
 
@@ -1033,20 +1203,25 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
     if (client->info.min_block) {
         assert(QEMU_IS_ALIGNED(request.len, client->info.min_block));
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
+            trace_nbd_co_request_fail(request.from, request.len, request.handle,
+                                      request.flags, request.type,
+                                      nbd_cmd_lookup(request.type),
+                                      ret, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(client));
 
-    ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
-                                           &extent, &request_ret, &local_err);
-    if (local_err) {
-        trace_nbd_co_request_fail(request.from, request.len, request.handle,
-                                  request.flags, request.type,
-                                  nbd_cmd_lookup(request.type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
     if (ret < 0 || request_ret < 0) {
         return ret ? ret : request_ret;
     }
@@ -1083,13 +1258,22 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
-    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
 
-    bdrv_inc_in_flight(bs);
+    /*
+     * client->connection_co is either yielded from nbd_receive_reply or from
+     * nbd_reconnect_loop(), in latter case we do nothing
+     */
+    if (client->state == NBD_CLIENT_CONNECTED) {
+        qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
 
-    /* Need to wait here for the BH to run because the BH must run while the
-     * node is still drained. */
-    aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, bs);
+        bdrv_inc_in_flight(bs);
+
+        /*
+         * Need to wait here for the BH to run because the BH must run while the
+         * node is still drained.
+         */
+        aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, bs);
+    }
 }
 
 void nbd_client_close(BlockDriverState *bs)
@@ -1097,9 +1281,9 @@ void nbd_client_close(BlockDriverState *bs)
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
@@ -1223,6 +1407,7 @@ int nbd_client_init(BlockDriverState *bs,
 {
     int ret;
     NBDClientSession *client = nbd_get_client_session(bs);
+    NBDConnection *con;
 
     client->bs = bs;
     qemu_co_mutex_init(&client->send_mutex);
@@ -1233,8 +1418,19 @@ int nbd_client_init(BlockDriverState *bs,
     if (ret < 0) {
         return ret;
     }
+    /* successfully connected */
+    client->state = NBD_CLIENT_CONNECTED;
+    client->reconnect_delay = reconnect_delay;
+
+    con = g_new(NBDConnection, 1);
+    con->bs = bs;
+    con->saddr = saddr;
+    con->export = export;
+    con->tlscreds = tlscreds;
+    con->hostname = hostname;
+    con->x_dirty_bitmap = x_dirty_bitmap;
 
-    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
+    client->connection_co = qemu_coroutine_create(nbd_connection_entry, con);
     bdrv_inc_in_flight(bs);
     aio_co_schedule(bdrv_get_aio_context(bs), client->connection_co);
 
-- 
2.18.0


