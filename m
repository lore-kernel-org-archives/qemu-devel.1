Received: from eggs.gnu.org ([209.51.188.92]:38619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYSB-0007TO-C1
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYS7-0002yG-18
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:54 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  1 Feb 2019 16:01:33 +0300
Message-Id: <20190201130138.94525-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190201130138.94525-1-vsementsov@virtuozzo.com>
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 1/6] block/nbd-client: split channel errors
 from export errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

To implement nbd reconnect in further patches, we need to distinguish
error codes, returned by nbd server, from channel errors, to reconnect
only in the latter case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 83 ++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 813539676d..b023a35d1d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -504,11 +504,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
         NBDClientSession *s, uint64_t handle, bool only_structured,
-        QEMUIOVector *qiov, NBDReply *reply, void **payload, Error **errp)
+        int *request_ret, QEMUIOVector *qiov, NBDReply *reply, void **payload,
+        Error **errp)
 {
-    int request_ret;
     int ret = nbd_co_do_receive_one_chunk(s, handle, only_structured,
-                                          &request_ret, qiov, payload, errp);
+                                          request_ret, qiov, payload, errp);
 
     if (ret < 0) {
         s->quit = true;
@@ -518,7 +518,6 @@ static coroutine_fn int nbd_co_receive_one_chunk(
             *reply = s->reply;
         }
         s->reply.handle = 0;
-        ret = request_ret;
     }
 
     if (s->read_reply_co) {
@@ -530,22 +529,17 @@ static coroutine_fn int nbd_co_receive_one_chunk(
 
 typedef struct NBDReplyChunkIter {
     int ret;
-    bool fatal;
+    int request_ret;
     Error *err;
     bool done, only_structured;
 } NBDReplyChunkIter;
 
-static void nbd_iter_error(NBDReplyChunkIter *iter, bool fatal,
-                           int ret, Error **local_err)
+static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
+                                   int ret, Error **local_err)
 {
     assert(ret < 0);
 
-    if ((fatal && !iter->fatal) || iter->ret == 0) {
-        if (iter->ret != 0) {
-            error_free(iter->err);
-            iter->err = NULL;
-        }
-        iter->fatal = fatal;
+    if (!iter->ret) {
         iter->ret = ret;
         error_propagate(&iter->err, *local_err);
     } else {
@@ -555,6 +549,15 @@ static void nbd_iter_error(NBDReplyChunkIter *iter, bool fatal,
     *local_err = NULL;
 }
 
+static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)
+{
+    assert(ret < 0);
+
+    if (!iter->request_ret) {
+        iter->request_ret = ret;
+    }
+}
+
 /* NBD_FOREACH_REPLY_CHUNK
  */
 #define NBD_FOREACH_REPLY_CHUNK(s, iter, handle, structured, \
@@ -570,13 +573,13 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
                                          QEMUIOVector *qiov, NBDReply *reply,
                                          void **payload)
 {
-    int ret;
+    int ret, request_ret;
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err = NULL;
     if (s->quit) {
         error_setg(&local_err, "Connection closed");
-        nbd_iter_error(iter, true, -EIO, &local_err);
+        nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
     }
 
@@ -590,10 +593,12 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
     }
 
     ret = nbd_co_receive_one_chunk(s, handle, iter->only_structured,
-                                   qiov, reply, payload, &local_err);
+                                   &request_ret, qiov, reply, payload,
+                                   &local_err);
     if (ret < 0) {
-        /* If it is a fatal error s->quit is set by nbd_co_receive_one_chunk */
-        nbd_iter_error(iter, s->quit, ret, &local_err);
+        nbd_iter_channel_error(iter, ret, &local_err);
+    } else if (request_ret < 0) {
+        nbd_iter_request_error(iter, request_ret);
     }
 
     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply. */
@@ -630,7 +635,7 @@ break_loop:
 }
 
 static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle,
-                                      Error **errp)
+                                      int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
 
@@ -639,12 +644,13 @@ static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle,
     }
 
     error_propagate(errp, iter.err);
+    *request_ret = iter.request_ret;
     return iter.ret;
 }
 
 static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
                                         uint64_t offset, QEMUIOVector *qiov,
-                                        Error **errp)
+                                        int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
     NBDReply reply;
@@ -669,7 +675,7 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
                                                 offset, qiov, &local_err);
             if (ret < 0) {
                 s->quit = true;
-                nbd_iter_error(&iter, true, ret, &local_err);
+                nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
@@ -679,7 +685,7 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) for CMD_READ",
                            chunk->type, nbd_reply_type_lookup(chunk->type));
-                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
         }
 
@@ -688,12 +694,14 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
     }
 
     error_propagate(errp, iter.err);
+    *request_ret = iter.request_ret;
     return iter.ret;
 }
 
 static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
                                             uint64_t handle, uint64_t length,
-                                            NBDExtent *extent, Error **errp)
+                                            NBDExtent *extent,
+                                            int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
     NBDReply reply;
@@ -715,7 +723,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
             if (received) {
                 s->quit = true;
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
-                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
             received = true;
 
@@ -724,7 +732,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
                                                 &local_err);
             if (ret < 0) {
                 s->quit = true;
-                nbd_iter_error(&iter, true, ret, &local_err);
+                nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
@@ -734,7 +742,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
                            "Unexpected reply type: %d (%s) "
                            "for CMD_BLOCK_STATUS",
                            chunk->type, nbd_reply_type_lookup(chunk->type));
-                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
         }
 
@@ -749,14 +757,16 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
             iter.ret = -EIO;
         }
     }
+
     error_propagate(errp, iter.err);
+    *request_ret = iter.request_ret;
     return iter.ret;
 }
 
 static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
                           QEMUIOVector *write_qiov)
 {
-    int ret;
+    int ret, request_ret;
     Error *local_err = NULL;
     NBDClientSession *client = nbd_get_client_session(bs);
 
@@ -772,7 +782,8 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
         return ret;
     }
 
-    ret = nbd_co_receive_return_code(client, request->handle, &local_err);
+    ret = nbd_co_receive_return_code(client, request->handle,
+                                     &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request->from, request->len, request->handle,
                                   request->flags, request->type,
@@ -780,13 +791,13 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
                                   ret, error_get_pretty(local_err));
         error_free(local_err);
     }
-    return ret;
+    return ret ? ret : request_ret;
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    int ret;
+    int ret, request_ret;
     Error *local_err = NULL;
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
@@ -807,7 +818,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     }
 
     ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
-                                       &local_err);
+                                       &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request.from, request.len, request.handle,
                                   request.flags, request.type,
@@ -815,7 +826,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                                   ret, error_get_pretty(local_err));
         error_free(local_err);
     }
-    return ret;
+    return ret ? ret : request_ret;
 }
 
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -909,7 +920,7 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
                                             int64_t *pnum, int64_t *map,
                                             BlockDriverState **file)
 {
-    int64_t ret;
+    int ret, request_ret;
     NBDExtent extent = { 0 };
     NBDClientSession *client = nbd_get_client_session(bs);
     Error *local_err = NULL;
@@ -934,7 +945,7 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
     }
 
     ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
-                                           &extent, &local_err);
+                                           &extent, &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request.from, request.len, request.handle,
                                   request.flags, request.type,
@@ -942,8 +953,8 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
                                   ret, error_get_pretty(local_err));
         error_free(local_err);
     }
-    if (ret < 0) {
-        return ret;
+    if (ret < 0 || request_ret < 0) {
+        return ret ? ret : request_ret;
     }
 
     assert(extent.length);
-- 
2.18.0
