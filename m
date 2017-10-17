Received: from eggs.gnu.org ([2001:4830:134:3::10]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e4RQv-0007nC-Tq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e4RQs-0003k5-PF
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:57:21 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5394 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e4RQs-0003h9-52
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:57:18 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 17 Oct 2017 15:57:10 +0300
Message-Id: <20171017125710.11626-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171015010131.12172-1-eblake@redhat.com>
References: <20171015010131.12172-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 RFC 9/8] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Minimal implementation: for structured error only error_report error
message.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

it's an updated
 [PATCH v3 13/13] nbd: Minimal structured read for client
 https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02760.html
from
 [PATCH v3 00/13] nbd minimal structured read
 https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02755.html
and now it is based on
 [PATCH v4 8/8] nbd: Move nbd_read() to common header
 https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03489.html
from
 [PATCH v4 0/8] nbd mimimal structured read
 https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03305.html

v4:
- add Error messages and errp to most of new functions
  (I try to return save first occurred error from structured reply,
   but rewrite it if fatal error occurred)
- add comment to NBDExportInfo
- move nbd_reply_type_lookup prot. to public .h (I think it should be
  merged into some previous patch of v4)
- remove ''#include "qemu/error-report.h"'
- rewrite payload_advance* helpers
- add comments about qemu_vfree for *payload
- _SREP_ -> _REPLY_
- move checking NBD_REPLY_FLAG_DONE for NBD_REPLY_TYPE_NONE
- do not negotiate structured reply from qemu-nbd client thread
  (make client->info.structured_reply in-out)

