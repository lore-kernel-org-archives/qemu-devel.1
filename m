Received: from eggs.gnu.org ([209.51.188.92]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaC-0002iz-BS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZa3-0004Vf-Oy
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa2-0004Ri-Ba
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:19 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:01:03 -0500
Message-Id: <20190116010106.27626-6-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] block/mirror: fix and improve
 do_sync_target_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

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
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index f0b211a9c8..24ede6fdaa 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1185,25 +1185,23 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
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
+        dirty_bytes = MIN(offset + bytes - dirty_offset, INT_MAX);
+        valid_area = bdrv_dirty_bitmap_next_dirty_area(job->dirty_bitmap,
+                                                       &dirty_offset,
+                                                       &dirty_bytes);
         if (!valid_area) {
             bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
             break;
@@ -1259,9 +1257,10 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
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
2.17.2
