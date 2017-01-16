Received: from eggs.gnu.org ([2001:4830:134:3::10]:49859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9wt-0007wy-3k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9ws-0002H0-1X
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:15:59 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 17:15:47 +0100
Message-Id: <20170116161547.9005-1-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 6/9] qemu-img: Use bdrv_filename() for map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Replaces bs->filename by the result of bdrv_filename() in the
qemu-img map subcommand. Since that value is queried relatively often,
however, we should try to reuse the last result.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5df66fe661..6f14792025 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2469,12 +2469,14 @@ static void dump_map_entry(OutputFormat output_format, MapEntry *e,
 }
 
 static int get_block_status(BlockDriverState *bs, int64_t sector_num,
-                            int nb_sectors, MapEntry *e)
+                            int nb_sectors, MapEntry *e,
+                            BlockDriverState **current_file)
 {
     int64_t ret;
     int depth;
     BlockDriverState *file;
     bool has_offset;
+    char *filename;
 
     /* As an optimization, we could cache the current range of unallocated
      * clusters in each file of the chain, and avoid querying the same
@@ -2503,6 +2505,18 @@ static int get_block_status(BlockDriverState *bs, int64_t sector_num,
 
     has_offset = !!(ret & BDRV_BLOCK_OFFSET_VALID);
 
+    if (!file || !has_offset) {
+        g_free(e->filename);
+        filename = NULL;
+    } else if (file == *current_file && e->has_filename) {
+        filename = e->filename;
+    } else {
+        g_free(e->filename);
+        filename = bdrv_filename(file, NULL, 0);
+    }
+
+    *current_file = file;
+
     *e = (MapEntry) {
         .start = sector_num * BDRV_SECTOR_SIZE,
         .length = nb_sectors * BDRV_SECTOR_SIZE,
@@ -2511,8 +2525,8 @@ static int get_block_status(BlockDriverState *bs, int64_t sector_num,
         .offset = ret & BDRV_BLOCK_OFFSET_MASK,
         .has_offset = has_offset,
         .depth = depth,
-        .has_filename = file && has_offset,
-        .filename = file && has_offset ? file->filename : NULL,
+        .has_filename = filename,
+        .filename = filename,
     };
 
     return 0;
@@ -2544,10 +2558,10 @@ static int img_map(int argc, char **argv)
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *blk;
-    BlockDriverState *bs;
+    BlockDriverState *bs, *current_file = NULL;
     const char *filename, *fmt, *output;
     int64_t length;
-    MapEntry curr = { .length = 0 }, next;
+    MapEntry curr = { .length = 0 }, next = { 0 };
     int ret = 0;
     bool image_opts = false;
 
@@ -2633,7 +2647,7 @@ static int img_map(int argc, char **argv)
         /* Probe up to 1 GiB at a time.  */
         nsectors_left = DIV_ROUND_UP(length, BDRV_SECTOR_SIZE) - sector_num;
         n = MIN(1 << (30 - BDRV_SECTOR_BITS), nsectors_left);
-        ret = get_block_status(bs, sector_num, n, &next);
+        ret = get_block_status(bs, sector_num, n, &next, &current_file);
 
         if (ret < 0) {
             error_report("Could not read file metadata: %s", strerror(-ret));
@@ -2648,12 +2662,17 @@ static int img_map(int argc, char **argv)
         if (curr.length > 0) {
             dump_map_entry(output_format, &curr, &next);
         }
+
+        g_free(curr.filename);
         curr = next;
+        curr.filename = g_strdup(curr.filename);
     }
 
     dump_map_entry(output_format, &curr, NULL);
 
 out:
+    g_free(curr.filename);
+    g_free(next.filename);
     blk_unref(blk);
     return ret < 0;
 }
-- 
2.11.0