RFC: I don't like resulting error handling: it is rather confusing,
    requires a lot of definitions of "local_err" which looks bad. Propagating,
    setting error and then drop it for errp=NULL case - all it looks not
    very effective. Any ideas?
 include/block/nbd.h |  12 ++
 nbd/nbd-internal.h  |   1 -
 block/nbd-client.c  | 483 ++++++++++++++++++++++++++++++++++++++++++++++++----
 nbd/client.c        |  10 ++
 4 files changed, 474 insertions(+), 32 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index da6e305dd5..92d1723d7c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -197,6 +197,11 @@ enum {
 #define NBD_REPLY_TYPE_ERROR         NBD_REPLY_ERR(1)
 #define NBD_REPLY_TYPE_ERROR_OFFSET  NBD_REPLY_ERR(2)
 
+static inline bool nbd_reply_type_is_error(int type)
+{
+    return type & (1 << 15);
+}
+
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
  * but only a limited set of errno values is specified in the protocol.
  * Everything else is squashed to EINVAL.
@@ -214,6 +219,11 @@ enum {
 struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
+
+    /* In-out fields, set by client before nbd_receive_negotiate() and
+     * updated by server results during nbd_receive_negotiate() */
+    bool structured_reply;
+
     /* Set by server results during nbd_receive_negotiate() */
     uint64_t size;
     uint16_t flags;
@@ -284,4 +294,6 @@ static inline bool nbd_reply_is_structured(NBDReply *reply)
     return reply->magic == NBD_STRUCTURED_REPLY_MAGIC;
 }
 
+const char *nbd_reply_type_lookup(uint16_t type);
+
 #endif
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index b64eb1cc9b..eeff78d3c9 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -104,7 +104,6 @@ const char *nbd_opt_lookup(uint32_t opt);
 const char *nbd_rep_lookup(uint32_t rep);
 const char *nbd_info_lookup(uint16_t info);
 const char *nbd_cmd_lookup(uint16_t info);
-const char *nbd_reply_type_lookup(uint16_t type);
 const char *nbd_err_lookup(int err);
 
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 58493b7ac4..9d9e75643e 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -93,7 +93,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         if (i >= MAX_NBD_REQUESTS ||
             !s->requests[i].coroutine ||
             !s->requests[i].receiving ||
-            nbd_reply_is_structured(&s->reply))
+            (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
         {
             break;
         }
@@ -181,75 +181,486 @@ err:
     return rc;
 }
 
-static int nbd_co_receive_reply(NBDClientSession *s,
-                                uint64_t handle,
-                                QEMUIOVector *qiov)
+static inline uint16_t payload_advance16(uint8_t **payload)
+{
+    *payload += 2;
+    return lduw_be_p(*payload - 2);
+}
+
+static inline uint32_t payload_advance32(uint8_t **payload)
+{
+    *payload += 4;
+    return lduw_be_p(*payload - 4);
+}
+
+static inline uint64_t payload_advance64(uint8_t **payload)
+{
+    *payload += 8;
+    return lduw_be_p(*payload - 8);
+}
+
+static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
+                                         uint8_t *payload, QEMUIOVector *qiov,
+                                         Error **errp)
+{
+    uint64_t offset;
+    uint32_t hole_size;
+
+    if (chunk->length != sizeof(offset) + sizeof(hole_size)) {
+        error_setg(errp, "Protocol error: invalid payload for "
+                         "NBD_REPLY_TYPE_OFFSET_HOLE");
+        return -EINVAL;
+    }
+
+    offset = payload_advance64(&payload);
+    hole_size = payload_advance32(&payload);
+
+    if (offset + hole_size > qiov->size) {
+        error_setg(errp, "Protocol error: server sent chunk exceeding requested"
+                         " region");
+        return -EINVAL;
+    }
+
+    qemu_iovec_memset(qiov, offset, 0, hole_size);
+
+    return 0;
+}
+
+/* nbd_parse_error_payload
+ * on success @errp contains message describing nbd error reply
+ */
+static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
+                                   uint8_t *payload, int *request_ret,
+                                   Error **errp)
+{
+    uint32_t error;
+    uint16_t message_size;
+
+    assert(chunk->type & (1 << 15));
+
+    if (chunk->length < sizeof(error) + sizeof(message_size)) {
+        error_setg(errp,
+                   "Protocol error: invalid payload for structured error");
+        return -EINVAL;
+    }
+
+    error = nbd_errno_to_system_errno(payload_advance32(&payload));
+    if (error == 0) {
+        error_setg(errp, "Protocol error: server sent structured error chunk"
+                         "with error = 0");
+        return -EINVAL;
+    }
+
+    *request_ret = error;
+    message_size = payload_advance16(&payload);
+    error_setg_errno(errp, error, "%.*s", message_size, payload);
+
+    /* TODO handle ERROR_OFFSET */
+
+    return 0;
+}
+
+static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
+                                              QEMUIOVector *qiov, Error **errp)
+{
+    QEMUIOVector sub_qiov;
+    uint64_t offset;
+    size_t data_size;
+    int ret;
+    NBDStructuredReplyChunk *chunk = &s->reply.structured;
+
+    assert(nbd_reply_is_structured(&s->reply));
+
+    if (chunk->length < sizeof(offset)) {
+        error_setg(errp, "Protocol error: invalid payload for "
+                         "NBD_REPLY_TYPE_OFFSET_DATA");
+        return -EINVAL;
+    }
+
+    if (nbd_read(s->ioc, &offset, sizeof(offset), errp) < 0) {
+        return -EIO;
+    }
+    be64_to_cpus(&offset);
+
+    data_size = chunk->length - sizeof(offset);
+    if (offset + data_size > qiov->size) {
+        error_setg(errp, "Protocol error: server sent chunk exceeding requested"
+                         " region");
+        return -EINVAL;
+    }
+
+    qemu_iovec_init(&sub_qiov, qiov->niov);
+    qemu_iovec_concat(&sub_qiov, qiov, offset, data_size);
+    ret = qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, errp);
+    qemu_iovec_destroy(&sub_qiov);
+
+    return ret < 0 ? -EIO : 0;
+}
+
+#define NBD_MAX_MALLOC_PAYLOAD 1000
+/* nbd_co_receive_structured_payload
+ * The resulting pointer stored in @payload requires qemu_vfree() to free it.
+ */
+static coroutine_fn int nbd_co_receive_structured_payload(
+        NBDClientSession *s, void **payload, Error **errp)
+{
+    int ret;
+    uint32_t len;
+
+    assert(nbd_reply_is_structured(&s->reply));
+
+    len = s->reply.structured.length;
+
+    if (len == 0) {
+        return 0;
+    }
+
+    if (payload == NULL) {
+        error_setg(errp, "Unexpected structured payload");
+        return -EINVAL;
+    }
+
+    if (len > NBD_MAX_MALLOC_PAYLOAD) {
+        error_setg(errp, "Too large payload");
+        return -EINVAL;
+    }
+
+    *payload = qemu_memalign(8, len);
+    ret = nbd_read(s->ioc, *payload, len, errp);
+    if (ret < 0) {
+        qemu_vfree(*payload);
+        *payload = NULL;
+        return ret;
+    }
+
+    return 0;
+}
+
+/* nbd_co_do_receive_one_chunk
+ * for simple reply:
+ *   set request_ret to received reply error
+ *   if qiov is not NULL: read payload to @qiov
+ * for structured reply chunk:
+ *   if error chunk: read payload, set @request_ret, do not set @payload
+ *   else if offset_data chunk: read payload data to @qiov, do not set @payload
+ *   else: read payload to @payload
+ *
+ * The pointer stored in @payload requires qemu_vfree() to free it.
+ * If function fails @errp containts corresponding error message. If function
+ * doesn't fail but reply contains error @request_ret is set to corresponding
+ * return code and errp is set to corresponding error message.
+ */
+static coroutine_fn int nbd_co_do_receive_one_chunk(
+        NBDClientSession *s, uint64_t handle, bool only_structured,
+        int *request_ret, QEMUIOVector *qiov, void **payload, Error **errp)
 {
     int ret;
     int i = HANDLE_TO_INDEX(s, handle);
+    void *local_payload = NULL;
+    NBDStructuredReplyChunk *chunk;
+
+    if (payload) {
+        *payload = NULL;
+    }
+    *request_ret = 0;
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
     if (!s->ioc || s->quit) {
-        ret = -EIO;
-    } else {
-        assert(s->reply.handle == handle);
-        ret = -nbd_errno_to_system_errno(s->reply.simple.error);
-        if (qiov && ret == 0) {
-            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
-                                      NULL) < 0) {
-                ret = -EIO;
-                s->quit = true;
+        error_setg(errp, "Connection closed");
+        return -EIO;
+    }
+
+    assert(s->reply.handle == handle);
+
+    if (nbd_reply_is_simple(&s->reply)) {
+        if (only_structured) {
+            error_setg(errp, "Protocol error: simple reply when structured"
+                             "reply chunk was expected");
+            return -EINVAL;
+        }
+
+        *request_ret = -nbd_errno_to_system_errno(s->reply.simple.error);
+        if (*request_ret < 0 || !qiov) {
+            if (*request_ret < 0) {
+                error_setg_errno(errp, -*request_ret, "Request failed");
             }
+            return 0;
         }
 
-        /* Tell the read handler to read another header.  */
-        s->reply.handle = 0;
+        return qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
+                                     errp) < 0 ? -EIO : 0;
     }
 
