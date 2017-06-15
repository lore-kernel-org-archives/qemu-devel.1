Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPQ-0000Df-4V
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPP-0007jD-0L
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:52 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPO-0007iq-Nx
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:50 -0400
Received: by mail-wr0-x242.google.com with SMTP id x23so2770096wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:55 +0200
Message-Id: <1497523981-38449-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/41] nbd/server: refactor nbd_trip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

- do not use 'goto error_reply' outside a switch to jump into the
  middle of the switch's default case label
- reduce code duplication

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170602150150.258222-13-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 53 ++++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index f19f5fd..8a70c05 100644
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
     client_close(client, true);
     nbd_client_put(client);
-- 
1.8.3.1
