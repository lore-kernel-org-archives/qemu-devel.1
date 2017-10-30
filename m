Received: from eggs.gnu.org ([2001:4830:134:3::10]:50671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7K-00005s-Ol
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7J-0001Ki-Fs
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 30 Oct 2017 21:56:31 +0100
Message-Id: <20171030205636.14236-8-eblake@redhat.com>
In-Reply-To: <20171030205636.14236-1-eblake@redhat.com>
References: <20171030205636.14236-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] nbd: Minimal structured read for server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Minimal implementation of structured read: one structured reply chunk,
no segmentation.
Minimal structured error implementation: no text message.
Support DF flag, but just ignore it, as there is no segmentation any
way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171027104037.8319-8-eblake@redhat.com>
---
 nbd/server.c     | 107 +++++++++++++++++++++++++++++++++++++++++++++++++------
 nbd/trace-events |   2 ++
 2 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index cf815603a6..3261fd1bd7 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -100,6 +100,8 @@ struct NBDClient {
     QTAILQ_ENTRY(NBDClient) next;
     int nb_requests;
     bool closing;
+
+    bool structured_reply;
 };

 /* That's all folks */
@@ -769,6 +771,23 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                      "TLS not configured");
                 }
                 break;
+
+            case NBD_OPT_STRUCTURED_REPLY:
+                if (length) {
+                    ret = nbd_reject_length(client, length, option, false,
+                                            errp);
+                } else if (client->structured_reply) {
+                    ret = nbd_negotiate_send_rep_err(
+                        client->ioc, NBD_REP_ERR_INVALID, option, errp,
+                        "structured reply already negotiated");
+                } else {
+                    ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
+                                                 option, errp);
+                    client->structured_reply = true;
+                    myflags |= NBD_FLAG_SEND_DF;
+                }
+                break;
+
             default:
                 if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
@@ -1243,6 +1262,60 @@ static int nbd_co_send_simple_reply(NBDClient *client,
     return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
 }

+static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
+                                uint16_t type, uint64_t handle, uint32_t length)
+{
+    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
+    stw_be_p(&chunk->flags, flags);
+    stw_be_p(&chunk->type, type);
+    stq_be_p(&chunk->handle, handle);
+    stl_be_p(&chunk->length, length);
+}
+
+static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
+                                                    uint64_t handle,
+                                                    uint64_t offset,
+                                                    void *data,
+                                                    size_t size,
+                                                    Error **errp)
+{
+    NBDStructuredRead chunk;
+    struct iovec iov[] = {
+        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+        {.iov_base = data, .iov_len = size}
+    };
+
+    trace_nbd_co_send_structured_read(handle, offset, data, size);
+    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_OFFSET_DATA,
+                 handle, sizeof(chunk) - sizeof(chunk.h) + size);
+    stq_be_p(&chunk.offset, offset);
+
+    return nbd_co_send_iov(client, iov, 2, errp);
+}
+
+static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
+                                                     uint64_t handle,
+                                                     uint32_t error,
+                                                     Error **errp)
+{
+    NBDStructuredError chunk;
+    int nbd_err = system_errno_to_nbd_errno(error);
+    struct iovec iov[] = {
+        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+        /* FIXME: Support human-readable error message */
+    };
+
+    assert(nbd_err);
+    trace_nbd_co_send_structured_error(handle, nbd_err,
+                                       nbd_err_lookup(nbd_err));
+    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
+                 sizeof(chunk) - sizeof(chunk.h));
+    stl_be_p(&chunk.error, nbd_err);
+    stw_be_p(&chunk.message_length, 0);
+
+    return nbd_co_send_iov(client, iov, 1, errp);
+}
+
 /* nbd_co_receive_request
  * Collect a client request. Return 0 if request looks valid, -EIO to drop
  * connection right away, and any other negative value to report an error to
@@ -1253,6 +1326,7 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
                                   Error **errp)
 {
     NBDClient *client = req->client;
+    int valid_flags;

     g_assert(qemu_in_coroutine());
     assert(client->recv_coroutine == qemu_coroutine_self());
@@ -1314,13 +1388,15 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
                    (uint64_t)client->exp->size);
         return request->type == NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
     }
-    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) {
-        error_setg(errp, "unsupported flags (got 0x%x)", request->flags);
-        return -EINVAL;
+    valid_flags = NBD_CMD_FLAG_FUA;
+    if (request->type == NBD_CMD_READ && client->structured_reply) {
+        valid_flags |= NBD_CMD_FLAG_DF;
+    } else if (request->type == NBD_CMD_WRITE_ZEROES) {
+        valid_flags |= NBD_CMD_FLAG_NO_HOLE;
     }
-    if (request->type != NBD_CMD_WRITE_ZEROES &&
-        (request->flags & NBD_CMD_FLAG_NO_HOLE)) {
-        error_setg(errp, "unexpected flags (got 0x%x)", request->flags);
+    if (request->flags & ~valid_flags) {
+        error_setg(errp, "unsupported flags for command %s (got 0x%x)",
+                   nbd_cmd_lookup(request->type), request->flags);
         return -EINVAL;
     }

@@ -1458,10 +1534,21 @@ reply:
         local_err = NULL;
     }

-    if (nbd_co_send_simple_reply(req->client, request.handle,
-                                 ret < 0 ? -ret : 0,
-                                 req->data, reply_data_len, &local_err) < 0)
-    {
+    if (client->structured_reply && request.type == NBD_CMD_READ) {
+        if (ret < 0) {
+            ret = nbd_co_send_structured_error(req->client, request.handle,
+                                               -ret, &local_err);
+        } else {
+            ret = nbd_co_send_structured_read(req->client, request.handle,
+                                              request.from, req->data,
+                                              reply_data_len, &local_err);
+        }
+    } else {
+        ret = nbd_co_send_simple_reply(req->client, request.handle,
+                                       ret < 0 ? -ret : 0,
+                                       req->data, reply_data_len, &local_err);
+    }
+    if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
     }
diff --git a/nbd/trace-events b/nbd/trace-events
index ab3d7dad4f..6894f8bbb4 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -56,6 +56,8 @@ nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
+nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
+nbd_co_send_structured_error(uint64_t handle, int err, const char *errname) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s)"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
 nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " byte(s)"
-- 
2.13.6
