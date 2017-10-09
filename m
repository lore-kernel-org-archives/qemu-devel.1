Received: from eggs.gnu.org ([2001:4830:134:3::10]:50532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq5-0000V6-2o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq1-0004de-1e
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:40414 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004ZL-Dx
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:22 +0300
Message-Id: <20171009172723.190282-17-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 09/10] nbd/client: prepare nbd_receive_reply
 for structured reply
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

In following patch nbd_receive_reply will be used both for simple
and structured reply header receiving.
NBDReply is altered into union of simple reply header and structured
reply chunk header, simple error translation moved to block/nbd-client
to be consistent with further structured reply error translation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  30 ++++++++++++----
 block/nbd-client.c  |   8 +++--
 nbd/client.c        | 102 +++++++++++++++++++++++++++++++++++++++++-----------
 nbd/trace-events    |   3 +-
 4 files changed, 113 insertions(+), 30 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 09e4592971..1ef8c8897f 100644
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
@@ -77,9 +71,33 @@ typedef struct NBDStructuredReplyChunk {
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
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
 #define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
 
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
 typedef struct NBDStructuredRead {
     NBDStructuredReplyChunk h;
     uint64_t offset;
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
index f0f3075569..a38e1a7d8e 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -910,6 +910,57 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
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
@@ -917,37 +968,48 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
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
 
-    reply->error = nbd_errno_to_system_errno(reply->error);
+        if (reply->simple.error == NBD_ESHUTDOWN) {
+            /* This works even on mingw which lacks a native ESHUTDOWN */
+            error_setg(errp, "server shutting down");
+            return -EINVAL;
+        }
 
-    if (reply->error == ESHUTDOWN) {
-        /* This works even on mingw which lacks a native ESHUTDOWN */
-        error_setg(errp, "server shutting down");
+        trace_nbd_receive_simple_reply(
+                nbd_errno_to_system_errno(reply->simple.error),
+                reply->simple.handle);
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
-    trace_nbd_receive_reply(magic, reply->error, reply->handle);
-
-    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
-        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
-        return -EINVAL;
+    if (ret < 0) {
+        return ret;
     }
 
     return 1;
diff --git a/nbd/trace-events b/nbd/trace-events
index ea44e6963f..647df4152c 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -30,7 +30,8 @@ nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
 nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
-nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"
+nbd_receive_simple_reply(int32_t error, uint64_t handle) "Got simple reply: { error = % " PRId32 ", handle = %" PRIu64" }"
+nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, uint64_t handle, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d, handle = %" PRIu64 ", length = %" PRIu32 " }"
 
 # nbd/server.c
 nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=0x%" PRIx32 " (%s), type=0x%" PRIx32 " (%s), len=%" PRIu32
-- 
2.11.1
