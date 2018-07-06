Received: from eggs.gnu.org ([2001:4830:134:3::10]:36266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbVVV-0000wV-M9
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbVVQ-0002Oy-QB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:31:01 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  6 Jul 2018 21:30:50 +0300
Message-Id: <20180706183051.197403-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180706183051.197403-1-vsementsov@virtuozzo.com>
References: <20180706183051.197403-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 3/4] block: add BDRV_REQ_SERIALISING flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

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
---
 include/block/block.h | 15 ++++++++++++++-
 block/io.c            | 26 +++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 478ebc6c6c..fded1b7657 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -71,8 +71,21 @@ typedef enum {
      * content. */
     BDRV_REQ_WRITE_UNCHANGED    = 0x40,
 
+    /* BDRV_REQ_SERIALISING forces request serializing. Only for writes. Used
+     * to serialize writes to target in backup process, when source is in
+     * backing chain of target (image fleecing scheme is example) to avoid a
+     * possibility for a client, reading from target during backup to read
+     * updated data from source in case of unhappy race of client-read and
+     * backup-cow-write.
+     *
+     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
+     * BDRV_REQ_NO_SERIALISING. May be, better name for the latter is
+     * _DO_NOT_WAIT_FOR_SERIALISING, but it is too long.
+     */
+    BDRV_REQ_SERIALISING        = 0x80,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x7f,
+    BDRV_REQ_MASK               = 0xff,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index ba5a136d11..ecb35881d0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -623,6 +623,16 @@ static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
 }
 
+static bool is_request_serialising_and_aligned(BdrvTrackedRequest *req)
+{
+    /* if request is serialising, overlap_offset and overlap_bytes are set, so
+     * we can check is request aligned. Otherwise don't care and return false
+     */
+
+    return req->serialising && (req->offset == req->overlap_offset) &&
+           (req->bytes == req->overlap_bytes);
+}
+
 /**
  * Round a region to cluster boundaries
  */
@@ -1291,6 +1301,9 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
 
+    /* BDRV_REQ_SERIALISING is only for write operation */
+    assert(!(flags & BDRV_REQ_SERIALISING));
+
     if (!(flags & BDRV_REQ_NO_SERIALISING)) {
         wait_serialising_requests(req);
     }
@@ -1574,8 +1587,14 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 
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
@@ -2956,6 +2975,8 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
     bdrv_inc_in_flight(src->bs);
     tracked_request_begin(&req, src->bs, src_offset, bytes, BDRV_TRACKED_READ);
 
+    /* BDRV_REQ_SERIALISING is only for write operation */
+    assert(!(read_flags & BDRV_REQ_SERIALISING));
     if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
         wait_serialising_requests(&req);
     }
@@ -2995,6 +3016,9 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
 
     /* BDRV_REQ_NO_SERIALISING is only for read operation */
     assert(!(write_flags & BDRV_REQ_NO_SERIALISING));
+    if (write_flags & BDRV_REQ_SERIALISING) {
+        mark_request_serialising(&req, bdrv_get_cluster_size(dst->bs));
+    }
     wait_serialising_requests(&req);
 
     ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
-- 
2.11.1
