Received: from eggs.gnu.org ([2001:4830:134:3::10]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yu-0004YN-Pd
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yp-0003JR-Vg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  8 Mar 2018 21:46:35 +0300
Message-Id: <20180308184636.178534-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180308184636.178534-1-vsementsov@virtuozzo.com>
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/5] nbd/server: refactor nbd_trip: cmd_read
 and generic reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

nbd_trip has difficult logic of sending reply: it tries to use one
code path for all replies. It is ok for simple replies, but is not
comfortable for structured replies. Also, two types of error (and
corresponding message in local_err) - fatal (leading to disconnect)
and not-fatal (just to be sent to the client) are difficult to follow.

To make things a bit clearer, the following is done:
 - split CMD_READ logic to separate function. It is the most difficult
   command for now, and it is definitely cramped inside nbd_trip. Also,
   it is difficult to follow CMD_READ logic, shared between
   "case NBD_CMD_READ" and "if"s under "reply:" label.
 - create separate helper function nbd_send_generic_reply() and use it
   both in new nbd_do_cmd_read and for other command in nbd_trip instead
   of common code-path under "reply:" label in nbd_trip. The helper
   supports error message, so logic with local_err in nbd_trip is
   simplified.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 164 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 88 insertions(+), 76 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 97b45a21fa..a2f5f73d52 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1520,6 +1520,70 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
     return 0;
 }
 
+/* Send simple reply without a payload or structured error
+ * @error_msg is ignored if @ret >= 0 */
+static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
+                                               uint64_t handle,
+                                               int ret,
+                                               const char *error_msg,
+                                               Error **errp)
+{
+    if (client->structured_reply && ret < 0) {
+        return nbd_co_send_structured_error(client, handle, -ret, error_msg,
+                                            errp);
+    } else {
+        return nbd_co_send_simple_reply(client, handle, ret < 0 ? -ret : 0,
+                                        NULL, 0, errp);
+    }
+}
+
+/* Handle NBD_CMD_READ request.
+ * Return -errno if sending fails. Other errors are reported directly to the
+ * client as an error reply. */
+static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
+                                        uint8_t *data, Error **errp)
+{
+    int ret;
+    NBDExport *exp = client->exp;
+
+    assert(request->type == NBD_CMD_READ);
+
+    /* XXX: NBD Protocol only documents use of FUA with WRITE */
+    if (request->flags & NBD_CMD_FLAG_FUA) {
+        ret = blk_co_flush(exp->blk);
+        if (ret < 0) {
+            return nbd_send_generic_reply(client, request->handle, ret,
+                                          "flush failed", errp);
+        }
+    }
+
+    if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
+        request->len) {
+        return nbd_co_send_sparse_read(client, request->handle, request->from,
+                                       data, request->len, errp);
+    }
+
+    ret = blk_pread(exp->blk, request->from + exp->dev_offset, data,
+                    request->len);
+    if (ret < 0) {
+        return nbd_send_generic_reply(client, request->handle, ret,
+                                      "reading from file failed", errp);
+    }
+
+    if (client->structured_reply) {
+        if (request->len) {
+            return nbd_co_send_structured_read(client, request->handle,
+                                               request->from, data,
+                                               request->len, true, errp);
+        } else {
+            return nbd_co_send_structured_done(client, request->handle, errp);
+        }
+    } else {
+        return nbd_co_send_simple_reply(client, request->handle, 0,
+                                        data, request->len, errp);
+    }
+}
+
 /* Owns a reference to the NBDClient passed as opaque.  */
 static coroutine_fn void nbd_trip(void *opaque)
 {
@@ -1529,7 +1593,6 @@ static coroutine_fn void nbd_trip(void *opaque)
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
     int ret;
     int flags;
-    int reply_data_len = 0;
     Error *local_err = NULL;
     char *msg = NULL;
 
@@ -1556,39 +1619,21 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
     if (ret < 0) {
-        goto reply;
+        /* It's not a -EIO, so, accordingly to nbd_co_receive_request()
+         * semantics, we should return the error to the client. */
+        Error *export_err = local_err;
+
+        local_err = NULL;
+        ret = nbd_send_generic_reply(client, request.handle, -EINVAL,
+                                     error_get_pretty(export_err), &local_err);
+        error_free(export_err);
+
+        goto replied;
     }
 
     switch (request.type) {
     case NBD_CMD_READ:
-        /* XXX: NBD Protocol only documents use of FUA with WRITE */
-        if (request.flags & NBD_CMD_FLAG_FUA) {
-            ret = blk_co_flush(exp->blk);
-            if (ret < 0) {
-                error_setg_errno(&local_err, -ret, "flush failed");
-                break;
-            }
-        }
-
-        if (client->structured_reply && !(request.flags & NBD_CMD_FLAG_DF) &&
-            request.len) {
-            ret = nbd_co_send_sparse_read(req->client, request.handle,
-                                          request.from, req->data, request.len,
-                                          &local_err);
-            if (ret < 0) {
-                goto replied;
-            }
-            goto done;
-        }
-
-        ret = blk_pread(exp->blk, request.from + exp->dev_offset,
-                        req->data, request.len);
-        if (ret < 0) {
-            error_setg_errno(&local_err, -ret, "reading from file failed");
-            break;
-        }
-
-        reply_data_len = request.len;
+        ret = nbd_do_cmd_read(client, &request, req->data, &local_err);
 
         break;
     case NBD_CMD_WRITE:
@@ -1598,9 +1643,8 @@ static coroutine_fn void nbd_trip(void *opaque)
         }
         ret = blk_pwrite(exp->blk, request.from + exp->dev_offset,
                          req->data, request.len, flags);
-        if (ret < 0) {
-            error_setg_errno(&local_err, -ret, "writing to file failed");
-        }
+        ret = nbd_send_generic_reply(client, request.handle, ret,
+                                     "writing to file failed", &local_err);
 
         break;
     case NBD_CMD_WRITE_ZEROES:
@@ -1613,9 +1657,8 @@ static coroutine_fn void nbd_trip(void *opaque)
         }
         ret = blk_pwrite_zeroes(exp->blk, request.from + exp->dev_offset,
                                 request.len, flags);
