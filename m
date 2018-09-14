Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0rJW-0006LB-8d
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0rJS-0002Og-75
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:51:26 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Sep 2018 19:51:16 +0300
Message-Id: <20180914165116.23182-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] nbd/server: fix bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

bitmap_to_extents function is broken: it switches dirty variable after
every iteration, however it can process only part of dirty (or zero)
area during one iteration in case when this area is too large for one
extent.

Fortunately, the bug don't produce wrong extents: it just inserts
zero-length extents between sequential extents representing large dirty
(or zero) area. However, zero-length extents are abandoned by NBD
protocol. So, careful client should consider such replay as server
fault and not-careful will likely ignore zero-length extents.

Fix this by more careful handling of dirty variable.

Bug was introduced in 3d068aff16
 "nbd/server: implement dirty bitmap export", with the whole function.
and presents in v3.0.0 release.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index ea5fe0eb33..12f721482d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1951,6 +1951,8 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
 
     assert(begin < overall_end && nb_extents);
     while (begin < overall_end && i < nb_extents) {
+        bool next_dirty = !dirty;
+
         if (dirty) {
             end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
         } else {
@@ -1962,6 +1964,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
             end = MIN(bdrv_dirty_bitmap_size(bitmap),
                       begin + UINT32_MAX + 1 -
                       bdrv_dirty_bitmap_granularity(bitmap));
+            next_dirty = dirty;
         }
         if (dont_fragment && end > overall_end) {
             end = overall_end;
@@ -1971,7 +1974,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
         extents[i].flags = cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
         i++;
         begin = end;
-        dirty = !dirty;
+        dirty = next_dirty;
     }
 
     bdrv_dirty_iter_free(it);
-- 
2.18.0
