Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451D22086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP2ieu2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451D22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN60R-00039E-1y
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 22:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN5y3-00016O-Mi
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN5y1-0008OT-12
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN5xz-0008Nr-Jv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571796098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+/+KQzdqlCZEETYsjEJxlTvCGoZH1253i36CtRhB7Y=;
 b=RP2ieu2U5d4HQmfi2bPi2BghgU98m8PsSBWfdzLXPX4AgZlPJk05iu/R4EeFMKEOpuGUZf
 kLqvFzYvKrQ0V0oC6EQN+zJUHKEpoTZgwrO+lu/48ei1cgviiWE/x/+/oiwFNnHzB2B0Is
 pi2MFCGcyMwLPaw1bHNn7xLNFsrWycw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-wRjBojW-P3WtpqfDlfFLTQ-1; Tue, 22 Oct 2019 22:01:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E85F81800D6A;
 Wed, 23 Oct 2019 02:01:33 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58A1560161;
 Wed, 23 Oct 2019 02:01:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] block/nbd: nbd reconnect
Date: Tue, 22 Oct 2019 21:01:25 -0500
Message-Id: <20191023020126.24991-3-eblake@redhat.com>
In-Reply-To: <20191023020126.24991-1-eblake@redhat.com>
References: <20191023020126.24991-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wRjBojW-P3WtpqfDlfFLTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
Message-Id: <20191009084158.15614-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 331 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 268 insertions(+), 63 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index fd78e5f33055..123976171cf4 100644
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
-    s->state =3D NBD_CLIENT_QUIT;
+    if (ret =3D=3D -EIO) {
+        if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+            s->state =3D s->reconnect_delay ? NBD_CLIENT_CONNECTING_WAIT :
+                                            NBD_CLIENT_CONNECTING_NOWAIT;
+        }
+    } else {
+        if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+            qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        }
+        s->state =3D NBD_CLIENT_QUIT;
+    }
 }

 static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
@@ -129,7 +149,13 @@ static void nbd_client_attach_aio_context(BlockDriverS=
tate *bs,
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

-    qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
+    /*
+     * s->connection_co is either yielded from nbd_receive_reply or from
+     * nbd_co_reconnect_loop()
+     */
+    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
+    }

     bdrv_inc_in_flight(bs);

@@ -140,24 +166,150 @@ static void nbd_client_attach_aio_context(BlockDrive=
rState *bs,
     aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, bs)=
;
 }

+static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
+{
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    s->drained =3D true;
+    if (s->connection_co_sleep_ns_state) {
+        qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
+    }
+}
+
+static void coroutine_fn nbd_client_co_drain_end(BlockDriverState *bs)
+{
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    s->drained =3D false;
+    if (s->wait_drained_end) {
+        s->wait_drained_end =3D false;
+        aio_co_wake(s->connection_co);
+    }
+}
+

 static void nbd_teardown_connection(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

-    assert(s->ioc);
-
-    /* finish any pending coroutines */
-    qio_channel_shutdown(s->ioc,
-                         QIO_CHANNEL_SHUTDOWN_BOTH,
-                         NULL);
+    if (s->state =3D=3D NBD_CLIENT_CONNECTED) {
+        /* finish any pending coroutines */
+        assert(s->ioc);
+        qio_channel_shutdown(s->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    }
+    s->state =3D NBD_CLIENT_QUIT;
+    if (s->connection_co) {
+        if (s->connection_co_sleep_ns_state) {
+            qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
+        }
+    }
     BDRV_POLL_WHILE(bs, s->connection_co);
+}

-    nbd_client_detach_aio_context(bs);
-    object_unref(OBJECT(s->sioc));
-    s->sioc =3D NULL;
-    object_unref(OBJECT(s->ioc));
-    s->ioc =3D NULL;
+static bool nbd_client_connecting(BDRVNBDState *s)
+{
+    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
+        s->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
+}
+
+static bool nbd_client_connecting_wait(BDRVNBDState *s)
+{
+    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT;
+}
+
+static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
+{
+    Error *local_err =3D NULL;
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
+        s->wait_in_flight =3D true;
+        qemu_coroutine_yield();
+        s->wait_in_flight =3D false;
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
+     * Now we are sure that nobody is accessing the channel, and no one wi=
ll
+     * try until we set the state to CONNECTED.
+     */
+
+    /* Finalize previous connection if any */
+    if (s->ioc) {
+        nbd_client_detach_aio_context(s->bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc =3D NULL;
+        object_unref(OBJECT(s->ioc));
+        s->ioc =3D NULL;
+    }
+
+    s->connect_status =3D nbd_client_connect(s->bs, &local_err);
+    error_free(s->connect_err);
+    s->connect_err =3D NULL;
+    error_propagate(&s->connect_err, local_err);
+
+    if (s->connect_status < 0) {
+        /* failed attempt */
+        return;
+    }
+
+    /* successfully connected */
+    s->state =3D NBD_CLIENT_CONNECTED;
+    qemu_co_queue_restart_all(&s->free_sema);
+}
+
+static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
+{
+    uint64_t start_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    uint64_t delay_ns =3D s->reconnect_delay * NANOSECONDS_PER_SECOND;
+    uint64_t timeout =3D 1 * NANOSECONDS_PER_SECOND;
+    uint64_t max_timeout =3D 16 * NANOSECONDS_PER_SECOND;
+
+    nbd_reconnect_attempt(s);
+
+    while (nbd_client_connecting(s)) {
+        if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
+            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay=
_ns)
+        {
+            s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
+            qemu_co_queue_restart_all(&s->free_sema);
+        }
+
+        qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
+                                  &s->connection_co_sleep_ns_state);
+        if (s->drained) {
+            bdrv_dec_in_flight(s->bs);
+            s->wait_drained_end =3D true;
+            while (s->drained) {
+                /*
+                 * We may be entered once from nbd_client_attach_aio_conte=
xt_bh
+                 * and then from nbd_client_co_drain_end. So here is a loo=
p.
+                 */
+                qemu_coroutine_yield();
+            }
+            bdrv_inc_in_flight(s->bs);
+        }
+        if (timeout < max_timeout) {
+            timeout *=3D 2;
+        }
+
+        nbd_reconnect_attempt(s);
+    }
 }

 static coroutine_fn void nbd_connection_entry(void *opaque)
