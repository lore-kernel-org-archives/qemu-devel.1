Received: from eggs.gnu.org ([2001:4830:134:3::10]:36728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5o-0007oz-4w
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-00081b-2Z
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:08 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:2837 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007xZ-J4
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:42 +0300
Message-Id: <20170203154757.36140-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 03/18] nbd: Minimal structured read for server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Minimal implementation of structured read: one data chunk + finishing
none chunk. No segmentation.
Minimal structured error implementation: no text message.
Support DF flag, but just ignore it, as there is no segmentation any
way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  31 +++++++++++++
 nbd/nbd-internal.h  |   2 +
 nbd/server.c        | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3c65cf8d87..58b864f145 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -70,6 +70,25 @@ struct NBDSimpleReply {
 };
 typedef struct NBDSimpleReply NBDSimpleReply;
 
+typedef struct NBDStructuredReplyChunk {
+    uint32_t magic;
+    uint16_t flags;
+    uint16_t type;
+    uint64_t handle;
+    uint32_t length;
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
 #define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
@@ -79,6 +98,7 @@ typedef struct NBDSimpleReply NBDSimpleReply;
 #define NBD_FLAG_ROTATIONAL     (1 << 4)        /* Use elevator algorithm - rotational media */
 #define NBD_FLAG_SEND_TRIM      (1 << 5)        /* Send TRIM (discard) */
 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6)     /* Send WRITE_ZEROES */
+#define NBD_FLAG_SEND_DF        (1 << 7)        /* Send DF (Do not Fragment) */
 
 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
@@ -106,6 +126,7 @@ typedef struct NBDSimpleReply NBDSimpleReply;
 /* Request flags, sent from client to server during transmission phase */
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
 #define NBD_CMD_FLAG_NO_HOLE    (1 << 1) /* don't punch hole on zero run */
