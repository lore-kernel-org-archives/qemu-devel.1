Received: from eggs.gnu.org ([2001:4830:134:3::10]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUr-0007Kd-D3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUp-0000sb-SW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:34 -0500
Message-Id: <20180313171345.659672-7-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 06/17] nbd/server: refactor nbd_trip: split out
 nbd_handle_request
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

Split out request handling logic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180308184636.178534-6-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: touch up blank line placement]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 128 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 66 insertions(+), 62 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 297d314bd0b..83f21c55912 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1587,17 +1587,78 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     }
 }

+/* Handle NBD request.
+ * Return -errno if sending fails. Other errors are reported directly to the
+ * client as an error reply. */
+static coroutine_fn int nbd_handle_request(NBDClient *client,
+                                           NBDRequest *request,
+                                           uint8_t *data, Error **errp)
+{
+    int ret;
+    int flags;
+    NBDExport *exp = client->exp;
+    char *msg;
+
+    switch (request->type) {
+    case NBD_CMD_READ:
+        return nbd_do_cmd_read(client, request, data, errp);
+
+    case NBD_CMD_WRITE:
+        flags = 0;
+        if (request->flags & NBD_CMD_FLAG_FUA) {
+            flags |= BDRV_REQ_FUA;
+        }
+        ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
+                         data, request->len, flags);
+        return nbd_send_generic_reply(client, request->handle, ret,
+                                      "writing to file failed", errp);
+
+    case NBD_CMD_WRITE_ZEROES:
+        flags = 0;
+        if (request->flags & NBD_CMD_FLAG_FUA) {
+            flags |= BDRV_REQ_FUA;
+        }
+        if (!(request->flags & NBD_CMD_FLAG_NO_HOLE)) {
+            flags |= BDRV_REQ_MAY_UNMAP;
+        }
+        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
+                                request->len, flags);
+        return nbd_send_generic_reply(client, request->handle, ret,
+                                      "writing to file failed", errp);
+
+    case NBD_CMD_DISC:
+        /* unreachable, thanks to special case in nbd_co_receive_request() */
+        abort();
+
+    case NBD_CMD_FLUSH:
+        ret = blk_co_flush(exp->blk);
+        return nbd_send_generic_reply(client, request->handle, ret,
+                                      "flush failed", errp);
+
+    case NBD_CMD_TRIM:
+        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
+                              request->len);
+        return nbd_send_generic_reply(client, request->handle, ret,
+                                      "discard failed", errp);
+
+    default:
+        msg = g_strdup_printf("invalid request type (%" PRIu32 ") received",
+                              request->type);
+        ret = nbd_send_generic_reply(client, request->handle, -EINVAL, msg,
+                                     errp);
+        g_free(msg);
+        return ret;
+    }
+}
+
 /* Owns a reference to the NBDClient passed as opaque.  */
 static coroutine_fn void nbd_trip(void *opaque)
 {
     NBDClient *client = opaque;
-    NBDExport *exp = client->exp;
     NBDRequestData *req;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
     int ret;
-    int flags;
     Error *local_err = NULL;
-    char *msg = NULL;

     trace_nbd_trip();
     if (client->closing) {
@@ -1631,66 +1692,9 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = nbd_send_generic_reply(client, request.handle, -EINVAL,
                                      error_get_pretty(export_err), &local_err);
         error_free(export_err);
-
-        goto replied;
+    } else {
+        ret = nbd_handle_request(client, &request, req->data, &local_err);
     }
-
-    switch (request.type) {
-    case NBD_CMD_READ:
-        ret = nbd_do_cmd_read(client, &request, req->data, &local_err);
-        break;
-
-    case NBD_CMD_WRITE:
-        flags = 0;
-        if (request.flags & NBD_CMD_FLAG_FUA) {
-            flags |= BDRV_REQ_FUA;
-        }
-        ret = blk_pwrite(exp->blk, request.from + exp->dev_offset,
-                         req->data, request.len, flags);
-        ret = nbd_send_generic_reply(client, request.handle, ret,
-                                     "writing to file failed", &local_err);
-        break;
-
-    case NBD_CMD_WRITE_ZEROES:
-        flags = 0;
-        if (request.flags & NBD_CMD_FLAG_FUA) {
-            flags |= BDRV_REQ_FUA;
-        }
-        if (!(request.flags & NBD_CMD_FLAG_NO_HOLE)) {
-            flags |= BDRV_REQ_MAY_UNMAP;
-        }
-        ret = blk_pwrite_zeroes(exp->blk, request.from + exp->dev_offset,
-                                request.len, flags);
-        ret = nbd_send_generic_reply(client, request.handle, ret,
-                                     "writing to file failed", &local_err);
-        break;
-
-    case NBD_CMD_DISC:
-        /* unreachable, thanks to special case in nbd_co_receive_request() */
-        abort();
-
-    case NBD_CMD_FLUSH:
-        ret = blk_co_flush(exp->blk);
-        ret = nbd_send_generic_reply(client, request.handle, ret,
-                                     "flush failed", &local_err);
-        break;
-
-    case NBD_CMD_TRIM:
-        ret = blk_co_pdiscard(exp->blk, request.from + exp->dev_offset,
-                              request.len);
-        ret = nbd_send_generic_reply(client, request.handle, ret,
-                                     "discard failed", &local_err);
-        break;
-
-    default:
-        msg = g_strdup_printf("invalid request type (%" PRIu32 ") received",
-                              request.type);
-        ret = nbd_send_generic_reply(client, request.handle, -EINVAL, msg,
-                                     &local_err);
-        g_free(msg);
-    }
-
-replied:
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.14.3
