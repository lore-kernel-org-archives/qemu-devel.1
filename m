Received: from eggs.gnu.org ([2001:4830:134:3::10]:37722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuAB-0007e5-IE
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuAA-0003Wo-A8
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:55 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:02:36 -0600
Message-Id: <20171107030236.23633-9-eblake@redhat.com>
In-Reply-To: <20171107030236.23633-1-eblake@redhat.com>
References: <20171107030236.23633-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 8/8] nbd/server: Fix structured read of length 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com

The NBD spec is being clarified that a read of length 0 should not
be attempted by a compliant client; but that a server must handle
it correctly.  However, it also implies that NBD_REPLY_TYPE_OFFSET_DATA
must have a non-zero payload length, which means that we must either
give an error or use a no-op REPLY_TYPE_NONE in response to a
zero-length read, so that we don't trip up any clients that might
kill the connection if we send a data chunk without data.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c     | 21 ++++++++++++++++++++-
 nbd/trace-events |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 6ebb7d9c2e..df771fd42f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1273,6 +1273,21 @@ static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
     stl_be_p(&chunk->length, length);
 }

+static int coroutine_fn nbd_co_send_structured_done(NBDClient *client,
+                                                    uint64_t handle,
+                                                    Error **errp)
+{
+    NBDStructuredReplyChunk chunk;
+    struct iovec iov[] = {
+        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+    };
+
+    trace_nbd_co_send_structured_done(handle);
+    set_be_chunk(&chunk, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE, handle, 0);
+
+    return nbd_co_send_iov(client, iov, 1, errp);
+}
+
 static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
                                                     uint64_t handle,
                                                     uint64_t offset,
@@ -1286,6 +1301,7 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
         {.iov_base = data, .iov_len = size}
     };

+    assert(size);
     trace_nbd_co_send_structured_read(handle, offset, data, size);
     set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_OFFSET_DATA,
                  handle, sizeof(chunk) - sizeof(chunk.h) + size);
@@ -1544,10 +1560,13 @@ reply:
         if (ret < 0) {
             ret = nbd_co_send_structured_error(req->client, request.handle,
                                                -ret, msg, &local_err);
-        } else {
+        } else if (reply_data_len) {
             ret = nbd_co_send_structured_read(req->client, request.handle,
                                               request.from, req->data,
                                               reply_data_len, &local_err);
+        } else {
+            ret = nbd_co_send_structured_done(req->client, request.handle,
+                                              &local_err);
         }
     } else {
         ret = nbd_co_send_simple_reply(req->client, request.handle,
diff --git a/nbd/trace-events b/nbd/trace-events
index bbc75f6414..92568edce5 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -55,6 +55,7 @@ nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
+nbd_co_send_structured_done(uint64_t handle) "Send structured reply done: handle = %" PRIu64
 nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
 nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
-- 
2.13.6
