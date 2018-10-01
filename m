Received: from eggs.gnu.org ([2001:4830:134:3::10]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSN-0004qa-MH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSK-0002LM-PX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:12 +0300
Message-Id: <20181001102928.20533-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 02/18] block/io: allow BDRV_REQ_SERIALISING
 for read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

It will be used in further commit, changing backup architecture.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index bd9d688f8b..b003b4d5bf 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1318,10 +1318,11 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
      * potential fallback support, if we ever implement any read flags
      * to pass through to drivers.  For now, there aren't any
      * passthrough flags.  */
-    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ)));
+    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
+                       BDRV_REQ_SERIALISING)));
 
     /* Handle Copy on Read and associated serialisation */
-    if (flags & BDRV_REQ_COPY_ON_READ) {
+    if (flags & (BDRV_REQ_COPY_ON_READ | BDRV_REQ_SERIALISING)) {
         /* If we touch the same cluster it counts as an overlap.  This
          * guarantees that allocating writes will be serialized and not race
          * with each other for the same cluster.  For example, in copy-on-read
@@ -1330,9 +1331,6 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
 
-    /* BDRV_REQ_SERIALISING is only for write operation */
-    assert(!(flags & BDRV_REQ_SERIALISING));
-
     if (!(flags & BDRV_REQ_NO_SERIALISING)) {
         wait_serialising_requests(req);
     }
@@ -3027,8 +3025,9 @@ static int coroutine_fn bdrv_co_copy_range_internal(
         tracked_request_begin(&req, src->bs, src_offset, bytes,
                               BDRV_TRACKED_READ);
 
-        /* BDRV_REQ_SERIALISING is only for write operation */
-        assert(!(read_flags & BDRV_REQ_SERIALISING));
+        if (read_flags & BDRV_REQ_SERIALISING) {
+            mark_request_serialising(&req, bdrv_get_cluster_size(src->bs));
+        }
         if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
             wait_serialising_requests(&req);
         }
-- 
2.18.0