-        if (ret < 0) {
-            error_setg_errno(&local_err, -ret, "writing to file failed");
-        }
+        ret = nbd_send_generic_reply(client, request.handle, ret,
+                                     "writing to file failed", &local_err);
 
         break;
     case NBD_CMD_DISC:
@@ -1624,56 +1667,25 @@ static coroutine_fn void nbd_trip(void *opaque)
 
     case NBD_CMD_FLUSH:
         ret = blk_co_flush(exp->blk);
-        if (ret < 0) {
-            error_setg_errno(&local_err, -ret, "flush failed");
-        }
+        ret = nbd_send_generic_reply(client, request.handle, ret,
+                                     "flush failed", &local_err);
 
         break;
     case NBD_CMD_TRIM:
         ret = blk_co_pdiscard(exp->blk, request.from + exp->dev_offset,
                               request.len);
-        if (ret < 0) {
-            error_setg_errno(&local_err, -ret, "discard failed");
-        }
+        ret = nbd_send_generic_reply(client, request.handle, ret,
+                                     "discard failed", &local_err);
 
         break;
     default:
-        error_setg(&local_err, "invalid request type (%" PRIu32 ") received",
-                   request.type);
-        ret = -EINVAL;
-    }
-
-reply:
-    if (local_err) {
-        /* If we get here, local_err was not a fatal error, and should be sent
-         * to the client. */
-        assert(ret < 0);
-        msg = g_strdup(error_get_pretty(local_err));
-        error_report_err(local_err);
-        local_err = NULL;
+        msg = g_strdup_printf("invalid request type (%" PRIu32 ") received",
+                              request.type);
+        ret = nbd_send_generic_reply(client, request.handle, -EINVAL, msg,
+                                     &local_err);
+        g_free(msg);
     }
 
-    if (client->structured_reply &&
-        (ret < 0 || request.type == NBD_CMD_READ)) {
-        if (ret < 0) {
-            ret = nbd_co_send_structured_error(req->client, request.handle,
-                                               -ret, msg, &local_err);
-        } else if (reply_data_len) {
-            ret = nbd_co_send_structured_read(req->client, request.handle,
-                                              request.from, req->data,
-                                              reply_data_len, true,
-                                              &local_err);
-        } else {
-            ret = nbd_co_send_structured_done(req->client, request.handle,
-                                              &local_err);
-        }
-    } else {
-        ret = nbd_co_send_simple_reply(req->client, request.handle,
-                                       ret < 0 ? -ret : 0,
-                                       req->data, reply_data_len, &local_err);
-    }
-    g_free(msg);
-
 replied:
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
-- 
2.11.1
