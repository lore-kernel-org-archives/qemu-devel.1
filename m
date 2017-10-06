Received: from eggs.gnu.org ([2001:4830:134:3::10]:55703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxn-0000P8-Im
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxm-0002yH-2H
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:44 +0200
Message-Id: <20171006155422.10135-17-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/54] mirror: Switch mirror_dirty_init() to
 byte-based iteration
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

Now that we have adjusted the majority of the calls this function
makes to be byte-based, it is easier to read the code if it makes
passes over the image using bytes rather than sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 5c0f79f56a..459b80f8f3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -612,15 +612,13 @@ static void mirror_throttle(MirrorBlockJob *s)
 
 static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 {
-    int64_t sector_num, end;
+    int64_t offset;
     BlockDriverState *base = s->base;
     BlockDriverState *bs = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
-    int ret, n;
+    int ret;
     int64_t count;
 
-    end = s->bdev_length / BDRV_SECTOR_SIZE;
-
     if (base == NULL && !bdrv_has_zero_init(target_bs)) {
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
@@ -628,9 +626,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }
 
         s->initial_zeroing_ongoing = true;
-        for (sector_num = 0; sector_num < end; ) {
-            int nb_sectors = MIN(end - sector_num,
-                QEMU_ALIGN_DOWN(INT_MAX, s->granularity) >> BDRV_SECTOR_BITS);
+        for (offset = 0; offset < s->bdev_length; ) {
+            int bytes = MIN(s->bdev_length - offset,
+                            QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
             mirror_throttle(s);
 
@@ -646,9 +644,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
                 continue;
             }
 
-            mirror_do_zero_or_discard(s, sector_num * BDRV_SECTOR_SIZE,
-                                      nb_sectors * BDRV_SECTOR_SIZE, false);
-            sector_num += nb_sectors;
+            mirror_do_zero_or_discard(s, offset, bytes, false);
+            offset += bytes;
         }
 
         mirror_wait_for_all_io(s);
@@ -656,10 +653,10 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
     }
 
     /* First part, loop on the sectors and initialize the dirty bitmap.  */
-    for (sector_num = 0; sector_num < end; ) {
+    for (offset = 0; offset < s->bdev_length; ) {
         /* Just to make sure we are not exceeding int limit. */
-        int nb_sectors = MIN(INT_MAX >> BDRV_SECTOR_BITS,
-                             end - sector_num);
+        int bytes = MIN(s->bdev_length - offset,
+                        QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
         mirror_throttle(s);
 
@@ -667,23 +664,16 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             return 0;
         }
 
-        ret = bdrv_is_allocated_above(bs, base, sector_num * BDRV_SECTOR_SIZE,
-                                      nb_sectors * BDRV_SECTOR_SIZE, &count);
+        ret = bdrv_is_allocated_above(bs, base, offset, bytes, &count);
         if (ret < 0) {
             return ret;
         }
 
-        /* TODO: Relax this once bdrv_is_allocated_above and dirty
-         * bitmaps no longer require sector alignment. */
-        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
-        n = count >> BDRV_SECTOR_BITS;
-        assert(n > 0);
+        assert(count);
         if (ret == 1) {
-            bdrv_set_dirty_bitmap(s->dirty_bitmap,
-                                  sector_num * BDRV_SECTOR_SIZE,
-                                  n * BDRV_SECTOR_SIZE);
+            bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, count);
         }
-        sector_num += n;
+        offset += count;
     }
     return 0;
 }
-- 
2.13.6
