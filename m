Received: from eggs.gnu.org ([2001:4830:134:3::10]:39672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBL-00037I-MF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBK-0000rI-Gk
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:59 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 10:59:39 -0600
Message-Id: <20171109165939.23154-9-eblake@redhat.com>
In-Reply-To: <20171109165939.23154-1-eblake@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] nbd/server: Fix structured read of length 0
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

The NBD spec was recently clarified to state that a read of length 0
should not be attempted by a compliant client; but that a server must
still handle it correctly in an unspecified manner (that is, either
a successful no-op or an error reply, but not a crash) [1].  However,
it also implies that NBD_REPLY_TYPE_OFFSET_DATA must have a non-zero
payload length, but our existing code was replying with a chunk
that a picky client could reject as invalid because it was missing
a payload (our own client implementation was recently patched to be
that picky, after first fixing it to not send 0-length requests).

We are already doing successful no-ops for 0-length writes and for
non-structured reads; so for consistency, we want structured reply
reads to also be a no-op.  The easiest way to do this is to return
a NBD_REPLY_TYPE_NONE chunk; this is best done via a new helper
function (especially since future patches for other structured
replies may benefit from using the same helper).

[1] https://github.com/NetworkBlockDevice/nbd/commit/ee926037

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171108215703.9295-8-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