+#define NBD_CMD_FLAG_DF         (1 << 2) /* don't fragment structured read */
 
 /* Supported request types */
 enum {
@@ -130,6 +151,16 @@ enum {
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256
 
+/* Structured reply flags */
+#define NBD_REPLY_FLAG_DONE 1
+
+/* Structured reply types */
+#define NBD_REPLY_TYPE_NONE 0
+#define NBD_REPLY_TYPE_OFFSET_DATA 1
+#define NBD_REPLY_TYPE_OFFSET_HOLE 2
+#define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
+#define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)
+
 ssize_t nbd_wr_syncv(QIOChannel *ioc,
                      struct iovec *iov,
                      size_t niov,
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 49b66b6896..489eeaf887 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -60,6 +60,7 @@
 #define NBD_REPLY_SIZE          (4 + 4 + 8)
 #define NBD_REQUEST_MAGIC       0x25609513
 #define NBD_SIMPLE_REPLY_MAGIC  0x67446698
+#define NBD_STRUCTURED_REPLY_MAGIC 0x668e33ef
 #define NBD_OPTS_MAGIC          0x49484156454F5054LL
 #define NBD_CLIENT_MAGIC        0x0000420281861253LL
 #define NBD_REP_MAGIC           0x0003e889045565a9LL
@@ -81,6 +82,7 @@
 #define NBD_OPT_LIST            (3)
 #define NBD_OPT_PEEK_EXPORT     (4)
 #define NBD_OPT_STARTTLS        (5)
+#define NBD_OPT_STRUCTURED_REPLY (8)
 
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
  * but only a limited set of errno values is specified in the protocol.
diff --git a/nbd/server.c b/nbd/server.c
index 4cfc02123b..cb79a93c87 100644
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
@@ -573,6 +575,16 @@ static int nbd_negotiate_options(NBDClient *client)
                     return ret;
                 }
                 break;
+
+            case NBD_OPT_STRUCTURED_REPLY:
+                client->structured_reply = true;
+                ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
+                                             clientflags);
+                if (ret < 0) {
+                    return ret;
+                }
+                break;
+
             default:
                 if (nbd_negotiate_drop_sync(client->ioc, length) != length) {
                     return -EIO;
@@ -1067,6 +1079,86 @@ static ssize_t nbd_co_send_simple_reply(NBDRequestData *req,
     return rc;
 }
 
+static void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
+                         uint16_t type, uint64_t handle, uint32_t length)
+{
+    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
+    stw_be_p(&chunk->flags, flags);
+    stw_be_p(&chunk->type, type);
+    stq_be_p(&chunk->handle, handle);
+    stl_be_p(&chunk->length, length);
+}
+
+static int nbd_co_send_iov(NBDClient *client, struct iovec *iov, unsigned niov)
+{
+    ssize_t ret;
+    size_t size = iov_size(iov, niov);
+
+    g_assert(qemu_in_coroutine());
+    qemu_co_mutex_lock(&client->send_lock);
+    client->send_coroutine = qemu_coroutine_self();
+    nbd_set_handlers(client);
+
+    ret = nbd_wr_syncv(client->ioc, iov, niov, size, false);
+    if (ret >= 0 && ret != size) {
+        ret = -EIO;
+    }
+
+    client->send_coroutine = NULL;
+    nbd_set_handlers(client);
+    qemu_co_mutex_unlock(&client->send_lock);
+
+    return ret;
+}
+
+static inline int nbd_co_send_buf(NBDClient *client, void *buf, size_t size)
+{
+    struct iovec iov[] = {
+        {.iov_base = buf, .iov_len = size}
+    };
+
+    return nbd_co_send_iov(client, iov, 1);
+}
+
+static int nbd_co_send_structured_read(NBDClient *client, uint64_t handle,
+                                       uint64_t offset, void *data, size_t size)
+{
+    NBDStructuredRead chunk;
+
+    struct iovec iov[] = {
+        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+        {.iov_base = data, .iov_len = size}
+    };
+
+    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_OFFSET_DATA, handle,
+                 sizeof(chunk) - sizeof(chunk.h) + size);
+    stq_be_p(&chunk.offset, offset);
+
+    return nbd_co_send_iov(client, iov, 2);
+}
+
+static int nbd_co_send_structured_error(NBDClient *client, uint64_t handle,
+                                        uint32_t error)
+{
+    NBDStructuredError chunk;
+
+    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
+                 sizeof(chunk) - sizeof(chunk.h));
+    stl_be_p(&chunk.error, error);
+    stw_be_p(&chunk.message_length, 0);
+
+    return nbd_co_send_buf(client, &chunk, sizeof(chunk));
+}
+
+static int nbd_co_send_structured_none(NBDClient *client, uint64_t handle)
+{
+    NBDStructuredReplyChunk chunk;
+
+    set_be_chunk(&chunk, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE, handle, 0);
+
+    return nbd_co_send_buf(client, &chunk, sizeof(chunk));
+}
+
 /* Collect a client request.  Return 0 if request looks valid, -EAGAIN
  * to keep trying the collection, -EIO to drop connection right away,
  * and any other negative value to report an error to the client
@@ -1147,7 +1239,8 @@ static ssize_t nbd_co_receive_request(NBDRequestData *req,
         rc = request->type == NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
         goto out;
     }
-    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) {
+    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE |
+                           NBD_CMD_FLAG_DF)) {
         LOG("unsupported flags (got 0x%x)", request->flags);
         rc = -EINVAL;
         goto out;
@@ -1226,12 +1319,34 @@ static void nbd_trip(void *opaque)
                         req->data, request.len);
         if (ret < 0) {
             LOG("reading from file failed");
-            reply.error = -ret;
-            goto error_reply;
+            if (client->structured_reply) {
+                ret = nbd_co_send_structured_error(req->client, request.handle,
+                                                   -ret);
+                if (ret < 0) {
+                    goto out;
+                } else {
+                    break;
+                }
+            } else {
+                reply.error = -ret;
+                goto error_reply;
+            }
         }
 
         TRACE("Read %" PRIu32" byte(s)", request.len);
-        if (nbd_co_send_simple_reply(req, &reply, request.len) < 0) {
+        if (client->structured_reply) {
+            ret = nbd_co_send_structured_read(req->client, request.handle,
+                                              request.from, req->data,
+                                              request.len);
+            if (ret < 0) {
+                goto out;
+            }
+
+            ret = nbd_co_send_structured_none(req->client, request.handle);
+        } else {
+            ret = nbd_co_send_simple_reply(req, &reply, request.len);
+        }
+        if (ret < 0) {
             goto out;
         }
         break;
@@ -1444,6 +1559,8 @@ void nbd_client_new(NBDExport *exp,
     client->can_read = true;
     client->close = close_fn;
 
+    client->structured_reply = false;
+
     data->client = client;
     data->co = qemu_coroutine_create(nbd_co_client_start, data);
     qemu_coroutine_enter(data->co);
-- 
2.11.0
