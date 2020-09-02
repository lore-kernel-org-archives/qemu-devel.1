Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A2E20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D67fH57j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A2E20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDaip-0000tQ-3L
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDahq-0007uO-HG
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44567
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDahn-0002aE-VG
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599083648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71+WRF1kScJNHLwsOcF2FDQd1Dtqs5Xvhap0vNkNF/Q=;
 b=D67fH57j9POKNgjOOv4v/M7bEBQc5WzwX767S5SsGVGCEV9RXlAsmhFTdYo4yUR+BQ9jkq
 /+UAfI74sEOEnzrA0Ti/IauQC69kRdAfvn7K0vXQ40Rz8QDJsPMIkZloKd7yYKq5OCe6u7
 FRKWrvwXJ1gdvOgvX3DPbGa+zettg0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-98EPpeJMNmKFgv8xRZJBGA-1; Wed, 02 Sep 2020 17:54:05 -0400
X-MC-Unique: 98EPpeJMNmKFgv8xRZJBGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32B531DE00;
 Wed,  2 Sep 2020 21:54:04 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8263A7EEB6;
 Wed,  2 Sep 2020 21:54:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] block/nbd: use non-blocking connect: fix vm hang on
 connect()
Date: Wed,  2 Sep 2020 16:53:57 -0500
Message-Id: <20200902215400.2673028-4-eblake@redhat.com>
In-Reply-To: <20200902215400.2673028-1-eblake@redhat.com>
References: <20200902215400.2673028-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

This makes nbd's connection_co yield during reconnects, so that
reconnect doesn't block the main thread. This is very important in
case of an unavailable nbd server host: connect() call may take a long
time, blocking the main thread (and due to reconnect, it will hang
again and again with small gaps of working time during pauses between
connection attempts).

Realization notes:

 - We don't want to implement non-blocking connect() over non-blocking
 socket, because getaddrinfo() doesn't have portable non-blocking
 realization anyway, so let's just use a thread for both getaddrinfo()
 and connect().

 - We can't use qio_channel_socket_connect_async (which behaves
 similarly and starts a thread to execute connect() call), as it's relying
 on someone iterating main loop (g_main_loop_run() or something like
 this), which is not always the case.

 - We can't use thread_pool_submit_co API, as thread pool waits for all
 threads to finish (but we don't want to wait for blocking reconnect
 attempt on shutdown.

 So, we just create the thread by hand. Some additional difficulties
 are:

 - We want our connect to avoid blocking drained sections and aio context
 switches. To achieve this, we make it possible to "cancel" synchronous
 wait for the connect (which is a coroutine yield actually), still,
 the thread continues in background, and if successful, its result may be
 reused on next reconnect attempt.

 - We don't want to wait for reconnect on shutdown, so there is
 CONNECT_THREAD_RUNNING_DETACHED thread state, which means that the block
 layer is no longer interested in a result, and thread should close new
 connected socket on finish and free the state.

How to reproduce the bug, fixed with this commit:

1. Create an image on node1:
   qemu-img create -f qcow2 xx 100M

2. Start NBD server on node1:
   qemu-nbd xx

3. Start vm with second nbd disk on node2, like this:

  ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
    file=/work/images/cent7.qcow2 -drive file=nbd+tcp://192.168.100.2 \
    -vnc :0 -qmp stdio -m 2G -enable-kvm -vga std

4. Access the vm through vnc (or some other way?), and check that NBD
   drive works:

   dd if=/dev/sdb of=/dev/null bs=1M count=10

   - the command should succeed.

5. Now, let's trigger nbd-reconnect loop in Qemu process. For this:

5.1 Kill NBD server on node1

5.2 run "dd if=/dev/sdb of=/dev/null bs=1M count=10" in the guest
    again. The command should fail and a lot of error messages about
    failing disk may appear as well.

    Now NBD client driver in Qemu tries to reconnect.
    Still, VM works well.

6. Make node1 unavailable on NBD port, so connect() from node2 will
   last for a long time:

   On node1 (Note, that 10809 is just a default NBD port):

   sudo iptables -A INPUT -p tcp --dport 10809 -j DROP

   After some time the guest hangs, and you may check in gdb that Qemu
   hangs in connect() call, issued from the main thread. This is the
   BUG.

7. Don't forget to drop iptables rule from your node1:

   sudo iptables -D INPUT -p tcp --dport 10809 -j DROP

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200812145237.4396-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: minor wording and formatting tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 7bb881fef49c..9daf003bea30 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -38,6 +38,7 @@

 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/clone-visitor.h"

 #include "block/qdict.h"
 #include "block/nbd.h"
@@ -62,6 +63,47 @@ typedef enum NBDClientState {
     NBD_CLIENT_QUIT
 } NBDClientState;

+typedef enum NBDConnectThreadState {
+    /* No thread, no pending results */
+    CONNECT_THREAD_NONE,
+
+    /* Thread is running, no results for now */
+    CONNECT_THREAD_RUNNING,
+
+    /*
+     * Thread is running, but requestor exited. Thread should close
+     * the new socket and free the connect state on exit.
+     */
+    CONNECT_THREAD_RUNNING_DETACHED,
+
+    /* Thread finished, results are stored in a state */
+    CONNECT_THREAD_FAIL,
+    CONNECT_THREAD_SUCCESS
+} NBDConnectThreadState;
+
+typedef struct NBDConnectThread {
+    /* Initialization constants */
+    SocketAddress *saddr; /* address to connect to */
+    /*
+     * Bottom half to schedule on completion. Scheduled only if bh_ctx is not
+     * NULL
+     */
+    QEMUBHFunc *bh_func;
+    void *bh_opaque;
+
+    /*
+     * Result of last attempt. Valid in FAIL and SUCCESS states.
+     * If you want to steal error, don't forget to set pointer to NULL.
+     */
+    QIOChannelSocket *sioc;
+    Error *err;
+
+    /* state and bh_ctx are protected by mutex */
+    QemuMutex mutex;
+    NBDConnectThreadState state; /* current state of the thread */
+    AioContext *bh_ctx; /* where to schedule bh (NULL means don't schedule) */
+} NBDConnectThread;
+
 typedef struct BDRVNBDState {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
@@ -91,10 +133,17 @@ typedef struct BDRVNBDState {
     QCryptoTLSCreds *tlscreds;
     const char *hostname;
     char *x_dirty_bitmap;
+
+    bool wait_connect;
+    NBDConnectThread *connect_thread;
 } BDRVNBDState;

 static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                                   Error **errp);
+static QIOChannelSocket *nbd_co_establish_connection(BlockDriverState *bs,
+                                                     Error **errp);
+static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
+                                               bool detach);
 static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
                                 Error **errp);

