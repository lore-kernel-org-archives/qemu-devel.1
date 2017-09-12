Received: from eggs.gnu.org ([2001:4830:134:3::10]:39771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrqu-00027W-QV
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrqt-0006Oy-TC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:32:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 12 Sep 2017 15:31:14 -0500
Message-Id: <20170912203119.24166-16-eblake@redhat.com>
In-Reply-To: <20170912203119.24166-1-eblake@redhat.com>
References: <20170912203119.24166-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 15/20] mirror: Switch mirror_dirty_init() to
 byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that we have adjusted the majority of the calls this function
makes to be byte-based, it is easier to read the code if it makes
passes over the image using bytes rather than sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v6: no change
v5: rebase to earlier changes
v2-v4: no change
---
 block/mirror.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index c2f73c91c5..5cdaaed7be 100644
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
2.13.5
