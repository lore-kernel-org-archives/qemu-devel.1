Received: from eggs.gnu.org ([2001:4830:134:3::10]:53276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmb-0004lp-Lw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNma-0001ui-C6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:26:02 +0200
Message-Id: <20180611142611.6609-21-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 20/29] qemu-img: Special post-backing convert
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Currently, qemu-img convert writes zeroes when it reads zeroes.
Sometimes it does not because the target is initialized to zeroes
anyway, so we do not need to overwrite (and thus potentially allocate)
it.  This is never the case for targets with backing files, though.  But
even they may have an area that is initialized to zeroes, and that is
the area past the end of the backing file (if that is shorter than the
overlay).

So if the target format's unallocated blocks are zero and there is a gap
between the target's backing file's end and the target's end, we do not
have to explicitly write zeroes there.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1527898
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180501165750.19242-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index ebe1b866da..ae4acb655b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1556,7 +1556,9 @@ typedef struct ImgConvertState {
     BlockBackend *target;
     bool has_zero_init;
     bool compressed;
+    bool unallocated_blocks_are_zero;
     bool target_has_backing;
+    int64_t target_backing_sectors; /* negative if unknown */
     bool wr_in_order;
     bool copy_range;
     int min_sparse;
@@ -1586,12 +1588,23 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 {
     int64_t src_cur_offset;
     int ret, n, src_cur;
+    bool post_backing_zero = false;
 
     convert_select_part(s, sector_num, &src_cur, &src_cur_offset);
 
     assert(s->total_sectors > sector_num);
     n = MIN(s->total_sectors - sector_num, BDRV_REQUEST_MAX_SECTORS);
 
+    if (s->target_backing_sectors >= 0) {
+        if (sector_num >= s->target_backing_sectors) {
+            post_backing_zero = s->unallocated_blocks_are_zero;
+        } else if (sector_num + n > s->target_backing_sectors) {
+            /* Split requests around target_backing_sectors (because
+             * starting from there, zeros are handled differently) */
+            n = s->target_backing_sectors - sector_num;
+        }
+    }
+
     if (s->sector_next_status <= sector_num) {
         int64_t count = n * BDRV_SECTOR_SIZE;
 
@@ -1613,7 +1626,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
         n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
 
         if (ret & BDRV_BLOCK_ZERO) {
-            s->status = BLK_ZERO;
+            s->status = post_backing_zero ? BLK_BACKING_FILE : BLK_ZERO;
         } else if (ret & BDRV_BLOCK_DATA) {
             s->status = BLK_DATA;
         } else {
@@ -2379,6 +2392,16 @@ static int img_convert(int argc, char **argv)
         }
     }
 
+    if (s.target_has_backing) {
+        /* Errors are treated as "backing length unknown" (which means
+         * s.target_backing_sectors has to be negative, which it will
+         * be automatically).  The backing file length is used only
+         * for optimizations, so such a case is not fatal. */
+        s.target_backing_sectors = bdrv_nb_sectors(out_bs->backing->bs);
+    } else {
+        s.target_backing_sectors = -1;
+    }
+
     ret = bdrv_get_info(out_bs, &bdi);
     if (ret < 0) {
         if (s.compressed) {
@@ -2388,6 +2411,7 @@ static int img_convert(int argc, char **argv)
     } else {
         s.compressed = s.compressed || bdi.needs_compressed_writes;
         s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
+        s.unallocated_blocks_are_zero = bdi.unallocated_blocks_are_zero;
     }
 
     ret = convert_do_copy(&s);
-- 
2.17.1
