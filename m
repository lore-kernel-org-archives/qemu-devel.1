Received: from eggs.gnu.org ([2001:4830:134:3::10]:55927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cw-0007e1-Et
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cv-0004be-Hl
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:48 -0500
Message-Id: <20170703221456.30817-8-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/15] qemu-img: Switch get_block_status()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Continue by converting
an internal function (no semantic change), and simplifying its
caller accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: no change
---
 qemu-img.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index daba954..7b7f992 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2674,14 +2674,16 @@ static void dump_map_entry(OutputFormat output_format, MapEntry *e,
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
@@ -2689,8 +2691,8 @@ static int get_block_status(BlockDriverState *bs, int64_t sector_num,

     depth = 0;
     for (;;) {
-        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &nb_sectors,
-                                    &file);
+        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS, nb_sectors,
+                                    &nb_sectors, &file);
         if (ret < 0) {
             return ret;
         }
@@ -2710,7 +2712,7 @@ static int get_block_status(BlockDriverState *bs, int64_t sector_num,
     has_offset = !!(ret & BDRV_BLOCK_OFFSET_VALID);

     *e = (MapEntry) {
-        .start = sector_num * BDRV_SECTOR_SIZE,
+        .start = offset,
         .length = nb_sectors * BDRV_SECTOR_SIZE,
         .data = !!(ret & BDRV_BLOCK_DATA),
         .zero = !!(ret & BDRV_BLOCK_ZERO),
@@ -2840,16 +2842,12 @@ static int img_map(int argc, char **argv)

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
2.9.4
