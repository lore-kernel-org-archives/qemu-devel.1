Received: from eggs.gnu.org ([2001:4830:134:3::10]:35437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBI-0001FS-3u
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBF-0000HA-1h
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37412 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2aBE-0000Dc-Mr
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 12:53:11 +0300
Message-Id: <20171012095319.136610-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 05/13] nbd/server: do not use NBDReply
 structure
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

NBDReply structure will be upgraded in future patches to handle both
simple and structured replies and will be used only in the client

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 43ade30ba3..3878145f63 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1196,7 +1196,9 @@ static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
     stq_be_p(&reply->handle, handle);
 }
 
-static int nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *reply,
+static int nbd_co_send_simple_reply(NBDRequestData *req,
+                                    uint64_t handle,
+                                    uint32_t error,
                                     int len, Error **errp)
 {
     NBDClient *client = req->client;
@@ -1205,10 +1207,10 @@ static int nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *reply,
 
     g_assert(qemu_in_coroutine());
 
-    trace_nbd_co_send_simple_reply(reply->handle, reply->error, len);
+    trace_nbd_co_send_simple_reply(handle, error, len);
 
-    set_be_simple_reply(&simple_reply, system_errno_to_nbd_errno(reply->error),
-                        reply->handle);
+    set_be_simple_reply(&simple_reply, system_errno_to_nbd_errno(error),
+                        handle);
 
     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
@@ -1323,7 +1325,6 @@ static coroutine_fn void nbd_trip(void *opaque)
     NBDExport *exp = client->exp;
     NBDRequestData *req;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
-    NBDReply reply;
     int ret;
     int flags;
     int reply_data_len = 0;
@@ -1343,11 +1344,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto disconnect;
     }
 
-    reply.handle = request.handle;
-    reply.error = 0;
-
     if (ret < 0) {
-        reply.error = -ret;
         goto reply;
     }
 
@@ -1366,7 +1363,6 @@ static coroutine_fn void nbd_trip(void *opaque)
             ret = blk_co_flush(exp->blk);
             if (ret < 0) {
                 error_setg_errno(&local_err, -ret, "flush failed");
-                reply.error = -ret;
                 break;
             }
         }
@@ -1375,7 +1371,6 @@ static coroutine_fn void nbd_trip(void *opaque)
                         req->data, request.len);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "reading from file failed");
-            reply.error = -ret;
             break;
         }
 
@@ -1384,7 +1379,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         break;
     case NBD_CMD_WRITE:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            reply.error = EROFS;
+            ret = -EROFS;
             break;
         }
 
@@ -1396,14 +1391,13 @@ static coroutine_fn void nbd_trip(void *opaque)
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
 
@@ -1418,7 +1412,6 @@ static coroutine_fn void nbd_trip(void *opaque)
                                 request.len, flags);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "writing to file failed");
-            reply.error = -ret;
         }
 
         break;
@@ -1430,7 +1423,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_co_flush(exp->blk);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "flush failed");
-            reply.error = -ret;
         }
 
         break;
@@ -1439,25 +1431,27 @@ static coroutine_fn void nbd_trip(void *opaque)
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
+        /* If we get here, local_err was not a fatal error, and should be sent
+         * to the client. */
         error_report_err(local_err);
         local_err = NULL;
     }
 
-    if (nbd_co_send_simple_reply(req, &reply, reply_data_len, &local_err) < 0) {
+    if (nbd_co_send_simple_reply(req, request.handle,
+                                 ret < 0 ? -ret : 0,
+                                 reply_data_len, &local_err) < 0)
+    {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
     }
-- 
2.11.1
