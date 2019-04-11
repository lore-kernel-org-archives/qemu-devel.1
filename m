Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A892084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A892084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdYX-0008F1-Jg
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:32:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTn-0004ZJ-BR
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bX-OH
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:59350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTl-0003Zu-D5; Thu, 11 Apr 2019 13:27:13 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTi-00044D-L0; Thu, 11 Apr 2019 20:27:10 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 11 Apr 2019 20:27:05 +0300
Message-Id: <20190411172709.205032-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 3/7] block/nbd-client: move from quit to
 state
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
Message-ID: <20190411172705.o7R_GfwjM09l0HeMHlAXMjVic5d4wIbequ-FcENyCS0@z>

To implement reconnect we need several states for the client:
CONNECTED, QUIT and two different CONNECTING states. CONNECTING states
will be added in the following patches. This patch implements CONNECTED
and QUIT.

QUIT means, that we should close the connection and fail all current
and further requests (like old quit = true).

CONNECTED means that connection is ok, we can send requests (like old
quit = false).

For receiving loop we use a comparison of the current state with QUIT,
because reconnect will be in the same loop, so it should be looping
until the end.

Opposite, for requests we use a comparison of the current state with
CONNECTED, as we don't want to send requests in future CONNECTING
states.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  7 ++++++-
 block/nbd-client.c | 51 ++++++++++++++++++++++++++++------------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 09e03013d2..e45b7b0a14 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -23,6 +23,11 @@ typedef struct {
     bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;
 
+typedef enum NBDClientState {
+    NBD_CLIENT_CONNECTED,
+    NBD_CLIENT_QUIT
+} NBDClientState;
+
 typedef struct NBDClientSession {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
@@ -32,11 +37,11 @@ typedef struct NBDClientSession {
     CoQueue free_sema;
     Coroutine *connection_co;
     int in_flight;
+    NBDClientState state;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     BlockDriverState *bs;
-    bool quit;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index f9cee25865..9f5c86eaa3 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -36,6 +36,12 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
 
+/* @ret will be used for reconnect in future */
+static void nbd_channel_error(NBDClientSession *s, int ret)
+{
+    s->state = NBD_CLIENT_QUIT;
+}
+
 static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
 {
     int i;
@@ -75,7 +81,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
     int ret = 0;
     Error *local_err = NULL;
 
-    while (!s->quit) {
+    while (s->state != NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. This is
@@ -93,6 +99,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
             error_free(local_err);
         }
         if (ret <= 0) {
+            nbd_channel_error(s, ret ? ret : -EIO);
             break;
         }
 
@@ -106,6 +113,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
             !s->requests[i].receiving ||
             (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
         {
+            nbd_channel_error(s, -EINVAL);
             break;
         }
 
@@ -124,7 +132,6 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
-    s->quit = true;
     nbd_recv_coroutines_wake_all(s);
     bdrv_dec_in_flight(s->bs);
 
@@ -137,12 +144,18 @@ static int nbd_co_send_request(BlockDriverState *bs,
                                QEMUIOVector *qiov)
 {
     NBDClientSession *s = nbd_get_client_session(bs);
-    int rc, i;
+    int rc, i = -1;
 
     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight == MAX_NBD_REQUESTS) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }
+
+    if (s->state != NBD_CLIENT_CONNECTED) {
+        rc = -EIO;
+        goto err;
+    }
+
     s->in_flight++;
 
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
@@ -160,16 +173,12 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
     request->handle = INDEX_TO_HANDLE(s, i);
 
-    if (s->quit) {
-        rc = -EIO;
-        goto err;
-    }
     assert(s->ioc);
 
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
-        if (rc >= 0 && !s->quit) {
+        if (rc >= 0 && s->state == NBD_CLIENT_CONNECTED) {
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc = -EIO;
@@ -184,9 +193,11 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
 err:
     if (rc < 0) {
-        s->quit = true;
-        s->requests[i].coroutine = NULL;
-        s->in_flight--;
+        nbd_channel_error(s, rc);
+        if (i != -1) {
+            s->requests[i].coroutine = NULL;
+            s->in_flight--;
+        }
         qemu_co_queue_next(&s->free_sema);
     }
     qemu_co_mutex_unlock(&s->send_mutex);
@@ -477,7 +488,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (s->quit) {
+    if (s->state != NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -560,7 +571,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
                                           request_ret, qiov, payload, errp);
 
     if (ret < 0) {
-        s->quit = true;
+        nbd_channel_error(s, ret);
     } else {
         /* For assert at loop start in nbd_connection_entry */
         if (reply) {
@@ -626,7 +637,7 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err = NULL;
-    if (s->quit) {
+    if (s->state != NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -651,7 +662,7 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
     }
 
     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply. */
-    if (nbd_reply_is_simple(reply) || s->quit) {
+    if (nbd_reply_is_simple(reply) || s->state != NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }
 
@@ -723,14 +734,14 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
             ret = nbd_parse_offset_hole_payload(s, &reply.structured, payload,
                                                 offset, qiov, &local_err);
             if (ret < 0) {
-                s->quit = true;
+                nbd_channel_error(s, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
             if (!nbd_reply_type_is_error(chunk->type)) {
                 /* not allowed reply type */
-                s->quit = true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) for CMD_READ",
                            chunk->type, nbd_reply_type_lookup(chunk->type));
@@ -768,7 +779,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
         switch (chunk->type) {
         case NBD_REPLY_TYPE_BLOCK_STATUS:
             if (received) {
-                s->quit = true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
                 nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
@@ -778,13 +789,13 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
                                                 payload, length, extent,
                                                 &local_err);
             if (ret < 0) {
-                s->quit = true;
+                nbd_channel_error(s, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
             if (!nbd_reply_type_is_error(chunk->type)) {
-                s->quit = true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) "
                            "for CMD_BLOCK_STATUS",
-- 
2.18.0


