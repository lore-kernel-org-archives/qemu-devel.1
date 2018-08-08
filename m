Received: from eggs.gnu.org ([2001:4830:134:3::10]:38499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnNu9-0004dA-MF
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnNu6-0004DL-Ao
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:49:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  8 Aug 2018 15:49:22 +0300
Message-Id: <20180808124925.21031-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180808124925.21031-1-vsementsov@virtuozzo.com>
References: <20180808124925.21031-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/7] block/mirror: fix and improve
 do_sync_target_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Use bdrv_dirty_bitmap_next_dirty_area() instead of
bdrv_dirty_iter_next_area(), because of the following problems of
bdrv_dirty_iter_next_area():

1. Using HBitmap iterators we should carefully handle unaligned offset,
as first call to hbitmap_iter_next() may return a value less than
original offset (actually, it will be original offset rounded down to
bitmap granularity). This handling is not done in
do_sync_target_write().

2. bdrv_dirty_iter_next_area() handles unaligned max_offset
incorrectly:

look at the code:
    if (max_offset == iter->bitmap->size) {
        /* If max_offset points to the image end, round it up by the
         * bitmap granularity */
        gran_max_offset = ROUND_UP(max_offset, granularity);
    } else {
        gran_max_offset = max_offset;
    }

    ret = hbitmap_iter_next(&iter->hbi, false);
    if (ret < 0 || ret + granularity > gran_max_offset) {
        return false;
    }

and assume that max_offset != iter->bitmap->size but still unaligned.
if 0 < ret < max_offset we found dirty area, but the function can
return false in this case (if ret + granularity > max_offset).

3. bdrv_dirty_iter_next_area() uses inefficient loop to find the end of
the dirty area. Let's use more efficient hbitmap_next_zero instead
(bdrv_dirty_bitmap_next_dirty_area() do so)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/mirror.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b48c3f8cf5..d2806812c8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1167,25 +1167,22 @@ static void do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
                                  uint64_t offset, uint64_t bytes,
                                  QEMUIOVector *qiov, int flags)
 {
-    BdrvDirtyBitmapIter *iter;
     QEMUIOVector target_qiov;
-    uint64_t dirty_offset;
-    int dirty_bytes;
+    uint64_t dirty_offset = offset;
+    uint64_t dirty_bytes;
 
     if (qiov) {
         qemu_iovec_init(&target_qiov, qiov->niov);
     }
 
-    iter = bdrv_dirty_iter_new(job->dirty_bitmap);
-    bdrv_set_dirty_iter(iter, offset);
-
     while (true) {
         bool valid_area;
         int ret;
 
         bdrv_dirty_bitmap_lock(job->dirty_bitmap);
-        valid_area = bdrv_dirty_iter_next_area(iter, offset + bytes,
-                                               &dirty_offset, &dirty_bytes);
+        valid_area = bdrv_dirty_bitmap_next_dirty_area(
+            job->dirty_bitmap, &dirty_offset,
+            MIN(offset + bytes, dirty_offset + INT_MAX), &dirty_bytes);
         if (!valid_area) {
             bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
             break;
@@ -1241,9 +1238,10 @@ static void do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
                 break;
             }
         }
+
+        dirty_offset += dirty_bytes;
     }
 
-    bdrv_dirty_iter_free(iter);
     if (qiov) {
         qemu_iovec_destroy(&target_qiov);
     }
-- 
2.11.1
