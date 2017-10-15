Received: from eggs.gnu.org ([2001:4830:134:3::10]:52220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3WzA-0006di-Gx
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wz9-0003tr-HB
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 19:40:30 -0500
Message-Id: <20171015004033.3248-7-eblake@redhat.com>
In-Reply-To: <20171015004033.3248-1-eblake@redhat.com>
References: <20171015004033.3248-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] nbd/server: do not use NBDReply structure
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

NBDReply structure will be upgraded in future patches to handle both
simple and structured replies and will be used only in the client

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20171012095319.136610-6-vsementsov@virtuozzo.com>
[eblake: rebase to tweaks earlier in series]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 4f765ba992..06aeadcfbb 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1196,18 +1196,20 @@ static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
     stq_be_p(&reply->handle, handle);
 }

-static int nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *reply,
+static int nbd_co_send_simple_reply(NBDRequestData *req,
+                                    uint64_t handle,
+                                    uint32_t error,
                                     int len, Error **errp)
 {
     NBDClient *client = req->client;
     NBDSimpleReply simple_reply;
-    int nbd_err = system_errno_to_nbd_errno(reply->error);
+    int nbd_err = system_errno_to_nbd_errno(error);
     int ret;

     g_assert(qemu_in_coroutine());

-    trace_nbd_co_send_simple_reply(reply->handle, nbd_err, len);
-    set_be_simple_reply(&simple_reply, nbd_err, reply->handle);
+    trace_nbd_co_send_simple_reply(handle, nbd_err, len);
+    set_be_simple_reply(&simple_reply, nbd_err, handle);

     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine = qemu_coroutine_self();
@@ -1322,7 +1324,6 @@ static coroutine_fn void nbd_trip(void *opaque)
     NBDExport *exp = client->exp;
     NBDRequestData *req;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
-    NBDReply reply;
     int ret;
     int flags;
     int reply_data_len = 0;
@@ -1342,11 +1343,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto disconnect;
     }

-    reply.handle = request.handle;
-    reply.error = 0;
-
     if (ret < 0) {
-        reply.error = -ret;
         goto reply;
     }

@@ -1365,7 +1362,6 @@ static coroutine_fn void nbd_trip(void *opaque)
             ret = blk_co_flush(exp->blk);
             if (ret < 0) {
                 error_setg_errno(&local_err, -ret, "flush failed");
-                reply.error = -ret;
                 break;
             }
         }
@@ -1374,7 +1370,6 @@ static coroutine_fn void nbd_trip(void *opaque)
                         req->data, request.len);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "reading from file failed");
-            reply.error = -ret;
             break;
         }

@@ -1383,7 +1378,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         break;
     case NBD_CMD_WRITE:
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            reply.error = EROFS;
+            ret = -EROFS;
             break;
         }

@@ -1395,14 +1390,13 @@ static coroutine_fn void nbd_trip(void *opaque)
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

@@ -1417,7 +1411,6 @@ static coroutine_fn void nbd_trip(void *opaque)
                                 request.len, flags);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "writing to file failed");
-            reply.error = -ret;
         }

         break;
@@ -1429,7 +1422,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_co_flush(exp->blk);
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "flush failed");
-            reply.error = -ret;
         }

         break;
@@ -1438,25 +1430,27 @@ static coroutine_fn void nbd_trip(void *opaque)
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
2.13.6
