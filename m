Received: from eggs.gnu.org ([2001:4830:134:3::10]:39689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTu0-0006Zo-Oj
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtv-0007Dh-TN
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:28 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:8054 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwTtv-0007C9-Ak
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 16:58:01 +0300
Message-Id: <20170925135801.144261-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 8/8] nbd: Minimal structured read for client
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

Minimal implementation: drop most of additional error information.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h  |   2 +
 include/block/nbd.h |  15 ++++-
 block/nbd-client.c  |  97 +++++++++++++++++++++++++-----
 nbd/client.c        | 169 +++++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 249 insertions(+), 34 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index b435754b82..9e178de510 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -35,6 +35,8 @@ typedef struct NBDClientSession {
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     bool quit;
+
+    bool structured_reply;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 314f2f9bbc..7604e80c49 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -57,11 +57,17 @@ struct NBDRequest {
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
+    uint32_t tail_length;
+    uint64_t offset;
+    uint32_t hole_size;
+} NBDReply;
 
 typedef struct NBDSimpleReply {
     uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
@@ -178,12 +184,15 @@ enum {
 
 #define NBD_SREP_TYPE_NONE          0
 #define NBD_SREP_TYPE_OFFSET_DATA   1
+#define NBD_SREP_TYPE_OFFSET_HOLE   2
 #define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
+#define NBD_SREP_TYPE_ERROR_OFFSET  NBD_SREP_ERR(2)
 
 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
 struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
+    bool structured_reply;
     /* Set by server results during nbd_receive_negotiate() */
     uint64_t size;
     uint16_t flags;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index e4f0c789f4..bdf9299bb9 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -179,9 +179,10 @@ err:
     return rc;
 }
 
-static int nbd_co_receive_reply(NBDClientSession *s,
-                                uint64_t handle,
-                                QEMUIOVector *qiov)
+static int nbd_co_receive_1_reply_or_chunk(NBDClientSession *s,
+                                           uint64_t handle,
+                                           bool *cont,
+                                           QEMUIOVector *qiov)
 {
     int ret;
     int i = HANDLE_TO_INDEX(s, handle);
@@ -191,29 +192,95 @@ static int nbd_co_receive_reply(NBDClientSession *s,
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
     if (!s->ioc || s->quit) {
-        ret = -EIO;
-    } else {
-        assert(s->reply.handle == handle);
-        ret = -s->reply.error;
-        if (qiov && s->reply.error == 0) {
+        *cont = false;
+        return -EIO;
+    }
+
+    assert(s->reply.handle == handle);
+    *cont = !(s->reply.simple || (s->reply.flags & NBD_SREP_FLAG_DONE));
+    ret = -s->reply.error;
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (s->reply.simple) {
+        if (qiov) {
             if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
-                                      NULL) < 0) {
-                ret = -EIO;
-                s->quit = true;
+                                      NULL) < 0)
+            {
+                goto fatal;
             }
         }
+        goto out;
+    }
 
-        /* Tell the read handler to read another header.  */
-        s->reply.handle = 0;
+    /* here we deal with successful structured reply */
+    switch (s->reply.type) {
+        QEMUIOVector sub_qiov;
+    case NBD_SREP_TYPE_OFFSET_DATA:
+        if (!qiov || s->reply.offset + s->reply.tail_length > qiov->size) {
+            goto fatal;
+        }
+        qemu_iovec_init(&sub_qiov, qiov->niov);
+        qemu_iovec_concat(&sub_qiov, qiov, s->reply.offset,
+                          s->reply.tail_length);
+        ret = qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, NULL);
+        qemu_iovec_destroy(&sub_qiov);
+        if (ret < 0) {
+            goto fatal;
+        }
+        assert(ret == 0);
+        break;
+    case NBD_SREP_TYPE_OFFSET_HOLE:
+        if (!qiov || s->reply.offset + s->reply.hole_size > qiov->size) {
+            goto fatal;
+        }
+        qemu_iovec_memset(qiov, s->reply.offset, 0, s->reply.hole_size);
+        break;
+    case NBD_SREP_TYPE_NONE:
+        break;
+    default:
+        goto fatal;
     }
 
-    s->requests[i].coroutine = NULL;
+out:
+    /* For assert at loop start in nbd_read_reply_entry */
+    s->reply.handle = 0;
+
+    if (s->read_reply_co) {
+        aio_co_wake(s->read_reply_co);
+    }
+
+    return ret;
 
-    /* Kick the read_reply_co to get the next reply.  */
+fatal:
+    /* protocol or ioc failure */
+    *cont = false;
+    s->quit = true;
     if (s->read_reply_co) {
         aio_co_wake(s->read_reply_co);
     }
 
+    return -EIO;
+}
+
+static int nbd_co_receive_reply(NBDClientSession *s,
+                                uint64_t handle,
+                                QEMUIOVector *qiov)
+{
+    int ret = 0;
+    int i = HANDLE_TO_INDEX(s, handle);
+    bool cont = true;
+
+    while (cont) {
+        int rc = nbd_co_receive_1_reply_or_chunk(s, handle, &cont, qiov);
+        if (rc < 0 && ret == 0) {
+            ret = rc;
+        }
+    }
+
+    s->requests[i].coroutine = NULL;
+
     qemu_co_mutex_lock(&s->send_mutex);
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
diff --git a/nbd/client.c b/nbd/client.c
index 51ae492e92..880eb17b85 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -719,6 +719,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         if (fixedNewStyle) {
             int result;
 
+            result = nbd_request_simple_option(ioc, NBD_OPT_STRUCTURED_REPLY,
+                                               errp);
+            if (result < 0) {
+                goto fail;
+            }
+            info->structured_reply = result > 0;
+
             /* Try NBD_OPT_GO first - if it works, we are done (it
              * also gives us a good message if the server requires
              * TLS).  If it is not available, fall back to
@@ -759,6 +766,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
             goto fail;
         }
         be16_to_cpus(&info->flags);
+
+        if (info->structured_reply && !(info->flags & NBD_CMD_FLAG_DF)) {
+            error_setg(errp, "Structured reply is negotiated, "
+                             "but DF flag is not.");
+            goto fail;
+        }
     } else if (magic == NBD_CLIENT_MAGIC) {
         uint32_t oldflags;
 
@@ -942,6 +955,128 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     return nbd_write(ioc, buf, sizeof(buf), NULL);
 }
 
+/* nbd_receive_simple_reply
+ * Read simple reply except magic field (which should be already read)
+ */
+static int nbd_receive_simple_reply(QIOChannel *ioc, NBDReply *reply,
+                                    Error **errp)
+{
+    NBDSimpleReply simple_reply;
+    int ret;
+
+    ret = nbd_read(ioc, (uint8_t *)&simple_reply + sizeof(simple_reply.magic),
+                   sizeof(simple_reply) - sizeof(simple_reply.magic), errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    reply->error = be32_to_cpu(simple_reply.error);
+    reply->handle = be64_to_cpu(simple_reply.handle);
+
+    return 0;
+}
+
+/* nbd_receive_structured_reply_chunk
+ * Read structured reply chunk except magic field (which should be already read)
+ * Data for NBD_SREP_TYPE_OFFSET_DATA is not read too.
+ * tail_length field of reply out parameter corresponds to unread part of reply.
+ */
+static int nbd_receive_structured_reply_chunk(QIOChannel *ioc, NBDReply *reply,
+                                              Error **errp)
+{
+    NBDStructuredReplyChunk chunk;
+    ssize_t ret;
+    uint16_t message_size;
+
+    ret = nbd_read(ioc, (uint8_t *)&chunk + sizeof(chunk.magic),
+                          sizeof(chunk) - sizeof(chunk.magic), errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    reply->flags = be16_to_cpu(chunk.flags);
+    reply->type = be16_to_cpu(chunk.type);
+    reply->handle = be64_to_cpu(chunk.handle);
+    reply->tail_length = be32_to_cpu(chunk.length);
+
+    switch (reply->type) {
+    case NBD_SREP_TYPE_NONE:
+        break;
+    case NBD_SREP_TYPE_OFFSET_DATA:
+        if (reply->tail_length < sizeof(reply->offset)) {
+            return -EIO;
+        }
+        ret = nbd_read(ioc, &reply->offset, sizeof(reply->offset), errp);
+        if (ret < 0) {
+            return ret;
+        }
+        be64_to_cpus(&reply->offset);
+        reply->tail_length -= sizeof(reply->offset);
+
+        break;
+    case NBD_SREP_TYPE_OFFSET_HOLE:
+        ret = nbd_read(ioc, &reply->offset, sizeof(reply->offset), errp);
+        if (ret < 0) {
+            return ret;
+        }
+        be64_to_cpus(&reply->offset);
+
+        ret = nbd_read(ioc, &reply->hole_size, sizeof(reply->hole_size), errp);
+        if (ret < 0) {
+            return ret;
+        }
+        be32_to_cpus(&reply->hole_size);
+
+        break;
+    case NBD_SREP_TYPE_ERROR:
+    case NBD_SREP_TYPE_ERROR_OFFSET:
+        ret = nbd_read(ioc, &reply->error, sizeof(reply->error), errp);
+        if (ret < 0) {
+            return ret;
+        }
+        be32_to_cpus(&reply->error);
+
+        ret = nbd_read(ioc, &message_size, sizeof(message_size), errp);
+        if (ret < 0) {
+            return ret;
+        }
+        be16_to_cpus(&message_size);
+
+        if (message_size > 0) {
+            /* TODO: provide error message to user */
+            ret = nbd_drop(ioc, message_size, errp);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+
+        if (reply->type == NBD_SREP_TYPE_ERROR_OFFSET) {
+            /* drop 64bit offset */
+            ret = nbd_drop(ioc, 8, errp);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        break;
+    default:
+        if (reply->type & (1 << 15)) {
+            /* unknown error */
+            ret = nbd_drop(ioc, reply->tail_length, errp);
+            if (ret < 0) {
+                return ret;
+            }
+
+            reply->error = NBD_EINVAL;
+            reply->tail_length = 0;
+        } else {
+            /* unknown non-error reply type */
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
 /* nbd_receive_reply
  * Returns 1 on success
  *         0 on eof, when no data was read (errp is not set)
@@ -949,24 +1084,32 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
  */
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
-    uint8_t buf[NBD_REPLY_SIZE];
     uint32_t magic;
     int ret;
 
-    ret = nbd_read_eof(ioc, buf, sizeof(buf), errp);
+    ret = nbd_read_eof(ioc, &magic, sizeof(magic), errp);
     if (ret <= 0) {
         return ret;
     }
 
-    /* Reply
-       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
-       [ 4 ..  7]    error   (0 == no error)
-       [ 7 .. 15]    handle
-     */
+    be32_to_cpus(&magic);
 
-    magic = ldl_be_p(buf);
-    reply->error  = ldl_be_p(buf + 4);
-    reply->handle = ldq_be_p(buf + 8);
+    switch (magic) {
+    case NBD_SIMPLE_REPLY_MAGIC:
+        reply->simple = true;
+        ret = nbd_receive_simple_reply(ioc, reply, errp);
+        break;
+    case NBD_STRUCTURED_REPLY_MAGIC:
+        reply->simple = false;
+        ret = nbd_receive_structured_reply_chunk(ioc, reply, errp);
+        break;
+    default:
+        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
+        return -EINVAL;
+    }
+    if (ret < 0) {
+        return ret;
+    }
 
     reply->error = nbd_errno_to_system_errno(reply->error);
 
@@ -977,11 +1120,5 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     }
     trace_nbd_receive_reply(magic, reply->error, reply->handle);
 
-    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
-        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
-        return -EINVAL;
-    }
-
     return 1;
 }
-
-- 
2.11.1
