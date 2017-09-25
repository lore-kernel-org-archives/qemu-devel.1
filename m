Received: from eggs.gnu.org ([2001:4830:134:3::10]:39655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtz-0006YX-Jn
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtw-0007E8-5R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:27 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:46327 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwTtv-0007CS-K7
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 16:57:57 +0300
Message-Id: <20170925135801.144261-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/8] nbd-server: refactor simple reply sending
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

Get rid of calculating structure fields offsets by hand and set_cork,
rename nbd_co_send_reply to nbd_co_send_simple_reply. Do not use
NBDReply which will be upgraded in future patches to handle both simple
and structured replies and will be used only in the client.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  6 ++++
 nbd/nbd-internal.h  |  9 +++++
 nbd/server.c        | 97 ++++++++++++++++++++++-------------------------------
 3 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 707fd37575..49008980f4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -63,6 +63,12 @@ struct NBDReply {
 };
 typedef struct NBDReply NBDReply;
 
+typedef struct NBDSimpleReply {
+    uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
+    uint32_t error;
+    uint64_t handle;
+} QEMU_PACKED NBDSimpleReply;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 2d6663de23..320abef296 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -113,6 +113,15 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
     return qio_channel_write_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
 }
 
+/* nbd_writev
+ * Writes @size bytes to @ioc. Returns 0 on success.
+ */
+static inline int nbd_writev(QIOChannel *ioc, const struct iovec *iov,
+                             size_t niov, Error **errp)
+{
+    return qio_channel_writev_all(ioc, iov, niov, errp) < 0 ? -EIO : 0;
+}
+
 struct NBDTLSHandshakeData {
     GMainLoop *loop;
     bool complete;
diff --git a/nbd/server.c b/nbd/server.c
index a1b21a6951..57d5598e0f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -902,26 +902,6 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
     return 0;
 }
 
-static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
-{
-    uint8_t buf[NBD_REPLY_SIZE];
-
-    reply->error = system_errno_to_nbd_errno(reply->error);
-
-    trace_nbd_send_reply(reply->error, reply->handle);
-
-    /* Reply
-       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
-       [ 4 ..  7]    error   (0 == no error)
-       [ 7 .. 15]    handle
-     */
-    stl_be_p(buf, NBD_SIMPLE_REPLY_MAGIC);
-    stl_be_p(buf + 4, reply->error);
-    stq_be_p(buf + 8, reply->handle);
-
-    return nbd_write(ioc, buf, sizeof(buf), errp);
-}
-
 #define MAX_NBD_REQUESTS 16
 
 void nbd_client_get(NBDClient *client)
@@ -1208,38 +1188,51 @@ void nbd_export_close_all(void)
     }
 }
 
-static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
-                             Error **errp)
+static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
+                                        unsigned niov, Error **errp)
 {
-    NBDClient *client = req->client;
     int ret;
 
     g_assert(qemu_in_coroutine());
-
-    trace_nbd_co_send_reply(reply->handle, reply->error, len);
-
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
 
-    if (!len) {
-        ret = nbd_send_reply(client->ioc, reply, errp);
-    } else {
-        qio_channel_set_cork(client->ioc, true);
-        ret = nbd_send_reply(client->ioc, reply, errp);
-        if (ret == 0) {
-            ret = nbd_write(client->ioc, req->data, len, errp);
-            if (ret < 0) {
-                ret = -EIO;
-            }
-        }
-        qio_channel_set_cork(client->ioc, false);
-    }
+    ret = nbd_writev(client->ioc, iov, niov, errp);
 
     client->send_coroutine = NULL;
     qemu_co_mutex_unlock(&client->send_lock);
+
     return ret;
 }
 
+static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
+                                       uint64_t handle)
+{
+    stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
+    stl_be_p(&reply->error, error);
+    stq_be_p(&reply->handle, handle);
+}
+
+static int nbd_co_send_simple_reply(NBDClient *client,
+                                    uint64_t handle,
+                                    uint32_t error,
+                                    void *data,
+                                    size_t size,
+                                    Error **errp)
+{
+    NBDSimpleReply reply;
+    struct iovec iov[] = {
+        {.iov_base = &reply, .iov_len = sizeof(reply)},
+        {.iov_base = data, .iov_len = size}
+    };
+
+    trace_nbd_co_send_reply(handle, error, size);
+
+    set_be_simple_reply(&reply, system_errno_to_nbd_errno(error), handle);
+
+    return nbd_co_send_iov(client, iov, size ? 2 : 1, errp);
+}
+
 /* nbd_co_receive_request
  * Collect a client request. Return 0 if request looks valid, -EIO to drop
  * connection right away, and any other negative value to report an error to
@@ -1331,7 +1324,6 @@ static coroutine_fn void nbd_trip(void *opaque)
     NBDExport *exp = client->exp;
     NBDRequestData *req;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
-    NBDReply reply;
     int ret;
     int flags;
     int reply_data_len = 0;
@@ -1351,11 +1343,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto disconnect;
     }
 
-    reply.handle = request.handle;
-    reply.error = 0;
-
     if (ret < 0) {
-        reply.error = -ret;
         goto reply;
     }
 
@@ -1374,7 +1362,6 @@ static coroutine_fn void nbd_trip(void *opaque)
             ret = blk_co_flush(exp->blk);
             if (ret < 0) {
                 error_setg_errno(&local_err, -ret, "flush failed");
-                reply.error = -ret;
                 break;
             }
         }
@@ -1383,7 +1370,6 @@ static coroutine_fn void nbd_trip(void *opaque)
                         req->data, request.len);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "reading from file failed");
-            reply.error = -ret;
             break;
         }
 
@@ -1392,7 +1378,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         break;
     case NBD_CMD_WRITE:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            reply.error = EROFS;
+            ret = -EROFS;
             break;
         }
 
@@ -1404,14 +1390,13 @@ static coroutine_fn void nbd_trip(void *opaque)
                          req->data, request.len, flags);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "writing to file failed");
-            reply.error = -ret;
         }
 
         break;
     case NBD_CMD_WRITE_ZEROES:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
             error_setg(&local_err, "Server is read-only, return error");
-            reply.error = EROFS;
+            ret = -EROFS;
             break;
         }
 
@@ -1426,7 +1411,6 @@ static coroutine_fn void nbd_trip(void *opaque)
                                 request.len, flags);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "writing to file failed");
-            reply.error = -ret;
         }
 
         break;
@@ -1438,7 +1422,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_co_flush(exp->blk);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "flush failed");
-            reply.error = -ret;
         }
 
         break;
@@ -1447,25 +1430,27 @@ static coroutine_fn void nbd_trip(void *opaque)
                               request.len);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "discard failed");
-            reply.error = -ret;
         }
 
         break;
     default:
         error_setg(&local_err, "invalid request type (%" PRIu32 ") received",
                    request.type);
-        reply.error = EINVAL;
+        ret = -EINVAL;
     }
 
 reply:
     if (local_err) {
-        /* If we are here local_err is not fatal error, already stored in
-         * reply.error */
+        /* If we are here local_err is not fatal error, which should be sent
+         * to client. */
         error_report_err(local_err);
         local_err = NULL;
     }
 
-    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0) {
+    if (nbd_co_send_simple_reply(req->client, request.handle,
+                                 ret < 0 ? -ret : 0,
+                                 req->data, reply_data_len, &local_err) < 0)
+    {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
     }
-- 
2.11.1
