Received: from eggs.gnu.org ([2001:4830:134:3::10]:39657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtz-0006YZ-KV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtv-0007DW-RN
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:27 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33731 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwTtv-0007C2-An
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 16:57:59 +0300
Message-Id: <20170925135801.144261-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 6/8] nbd: Minimal structured read for server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Hmreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Minimal implementation of structured read: one structured reply chunk,
no segmentation.
Minimal structured error implementation: no text message.
Support DF flag, but just ignore it, as there is no segmentation any
way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  31 ++++++++++++++++
 nbd/nbd-internal.h  |   1 +
 nbd/server.c        | 100 ++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 126 insertions(+), 6 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index a6df5ce8b5..314f2f9bbc 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -69,6 +69,25 @@ typedef struct NBDSimpleReply {
     uint64_t handle;
 } QEMU_PACKED NBDSimpleReply;
 
+typedef struct NBDStructuredReplyChunk {
+    uint32_t magic;  /* NBD_STRUCTURED_REPLY_MAGIC */
+    uint16_t flags;  /* combination of NBD_SREP_FLAG_* */
+    uint16_t type;   /* NBD_SREP_TYPE_* */
+    uint64_t handle; /* request handle */
+    uint32_t length; /* length of payload */
+} QEMU_PACKED NBDStructuredReplyChunk;
+
+typedef struct NBDStructuredRead {
+    NBDStructuredReplyChunk h;
+    uint64_t offset;
+} QEMU_PACKED NBDStructuredRead;
+
+typedef struct NBDStructuredError {
+    NBDStructuredReplyChunk h;
+    uint32_t error;
+    uint16_t message_length;
+} QEMU_PACKED NBDStructuredError;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
@@ -79,6 +98,7 @@ typedef struct NBDSimpleReply {
                                                rotational media */
 #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
+#define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
 
 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
@@ -125,6 +145,7 @@ typedef struct NBDSimpleReply {
 /* Request flags, sent from client to server during transmission phase */
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
 #define NBD_CMD_FLAG_NO_HOLE    (1 << 1) /* don't punch hole on zero run */
+#define NBD_CMD_FLAG_DF         (1 << 2) /* don't fragment structured read */
 
 /* Supported request types */
 enum {
@@ -149,6 +170,16 @@ enum {
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256
 
+/* Structured reply flags */
+#define NBD_SREP_FLAG_DONE          (1 << 0) /* This reply-chunk is last */
+
+/* Structured reply types */
+#define NBD_SREP_ERR(value)         ((1 << 15) | (value))
+
+#define NBD_SREP_TYPE_NONE          0
+#define NBD_SREP_TYPE_OFFSET_DATA   1
+#define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
+
 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
 struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index d96c9cc7fd..6b0d1183ba 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -48,6 +48,7 @@
 
 #define NBD_REQUEST_MAGIC           0x25609513
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
+#define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
 #define NBD_OPTS_MAGIC              0x49484156454F5054LL
 #define NBD_CLIENT_MAGIC            0x0000420281861253LL
 #define NBD_REP_MAGIC               0x0003e889045565a9LL
diff --git a/nbd/server.c b/nbd/server.c
index 57d5598e0f..0af94a293d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -98,6 +98,8 @@ struct NBDClient {
     QTAILQ_ENTRY(NBDClient) next;
     int nb_requests;
     bool closing;
+
+    bool structured_reply;
 };
 
 /* That's all folks */
@@ -760,6 +762,20 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                     return ret;
                 }
                 break;
+
+            case NBD_OPT_STRUCTURED_REPLY:
+                if (client->structured_reply) {
+                    error_setg(errp, "Double negotiation of structured reply");
+                    return -EINVAL;
+                }
+                ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, option,
+                                             errp);
+                if (ret < 0) {
+                    return ret;
+                }
+                client->structured_reply = true;
+                break;
+
             default:
                 if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
@@ -1233,6 +1249,61 @@ static int nbd_co_send_simple_reply(NBDClient *client,
     return nbd_co_send_iov(client, iov, size ? 2 : 1, errp);
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
+static inline int coroutine_fn nbd_co_send_buf(NBDClient *client, void *buf,
+                                               size_t size, Error **errp)
+{
+    struct iovec iov[] = {
+        {.iov_base = buf, .iov_len = size}
+    };
+
+    return nbd_co_send_iov(client, iov, 1, errp);
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
+    set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_OFFSET_DATA,
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
+
+    set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_ERROR, handle,
+                 sizeof(chunk) - sizeof(chunk.h));
+    stl_be_p(&chunk.error, error);
+    stw_be_p(&chunk.message_length, 0);
+
+    return nbd_co_send_buf(client, &chunk, sizeof(chunk), errp);
+}
+
 /* nbd_co_receive_request
  * Collect a client request. Return 0 if request looks valid, -EIO to drop
  * connection right away, and any other negative value to report an error to
@@ -1304,10 +1375,17 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
                    (uint64_t)client->exp->size);
         return request->type == NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
     }
-    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) {
+    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE |
+                           NBD_CMD_FLAG_DF))
+    {
         error_setg(errp, "unsupported flags (got 0x%x)", request->flags);
         return -EINVAL;
     }
+    if (request->type != NBD_CMD_READ && (request->flags & NBD_CMD_FLAG_DF)) {
+        error_setg(errp, "DF flag used with command %d (%s) which is not READ",
+                   request->type, nbd_cmd_lookup(request->type));
+        return -EINVAL;
+    }
     if (request->type != NBD_CMD_WRITE_ZEROES &&
         (request->flags & NBD_CMD_FLAG_NO_HOLE)) {
         error_setg(errp, "unexpected flags (got 0x%x)", request->flags);
@@ -1374,7 +1452,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         }
 
         reply_data_len = request.len;
-
         break;
     case NBD_CMD_WRITE:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
@@ -1447,10 +1524,21 @@ reply:
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
-- 
2.11.1
