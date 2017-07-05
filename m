Received: from eggs.gnu.org ([2001:4830:134:3::10]:38059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrY3-00055z-2j
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXx-0002ky-SV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:34 -0500
Message-Id: <20170705210842.960-14-eblake@redhat.com>
In-Reply-To: <20170705210842.960-1-eblake@redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 13/21] mirror: Switch mirror_iteration() to
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
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the internal
loop iteration of mirroring to track by bytes instead of sectors
(although we are still guaranteed that we iterate by steps that
are both sector-aligned and multiples of the granularity).  Drop
the now-unused mirror_clip_sectors().

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
v4: no change
v3: rebase to Paolo's thread-safety changes, R-b kept
v2: straightforward rebase to earlier mirror_clip_bytes() change, R-b kept
---
 block/mirror.c | 105 +++++++++++++++++++++++++--------------------------------
 1 file changed, 46 insertions(+), 59 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index d3325d0..f54a8d7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -184,15 +184,6 @@ static inline int64_t mirror_clip_bytes(MirrorBlockJob *s,
     return MIN(bytes, s->bdev_length - offset);
 }

-/* Clip nb_sectors relative to sector_num to not exceed end-of-file */
-static inline int mirror_clip_sectors(MirrorBlockJob *s,
-                                      int64_t sector_num,
-                                      int nb_sectors)
-{
-    return MIN(nb_sectors,
-               s->bdev_length / BDRV_SECTOR_SIZE - sector_num);
-}
-
 /* Round offset and/or bytes to target cluster if COW is needed, and
  * return the offset of the adjusted tail against original. */
 static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
@@ -336,30 +327,28 @@ static void mirror_do_zero_or_discard(MirrorBlockJob *s,
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
     BlockDriverState *source = s->source;
-    int64_t sector_num, first_chunk;
+    int64_t offset, first_chunk;
     uint64_t delay_ns = 0;
     /* At least the first dirty chunk is mirrored in one iteration. */
     int nb_chunks = 1;
-    int64_t end = s->bdev_length / BDRV_SECTOR_SIZE;
     int sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);

     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
-    sector_num = bdrv_dirty_iter_next(s->dbi);
-    if (sector_num < 0) {
+    offset = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+    if (offset < 0) {
         bdrv_set_dirty_iter(s->dbi, 0);
-        sector_num = bdrv_dirty_iter_next(s->dbi);
+        offset = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
         trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap) *
                                   BDRV_SECTOR_SIZE);
-        assert(sector_num >= 0);
+        assert(offset >= 0);
     }
     bdrv_dirty_bitmap_unlock(s->dirty_bitmap);

-    first_chunk = sector_num / sectors_per_chunk;
+    first_chunk = offset / s->granularity;
     while (test_bit(first_chunk, s->in_flight_bitmap)) {
-        trace_mirror_yield_in_flight(s, sector_num * BDRV_SECTOR_SIZE,
-                                     s->in_flight);
+        trace_mirror_yield_in_flight(s, offset, s->in_flight);
         mirror_wait_for_io(s);
     }

