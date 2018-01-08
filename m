Received: from eggs.gnu.org ([2001:4830:134:3::10]:36895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZOt-0002Rk-6b
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZOs-0007jS-A9
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:31:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  8 Jan 2018 09:31:36 -0600
Message-Id: <20180108153137.5195-3-eblake@redhat.com>
In-Reply-To: <20180108153137.5195-1-eblake@redhat.com>
References: <20180108153137.5195-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] nbd/server: Optimize final chunk of sparse
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

If we are careful to handle 0-length read requests correctly,
we can optimize our sparse read to send the NBD_REPLY_FLAG_DONE
bit on our last OFFSET_DATA or OFFSET_HOLE chunk rather than
needing a separate chunk.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171107030912.23930-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index be7310cb41..e443b3cf5c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1339,12 +1339,14 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
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
@@ -1353,7 +1355,8 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,

             trace_nbd_co_send_structured_read_hole(handle, offset + progress,
                                                    pnum);
-            set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_OFFSET_HOLE,
+            set_be_chunk(&chunk.h, final ? NBD_REPLY_FLAG_DONE : 0,
+                         NBD_REPLY_TYPE_OFFSET_HOLE,
                          handle, sizeof(chunk) - sizeof(chunk.h));
             stq_be_p(&chunk.offset, offset + progress);
             stl_be_p(&chunk.length, pnum);
@@ -1366,7 +1369,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                 break;
             }
             ret = nbd_co_send_structured_read(client, handle, offset + progress,
-                                              data + progress, pnum, false,
+                                              data + progress, pnum, final,
                                               errp);
         }

@@ -1375,9 +1378,6 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
         }
         progress += pnum;
     }
-    if (!ret) {
-        ret = nbd_co_send_structured_done(client, handle, errp);
-    }
     return ret;
 }

@@ -1542,7 +1542,8 @@ static coroutine_fn void nbd_trip(void *opaque)
             }
         }

-        if (client->structured_reply && !(request.flags & NBD_CMD_FLAG_DF)) {
+        if (client->structured_reply && !(request.flags & NBD_CMD_FLAG_DF) &&
+            request.len) {
             ret = nbd_co_send_sparse_read(req->client, request.handle,
                                           request.from, req->data, request.len,
                                           &local_err);
-- 
2.14.3