@@ -177,16 +329,26 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
          * Therefore we keep an additional in_flight reference all the tim=
e and
          * only drop it temporarily here.
          */
+
+        if (nbd_client_connecting(s)) {
+            nbd_co_reconnect_loop(s);
+        }
+
+        if (s->state !=3D NBD_CLIENT_CONNECTED) {
+            continue;
+        }
+
         assert(s->reply.handle =3D=3D 0);
         ret =3D nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err);

         if (local_err) {
             trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_er=
r));
             error_free(local_err);
+            local_err =3D NULL;
         }
         if (ret <=3D 0) {
             nbd_channel_error(s, ret ? ret : -EIO);
-            break;
+            continue;
         }

         /*
@@ -201,7 +363,7 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
             (nbd_reply_is_structured(&s->reply) && !s->info.structured_rep=
ly))
         {
             nbd_channel_error(s, -EINVAL);
-            break;
+            continue;
         }

         /*
@@ -220,10 +382,19 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
         qemu_coroutine_yield();
     }

+    qemu_co_queue_restart_all(&s->free_sema);
     nbd_recv_coroutines_wake_all(s);
     bdrv_dec_in_flight(s->bs);

     s->connection_co =3D NULL;
+    if (s->ioc) {
+        nbd_client_detach_aio_context(s->bs);
+        object_unref(OBJECT(s->sioc));
+        s->sioc =3D NULL;
+        object_unref(OBJECT(s->ioc));
+        s->ioc =3D NULL;
+    }
+
     aio_wait_kick();
 }

@@ -235,7 +406,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     int rc, i =3D -1;

     qemu_co_mutex_lock(&s->send_mutex);
-    while (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
+    while (s->in_flight =3D=3D MAX_NBD_REQUESTS || nbd_client_connecting_w=
ait(s)) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }

@@ -286,7 +457,11 @@ err:
             s->requests[i].coroutine =3D NULL;
             s->in_flight--;
         }
-        qemu_co_queue_next(&s->free_sema);
+        if (s->in_flight =3D=3D 0 && s->wait_in_flight) {
+            aio_co_wake(s->connection_co);
+        } else {
+            qemu_co_queue_next(&s->free_sema);
+        }
     }
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;
@@ -666,10 +841,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
     } else {
         /* For assert at loop start in nbd_connection_entry */
         *reply =3D s->reply;
-        s->reply.handle =3D 0;
     }
+    s->reply.handle =3D 0;

