Received: from eggs.gnu.org ([2001:4830:134:3::10]:50754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7P-0000Bo-RD
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7L-0001MQ-1n
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:11 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 30 Oct 2017 21:56:32 +0100
Message-Id: <20171030205636.14236-9-eblake@redhat.com>
In-Reply-To: <20171030205636.14236-1-eblake@redhat.com>
References: <20171030205636.14236-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 08/12] nbd/server: Include human-readable
 message in structured errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec permits including a human-readable error string if
structured replies are in force, so we might as well send the
client the message that we logged on any error.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20171027104037.8319-9-eblake@redhat.com>
---
 nbd/server.c     | 20 +++++++++++++-------
 nbd/trace-events |  2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3261fd1bd7..70b40ed27e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1296,24 +1296,25 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
 static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
                                                      uint64_t handle,
                                                      uint32_t error,
+                                                     const char *msg,
                                                      Error **errp)
 {
     NBDStructuredError chunk;
     int nbd_err = system_errno_to_nbd_errno(error);
     struct iovec iov[] = {
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
-        /* FIXME: Support human-readable error message */
+        {.iov_base = (char *)msg, .iov_len = msg ? strlen(msg) : 0},
     };

     assert(nbd_err);
     trace_nbd_co_send_structured_error(handle, nbd_err,
-                                       nbd_err_lookup(nbd_err));
+                                       nbd_err_lookup(nbd_err), msg ? msg : "");
     set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
-                 sizeof(chunk) - sizeof(chunk.h));
+                 sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
     stl_be_p(&chunk.error, nbd_err);
-    stw_be_p(&chunk.message_length, 0);
+    stw_be_p(&chunk.message_length, iov[1].iov_len);

-    return nbd_co_send_iov(client, iov, 1, errp);
+    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
 }

 /* nbd_co_receive_request
@@ -1414,6 +1415,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     int flags;
     int reply_data_len = 0;
     Error *local_err = NULL;
+    char *msg = NULL;

     trace_nbd_trip();
     if (client->closing) {
@@ -1530,14 +1532,17 @@ reply:
     if (local_err) {
         /* If we get here, local_err was not a fatal error, and should be sent
          * to the client. */
+        assert(ret < 0);
+        msg = g_strdup(error_get_pretty(local_err));
         error_report_err(local_err);
         local_err = NULL;
     }

-    if (client->structured_reply && request.type == NBD_CMD_READ) {
+    if (client->structured_reply &&
+        (ret < 0 || request.type == NBD_CMD_READ)) {
         if (ret < 0) {
             ret = nbd_co_send_structured_error(req->client, request.handle,
-                                               -ret, &local_err);
+                                               -ret, msg, &local_err);
         } else {
             ret = nbd_co_send_structured_read(req->client, request.handle,
                                               request.from, req->data,
@@ -1548,6 +1553,7 @@ reply:
                                        ret < 0 ? -ret : 0,
                                        req->data, reply_data_len, &local_err);
     }
+    g_free(msg);
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
diff --git a/nbd/trace-events b/nbd/trace-events
index 6894f8bbb4..52150bd738 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -57,7 +57,7 @@ nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
 nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
-nbd_co_send_structured_error(uint64_t handle, int err, const char *errname) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s)"
+nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
 nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " byte(s)"
-- 
2.13.6
