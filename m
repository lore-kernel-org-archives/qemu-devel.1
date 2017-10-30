Received: from eggs.gnu.org ([2001:4830:134:3::10]:50851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7T-0000Fh-RD
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7S-0001UE-AK
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:15 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 30 Oct 2017 21:56:34 +0100
Message-Id: <20171030205636.14236-11-eblake@redhat.com>
In-Reply-To: <20171030205636.14236-1-eblake@redhat.com>
References: <20171030205636.14236-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] nbd/client: prepare nbd_receive_reply for
 structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In following patch nbd_receive_reply will be used both for simple
and structured reply header receiving.
NBDReply is altered into union of simple reply header and structured
reply chunk header, simple error translation moved to block/nbd-client
to be consistent with further structured reply error translation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171027104037.8319-11-eblake@redhat.com>
---
 include/block/nbd.h |  30 ++++++++++++---
 block/nbd-client.c  |   8 ++--
 nbd/client.c        | 104 +++++++++++++++++++++++++++++++++++++++++-----------
 nbd/trace-events    |   3 +-
 4 files changed, 113 insertions(+), 32 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 225e9575e4..2ee1578420 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -57,12 +57,6 @@ struct NBDRequest {
 };
 typedef struct NBDRequest NBDRequest;

-struct NBDReply {
-    uint64_t handle;
-    uint32_t error;
-};
-typedef struct NBDReply NBDReply;
-
 typedef struct NBDSimpleReply {
     uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
     uint32_t error;
@@ -78,6 +72,20 @@ typedef struct NBDStructuredReplyChunk {
     uint32_t length; /* length of payload */
 } QEMU_PACKED NBDStructuredReplyChunk;

+typedef union NBDReply {
+    NBDSimpleReply simple;
+    NBDStructuredReplyChunk structured;
+    struct {
+        /* @magic and @handle fields have the same offset and size both in
+         * simple reply and structured reply chunk, so let them be accessible
+         * without ".simple." or ".structured." specification
+         */
+        uint32_t magic;
+        uint32_t _skip;
+        uint64_t handle;
+    } QEMU_PACKED;
+} NBDReply;
+
 /* Header of NBD_REPLY_TYPE_OFFSET_DATA, complete NBD_REPLY_TYPE_OFFSET_HOLE */
 typedef struct NBDStructuredRead {
     NBDStructuredReplyChunk h;
@@ -256,4 +264,14 @@ void nbd_client_put(NBDClient *client);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       Error **errp);

+static inline bool nbd_reply_is_simple(NBDReply *reply)
+{
+    return reply->magic == NBD_SIMPLE_REPLY_MAGIC;
+}
+
+static inline bool nbd_reply_is_structured(NBDReply *reply)
+{
+    return reply->magic == NBD_STRUCTURED_REPLY_MAGIC;
+}
+
 #endif
diff --git a/block/nbd-client.c b/block/nbd-client.c
index c0683c3c83..58493b7ac4 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -92,7 +92,9 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         i = HANDLE_TO_INDEX(s, s->reply.handle);
         if (i >= MAX_NBD_REQUESTS ||
             !s->requests[i].coroutine ||
-            !s->requests[i].receiving) {
+            !s->requests[i].receiving ||
+            nbd_reply_is_structured(&s->reply))
+        {
             break;
         }

@@ -194,8 +196,8 @@ static int nbd_co_receive_reply(NBDClientSession *s,
         ret = -EIO;
     } else {
         assert(s->reply.handle == handle);
-        ret = -s->reply.error;
-        if (qiov && s->reply.error == 0) {
+        ret = -nbd_errno_to_system_errno(s->reply.simple.error);
+        if (qiov && ret == 0) {
             if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
                                       NULL) < 0) {
                 ret = -EIO;
diff --git a/nbd/client.c b/nbd/client.c
index 9acf745b79..4f0745f601 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -908,6 +908,57 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     return nbd_write(ioc, buf, sizeof(buf), NULL);
 }

+/* nbd_receive_simple_reply
+ * Read simple reply except magic field (which should be already read).
+ * Payload is not read (payload is possible for CMD_READ, but here we even
+ * don't know whether it take place or not).
+ */
+static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply,
+                                    Error **errp)
+{
+    int ret;
+
+    assert(reply->magic == NBD_SIMPLE_REPLY_MAGIC);
+
+    ret = nbd_read(ioc, (uint8_t *)reply + sizeof(reply->magic),
+                   sizeof(*reply) - sizeof(reply->magic), errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    be32_to_cpus(&reply->error);
+    be64_to_cpus(&reply->handle);
+
+    return 0;
+}
+
+/* nbd_receive_structured_reply_chunk
+ * Read structured reply chunk except magic field (which should be already
+ * read).
+ * Payload is not read.
+ */
+static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
+                                              NBDStructuredReplyChunk *chunk,
+                                              Error **errp)
+{
+    int ret;
+
+    assert(chunk->magic == NBD_STRUCTURED_REPLY_MAGIC);
+
+    ret = nbd_read(ioc, (uint8_t *)chunk + sizeof(chunk->magic),
+                   sizeof(*chunk) - sizeof(chunk->magic), errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    be16_to_cpus(&chunk->flags);
+    be16_to_cpus(&chunk->type);
+    be64_to_cpus(&chunk->handle);
+    be32_to_cpus(&chunk->length);
+
+    return 0;
+}
+
 /* nbd_receive_reply
  * Returns 1 on success
  *         0 on eof, when no data was read (errp is not set)
@@ -915,38 +966,47 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
  */
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
-    uint8_t buf[NBD_REPLY_SIZE];
-    uint32_t magic;
     int ret;

-    ret = nbd_read_eof(ioc, buf, sizeof(buf), errp);
+    ret = nbd_read_eof(ioc, &reply->magic, sizeof(reply->magic), errp);
     if (ret <= 0) {
         return ret;
     }

-    /* Reply
-       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
-       [ 4 ..  7]    error   (0 == no error)
-       [ 7 .. 15]    handle
-     */
+    be32_to_cpus(&reply->magic);

-    magic = ldl_be_p(buf);
-    reply->error  = ldl_be_p(buf + 4);
-    reply->handle = ldq_be_p(buf + 8);
+    switch (reply->magic) {
+    case NBD_SIMPLE_REPLY_MAGIC:
+        ret = nbd_receive_simple_reply(ioc, &reply->simple, errp);
+        if (ret < 0) {
+            break;
+        }

-    trace_nbd_receive_reply(magic, reply->error, nbd_err_lookup(reply->error),
-                            reply->handle);
-    reply->error = nbd_errno_to_system_errno(reply->error);
-
-    if (reply->error == ESHUTDOWN) {
-        /* This works even on mingw which lacks a native ESHUTDOWN */
-        error_setg(errp, "server shutting down");
+        trace_nbd_receive_simple_reply(reply->simple.error,
+                                       nbd_err_lookup(reply->simple.error),
+                                       reply->handle);
+        if (reply->simple.error == NBD_ESHUTDOWN) {
+            /* This works even on mingw which lacks a native ESHUTDOWN */
+            error_setg(errp, "server shutting down");
+            return -EINVAL;
+        }
+        break;
+    case NBD_STRUCTURED_REPLY_MAGIC:
+        ret = nbd_receive_structured_reply_chunk(ioc, &reply->structured, errp);
+        if (ret < 0) {
+            break;
+        }
+        trace_nbd_receive_structured_reply_chunk(reply->structured.flags,
+                                                 reply->structured.type,
+                                                 reply->structured.handle,
+                                                 reply->structured.length);
+        break;
+    default:
+        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", reply->magic);
         return -EINVAL;
     }
-
-    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
-        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
-        return -EINVAL;
+    if (ret < 0) {
+        return ret;
     }

     return 1;
diff --git a/nbd/trace-events b/nbd/trace-events
index 596df96575..4a13757524 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -26,7 +26,8 @@ nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
 nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
-nbd_receive_reply(uint32_t magic, int32_t error, const char *errname, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = %" PRId32 " (%s), handle = %" PRIu64" }"
+nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t handle) "Got simple reply: { .error = %" PRId32 " (%s), handle = %" PRIu64" }"
+nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, uint64_t handle, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d, handle = %" PRIu64 ", length = %" PRIu32 " }"

 # nbd/common.c
 nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
-- 
2.13.6
