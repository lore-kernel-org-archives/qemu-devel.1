Received: from eggs.gnu.org ([2001:4830:134:3::10]:58696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i38-0000Pf-VR
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i32-0001q4-Qb
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:14 +0200
Message-Id: <20171026131741.5059-9-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/35] qemu-img: Switch get_block_status() to
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
easier to reason about than sector-based.  Continue by converting
an internal function (no semantic change), and simplifying its
caller accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e9c7b30c91..af3effdec5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2671,14 +2671,16 @@ static void dump_map_entry(OutputFormat output_format, MapEntry *e,
     }
 }
 
-static int get_block_status(BlockDriverState *bs, int64_t sector_num,
-                            int nb_sectors, MapEntry *e)
+static int get_block_status(BlockDriverState *bs, int64_t offset,
+                            int64_t bytes, MapEntry *e)
 {
     int64_t ret;
     int depth;
     BlockDriverState *file;
     bool has_offset;
+    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
 
+    assert(bytes < INT_MAX);
     /* As an optimization, we could cache the current range of unallocated
      * clusters in each file of the chain, and avoid querying the same
      * range repeatedly.
@@ -2686,8 +2688,8 @@ static int get_block_status(BlockDriverState *bs, int64_t sector_num,
 
     depth = 0;
     for (;;) {
-        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &nb_sectors,
-                                    &file);
+        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS, nb_sectors,
+                                    &nb_sectors, &file);
         if (ret < 0) {
             return ret;
         }
@@ -2707,7 +2709,7 @@ static int get_block_status(BlockDriverState *bs, int64_t sector_num,
     has_offset = !!(ret & BDRV_BLOCK_OFFSET_VALID);
 
     *e = (MapEntry) {
-        .start = sector_num * BDRV_SECTOR_SIZE,
+        .start = offset,
         .length = nb_sectors * BDRV_SECTOR_SIZE,
         .data = !!(ret & BDRV_BLOCK_DATA),
         .zero = !!(ret & BDRV_BLOCK_ZERO),
@@ -2837,16 +2839,12 @@ static int img_map(int argc, char **argv)
 
     length = blk_getlength(blk);
     while (curr.start + curr.length < length) {
-        int64_t nsectors_left;
-        int64_t sector_num;
-        int n;
-
-        sector_num = (curr.start + curr.length) >> BDRV_SECTOR_BITS;
+        int64_t offset = curr.start + curr.length;
+        int64_t n;
 
         /* Probe up to 1 GiB at a time.  */
-        nsectors_left = DIV_ROUND_UP(length, BDRV_SECTOR_SIZE) - sector_num;
-        n = MIN(1 << (30 - BDRV_SECTOR_BITS), nsectors_left);
-        ret = get_block_status(bs, sector_num, n, &next);
+        n = QEMU_ALIGN_DOWN(MIN(1 << 30, length - offset), BDRV_SECTOR_SIZE);
+        ret = get_block_status(bs, offset, n, &next);
 
         if (ret < 0) {
             error_report("Could not read file metadata: %s", strerror(-ret));
-- 
2.13.6
