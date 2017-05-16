Received: from eggs.gnu.org ([2001:4830:134:3::10]:41254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNm-0002gU-L4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNl-0003bX-OG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:50 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 16 May 2017 15:47:19 -0500
Message-Id: <20170516204724.1617-8-eblake@redhat.com>
In-Reply-To: <20170516204724.1617-1-eblake@redhat.com>
References: <20170516204724.1617-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/12] dirty-bitmap: Change
 bdrv_get_dirty_count() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Thanks to recent cleanups, all callers were scaling a return value
of sectors into bytes; do the scaling internally instead.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 block/dirty-bitmap.c |  4 ++--
 block/mirror.c       | 13 +++++--------
 migration/block.c    |  2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 2f9f554..e3c2e34 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -319,7 +319,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
     QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
         BlockDirtyInfo *info = g_new0(BlockDirtyInfo, 1);
         BlockDirtyInfoList *entry = g_new0(BlockDirtyInfoList, 1);
-        info->count = bdrv_get_dirty_count(bm) << BDRV_SECTOR_BITS;
+        info->count = bdrv_get_dirty_count(bm);
         info->granularity = bdrv_dirty_bitmap_granularity(bm);
         info->has_name = !!bm->name;
         info->name = g_strdup(bm->name);
@@ -494,7 +494,7 @@ void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *iter, int64_t offset)

 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
 {
-    return hbitmap_count(bitmap->bitmap);
+    return hbitmap_count(bitmap->bitmap) << BDRV_SECTOR_BITS;
 }

 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
diff --git a/block/mirror.c b/block/mirror.c
index 8428733..b82bdce 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -794,11 +794,10 @@ static void coroutine_fn mirror_run(void *opaque)

         cnt = bdrv_get_dirty_count(s->dirty_bitmap);
         /* s->common.offset contains the number of bytes already processed so
-         * far, cnt is the number of dirty sectors remaining and
+         * far, cnt is the number of dirty bytes remaining and
          * s->bytes_in_flight is the number of bytes currently being
          * processed; together those are the current total operation length */
-        s->common.len = s->common.offset + s->bytes_in_flight +
-            cnt * BDRV_SECTOR_SIZE;
+        s->common.len = s->common.offset + s->bytes_in_flight + cnt;

         /* Note that even when no rate limit is applied we need to yield
          * periodically with no pending I/O so that bdrv_drain_all() returns.
@@ -810,8 +809,7 @@ static void coroutine_fn mirror_run(void *opaque)
             s->common.iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
                 (cnt == 0 && s->in_flight > 0)) {
-                trace_mirror_yield(s, cnt * BDRV_SECTOR_SIZE,
-                                   s->buf_free_count, s->in_flight);
+                trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
                 mirror_wait_for_io(s);
                 continue;
             } else if (cnt != 0) {
@@ -852,7 +850,7 @@ static void coroutine_fn mirror_run(void *opaque)
              * whether to switch to target check one last time if I/O has
              * come in the meanwhile, and if not flush the data to disk.
              */
-            trace_mirror_before_drain(s, cnt * BDRV_SECTOR_SIZE);
+            trace_mirror_before_drain(s, cnt);

             bdrv_drained_begin(bs);
             cnt = bdrv_get_dirty_count(s->dirty_bitmap);
@@ -871,8 +869,7 @@ static void coroutine_fn mirror_run(void *opaque)
         }

         ret = 0;
-        trace_mirror_before_sleep(s, cnt * BDRV_SECTOR_SIZE,
-                                  s->synced, delay_ns);
+        trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
         if (!s->synced) {
             block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, delay_ns);
             if (block_job_is_cancelled(&s->common)) {
diff --git a/migration/block.c b/migration/block.c
index ecc838a..5a545cf 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -672,7 +672,7 @@ static int64_t get_remaining_dirty(void)
         aio_context_release(blk_get_aio_context(bmds->blk));
     }

-    return dirty << BDRV_SECTOR_BITS;
+    return dirty;
 }

 /* Called with iothread lock taken.  */
-- 
2.9.4
