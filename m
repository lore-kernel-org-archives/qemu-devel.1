Received: from eggs.gnu.org ([2001:4830:134:3::10]:36939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Uk-BL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTo-0004Fh-OO
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:29 +0300
Message-Id: <20180731173033.75467-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 06/10] block/nbd-client: move from quit to
 state
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

To implement reconnect we need several states for the client:
CONNECTED, QUIT and two CONNECTING states. CONNECTING states will
be realized in the following patches. This patch implements CONNECTED
and QUIT.

QUIT means, that we should close the connection and fail all current
and further requests (like old quit = true).

CONNECTED means that connection is ok, we can send requests (like old
quit = false).

For receiving loop we use a comparison of the current state with QUIT,
because reconnect will be in the same loop, so it should be looping
until the end.

Opposite, for requests we use a comparison of the current state with
CONNECTED, as we don't want to send requests in CONNECTING states (
which are unreachable now, but will be reachable after the following
commits)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  9 ++++++++-
 block/nbd-client.c | 55 ++++++++++++++++++++++++++++++++----------------------
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 2f047ba614..5367425774 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -23,6 +23,13 @@ typedef struct {
     bool receiving;         /* waiting for read_reply_co? */
 } NBDClientRequest;
 
+typedef enum NBDClientState {
+    NBD_CLIENT_CONNECTING_WAIT,
+    NBD_CLIENT_CONNECTING_NOWAIT,
+    NBD_CLIENT_CONNECTED,
+    NBD_CLIENT_QUIT
+} NBDClientState;
+
 typedef struct NBDClientSession {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
@@ -32,10 +39,10 @@ typedef struct NBDClientSession {
     CoQueue free_sema;
     Coroutine *read_reply_co;
     int in_flight;
+    NBDClientState state;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
-    bool quit;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 7eaf0149f0..a91fd3ea3e 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -34,6 +34,12 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
 
+/* @ret would be used for reconnect in future */
+static void nbd_channel_error(NBDClientSession *s, int ret)
+{
+    s->state = NBD_CLIENT_QUIT;
+}
+
 static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
 {
     int i;
@@ -73,14 +79,15 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     int ret = 0;
     Error *local_err = NULL;
 
-    while (!s->quit) {
+    while (s->state != NBD_CLIENT_QUIT) {
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
         if (local_err) {
             error_report_err(local_err);
         }
         if (ret <= 0) {
-            break;
+            nbd_channel_error(s, ret ? ret : -EIO);
+            continue;
         }
 
         /* There's no need for a mutex on the receive side, because the
@@ -93,7 +100,8 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             !s->requests[i].receiving ||
             (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
         {
-            break;
+            nbd_channel_error(s, -EINVAL);
+            continue;
         }
 
         /* We're woken up again by the request itself.  Note that there
@@ -111,7 +119,6 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
-    s->quit = true;
     nbd_recv_coroutines_wake_all(s);
     s->read_reply_co = NULL;
 }
@@ -121,12 +128,18 @@ static int nbd_co_send_request(BlockDriverState *bs,
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
@@ -144,16 +157,12 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
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
@@ -168,9 +177,11 @@ static int nbd_co_send_request(BlockDriverState *bs,
 
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
@@ -421,7 +432,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (s->quit) {
+    if (s->state != NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -504,7 +515,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
                                           request_ret, qiov, payload, errp);
 
     if (ret < 0) {
-        s->quit = true;
+        nbd_channel_error(s, ret);
     } else {
         /* For assert at loop start in nbd_read_reply_entry */
         if (reply) {
@@ -570,7 +581,7 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err = NULL;
-    if (s->quit) {
+    if (s->state != NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -595,7 +606,7 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
     }
 
     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply. */
-    if (nbd_reply_is_simple(reply) || s->quit) {
+    if (nbd_reply_is_simple(reply) || s->state != NBD_CLIENT_CONNECTED) {
         goto break_loop;
     }
 
@@ -667,14 +678,14 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
             ret = nbd_parse_offset_hole_payload(&reply.structured, payload,
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
@@ -714,7 +725,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
         switch (chunk->type) {
         case NBD_REPLY_TYPE_BLOCK_STATUS:
             if (received) {
-                s->quit = true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
                 nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
@@ -724,13 +735,13 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
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
2.11.1
