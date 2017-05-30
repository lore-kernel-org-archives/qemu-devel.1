Received: from eggs.gnu.org ([2001:4830:134:3::10]:54303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005QE-2c
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000PM-5N
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:42902 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000N9-Mw
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:43 +0300
Message-Id: <20170530143052.165002-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 10/19] nbd/server: refactor nbd_trip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

- do not goto into switch block from outer block
- reduce code duplications

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 53 ++++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index a76267bea7..a47f13e4fb 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1078,6 +1078,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     NBDReply reply;
     int ret;
     int flags;
+    int reply_data_len = 0;
 
     TRACE("Reading request.");
     if (client->closing) {
@@ -1090,7 +1091,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     client->recv_coroutine = NULL;
     nbd_client_receive_next_request(client);
     if (ret == -EIO) {
-        goto out;
+        goto disconnect;
     }
 
     reply.handle = request.handle;
@@ -1098,7 +1099,7 @@ static coroutine_fn void nbd_trip(void *opaque)
 
     if (ret < 0) {
         reply.error = -ret;
-        goto error_reply;
+        goto reply;
     }
 
     if (client->closing) {
@@ -1119,7 +1120,7 @@ static coroutine_fn void nbd_trip(void *opaque)
             if (ret < 0) {
                 LOG("flush failed");
                 reply.error = -ret;
-                goto error_reply;
+                break;
             }
         }
 
@@ -1128,12 +1129,12 @@ static coroutine_fn void nbd_trip(void *opaque)
         if (ret < 0) {
             LOG("reading from file failed");
             reply.error = -ret;
-            goto error_reply;
+            break;
         }
 
+        reply_data_len = request.len;
         TRACE("Read %" PRIu32" byte(s)", request.len);
-        if (nbd_co_send_reply(req, &reply, request.len) < 0)
-            goto out;
+
         break;
     case NBD_CMD_WRITE:
         TRACE("Request type is WRITE");
@@ -1141,7 +1142,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
             TRACE("Server is read-only, return error");
             reply.error = EROFS;
-            goto error_reply;
+            break;
         }
 
         TRACE("Writing to device");
@@ -1155,21 +1156,16 @@ static coroutine_fn void nbd_trip(void *opaque)
         if (ret < 0) {
             LOG("writing to file failed");
             reply.error = -ret;
-            goto error_reply;
         }
 
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
-            goto out;
-        }
         break;
-
     case NBD_CMD_WRITE_ZEROES:
         TRACE("Request type is WRITE_ZEROES");
 
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
             TRACE("Server is read-only, return error");
             reply.error = EROFS;
-            goto error_reply;
+            break;
         }
 
         TRACE("Writing to device");
@@ -1186,14 +1182,9 @@ static coroutine_fn void nbd_trip(void *opaque)
         if (ret < 0) {
             LOG("writing to file failed");
             reply.error = -ret;
-            goto error_reply;
         }
 
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
-            goto out;
-        }
         break;
-
     case NBD_CMD_DISC:
         /* unreachable, thanks to special case in nbd_co_receive_request() */
         abort();
@@ -1206,9 +1197,7 @@ static coroutine_fn void nbd_trip(void *opaque)
             LOG("flush failed");
             reply.error = -ret;
         }
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
-            goto out;
-        }
+
         break;
     case NBD_CMD_TRIM:
         TRACE("Request type is TRIM");
@@ -1218,21 +1207,19 @@ static coroutine_fn void nbd_trip(void *opaque)
             LOG("discard failed");
             reply.error = -ret;
         }
-        if (nbd_co_send_reply(req, &reply, 0) < 0) {
-            goto out;
-        }
+
         break;
     default:
         LOG("invalid request type (%" PRIu32 ") received", request.type);
         reply.error = EINVAL;
-    error_reply:
-        /* We must disconnect after NBD_CMD_WRITE if we did not
-         * read the payload.
-         */
-        if (nbd_co_send_reply(req, &reply, 0) < 0 || !req->complete) {
-            goto out;
-        }
-        break;
+    }
+
+reply:
+    /* We must disconnect after NBD_CMD_WRITE if we did not
+     * read the payload.
+     */
+    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0 || !req->complete) {
+        goto disconnect;
     }
 
     TRACE("Request/Reply complete");
@@ -1242,7 +1229,7 @@ done:
     nbd_client_put(client);
     return;
 
-out:
+disconnect:
     nbd_request_put(req);
     client_close(client);
     nbd_client_put(client);
-- 
2.11.1
