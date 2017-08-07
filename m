Received: from eggs.gnu.org ([2001:4830:134:3::10]:49096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJA-0007Rb-1F
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIu-0003yO-8z
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:31 +0200
Message-Id: <1502117160-24655-28-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 27/56] block/dirty-bitmap: Clean up signed
 vs. unsigned dirty counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

hbitmap_count() returns uint64_t.

Clean up test-hbitmap.c to check its value with g_assert_cmpuint()
instead of g_assert_cmpint().

bdrv_get_dirty_count() and bdrv_get_meta_dirty_count() return its
value converted to int64_t.  Clean them up to return it unadulterated.

This moves the implicit conversion to some callers, so clean them up,
too.

mirror_run() assigns the value of bdrv_get_meta_dirty_count() to a
local int64_t variable.  Change it to uint64_t.  Signedness still gets
mixed up in the computation of s->common.len, but messing with that is
more than I can handle right now.

get_remaining_dirty() tallies bdrv_get_dirty_count() values in
int64_t.  Its caller block_save_pending() converts it back to
uint64_t.  Change get_remaining_dirty() to uint64_t.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/dirty-bitmap.c         |  4 ++--
 block/mirror.c               |  4 ++--
 block/trace-events           |  8 ++++----
 include/block/dirty-bitmap.h |  4 ++--
 migration/block.c            |  4 ++--
 tests/test-hbitmap.c         | 16 +++++++++-------
 6 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 30462d4..5b1699c 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -681,12 +681,12 @@ void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *iter, int64_t sector_num)
     hbitmap_iter_init(&iter->hbi, iter->hbi.hb, sector_num);
 }
 
-int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
+uint64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->bitmap);
 }
 
-int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
+uint64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->meta);
 }
diff --git a/block/mirror.c b/block/mirror.c
index c9a6a3c..14c34e9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -798,8 +798,8 @@ static void coroutine_fn mirror_run(void *opaque)
     assert(!s->dbi);
     s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap, 0);
     for (;;) {
-        uint64_t delay_ns = 0;
-        int64_t cnt, delta;
+        uint64_t cnt, delay_ns = 0;
+        int64_t delta;
         bool should_complete;
 
         if (s->ret < 0) {
diff --git a/block/trace-events b/block/trace-events
index 071a8d7..464a11f 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -24,13 +24,13 @@ commit_start(void *bs, void *base, void *top, void *s) "bs %p base %p top %p s %
 
 # block/mirror.c
 mirror_start(void *bs, void *s, void *opaque) "bs %p s %p opaque %p"
-mirror_restart_iter(void *s, int64_t cnt) "s %p dirty count %"PRId64
+mirror_restart_iter(void *s, uint64_t cnt) "s %p dirty count %" PRIu64
 mirror_before_flush(void *s) "s %p"
-mirror_before_drain(void *s, int64_t cnt) "s %p dirty count %"PRId64
-mirror_before_sleep(void *s, int64_t cnt, int synced, uint64_t delay_ns) "s %p dirty count %"PRId64" synced %d delay %"PRIu64"ns"
+mirror_before_drain(void *s, uint64_t cnt) "s %p dirty count %" PRIu64
+mirror_before_sleep(void *s, uint64_t cnt, int synced, uint64_t delay_ns) "s %p dirty count %" PRIu64 " synced %d delay %" PRIu64 "ns"
 mirror_one_iteration(void *s, int64_t offset, uint64_t bytes) "s %p offset %" PRId64 " bytes %" PRIu64
 mirror_iteration_done(void *s, int64_t offset, uint64_t bytes, int ret) "s %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
-mirror_yield(void *s, int64_t cnt, int buf_free_count, int in_flight) "s %p dirty count %"PRId64" free buffers %d in_flight %d"
+mirror_yield(void *s, uint64_t cnt, int buf_free_count, int in_flight) "s %p dirty count %" PRIu64 " free buffers %d in_flight %d"
 mirror_yield_in_flight(void *s, int64_t offset, int in_flight) "s %p offset %" PRId64 " in_flight %d"
 
 # block/backup.c
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index a79a58d..d7e0f61 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -91,8 +91,8 @@ void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t cur_sector, int64_t nr_sectors);
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
-int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
-int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
+uint64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
+uint64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
diff --git a/migration/block.c b/migration/block.c
index 9171f60..59b7551 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -656,10 +656,10 @@ static int flush_blks(QEMUFile *f)
 
 /* Called with iothread lock taken.  */
 
-static int64_t get_remaining_dirty(void)
+static uint64_t get_remaining_dirty(void)
 {
     BlkMigDevState *bmds;
-    int64_t dirty = 0;
+    uint64_t dirty = 0;
 
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
         aio_context_acquire(blk_get_aio_context(bmds->blk));
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 1acb353..f816827 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -70,7 +70,8 @@ static void hbitmap_test_check(TestHBitmapData *data,
     }
 
     if (first == 0) {
-        g_assert_cmpint(count << data->granularity, ==, hbitmap_count(data->hb));
+        g_assert_cmpuint(count << data->granularity,
+                         ==, hbitmap_count(data->hb));
     }
 }
 
@@ -222,7 +223,7 @@ static void hbitmap_test_check_get(TestHBitmapData *data)
         count += hbitmap_get(data->hb, i);
         g_assert_cmpint(hbitmap_get(data->hb, i), ==, val != 0);
     }
-    g_assert_cmpint(count, ==, hbitmap_count(data->hb));
+    g_assert_cmpuint(count, ==, hbitmap_count(data->hb));
 }
 
 static void test_hbitmap_zero(TestHBitmapData *data,
@@ -416,15 +417,15 @@ static void test_hbitmap_granularity(TestHBitmapData *data,
     /* Note that hbitmap_test_check has to be invoked manually in this test.  */
     hbitmap_test_init(data, L1, 1);
     hbitmap_test_set(data, 0, 1);
-    g_assert_cmpint(hbitmap_count(data->hb), ==, 2);
+    g_assert_cmpuint(hbitmap_count(data->hb), ==, 2);
     hbitmap_test_check(data, 0);
     hbitmap_test_set(data, 2, 1);
-    g_assert_cmpint(hbitmap_count(data->hb), ==, 4);
+    g_assert_cmpuint(hbitmap_count(data->hb), ==, 4);
     hbitmap_test_check(data, 0);
     hbitmap_test_set(data, 0, 3);
-    g_assert_cmpint(hbitmap_count(data->hb), ==, 4);
+    g_assert_cmpuint(hbitmap_count(data->hb), ==, 4);
     hbitmap_test_reset(data, 0, 1);
-    g_assert_cmpint(hbitmap_count(data->hb), ==, 2);
+    g_assert_cmpuint(hbitmap_count(data->hb), ==, 2);
 }
 
 static void test_hbitmap_iter_granularity(TestHBitmapData *data,
@@ -494,7 +495,8 @@ static void hbitmap_test_check_boundary_bits(TestHBitmapData *data)
          */
         g_assert(hbitmap_get(data->hb, 0));
         g_assert(hbitmap_get(data->hb, size - 1));
-        g_assert_cmpint(2 << data->granularity, ==, hbitmap_count(data->hb));
+        g_assert_cmpuint(2ull << data->granularity,
+                         ==, hbitmap_count(data->hb));
     }
 }
 
-- 
2.7.5