@@ -191,6 +240,8 @@ static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
     if (s->connection_co_sleep_ns_state) {
         qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
     }
+
+    nbd_co_establish_connection_cancel(bs, false);
 }

 static void coroutine_fn nbd_client_co_drain_end(BlockDriverState *bs)
@@ -223,6 +274,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
         if (s->connection_co_sleep_ns_state) {
             qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
         }
+        nbd_co_establish_connection_cancel(bs, true);
     }
     if (qemu_in_coroutine()) {
         s->teardown_co = qemu_coroutine_self();
@@ -246,6 +298,216 @@ static bool nbd_client_connecting_wait(BDRVNBDState *s)
     return s->state == NBD_CLIENT_CONNECTING_WAIT;
 }

+static void connect_bh(void *opaque)
+{
+    BDRVNBDState *state = opaque;
+
+    assert(state->wait_connect);
+    state->wait_connect = false;
+    aio_co_wake(state->connection_co);
+}
+
+static void nbd_init_connect_thread(BDRVNBDState *s)
+{
+    s->connect_thread = g_new(NBDConnectThread, 1);
+
+    *s->connect_thread = (NBDConnectThread) {
+        .saddr = QAPI_CLONE(SocketAddress, s->saddr),
+        .state = CONNECT_THREAD_NONE,
+        .bh_func = connect_bh,
+        .bh_opaque = s,
+    };
+
+    qemu_mutex_init(&s->connect_thread->mutex);
+}
+
+static void nbd_free_connect_thread(NBDConnectThread *thr)
+{
+    if (thr->sioc) {
+        qio_channel_close(QIO_CHANNEL(thr->sioc), NULL);
+    }
+    error_free(thr->err);
+    qapi_free_SocketAddress(thr->saddr);
+    g_free(thr);
+}
+
+static void *connect_thread_func(void *opaque)
+{
+    NBDConnectThread *thr = opaque;
+    int ret;
+    bool do_free = false;
+
+    thr->sioc = qio_channel_socket_new();
+
+    error_free(thr->err);
+    thr->err = NULL;
+    ret = qio_channel_socket_connect_sync(thr->sioc, thr->saddr, &thr->err);
+    if (ret < 0) {
+        object_unref(OBJECT(thr->sioc));
+        thr->sioc = NULL;
+    }
+
+    qemu_mutex_lock(&thr->mutex);
+
+    switch (thr->state) {
+    case CONNECT_THREAD_RUNNING:
+        thr->state = ret < 0 ? CONNECT_THREAD_FAIL : CONNECT_THREAD_SUCCESS;
+        if (thr->bh_ctx) {
+            aio_bh_schedule_oneshot(thr->bh_ctx, thr->bh_func, thr->bh_opaque);
+
+            /* play safe, don't reuse bh_ctx on further connection attempts */
+            thr->bh_ctx = NULL;
+        }
+        break;
+    case CONNECT_THREAD_RUNNING_DETACHED:
+        do_free = true;
+        break;
+    default:
+        abort();
+    }
+
+    qemu_mutex_unlock(&thr->mutex);
+
+    if (do_free) {
+        nbd_free_connect_thread(thr);
+    }
+
+    return NULL;
+}
+
+static QIOChannelSocket *coroutine_fn
+nbd_co_establish_connection(BlockDriverState *bs, Error **errp)
+{
+    QemuThread thread;
+    BDRVNBDState *s = bs->opaque;
+    QIOChannelSocket *res;
+    NBDConnectThread *thr = s->connect_thread;
+
+    qemu_mutex_lock(&thr->mutex);
+
+    switch (thr->state) {
+    case CONNECT_THREAD_FAIL:
+    case CONNECT_THREAD_NONE:
+        error_free(thr->err);
+        thr->err = NULL;
+        thr->state = CONNECT_THREAD_RUNNING;
+        qemu_thread_create(&thread, "nbd-connect",
+                           connect_thread_func, thr, QEMU_THREAD_DETACHED);
+        break;
+    case CONNECT_THREAD_SUCCESS:
+        /* Previous attempt finally succeeded in background */
+        thr->state = CONNECT_THREAD_NONE;
+        res = thr->sioc;
+        thr->sioc = NULL;
+        qemu_mutex_unlock(&thr->mutex);
+        return res;
+    case CONNECT_THREAD_RUNNING:
+        /* Already running, will wait */
+        break;
+    default:
+        abort();
+    }
+
+    thr->bh_ctx = qemu_get_current_aio_context();
+
+    qemu_mutex_unlock(&thr->mutex);
+
+
+    /*
+     * We are going to wait for connect-thread finish, but
+     * nbd_client_co_drain_begin() can interrupt.
+     *
+     * Note that wait_connect variable is not visible for connect-thread. It
+     * doesn't need mutex protection, it used only inside home aio context of
+     * bs.
+     */
+    s->wait_connect = true;
+    qemu_coroutine_yield();
+
+    qemu_mutex_lock(&thr->mutex);
+
+    switch (thr->state) {
+    case CONNECT_THREAD_SUCCESS:
+    case CONNECT_THREAD_FAIL:
+        thr->state = CONNECT_THREAD_NONE;
+        error_propagate(errp, thr->err);
+        thr->err = NULL;
+        res = thr->sioc;
+        thr->sioc = NULL;
+        break;
+    case CONNECT_THREAD_RUNNING:
+    case CONNECT_THREAD_RUNNING_DETACHED:
+        /*
+         * Obviously, drained section wants to start. Report the attempt as
+         * failed. Still connect thread is executing in background, and its
+         * result may be used for next connection attempt.
+         */
+        res = NULL;
+        error_setg(errp, "Connection attempt cancelled by other operation");
+        break;
+
+    case CONNECT_THREAD_NONE:
+        /*
+         * Impossible. We've seen this thread running. So it should be
+         * running or at least give some results.
+         */
+        abort();
+
+    default:
+        abort();
+    }
+
+    qemu_mutex_unlock(&thr->mutex);
+
+    return res;
+}
+
+/*
+ * nbd_co_establish_connection_cancel
+ * Cancel nbd_co_establish_connection asynchronously: it will finish soon, to
+ * allow drained section to begin.
+ *
+ * If detach is true, also cleanup the state (or if thread is running, move it
+ * to CONNECT_THREAD_RUNNING_DETACHED state). s->connect_thread becomes NULL if
+ * detach is true.
+ */
+static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
+                                               bool detach)
+{
+    BDRVNBDState *s = bs->opaque;
+    NBDConnectThread *thr = s->connect_thread;
+    bool wake = false;
+    bool do_free = false;
+
+    qemu_mutex_lock(&thr->mutex);
+
+    if (thr->state == CONNECT_THREAD_RUNNING) {
+        /* We can cancel only in running state, when bh is not yet scheduled */
+        thr->bh_ctx = NULL;
+        if (s->wait_connect) {
+            s->wait_connect = false;
+            wake = true;
+        }
+        if (detach) {
+            thr->state = CONNECT_THREAD_RUNNING_DETACHED;
+            s->connect_thread = NULL;
+        }
+    } else if (detach) {
+        do_free = true;
+    }
+
+    qemu_mutex_unlock(&thr->mutex);
+
+    if (do_free) {
+        nbd_free_connect_thread(thr);
+        s->connect_thread = NULL;
+    }
+
+    if (wake) {
+        aio_co_wake(s->connection_co);
+    }
+}
+
 static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
 {
     int ret;
@@ -289,7 +551,7 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
         s->ioc = NULL;
     }

-    sioc = nbd_establish_connection(s->saddr, &local_err);
+    sioc = nbd_co_establish_connection(s->bs, &local_err);
     if (!sioc) {
         ret = -ECONNREFUSED;
         goto out;
@@ -1946,6 +2208,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     /* successfully connected */
     s->state = NBD_CLIENT_CONNECTED;

+    nbd_init_connect_thread(s);
+
     s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
     bdrv_inc_in_flight(bs);
     aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
-- 
2.28.0


