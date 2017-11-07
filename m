Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuGP-0003xz-JN
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuGO-00071Y-Aj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:09:21 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:09:11 -0600
Message-Id: <20171107030912.23930-2-eblake@redhat.com>
In-Reply-To: <20171107030912.23930-1-eblake@redhat.com>
References: <20171107030912.23930-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] nbd/server: Implement sparse reads atop
 structured reply
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

The reason that NBD added structured reply in the first place was
to allow for efficient reads of sparse files, by allowing the
reply to include chunks to quickly communicate holes to the client
without sending lots of zeroes over the wire.  Time to implement
this in the server; our client can already read such data.

We can only skip holes insofar as the block layer can query them;
and only if the client is okay with a fragmented request (if a
client requests NBD_CMD_FLAG_DF and the entire read is a hole, we
could technically return a single NBD_REPLY_TYPE_OFFSET_HOLE, but
that's a fringe case not worth catering to here).  Sadly, the
control flow is a bit wonkier than I would have preferred, but
it was minimally invasive to have a split in the action between
a fragmented read (handled directly where we recognize
NBD_CMD_READ with the right conditions, and sending multiple
chunks) vs. a single read (handled at the end of nbd_trip, for
both simple and structured replies, when we know there is only
one thing being read).  Likewise, I didn't make any effort to
optimize the final chunk of a fragmented read to set the
NBD_REPLY_FLAG_DONE, but unconditionally send that as a separate
NBD_REPLY_TYPE_NONE.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 nbd/trace-events |  1 +
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index df771fd42f..3c5e3005a6 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1293,6 +1293,7 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
                                                     uint64_t offset,
                                                     void *data,
                                                     size_t size,
+                                                    bool final,
                                                     Error **errp)
 {
     NBDStructuredReadData chunk;
@@ -1303,13 +1304,73 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,

     assert(size);
     trace_nbd_co_send_structured_read(handle, offset, data, size);
-    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_OFFSET_DATA,
-                 handle, sizeof(chunk) - sizeof(chunk.h) + size);
+    set_be_chunk(&chunk.h, final ? NBD_REPLY_FLAG_DONE : 0,
+                 NBD_REPLY_TYPE_OFFSET_DATA, handle,
+                 sizeof(chunk) - sizeof(chunk.h) + size);
     stq_be_p(&chunk.offset, offset);

     return nbd_co_send_iov(client, iov, 2, errp);
 }

+static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
+                                                uint64_t handle,
+                                                uint64_t offset,
+                                                uint8_t *data,
+                                                size_t size,
+                                                Error **errp)
+{
+    int ret = 0;
+    NBDExport *exp = client->exp;
+    size_t progress = 0;
+
+    while (progress < size) {
+        int64_t pnum;
+        int status = bdrv_block_status_above(blk_bs(exp->blk), NULL,
+                                             offset + progress,
+                                             size - progress, &pnum, NULL,
+                                             NULL);
+
+        if (status < 0) {
+            error_setg_errno(errp, -status, "unable to check for holes");
+            return status;
+        }
+        assert(pnum && pnum <= size - progress);
+        if (status & BDRV_BLOCK_ZERO) {
+            NBDStructuredReadHole chunk;
+            struct iovec iov[] = {
+                {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+            };
+
+            trace_nbd_co_send_structured_read_hole(handle, offset + progress,
+                                                   pnum);
+            set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_OFFSET_HOLE,
+                         handle, sizeof(chunk) - sizeof(chunk.h));
+            stq_be_p(&chunk.offset, offset + progress);
+            stl_be_p(&chunk.length, pnum);
+            ret = nbd_co_send_iov(client, iov, 1, errp);
+        } else {
+            ret = blk_pread(exp->blk, offset + progress + exp->dev_offset,
+                            data + progress, pnum);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "reading from file failed");
+                break;
+            }
+            ret = nbd_co_send_structured_read(client, handle, offset + progress,
+                                              data + progress, pnum, false,
+                                              errp);
+        }
+
+        if (ret < 0) {
+            break;
+        }
+        progress += pnum;
+    }
+    if (!ret) {
+        ret = nbd_co_send_structured_done(client, handle, errp);
+    }
+    return ret;
+}
+
 static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
                                                      uint64_t handle,
                                                      uint32_t error,
@@ -1471,6 +1532,16 @@ static coroutine_fn void nbd_trip(void *opaque)
             }
         }

+        if (client->structured_reply && !(request.flags & NBD_CMD_FLAG_DF)) {
+            ret = nbd_co_send_sparse_read(req->client, request.handle,
+                                          request.from, req->data, request.len,
+                                          &local_err);
+            if (ret < 0) {
+                goto reply;
+            }
+            goto done;
+        }
+
         ret = blk_pread(exp->blk, request.from + exp->dev_offset,
                         req->data, request.len);
         if (ret < 0) {
@@ -1563,7 +1634,8 @@ reply:
         } else if (reply_data_len) {
             ret = nbd_co_send_structured_read(req->client, request.handle,
                                               request.from, req->data,
-                                              reply_data_len, &local_err);
+                                              reply_data_len, true,
+                                              &local_err);
         } else {
             ret = nbd_co_send_structured_done(req->client, request.handle,
                                               &local_err);
diff --git a/nbd/trace-events b/nbd/trace-events
index 92568edce5..2b8268ce8c 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -57,6 +57,7 @@ nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients fr
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
 nbd_co_send_structured_done(uint64_t handle) "Send structured reply done: handle = %" PRIu64
 nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
+nbd_co_send_structured_read_hole(uint64_t handle, uint64_t offset, size_t size) "Send structured read hole reply: handle = %" PRIu64 ", offset = %" PRIu64 ", len = %zu"
 nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
-- 
2.13.6
