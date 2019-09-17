Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3FDC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39962053B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39962053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAH9R-00049e-1O
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAH2k-0006sr-KF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAH2i-00036O-4m
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:13:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:55312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAH2c-000302-ND; Tue, 17 Sep 2019 13:13:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAH2Z-0003rq-RC; Tue, 17 Sep 2019 20:13:23 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 20:13:21 +0300
Message-Id: <20190917171322.4127-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917171322.4127-1-vsementsov@virtuozzo.com>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 2/3] block/nbd: nbd reconnect
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
 block/nbd.c | 332 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 269 insertions(+), 63 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 813c40d8f0..bec01d85c7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Block driver for  NBD
  *
+ * Copyright (c) 2019 Virtuozzo International GmbH.
  * Copyright (C) 2016 Red Hat, Inc.
  * Copyright (C) 2008 Bull S.A.S.
  *     Author: Laurent Vivier <Laurent.Vivier@bull.net>
@@ -55,6 +56,8 @@ typedef struct {
 } NBDClientRequest;
 
 typedef enum NBDClientState {
+    NBD_CLIENT_CONNECTING_WAIT,
+    NBD_CLIENT_CONNECTING_NOWAIT,
     NBD_CLIENT_CONNECTED,
     NBD_CLIENT_QUIT
 } NBDClientState;
@@ -67,8 +70,14 @@ typedef struct BDRVNBDState {
     CoMutex send_mutex;
     CoQueue free_sema;
     Coroutine *connection_co;
+    QemuCoSleepState *connection_co_sleep_ns_state;
+    bool drained;
+    bool wait_drained_end;
     int in_flight;
     NBDClientState state;
+    int connect_status;
+    Error *connect_err;
+    bool wait_in_flight;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
@@ -83,10 +92,21 @@ typedef struct BDRVNBDState {
     char *x_dirty_bitmap;
 } BDRVNBDState;
 
-/* @ret will be used for reconnect in future */
+static int nbd_client_connect(BlockDriverState *bs, Error **errp);
+
 static void nbd_channel_error(BDRVNBDState *s, int ret)
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
 
 static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
@@ -129,7 +149,13 @@ static void nbd_client_attach_aio_context(BlockDriverState *bs,
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
-    qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
+    /*
+     * s->connection_co is either yielded from nbd_receive_reply or from
+     * nbd_reconnect_loop()
+     */
+    if (s->state == NBD_CLIENT_CONNECTED) {
+        qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
+    }
 
     bdrv_inc_in_flight(bs);
 
@@ -140,24 +166,151 @@ static void nbd_client_attach_aio_context(BlockDriverState *bs,
     aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, bs);
 }
 
+static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
+{
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
-static void nbd_teardown_connection(BlockDriverState *bs)
+    s->drained = true;
+    if (s->connection_co_sleep_ns_state) {
+        qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
+    }
+}
+
+static void coroutine_fn nbd_client_co_drain_end(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
-    assert(s->ioc);
+    s->drained = false;
+    if (s->wait_drained_end) {
+        s->wait_drained_end = false;
+        aio_co_wake(s->connection_co);
+    }
+}
+
 
-    /* finish any pending coroutines */
-    qio_channel_shutdown(s->ioc,
-                         QIO_CHANNEL_SHUTDOWN_BOTH,
-                         NULL);
+static void nbd_teardown_connection(BlockDriverState *bs)
+{
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+
+    if (s->state == NBD_CLIENT_CONNECTED) {
+        /* finish any pending coroutines */
+        assert(s->ioc);
+        qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    }
+    s->state = NBD_CLIENT_QUIT;
+    if (s->connection_co) {
+        if (s->connection_co_sleep_ns_state) {
+            qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
+        }
+    }
     BDRV_POLL_WHILE(bs, s->connection_co);
+}
 
-    nbd_client_detach_aio_context(bs);
-    object_unref(OBJECT(s->sioc));
-    s->sioc = NULL;
-    object_unref(OBJECT(s->ioc));
-    s->ioc = NULL;
+static bool nbd_client_connecting(BDRVNBDState *s)
+{
+    return s->state == NBD_CLIENT_CONNECTING_WAIT ||
+        s->state == NBD_CLIENT_CONNECTING_NOWAIT;
+}
+
+static bool nbd_client_connecting_wait(BDRVNBDState *s)
+{
+    return s->state == NBD_CLIENT_CONNECTING_WAIT;
+}
+
+static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
+{
+    Error *local_err = NULL;
+
+    if (!nbd_client_connecting(s)) {
+        return;
+    }
+
+    /* Wait for completion of all in-flight requests */
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
+    if (!nbd_client_connecting(s)) {
+        return;
+    }
+
+    /*
+     * Now we are sure that nobody is accessing the channel, and no one will
+     * try until we set the state to CONNECTED.
+     */
+
+    /* Finalize previous connection if any */
+    if (s->ioc) {
+        nbd_client_detach_aio_context(s->bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc = NULL;
+        object_unref(OBJECT(s->ioc));
+        s->ioc = NULL;
+    }
+
+    s->connect_status = nbd_client_connect(s->bs, &local_err);
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
+static coroutine_fn void nbd_reconnect_loop(BDRVNBDState *s)
+{
+    uint64_t start_time_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    uint64_t delay_ns = s->reconnect_delay * NANOSECONDS_PER_SECOND;
+    uint64_t timeout = 1 * NANOSECONDS_PER_SECOND;
+    uint64_t max_timeout = 16 * NANOSECONDS_PER_SECOND;
+
+    nbd_reconnect_attempt(s);
+
+    while (nbd_client_connecting(s)) {
+        if (s->state == NBD_CLIENT_CONNECTING_WAIT &&
+            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay_ns)
+        {
+            s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+            qemu_co_queue_restart_all(&s->free_sema);
+        }
+
+        qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
+                                  &s->connection_co_sleep_ns_state);
+        if (s->drained) {
+            bdrv_dec_in_flight(s->bs);
+            s->wait_drained_end = true;
+            while (s->drained) {
+                /*
+                 * We may be entered once from nbd_client_attach_aio_context_bh
+                 * and then from nbd_client_co_drain_end. So here is a loop.
+                 */
+                qemu_coroutine_yield();
+            }
+            bdrv_inc_in_flight(s->bs);
+        }
+        if (timeout < max_timeout) {
+            timeout *= 2;
+        }
+
+        nbd_reconnect_attempt(s);
+    }
 }
 
 static coroutine_fn void nbd_connection_entry(void *opaque)
@@ -177,16 +330,26 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
          * Therefore we keep an additional in_flight reference all the time and
          * only drop it temporarily here.
          */
+
+        if (nbd_client_connecting(s)) {
+            nbd_reconnect_loop(s);
+        }
+
+        if (s->state != NBD_CLIENT_CONNECTED) {
+            continue;
+        }
+
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err);
 
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
 
         /*
@@ -201,7 +364,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
             (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
         {
             nbd_channel_error(s, -EINVAL);
-            break;
+            continue;
         }
 
         /*
@@ -220,10 +383,19 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
+    qemu_co_queue_restart_all(&s->free_sema);
     nbd_recv_coroutines_wake_all(s);
     bdrv_dec_in_flight(s->bs);
 
     s->connection_co = NULL;
+    if (s->ioc) {
+        nbd_client_detach_aio_context(s->bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc = NULL;
+        object_unref(OBJECT(s->ioc));
+        s->ioc = NULL;
+    }
+
     aio_wait_kick();
 }
 
@@ -235,7 +407,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     int rc, i = -1;
 
     qemu_co_mutex_lock(&s->send_mutex);
-    while (s->in_flight == MAX_NBD_REQUESTS) {
+    while (s->in_flight == MAX_NBD_REQUESTS || nbd_client_connecting_wait(s)) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }
 
@@ -286,7 +458,11 @@ err:
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
@@ -666,10 +842,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
     } else {
         /* For assert at loop start in nbd_connection_entry */
         *reply = s->reply;
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
 
@@ -781,7 +962,11 @@ break_loop:
 
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
@@ -927,20 +1112,26 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
     } else {
         assert(request->type != NBD_CMD_WRITE);
     }
