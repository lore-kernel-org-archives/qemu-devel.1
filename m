Received: from eggs.gnu.org ([2001:4830:134:3::10]:58885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1esuTZ-0002rw-W3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1esuTW-0003xp-0e
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:04:41 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  5 Mar 2018 21:04:33 +0300
Message-Id: <20180305180433.106408-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] nbd/server: fix space read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

In case of io error in nbd_co_send_sparse_read we should not
"goto reply:", as it is fatal error and common behavior is
disconnect in this case. We should not try to send client an
error reply, representing channel-io error on previous try to
send a reply.

Fix this by handle block-status error in nbd_co_send_sparse_read,
so nbd_co_send_sparse_read fails only on io error. Then just skip
common "reply:" code path in nbd_trip.

Note: nbd_co_send_structured_error is moved without changes to be
called from nbd_co_send_sparse_read.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

PS: this all shows that nbd_trip is tooo complex (and yes, I remember,
that its final semantics was made by myself :(.. It should be
refactored into several smaller parts. Do you have any ideas?

The complexity here is that we should handle channel errors (fatal) and
export errors(non fatal) in different ways, and both of error types may
have errp, which should be handled differently too..

May be, the best way is to make separate functions for each command,
avoiding code duplication by using helper-functions instead of common code
in nbd_trip.

 nbd/server.c | 64 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 4990a5826e..ea6b9467e4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "nbd-internal.h"
+#include "qemu/error-report.h"
 
 static int system_errno_to_nbd_errno(int err)
 {
@@ -1341,6 +1342,30 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
     return nbd_co_send_iov(client, iov, 2, errp);
 }
 
+static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
+                                                     uint64_t handle,
+                                                     uint32_t error,
+                                                     const char *msg,
+                                                     Error **errp)
+{
+    NBDStructuredError chunk;
+    int nbd_err = system_errno_to_nbd_errno(error);
+    struct iovec iov[] = {
+        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+        {.iov_base = (char *)msg, .iov_len = msg ? strlen(msg) : 0},
+    };
+
+    assert(nbd_err);
+    trace_nbd_co_send_structured_error(handle, nbd_err,
+                                       nbd_err_lookup(nbd_err), msg ? msg : "");
+    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
+                 sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
+    stl_be_p(&chunk.error, nbd_err);
+    stw_be_p(&chunk.message_length, iov[1].iov_len);
+
+    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
+}
+
 static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                                                 uint64_t handle,
                                                 uint64_t offset,
@@ -1361,8 +1386,15 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
         bool final;
 
         if (status < 0) {
-            error_setg_errno(errp, -status, "unable to check for holes");
-            return status;
+            char *msg = g_strdup_printf("unable to check for holes: %s",
+                                              strerror(-status));
+
+            error_report("%s", msg);
+
+            ret = nbd_co_send_structured_error(client, handle, -status, msg,
+                                               errp);
+            g_free(msg);
+            return ret;
         }
         assert(pnum && pnum <= size - progress);
         final = progress + pnum == size;
@@ -1400,30 +1432,6 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
     return ret;
 }
 
-static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
-                                                     uint64_t handle,
-                                                     uint32_t error,
-                                                     const char *msg,
-                                                     Error **errp)
-{
-    NBDStructuredError chunk;
-    int nbd_err = system_errno_to_nbd_errno(error);
-    struct iovec iov[] = {
-        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
-        {.iov_base = (char *)msg, .iov_len = msg ? strlen(msg) : 0},
-    };
-
-    assert(nbd_err);
-    trace_nbd_co_send_structured_error(handle, nbd_err,
-                                       nbd_err_lookup(nbd_err), msg ? msg : "");
-    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
-                 sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
-    stl_be_p(&chunk.error, nbd_err);
-    stw_be_p(&chunk.message_length, iov[1].iov_len);
-
-    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
-}
-
 /* nbd_co_receive_request
  * Collect a client request. Return 0 if request looks valid, -EIO to drop
  * connection right away, and any other negative value to report an error to
@@ -1567,7 +1575,7 @@ static coroutine_fn void nbd_trip(void *opaque)
                                           request.from, req->data, request.len,
                                           &local_err);
             if (ret < 0) {
-                goto reply;
+                goto replied;
             }
             goto done;
         }
@@ -1664,6 +1672,8 @@ reply:
                                        req->data, reply_data_len, &local_err);
     }
     g_free(msg);
+
+replied:
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.11.1