-    s->requests[i].coroutine = NULL;
+    /* handle structured reply chunk */
+    assert(s->info.structured_reply);
+    chunk = &s->reply.structured;
+
+    if (chunk->type == NBD_REPLY_TYPE_NONE) {
+        if (!(chunk->flags & NBD_REPLY_FLAG_DONE)) {
+            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk without"
+                             "NBD_REPLY_FLAG_DONE flag set");
+            return -EINVAL;
+        }
+        return 0;
+    }
+
+    if (chunk->type == NBD_REPLY_TYPE_OFFSET_DATA) {
+        if (!qiov) {
+            error_setg(errp, "Unexpected NBD_REPLY_TYPE_OFFSET_DATA chunk");
+            return -EINVAL;
+        }
+
+        return nbd_co_receive_offset_data_payload(s, qiov, errp);
+    }
+
+    if (nbd_reply_type_is_error(chunk->type)) {
+        payload = &local_payload;
+    }
+
+    ret = nbd_co_receive_structured_payload(s, payload, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (nbd_reply_type_is_error(chunk->type)) {
+        ret = nbd_parse_error_payload(chunk, local_payload, request_ret, errp);
+        qemu_vfree(local_payload);
+        return ret;
+    }
+
+    return 0;
+}
+
+/* nbd_co_receive_one_chunk
+ * Read reply, wake up read_reply_co and set s->quit if needed.
+ * Return value is a fatal error code or normal nbd reply error code
+ *
+ * The pointer stored in @payload requires qemu_vfree() to free it.
+ */
+static coroutine_fn int nbd_co_receive_one_chunk(
+        NBDClientSession *s, uint64_t handle, bool only_structured,
+        QEMUIOVector *qiov, NBDReply *reply, void **payload, Error **errp)
+{
+    int request_ret;
+    int ret = nbd_co_do_receive_one_chunk(s, handle, only_structured,
+                                          &request_ret, qiov, payload, errp);
+
+    if (ret < 0) {
+        s->quit = true;
+    } else {
+        /* For assert at loop start in nbd_read_reply_entry */
+        if (reply) {
+            *reply = s->reply;
+        }
+        s->reply.handle = 0;
+        ret = request_ret;
+    }
 
-    /* Kick the read_reply_co to get the next reply.  */
     if (s->read_reply_co) {
         aio_co_wake(s->read_reply_co);
     }
 
+    return ret;
+}
+
+typedef struct NBDReplyChunkIter {
+    int ret;
+    Error *err;
+    bool done, only_structured;
+} NBDReplyChunkIter;
+
+static void nbd_iter_error(NBDReplyChunkIter *iter, bool fatal,
+                           int ret, Error **local_err)
+{
+    assert(ret < 0);
+
+    if (fatal || iter->ret == 0) {
+        if (iter->ret != 0) {
+            error_free(iter->err);
+            iter->err = NULL;
+        }
+        iter->ret = ret;
+        error_propagate(&iter->err, *local_err);
+    } else {
+        error_free(*local_err);
+    }
+
+    *local_err = NULL;
+}
+
+/* NBD_FOREACH_REPLY_CHUNK
+ * The pointer stored in @payload requires qemu_vfree() to free it.
+ */
+#define NBD_FOREACH_REPLY_CHUNK(s, iter, handle, structured, \
+                                qiov, reply, payload) \
+    for (iter = (NBDReplyChunkIter) { .only_structured = structured }; \
+         nbd_reply_chunk_iter_receive(s, &iter, handle, qiov, reply, payload);)
+
+/* nbd_reply_chunk_iter_receive
+ * The pointer stored in @payload requires qemu_vfree() to free it.
+ */
+static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
+                                         NBDReplyChunkIter *iter,
+                                         uint64_t handle,
+                                         QEMUIOVector *qiov, NBDReply *reply,
+                                         void **payload)
+{
+    int ret;
+    NBDReply local_reply;
+    NBDStructuredReplyChunk *chunk;
+    Error *local_err = NULL;
+    if (s->quit) {
+        error_setg(&local_err, "Connection closed");
+        nbd_iter_error(iter, true, -EIO, &local_err);
+        goto break_loop;
+    }
+
+    if (iter->done) {
+        /* Previous iteration was last. */
+        goto break_loop;
+    }
+
+    if (reply == NULL) {
+        reply = &local_reply;
+    }
+
+    ret = nbd_co_receive_one_chunk(s, handle, iter->only_structured,
+                                   qiov, reply, payload, &local_err);
+    if (ret < 0) {
+        /* If it is a fatal error s->quit is set by nbd_co_receive_one_chunk */
+        nbd_iter_error(iter, s->quit, ret, &local_err);
+    }
+
+    /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply. */
+    if (nbd_reply_is_simple(&s->reply) || s->quit) {
+        goto break_loop;
+    }
+
+    chunk = &reply->structured;
+    iter->only_structured = true;
+
+    if (chunk->type == NBD_REPLY_TYPE_NONE) {
+        /* NBD_REPLY_FLAG_DONE is already checked in nbd_co_receive_one_chunk */
+        assert(chunk->flags & NBD_REPLY_FLAG_DONE);
+        goto break_loop;
+    }
+
+    if (chunk->flags & NBD_REPLY_FLAG_DONE) {
+        /* This iteration is last. */
+        iter->done = true;
+    }
+
+    /* Execute the loop body */
+    return true;
+
+break_loop:
+    s->requests[HANDLE_TO_INDEX(s, handle)].coroutine = NULL;
+
     qemu_co_mutex_lock(&s->send_mutex);
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_co_mutex_unlock(&s->send_mutex);
 
-    return ret;
+    return false;
 }
 
