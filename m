Received: from eggs.gnu.org ([2001:4830:134:3::10]:37230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSaP-0005Dt-9E
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSaO-0001ru-31
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:33 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Jul 2017 20:05:50 -0500
Message-Id: <20170713010555.6769-14-eblake@redhat.com>
In-Reply-To: <20170713010555.6769-1-eblake@redhat.com>
References: <20170713010555.6769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 13/18] mirror: Switch mirror_dirty_init() to
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that we have adjusted the majority of the calls this function
makes to be byte-based, it is easier to read the code if it makes
passes over the image using bytes rather than sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v5: rebase to earlier changes
v2-v4: no change
---
 block/mirror.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index d0f0b87..4ad4203 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -613,15 +613,13 @@ static void mirror_throttle(MirrorBlockJob *s)

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
@@ -629,9 +627,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }

         s->initial_zeroing_ongoing = true;
-        for (sector_num = 0; sector_num < end; ) {
-            int nb_sectors = MIN(end - sector_num,
-                QEMU_ALIGN_DOWN(INT_MAX, s->granularity) >> BDRV_SECTOR_BITS);
+        for (offset = 0; offset < s->bdev_length; ) {
+            int bytes = MIN(s->bdev_length - offset,
+                            QEMU_ALIGN_DOWN(INT_MAX, s->granularity));

             mirror_throttle(s);

@@ -647,9 +645,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
                 continue;
             }

-            mirror_do_zero_or_discard(s, sector_num * BDRV_SECTOR_SIZE,
-                                      nb_sectors * BDRV_SECTOR_SIZE, false);
-            sector_num += nb_sectors;
+            mirror_do_zero_or_discard(s, offset, bytes, false);
+            offset += bytes;
         }

         mirror_wait_for_all_io(s);
@@ -657,10 +654,10 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
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

@@ -668,23 +665,16 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
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
2.9.4
