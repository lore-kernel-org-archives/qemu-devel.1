Received: from eggs.gnu.org ([2001:4830:134:3::10]:33882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I23-00056M-AZ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I22-0003a7-Ef
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:15 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:28 -0500
Message-Id: <20170418013356.3578-4-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 03/31] qcow2: Switch is_zero_sectors() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change), and rename it to is_zero_above() in
the process.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4d34610..fe4ccf6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2442,23 +2442,30 @@ finish:
 }


-static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
-                            uint32_t count)
+static bool is_zero_above(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     int nr;
     BlockDriverState *file;
     int64_t res;
+    int64_t start;

-    if (start + count > bs->total_sectors) {
-        count = bs->total_sectors - start;
+    /* Widen to sector boundaries, then clamp to image length, before
+     * checking status of underlying sectors */
+    start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
+    bytes = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start;
+
+    if (start + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
+        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - offset;
     }

-    if (!count) {
+    if (!bytes) {
         return true;
     }
-    res = bdrv_get_block_status_above(bs, NULL, start, count,
+    res = bdrv_get_block_status_above(bs, NULL, start >> BDRV_SECTOR_BITS,
+                                      bytes >> BDRV_SECTOR_BITS,
                                       &nr, &file);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) &&
+        nr * BDRV_SECTOR_SIZE == bytes;
 }

 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
@@ -2476,24 +2483,21 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     }

     if (head || tail) {
-        int64_t cl_start = (offset - head) >> BDRV_SECTOR_BITS;
         uint64_t off;
         unsigned int nr;

         assert(head + count <= s->cluster_size);

         /* check whether remainder of cluster already reads as zero */
-        if (!(is_zero_sectors(bs, cl_start,
-                              DIV_ROUND_UP(head, BDRV_SECTOR_SIZE)) &&
-              is_zero_sectors(bs, (offset + count) >> BDRV_SECTOR_BITS,
-                              DIV_ROUND_UP(-tail & (s->cluster_size - 1),
-                                           BDRV_SECTOR_SIZE)))) {
+        if (!(is_zero_above(bs, offset - head, head) &&
+              is_zero_above(bs, offset + count,
+                            tail ? s->cluster_size - tail : 0))) {
             return -ENOTSUP;
         }

         qemu_co_mutex_lock(&s->lock);
         /* We can have new write after previous check */
-        offset = cl_start << BDRV_SECTOR_BITS;
+        offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
         count = s->cluster_size;
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
-- 
2.9.3