-    if (s->connection_co) {
+    if (s->connection_co && !s->wait_in_flight) {
+        /*
+         * We must check s->wait_in_flight, because we may entered by
+         * nbd_recv_coroutines_wake_all(), in this case we should not
+         * wake connection_co here, it will woken by last request.
+         */
         aio_co_wake(s->connection_co);
     }

@@ -781,7 +961,11 @@ break_loop:

     qemu_co_mutex_lock(&s->send_mutex);
     s->in_flight--;
-    qemu_co_queue_next(&s->free_sema);
+    if (s->in_flight =3D=3D 0 && s->wait_in_flight) {
+        aio_co_wake(s->connection_co);
+    } else {
+        qemu_co_queue_next(&s->free_sema);
+    }
     qemu_co_mutex_unlock(&s->send_mutex);

     return false;
@@ -927,20 +1111,26 @@ static int nbd_co_request(BlockDriverState *bs, NBDR=
equest *request,
     } else {
         assert(request->type !=3D NBD_CMD_WRITE);
     }
-    ret =3D nbd_co_send_request(bs, request, write_qiov);
-    if (ret < 0) {
-        return ret;
-    }

-    ret =3D nbd_co_receive_return_code(s, request->handle,
-                                     &request_ret, &local_err);
-    if (local_err) {
-        trace_nbd_co_request_fail(request->from, request->len, request->ha=
ndle,
-                                  request->flags, request->type,
-                                  nbd_cmd_lookup(request->type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
+    do {
+        ret =3D nbd_co_send_request(bs, request, write_qiov);
+        if (ret < 0) {
+            continue;
+        }
+
+        ret =3D nbd_co_receive_return_code(s, request->handle,
+                                         &request_ret, &local_err);
+        if (local_err) {
+            trace_nbd_co_request_fail(request->from, request->len,
+                                      request->handle, request->flags,
+                                      request->type,
+                                      nbd_cmd_lookup(request->type),
+                                      ret, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err =3D NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(s));
+
     return ret ? ret : request_ret;
 }

@@ -981,20 +1171,24 @@ static int nbd_client_co_preadv(BlockDriverState *bs=
, uint64_t offset,
         request.len -=3D slop;
     }

-    ret =3D nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        return ret;
-    }
+    do {
+        ret =3D nbd_co_send_request(bs, &request, NULL);
+        if (ret < 0) {
+            continue;
+        }
+
+        ret =3D nbd_co_receive_cmdread_reply(s, request.handle, offset, qi=
ov,
+                                           &request_ret, &local_err);
+        if (local_err) {
+            trace_nbd_co_request_fail(request.from, request.len, request.h=
andle,
+                                      request.flags, request.type,
+                                      nbd_cmd_lookup(request.type),
+                                      ret, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err =3D NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(s));

-    ret =3D nbd_co_receive_cmdread_reply(s, request.handle, offset, qiov,
-                                       &request_ret, &local_err);
-    if (local_err) {
-        trace_nbd_co_request_fail(request.from, request.len, request.handl=
e,
-                                  request.flags, request.type,
-                                  nbd_cmd_lookup(request.type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
     return ret ? ret : request_ret;
 }

@@ -1131,20 +1325,25 @@ static int coroutine_fn nbd_client_co_block_status(
     if (s->info.min_block) {
         assert(QEMU_IS_ALIGNED(request.len, s->info.min_block));
     }
-    ret =3D nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        return ret;
-    }
+    do {
+        ret =3D nbd_co_send_request(bs, &request, NULL);
+        if (ret < 0) {
+            continue;
+        }
+
+        ret =3D nbd_co_receive_blockstatus_reply(s, request.handle, bytes,
+                                               &extent, &request_ret,
+                                               &local_err);
+        if (local_err) {
+            trace_nbd_co_request_fail(request.from, request.len, request.h=
andle,
+                                      request.flags, request.type,
+                                      nbd_cmd_lookup(request.type),
+                                      ret, error_get_pretty(local_err));
+            error_free(local_err);
+            local_err =3D NULL;
+        }
+    } while (ret < 0 && nbd_client_connecting_wait(s));

-    ret =3D nbd_co_receive_blockstatus_reply(s, request.handle, bytes,
-                                           &extent, &request_ret, &local_e=
rr);
-    if (local_err) {
-        trace_nbd_co_request_fail(request.from, request.len, request.handl=
e,
-                                  request.flags, request.type,
-                                  nbd_cmd_lookup(request.type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
     if (ret < 0 || request_ret < 0) {
         return ret ? ret : request_ret;
     }
@@ -1175,9 +1374,9 @@ static void nbd_client_close(BlockDriverState *bs)
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D { .type =3D NBD_CMD_DISC };

-    assert(s->ioc);
-
-    nbd_send_request(s->ioc, &request);
+    if (s->ioc) {
+        nbd_send_request(s->ioc, &request);
+    }

     nbd_teardown_connection(bs);
 }
@@ -1821,6 +2020,8 @@ static BlockDriver bdrv_nbd =3D {
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    =3D nbd_client_attach_aio_context,
+    .bdrv_co_drain_begin        =3D nbd_client_co_drain_begin,
+    .bdrv_co_drain_end          =3D nbd_client_co_drain_end,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
     .bdrv_dirname               =3D nbd_dirname,
@@ -1844,6 +2045,8 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    =3D nbd_client_attach_aio_context,
+    .bdrv_co_drain_begin        =3D nbd_client_co_drain_begin,
+    .bdrv_co_drain_end          =3D nbd_client_co_drain_end,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
     .bdrv_dirname               =3D nbd_dirname,
@@ -1867,6 +2070,8 @@ static BlockDriver bdrv_nbd_unix =3D {
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    =3D nbd_client_attach_aio_context,
+    .bdrv_co_drain_begin        =3D nbd_client_co_drain_begin,
+    .bdrv_co_drain_end          =3D nbd_client_co_drain_end,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
     .bdrv_dirname               =3D nbd_dirname,
--=20
2.21.0


