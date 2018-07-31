Received: from eggs.gnu.org ([2001:4830:134:3::10]:36936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Ui-B2
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTo-0004FP-8Z
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:24 +0300
Message-Id: <20180731173033.75467-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 01/10] block/nbd-client: split channel
 errors from export errors
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

To implement nbd reconnect in further patches, we need to distinguish
error codes, returned by nbd server, from channel errors, to reconnect
only in the latter case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 83 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9686ecbd5e..1efc3d36cc 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -501,11 +501,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
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
@@ -515,7 +515,6 @@ static coroutine_fn int nbd_co_receive_one_chunk(
             *reply = s->reply;
         }
         s->reply.handle = 0;
-        ret = request_ret;
     }
 
     if (s->read_reply_co) {
@@ -527,22 +526,17 @@ static coroutine_fn int nbd_co_receive_one_chunk(
 
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
@@ -552,6 +546,15 @@ static void nbd_iter_error(NBDReplyChunkIter *iter, bool fatal,
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
@@ -567,13 +570,13 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
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
 
@@ -587,10 +590,12 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
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
@@ -627,7 +632,7 @@ break_loop:
 }
 
 static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle,
-                                      Error **errp)
+                                      int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
 
@@ -636,12 +641,13 @@ static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle,
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
@@ -666,7 +672,7 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
                                                 offset, qiov, &local_err);
             if (ret < 0) {
                 s->quit = true;
-                nbd_iter_error(&iter, true, ret, &local_err);
+                nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
@@ -676,7 +682,7 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) for CMD_READ",
                            chunk->type, nbd_reply_type_lookup(chunk->type));
-                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
         }
 
@@ -685,12 +691,14 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
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
@@ -712,7 +720,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
             if (received) {
                 s->quit = true;
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
-                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
             received = true;
 
@@ -721,7 +729,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
                                                 &local_err);
             if (ret < 0) {
                 s->quit = true;
-                nbd_iter_error(&iter, true, ret, &local_err);
+                nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
@@ -731,7 +739,7 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
                            "Unexpected reply type: %d (%s) "
                            "for CMD_BLOCK_STATUS",
                            chunk->type, nbd_reply_type_lookup(chunk->type));
-                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
         }
 
@@ -746,14 +754,16 @@ static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
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
 
@@ -769,17 +779,18 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
         return ret;
     }
 
-    ret = nbd_co_receive_return_code(client, request->handle, &local_err);
+    ret = nbd_co_receive_return_code(client, request->handle,
+                                     &request_ret, &local_err);
     if (local_err) {
         error_report_err(local_err);
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
@@ -800,11 +811,11 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     }
 
     ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
-                                       &local_err);
+                                       &request_ret, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
-    return ret;
+    return ret ? ret : request_ret;
 }
 
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -898,7 +909,7 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
                                             int64_t *pnum, int64_t *map,
                                             BlockDriverState **file)
 {
-    int64_t ret;
+    int ret, request_ret;
     NBDExtent extent = { 0 };
     NBDClientSession *client = nbd_get_client_session(bs);
     Error *local_err = NULL;
@@ -923,12 +934,12 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
     }
 
     ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
-                                           &extent, &local_err);
+                                           &extent, &request_ret, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
-    if (ret < 0) {
-        return ret;
+    if (ret < 0 || request_ret < 0) {
+        return ret ? ret : request_ret;
     }
 
     assert(extent.length);
-- 
2.11.1
