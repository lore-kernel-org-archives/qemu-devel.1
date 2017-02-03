Received: from eggs.gnu.org ([2001:4830:134:3::10]:36703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007ng-Cn
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-00081v-4G
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:45806 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007yr-Ji
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:46 +0300
Message-Id: <20170203154757.36140-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 07/18] nbd: Minimal structured read for client
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

Minimal implementation: always send DF flag, to not deal with fragmented
replies.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c  |  47 +++++++++++----
 block/nbd-client.h  |   2 +
 include/block/nbd.h |  15 +++--
 nbd/client.c        | 170 ++++++++++++++++++++++++++++++++++++++++++++++------
 qemu-nbd.c          |   2 +-
 5 files changed, 203 insertions(+), 33 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 3779c6c999..ff96bd1635 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -180,13 +180,20 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     *reply = s->reply;
     if (reply->handle != request->handle ||
         !s->ioc) {
+        reply->simple = true;
         reply->error = EIO;
     } else {
-        if (qiov && reply->error == 0) {
-            ret = nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, request->len,
-                               true);
-            if (ret != request->len) {
-                reply->error = EIO;
+        if (qiov) {
+            if ((reply->simple ? reply->error == 0 :
+                         reply->type == NBD_REPLY_TYPE_OFFSET_DATA)) {
+                ret = nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, request->len,
+                                   true);
+                if (ret != request->len) {
+                    reply->error = EIO;
+                }
+            } else if (!reply->simple &&
+                       reply->type == NBD_REPLY_TYPE_OFFSET_HOLE) {
+                qemu_iovec_memset(qiov, 0, 0, request->len);
             }
         }
 
@@ -227,6 +234,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
         .type = NBD_CMD_READ,
         .from = offset,
         .len = bytes,
+        .flags = client->structured_reply ? NBD_CMD_FLAG_DF : 0,
     };
     NBDReply reply;
     ssize_t ret;
@@ -237,12 +245,30 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     nbd_coroutine_start(client, &request);
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, &request, &reply, qiov);
+        goto out;
     }
+
+    nbd_co_receive_reply(client, &request, &reply, qiov);
+    if (reply.error != 0) {
+        ret = -reply.error;
+    }
+
+    if (!reply.simple) {
+        while (!(reply.flags & NBD_REPLY_FLAG_DONE)) {
+            nbd_co_receive_reply(client, &request, &reply, qiov);
+            if (reply.error != 0) {
+                ret = -reply.error;
+            }
+            if (reply.simple) {
+                ret = -EIO;
+                goto out;
+            }
+        }
+    }
+
+out:
     nbd_coroutine_end(client, &request);
-    return -reply.error;
+    return ret;
 }
 
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -408,7 +434,8 @@ int nbd_client_init(BlockDriverState *bs,
                                 &client->nbdflags,
                                 tlscreds, hostname,
                                 &client->ioc,
-                                &client->size, errp);
+                                &client->size,
+                                &client->structured_reply, errp);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
         return ret;
diff --git a/block/nbd-client.h b/block/nbd-client.h
index f8d6006849..cba1f965bf 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -32,6 +32,8 @@ typedef struct NBDClientSession {
     NBDReply reply;
 
     bool is_unix;
+
+    bool structured_reply;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 58b864f145..dae2e4bd03 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -57,11 +57,16 @@ struct NBDRequest {
 };
 typedef struct NBDRequest NBDRequest;
 
-struct NBDReply {
+typedef struct NBDReply {
+    bool simple;
     uint64_t handle;
     uint32_t error;
-};
-typedef struct NBDReply NBDReply;
+
+    uint16_t flags;
+    uint16_t type;
+    uint32_t length;
+    uint64_t offset;
+} NBDReply;
 
 struct NBDSimpleReply {
     /* uint32_t NBD_SIMPLE_REPLY_MAGIC */
@@ -169,10 +174,10 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
-                          off_t *size, Error **errp);
+                          off_t *size, bool *structured_reply, Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size);
 ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
-ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
+int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
 
diff --git a/nbd/client.c b/nbd/client.c
index 1c274f3012..9225f7e30d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -472,11 +472,10 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     return QIO_CHANNEL(tioc);
 }
 
-
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
-                          off_t *size, Error **errp)
+                          off_t *size, bool *structured_reply, Error **errp)
 {
     char buf[256];
     uint64_t magic, s;
@@ -584,6 +583,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             if (nbd_receive_query_exports(ioc, name, errp) < 0) {
                 goto fail;
             }
+
+            if (structured_reply != NULL) {
+                *structured_reply =
+                    nbd_receive_simple_option(ioc, NBD_OPT_STRUCTURED_REPLY,
+                                              false, NULL) == 0;
+            }
         }
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, name,
@@ -603,6 +608,14 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             goto fail;
         }
         be16_to_cpus(flags);
+
+        if (!!structured_reply && *structured_reply &&
+            !(*flags & NBD_CMD_FLAG_DF))
+        {
+            error_setg(errp, "Structured reply is negotiated, "
+                             "but DF flag is not.");
+            goto fail;
+        }
     } else if (magic == NBD_CLIENT_MAGIC) {
         uint32_t oldflags;
 
@@ -790,20 +803,33 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     return 0;
 }
 
-ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
+static inline int read_sync_check(QIOChannel *ioc, void *buffer, size_t size)
 {
-    uint8_t buf[NBD_REPLY_SIZE];
-    uint32_t magic;
     ssize_t ret;
 
-    ret = read_sync(ioc, buf, sizeof(buf));
+    ret = read_sync(ioc, buffer, size);
     if (ret < 0) {
         return ret;
     }
-
-    if (ret != sizeof(buf)) {
+    if (ret != size) {
         LOG("read failed");
-        return -EINVAL;
+        return -EIO;
+    }
+
+    return 0;
+}
+
+/* nbd_receive_simple_reply
+ * Read simple reply except magic field (which should be already read)
+ */
+static int nbd_receive_simple_reply(QIOChannel *ioc, NBDReply *reply)
+{
+    uint8_t buf[NBD_REPLY_SIZE - 4];
+    ssize_t ret;
+
+    ret = read_sync_check(ioc, buf, sizeof(buf));
+    if (ret < 0) {
+        return ret;
     }
 
     /* Reply
@@ -812,9 +838,124 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
        [ 7 .. 15]    handle
      */
 
-    magic = ldl_be_p(buf);
-    reply->error  = ldl_be_p(buf + 4);
-    reply->handle = ldq_be_p(buf + 8);
+    reply->error  = ldl_be_p(buf);
+    reply->handle = ldq_be_p(buf + 4);
+
+    return 0;
+}
+
+/* nbd_receive_structured_reply_chunk
+ * Read structured reply chunk except magic field (which should be already read)
+ * Data for NBD_REPLY_TYPE_OFFSET_DATA is not read too.
+ * Length field of reply out parameter corresponds to unread part of reply.
+ */
+static int nbd_receive_structured_reply_chunk(QIOChannel *ioc, NBDReply *reply)
+{
+    NBDStructuredReplyChunk chunk;
+    ssize_t ret;
+    uint16_t message_size;
+
+    ret = read_sync_check(ioc, (uint8_t *)&chunk + sizeof(chunk.magic),
+                          sizeof(chunk) - sizeof(chunk.magic));
+    if (ret < 0) {
+        return ret;
+    }
+
+    reply->flags = be16_to_cpu(chunk.flags);
+    reply->type = be16_to_cpu(chunk.type);
+    reply->handle = be64_to_cpu(chunk.handle);
+    reply->length = be32_to_cpu(chunk.length);
+
+    switch (reply->type) {
+    case NBD_REPLY_TYPE_NONE:
+        break;
+    case NBD_REPLY_TYPE_OFFSET_DATA:
+    case NBD_REPLY_TYPE_OFFSET_HOLE:
+        ret = read_sync_check(ioc, &reply->offset, sizeof(reply->offset));
+        if (ret < 0) {
+            return ret;
+        }
+        be64_to_cpus(&reply->offset);
+        reply->length -= sizeof(reply->offset);
+        break;
+    case NBD_REPLY_TYPE_ERROR:
+    case NBD_REPLY_TYPE_ERROR_OFFSET:
+        ret = read_sync_check(ioc, &reply->error, sizeof(reply->error));
+        if (ret < 0) {
+            return ret;
+        }
+        be32_to_cpus(&reply->error);
+
+        ret = read_sync_check(ioc, &message_size, sizeof(message_size));
+        if (ret < 0) {
+            return ret;
+        }
+        be16_to_cpus(&message_size);
+
+        if (message_size > 0) {
+            /* TODO: provide error message to user */
+            ret = drop_sync(ioc, message_size);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+
+        if (reply->type == NBD_REPLY_TYPE_ERROR_OFFSET) {
+            /* drop 64bit offset */
+            ret = drop_sync(ioc, 8);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        break;
+    default:
+        if (reply->type & (1 << 15)) {
+            /* unknown error */
+            ret = drop_sync(ioc, reply->length);
+            if (ret < 0) {
+                return ret;
+            }
+
+            reply->error = NBD_EINVAL;
+            reply->length = 0;
+        } else {
+            /* unknown non-error reply type */
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
+int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
+{
+    uint32_t magic;
+    int ret;
+
+    ret = read_sync_check(ioc, &magic, sizeof(magic));
+    if (ret < 0) {
+        return ret;
+    }
+
+    be32_to_cpus(&magic);
+
+    switch (magic) {
+    case NBD_SIMPLE_REPLY_MAGIC:
+        reply->simple = true;
+        ret = nbd_receive_simple_reply(ioc, reply);
+        break;
+    case NBD_STRUCTURED_REPLY_MAGIC:
+        reply->simple = false;
+        ret = nbd_receive_structured_reply_chunk(ioc, reply);
+        break;
+    default:
+        LOG("invalid magic (got 0x%" PRIx32 ")", magic);
+        return -EINVAL;
+    }
+
+    if (ret < 0) {
+        return ret;
+    }
 
     reply->error = nbd_errno_to_system_errno(reply->error);
 
@@ -827,10 +968,5 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
           ", handle = %" PRIu64" }",
           magic, reply->error, reply->handle);
 
-    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
-        LOG("invalid magic (got 0x%" PRIx32 ")", magic);
-        return -EINVAL;
-    }
     return 0;
 }
-
diff --git a/qemu-nbd.c b/qemu-nbd.c
index c734f627b4..de0099e333 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -272,7 +272,7 @@ static void *nbd_client_thread(void *arg)
 
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL, &nbdflags,
                                 NULL, NULL, NULL,
-                                &size, &local_error);
+                                &size, NULL, &local_error);
     if (ret < 0) {
         if (local_error) {
             error_report_err(local_error);
-- 
2.11.0
