Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C33C46477
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FAB20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FAB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCeR-0001dC-06
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWZ-00041z-7W
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWV-0000Mx-5u
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:39 -0400
Received: from relay.sw.ru ([185.231.240.75]:58018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWU-0000Ji-Rl; Tue, 18 Jun 2019 07:43:35 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWP-00016b-68; Tue, 18 Jun 2019 14:43:29 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 14:43:22 +0300
Message-Id: <20190618114328.55249-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190618114328.55249-1-vsementsov@virtuozzo.com>
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 3/9] block/nbd: move from quit to state
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 58 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 16a38373fd..9e505c895a 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -53,6 +53,11 @@ typedef struct {
     bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;
 
+typedef enum NBDClientState {
+    NBD_CLIENT_CONNECTED,
+    NBD_CLIENT_QUIT
+} NBDClientState;
+
 typedef struct BDRVNBDState {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
@@ -62,17 +67,23 @@ typedef struct BDRVNBDState {
     CoQueue free_sema;
     Coroutine *connection_co;
     int in_flight;
+    NBDClientState state;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     BlockDriverState *bs;
-    bool quit;
 
     /* For nbd_refresh_filename() */
     SocketAddress *saddr;
     char *export, *tlscredsid;
 } BDRVNBDState;
 
+/* @ret will be used for reconnect in future */
+static void nbd_channel_error(BDRVNBDState *s, int ret)
+{
+    s->state = NBD_CLIENT_QUIT;
+}
+
 static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
 {
     int i;
@@ -151,7 +162,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
     int ret = 0;
     Error *local_err = NULL;
 
-    while (!s->quit) {
+    while (s->state != NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. This is
@@ -169,6 +180,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
             error_free(local_err);
         }
         if (ret <= 0) {
+            nbd_channel_error(s, ret ? ret : -EIO);
             break;
         }
 
@@ -183,6 +195,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
             !s->requests[i].receiving ||
             (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
         {
+            nbd_channel_error(s, -EINVAL);
             break;
         }
 
@@ -202,7 +215,6 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
-    s->quit = true;
     nbd_recv_coroutines_wake_all(s);
     bdrv_dec_in_flight(s->bs);
 
@@ -215,12 +227,18 @@ static int nbd_co_send_request(BlockDriverState *bs,
                                QEMUIOVector *qiov)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
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
@@ -238,16 +256,12 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
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
@@ -262,9 +276,11 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
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
@@ -556,7 +572,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (s->quit) {
+    if (s->state != NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -640,7 +656,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
                                           request_ret, qiov, payload, errp);
 
     if (ret < 0) {
-        s->quit = true;
+        nbd_channel_error(s, ret);
     } else {
         /* For assert at loop start in nbd_connection_entry */
         if (reply) {
@@ -710,7 +726,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err = NULL;
-    if (s->quit) {
+    if (s->state != NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -735,7 +751,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *s,
     }
 
     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply. */
-    if (nbd_reply_is_simple(reply) || s->quit) {
+    if (nbd_reply_is_simple(reply) || s->state != NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }
 
@@ -809,14 +825,14 @@ static int nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t handle,
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
@@ -854,7 +870,7 @@ static int nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
         switch (chunk->type) {
         case NBD_REPLY_TYPE_BLOCK_STATUS:
             if (received) {
-                s->quit = true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
                 nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
@@ -864,13 +880,13 @@ static int nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
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


