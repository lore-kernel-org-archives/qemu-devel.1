Received: from eggs.gnu.org ([2001:4830:134:3::10]:40615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuGO-0003x6-UL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuGO-00071P-1H
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:09:20 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:09:12 -0600
Message-Id: <20171107030912.23930-3-eblake@redhat.com>
In-Reply-To: <20171107030912.23930-1-eblake@redhat.com>
References: <20171107030912.23930-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] nbd/server: Optimize final chunk of sparse
 read
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

If we are careful to handle 0-length read requests correctly,
we can optimize our sparse read to send the NBD_REPLY_FLAG_DONE
bit on our last OFFSET_DATA or OFFSET_HOLE chunk rather than
needing a separate chunk.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3c5e3005a6..cde61d2461 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1329,12 +1329,14 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                                              offset + progress,
                                              size - progress, &pnum, NULL,
                                              NULL);
+        bool final;

         if (status < 0) {
             error_setg_errno(errp, -status, "unable to check for holes");
             return status;
         }
         assert(pnum && pnum <= size - progress);
+        final = progress + pnum == size;
         if (status & BDRV_BLOCK_ZERO) {
             NBDStructuredReadHole chunk;
             struct iovec iov[] = {
@@ -1343,7 +1345,8 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,

             trace_nbd_co_send_structured_read_hole(handle, offset + progress,
                                                    pnum);
-            set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_OFFSET_HOLE,
+            set_be_chunk(&chunk.h, final ? NBD_REPLY_FLAG_DONE : 0,
+                         NBD_REPLY_TYPE_OFFSET_HOLE,
                          handle, sizeof(chunk) - sizeof(chunk.h));
             stq_be_p(&chunk.offset, offset + progress);
             stl_be_p(&chunk.length, pnum);
@@ -1356,7 +1359,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                 break;
             }
             ret = nbd_co_send_structured_read(client, handle, offset + progress,
-                                              data + progress, pnum, false,
+                                              data + progress, pnum, final,
                                               errp);
         }

@@ -1365,9 +1368,6 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
         }
         progress += pnum;
     }
-    if (!ret) {
-        ret = nbd_co_send_structured_done(client, handle, errp);
-    }
     return ret;
 }

@@ -1532,7 +1532,8 @@ static coroutine_fn void nbd_trip(void *opaque)
             }
         }

-        if (client->structured_reply && !(request.flags & NBD_CMD_FLAG_DF)) {
+        if (client->structured_reply && !(request.flags & NBD_CMD_FLAG_DF) &&
+            request.len) {
             ret = nbd_co_send_sparse_read(req->client, request.handle,
                                           request.from, req->data, request.len,
                                           &local_err);
-- 
2.13.6