@@ -368,25 +357,26 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     /* Find the number of consective dirty chunks following the first dirty
      * one, and wait for in flight requests in them. */
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
-    while (nb_chunks * sectors_per_chunk < (s->buf_size >> BDRV_SECTOR_BITS)) {
+    while (nb_chunks * s->granularity < s->buf_size) {
         int64_t next_dirty;
-        int64_t next_sector = sector_num + nb_chunks * sectors_per_chunk;
-        int64_t next_chunk = next_sector / sectors_per_chunk;
-        if (next_sector >= end ||
-            !bdrv_get_dirty_locked(source, s->dirty_bitmap, next_sector)) {
+        int64_t next_offset = offset + nb_chunks * s->granularity;
+        int64_t next_chunk = next_offset / s->granularity;
+        if (next_offset >= s->bdev_length ||
+            !bdrv_get_dirty_locked(source, s->dirty_bitmap,
+                                   next_offset >> BDRV_SECTOR_BITS)) {
             break;
         }
         if (test_bit(next_chunk, s->in_flight_bitmap)) {
             break;
         }

-        next_dirty = bdrv_dirty_iter_next(s->dbi);
-        if (next_dirty > next_sector || next_dirty < 0) {
+        next_dirty = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+        if (next_dirty > next_offset || next_dirty < 0) {
             /* The bitmap iterator's cache is stale, refresh it */
-            bdrv_set_dirty_iter(s->dbi, next_sector);
-            next_dirty = bdrv_dirty_iter_next(s->dbi);
+            bdrv_set_dirty_iter(s->dbi, next_offset >> BDRV_SECTOR_BITS);
+            next_dirty = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
         }
-        assert(next_dirty == next_sector);
+        assert(next_dirty == next_offset);
         nb_chunks++;
     }

@@ -394,14 +384,15 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
      * calling bdrv_get_block_status_above could yield - if some blocks are
      * marked dirty in this window, we need to know.
      */
-    bdrv_reset_dirty_bitmap_locked(s->dirty_bitmap, sector_num,
-                                  nb_chunks * sectors_per_chunk);
+    bdrv_reset_dirty_bitmap_locked(s->dirty_bitmap, offset >> BDRV_SECTOR_BITS,
+                                   nb_chunks * sectors_per_chunk);
     bdrv_dirty_bitmap_unlock(s->dirty_bitmap);

-    bitmap_set(s->in_flight_bitmap, sector_num / sectors_per_chunk, nb_chunks);
-    while (nb_chunks > 0 && sector_num < end) {
+    bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
+    while (nb_chunks > 0 && offset < s->bdev_length) {
         int64_t ret;
         int io_sectors;
+        unsigned int io_bytes;
         int64_t io_bytes_acct;
         BlockDriverState *file;
         enum MirrorMethod {
@@ -410,28 +401,28 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
             MIRROR_METHOD_DISCARD
         } mirror_method = MIRROR_METHOD_COPY;

-        assert(!(sector_num % sectors_per_chunk));
-        ret = bdrv_get_block_status_above(source, NULL, sector_num,
+        assert(!(offset % s->granularity));
+        ret = bdrv_get_block_status_above(source, NULL,
+                                          offset >> BDRV_SECTOR_BITS,
                                           nb_chunks * sectors_per_chunk,
                                           &io_sectors, &file);
+        io_bytes = io_sectors * BDRV_SECTOR_SIZE;
         if (ret < 0) {
-            io_sectors = MIN(nb_chunks * sectors_per_chunk,
-                             max_io_bytes >> BDRV_SECTOR_BITS);
+            io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
         } else if (ret & BDRV_BLOCK_DATA) {
-            io_sectors = MIN(io_sectors, max_io_bytes >> BDRV_SECTOR_BITS);
+            io_bytes = MIN(io_bytes, max_io_bytes);
         }

-        io_sectors -= io_sectors % sectors_per_chunk;
-        if (io_sectors < sectors_per_chunk) {
-            io_sectors = sectors_per_chunk;
+        io_bytes -= io_bytes % s->granularity;
+        if (io_bytes < s->granularity) {
+            io_bytes = s->granularity;
         } else if (ret >= 0 && !(ret & BDRV_BLOCK_DATA)) {
-            int64_t target_sector_num;
-            int target_nb_sectors;
-            bdrv_round_sectors_to_clusters(blk_bs(s->target), sector_num,
-                                           io_sectors,  &target_sector_num,
-                                           &target_nb_sectors);
-            if (target_sector_num == sector_num &&
-                target_nb_sectors == io_sectors) {
+            int64_t target_offset;
+            unsigned int target_bytes;
+            bdrv_round_to_clusters(blk_bs(s->target), offset, io_bytes,
+                                   &target_offset, &target_bytes);
+            if (target_offset == offset &&
+                target_bytes == io_bytes) {
                 mirror_method = ret & BDRV_BLOCK_ZERO ?
                                     MIRROR_METHOD_ZERO :
                                     MIRROR_METHOD_DISCARD;
@@ -439,8 +430,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         }

         while (s->in_flight >= MAX_IN_FLIGHT) {
-            trace_mirror_yield_in_flight(s, sector_num * BDRV_SECTOR_SIZE,
-                                         s->in_flight);
+            trace_mirror_yield_in_flight(s, offset, s->in_flight);
             mirror_wait_for_io(s);
         }

@@ -448,30 +438,27 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
             return 0;
         }

-        io_sectors = mirror_clip_sectors(s, sector_num, io_sectors);
+        io_bytes = mirror_clip_bytes(s, offset, io_bytes);
         switch (mirror_method) {
         case MIRROR_METHOD_COPY:
-            io_bytes_acct = mirror_do_read(s, sector_num * BDRV_SECTOR_SIZE,
-                                           io_sectors * BDRV_SECTOR_SIZE);
-            io_sectors = io_bytes_acct / BDRV_SECTOR_SIZE;
+            io_bytes = io_bytes_acct = mirror_do_read(s, offset, io_bytes);
             break;
         case MIRROR_METHOD_ZERO:
         case MIRROR_METHOD_DISCARD:
-            mirror_do_zero_or_discard(s, sector_num * BDRV_SECTOR_SIZE,
-                                      io_sectors * BDRV_SECTOR_SIZE,
+            mirror_do_zero_or_discard(s, offset, io_bytes,
                                       mirror_method == MIRROR_METHOD_DISCARD);
             if (write_zeroes_ok) {
                 io_bytes_acct = 0;
             } else {
-                io_bytes_acct = io_sectors * BDRV_SECTOR_SIZE;
+                io_bytes_acct = io_bytes;
             }
             break;
         default:
             abort();
         }
-        assert(io_sectors);
-        sector_num += io_sectors;
-        nb_chunks -= DIV_ROUND_UP(io_sectors, sectors_per_chunk);
+        assert(io_bytes);
+        offset += io_bytes;
+        nb_chunks -= DIV_ROUND_UP(io_bytes, s->granularity);
         if (s->common.speed) {
             delay_ns = ratelimit_calculate_delay(&s->limit, io_bytes_acct);
         }
-- 
2.9.4
