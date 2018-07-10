Received: from eggs.gnu.org ([2001:4830:134:3::10]:44309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunb-000581-6v
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunX-0001ct-3s
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:47 +0200
Message-Id: <20180710154304.18304-8-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/24] block: add BDRV_REQ_SERIALISING flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Serialized writes should be used in copy-on-write of backup(sync=none)
for image fleecing scheme.

We need to change an assert in bdrv_aligned_pwritev, added in
28de2dcd88de. The assert may fail now, because call to
wait_serialising_requests here may become first call to it for this
request with serializing flag set. It occurs if the request is aligned
(otherwise, we should already set serializing flag before calling
bdrv_aligned_pwritev and correspondingly waited for all intersecting
requests). However, for aligned requests, we should not care about
outdating of previously read data, as there no such data. Therefore,
let's just update an assert to not care about aligned requests.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 14 +++++++++++++-
 block/io.c            | 28 +++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index e474f2541b..a91f37bedf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -70,8 +70,20 @@ typedef enum {
      * content. */
     BDRV_REQ_WRITE_UNCHANGED    = 0x40,
 
+    /*
+     * BDRV_REQ_SERIALISING forces request serialisation for writes.
+     * It is used to ensure that writes to the backing file of a backup process
+     * target cannot race with a read of the backup target that defers to the
+     * backing file.
+     *
+     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
+     * BDRV_REQ_NO_SERIALISING. A more descriptive name for the latter might be
+     * _DO_NOT_WAIT_FOR_SERIALISING, except that is too long.
+     */
+    BDRV_REQ_SERIALISING        = 0x80,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x7f,
+    BDRV_REQ_MASK               = 0xff,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index 75ab26fd58..6be9c40f23 100644
--- a/block/io.c
+++ b/block/io.c
@@ -637,6 +637,18 @@ static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
 }
 
+static bool is_request_serialising_and_aligned(BdrvTrackedRequest *req)
+{
+    /*
+     * If the request is serialising, overlap_offset and overlap_bytes are set,
+     * so we can check if the request is aligned. Otherwise, don't care and
+     * return false.
+     */
+
+    return req->serialising && (req->offset == req->overlap_offset) &&
+           (req->bytes == req->overlap_bytes);
+}
+
 /**
  * Round a region to cluster boundaries
  */
@@ -1311,6 +1323,9 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
 
+    /* BDRV_REQ_SERIALISING is only for write operation */
+    assert(!(flags & BDRV_REQ_SERIALISING));
+
     if (!(flags & BDRV_REQ_NO_SERIALISING)) {
         wait_serialising_requests(req);
     }
@@ -1594,8 +1609,14 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 
     /* BDRV_REQ_NO_SERIALISING is only for read operation */
     assert(!(flags & BDRV_REQ_NO_SERIALISING));
+
+    if (flags & BDRV_REQ_SERIALISING) {
+        mark_request_serialising(req, bdrv_get_cluster_size(bs));
+    }
+
     waited = wait_serialising_requests(req);
-    assert(!waited || !req->serialising);
+    assert(!waited || !req->serialising ||
+           is_request_serialising_and_aligned(req));
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
     if (flags & BDRV_REQ_WRITE_UNCHANGED) {
@@ -2949,6 +2970,8 @@ static int coroutine_fn bdrv_co_copy_range_internal(
         tracked_request_begin(&req, src->bs, src_offset, bytes,
                               BDRV_TRACKED_READ);
 
+        /* BDRV_REQ_SERIALISING is only for write operation */
+        assert(!(read_flags & BDRV_REQ_SERIALISING));
         if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
             wait_serialising_requests(&req);
         }
@@ -2968,6 +2991,9 @@ static int coroutine_fn bdrv_co_copy_range_internal(
 
         /* BDRV_REQ_NO_SERIALISING is only for read operation */
         assert(!(write_flags & BDRV_REQ_NO_SERIALISING));
+        if (write_flags & BDRV_REQ_SERIALISING) {
+            mark_request_serialising(&req, bdrv_get_cluster_size(dst->bs));
+        }
         wait_serialising_requests(&req);
 
         ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
-- 
2.13.6
