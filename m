Received: from eggs.gnu.org ([2001:4830:134:3::10]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i38-0000Pb-VE
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i32-0001pz-Q0
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:12 +0200
Message-Id: <20171026131741.5059-7-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/35] qcow2: Switch is_zero_sectors() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change), and rename it to is_zero() in the
process.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0e4c91cabc..795be673e7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2972,21 +2972,29 @@ finish:
 }
 
 
-static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
-                            uint32_t count)
+static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     int nr;
     int64_t res;
+    int64_t start;
 
-    if (start + count > bs->total_sectors) {
-        count = bs->total_sectors - start;
+    /* TODO: Widening to sector boundaries should only be needed as
+     * long as we can't query finer granularity. */
+    start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
+    bytes = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start;
+
+    /* Clamp to image length, before checking status of underlying sectors */
+    if (start + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
+        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - start;
     }
 
-    if (!count) {
+    if (!bytes) {
         return true;
     }
-    res = bdrv_get_block_status_above(bs, NULL, start, count, &nr, NULL);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
+    res = bdrv_get_block_status_above(bs, NULL, start >> BDRV_SECTOR_BITS,
+                                      bytes >> BDRV_SECTOR_BITS, &nr, NULL);
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) &&
+        nr * BDRV_SECTOR_SIZE == bytes;
 }
 
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
@@ -3004,24 +3012,21 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     }
 
     if (head || tail) {
-        int64_t cl_start = (offset - head) >> BDRV_SECTOR_BITS;
         uint64_t off;
         unsigned int nr;
 
         assert(head + bytes <= s->cluster_size);
 
         /* check whether remainder of cluster already reads as zero */
-        if (!(is_zero_sectors(bs, cl_start,
-                              DIV_ROUND_UP(head, BDRV_SECTOR_SIZE)) &&
-              is_zero_sectors(bs, (offset + bytes) >> BDRV_SECTOR_BITS,
-                              DIV_ROUND_UP(-tail & (s->cluster_size - 1),
-                                           BDRV_SECTOR_SIZE)))) {
+        if (!(is_zero(bs, offset - head, head) &&
+              is_zero(bs, offset + bytes,
+                      tail ? s->cluster_size - tail : 0))) {
             return -ENOTSUP;
         }
 
         qemu_co_mutex_lock(&s->lock);
         /* We can have new write after previous check */
-        offset = cl_start << BDRV_SECTOR_BITS;
+        offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
         bytes = s->cluster_size;
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
-- 
2.13.6
