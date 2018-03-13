Received: from eggs.gnu.org ([2001:4830:134:3::10]:47118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUp-0007Hw-Aa
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUn-0000pk-L8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:30 -0500
Message-Id: <20180313171345.659672-3-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 02/17] nbd/server: move
 nbd_co_send_structured_error up
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

To be reused in nbd_co_send_sparse_read() in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180308184636.178534-2-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index e714bfe6a17..3d0f024193c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1342,6 +1342,30 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
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
@@ -1401,30 +1425,6 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
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
-- 
2.14.3