-static int nbd_co_request(BlockDriverState *bs,
-                          NBDRequest *request,
-                          QEMUIOVector *qiov)
+static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle,
+                                      Error **errp)
+{
+    NBDReplyChunkIter iter;
+
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, NULL, NULL) {
+        /* nbd_reply_chunk_iter_receive does all the work */
+        ;
+    }
+
+    error_propagate(errp, iter.err);
+    return iter.ret;
+}
+
+static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
+                                        QEMUIOVector *qiov, Error **errp)
+{
+    NBDReplyChunkIter iter;
+    NBDReply reply;
+    void *payload = NULL;
+    Error *local_err = NULL;
+
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
+                            qiov, &reply, &payload)
+    {
+        int ret;
+        NBDStructuredReplyChunk *chunk = &reply.structured;
+
+        assert(nbd_reply_is_structured(&reply));
+
+        switch (chunk->type) {
+        case NBD_REPLY_TYPE_OFFSET_DATA:
+            /* special cased in nbd_co_receive_one_chunk, data is already
+             * in qiov */
+            break;
+        case NBD_REPLY_TYPE_OFFSET_HOLE:
+            ret = nbd_parse_offset_hole_payload(&reply.structured, payload,
+                                                qiov, &local_err);
+            if (ret < 0) {
+                s->quit = true;
+                nbd_iter_error(&iter, true, ret, &local_err);
+            }
+            break;
+        default:
+            if (!nbd_reply_type_is_error(chunk->type)) {
+                /* not allowed reply type */
+                s->quit = true;
+                error_setg(&local_err,
+                           "Unexpected reply type: %d (%s) for CMD_READ",
+                           chunk->type, nbd_reply_type_lookup(chunk->type));
+                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+            }
+        }
+
+        qemu_vfree(payload);
+        payload = NULL;
+    }
+
+    error_propagate(errp, iter.err);
+    return iter.ret;
+}
+
+static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
+                          QEMUIOVector *write_qiov)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
     int ret;