-    ret = nbd_co_send_request(bs, request, write_qiov);
-    if (ret < 0) {
-        return ret;
-    }
 
-    ret = nbd_co_receive_return_code(s, request->handle,
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
+        ret = nbd_co_receive_return_code(s, request->handle,
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
+    } while (ret < 0 && nbd_client_connecting_wait(s));
+
     return ret ? ret : request_ret;
 }
 
@@ -981,20 +1172,24 @@ static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
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
+        ret = nbd_co_receive_cmdread_reply(s, request.handle, offset, qiov,
+                                           &request_ret, &local_err);
+        if (local_err) {
+            trace_nbd_co_request_fail(request.from, request.len, request.handle,
+                                      request.flags, request.type,
+                                      nbd_cmd_lookup(request.type),
+                                      ret, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(s));
 
-    ret = nbd_co_receive_cmdread_reply(s, request.handle, offset, qiov,
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
 
@@ -1131,20 +1326,25 @@ static int coroutine_fn nbd_client_co_block_status(
     if (s->info.min_block) {
         assert(QEMU_IS_ALIGNED(request.len, s->info.min_block));
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
+        ret = nbd_co_receive_blockstatus_reply(s, request.handle, bytes,
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
+    } while (ret < 0 && nbd_client_connecting_wait(s));
 
-    ret = nbd_co_receive_blockstatus_reply(s, request.handle, bytes,
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
@@ -1163,9 +1363,9 @@ static void nbd_client_close(BlockDriverState *bs)
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = { .type = NBD_CMD_DISC };
 
-    assert(s->ioc);
-
-    nbd_send_request(s->ioc, &request);
+    if (s->ioc) {
+        nbd_send_request(s->ioc, &request);
+    }
 
     nbd_teardown_connection(bs);
 }
@@ -1808,6 +2008,8 @@ static BlockDriver bdrv_nbd = {
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
+    .bdrv_co_drain_begin        = nbd_client_co_drain_begin,
+    .bdrv_co_drain_end          = nbd_client_co_drain_end,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
     .bdrv_dirname               = nbd_dirname,
@@ -1830,6 +2032,8 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
+    .bdrv_co_drain_begin        = nbd_client_co_drain_begin,
+    .bdrv_co_drain_end          = nbd_client_co_drain_end,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
     .bdrv_dirname               = nbd_dirname,
@@ -1852,6 +2056,8 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
+    .bdrv_co_drain_begin        = nbd_client_co_drain_begin,
+    .bdrv_co_drain_end          = nbd_client_co_drain_end,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
     .bdrv_dirname               = nbd_dirname,
-- 
2.21.0