+    Error *local_err = NULL;
+    NBDClientSession *client = nbd_get_client_session(bs);
 
-    if (qiov) {
-        assert(request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ);
-        assert(request->len == iov_size(qiov->iov, qiov->niov));
+    assert(request->type != NBD_CMD_READ);
+    if (write_qiov) {
+        assert(request->type == NBD_CMD_WRITE);
+        assert(request->len == iov_size(write_qiov->iov, write_qiov->niov));
     } else {
-        assert(request->type != NBD_CMD_WRITE && request->type != NBD_CMD_READ);
+        assert(request->type != NBD_CMD_WRITE);
     }
-    ret = nbd_co_send_request(bs, request,
-                              request->type == NBD_CMD_WRITE ? qiov : NULL);
+    ret = nbd_co_send_request(bs, request, write_qiov);
     if (ret < 0) {
         return ret;
     }
 
-    return nbd_co_receive_reply(client, request->handle,
-                                request->type == NBD_CMD_READ ? qiov : NULL);
+    ret = nbd_co_receive_return_code(client, request->handle, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
+    int ret;
+    Error *local_err = NULL;
+    NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_READ,
         .from = offset,
@@ -259,7 +670,16 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
 
-    return nbd_co_request(bs, &request, qiov);
+    ret = nbd_co_send_request(bs, &request, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = nbd_co_receive_cmdread_reply(client, request.handle, qiov, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -381,6 +801,7 @@ int nbd_client_init(BlockDriverState *bs,
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
 
     client->info.request_sizes = true;
+    client->info.structured_reply = true;
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
                                 tlscreds, hostname,
                                 &client->ioc, &client->info, errp);
diff --git a/nbd/client.c b/nbd/client.c
index eeb23ae934..0297484264 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -684,6 +684,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         if (fixedNewStyle) {
             int result;
 
+            if (info->structured_reply) {
+                result = nbd_request_simple_option(ioc,
+                                                   NBD_OPT_STRUCTURED_REPLY,
+                                                   errp);
+                if (result < 0) {
+                    goto fail;
+                }
+                info->structured_reply = result == 1;
+            }
+
             /* Try NBD_OPT_GO first - if it works, we are done (it
              * also gives us a good message if the server requires
              * TLS).  If it is not available, fall back to
-- 
2.11.1
