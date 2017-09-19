Received: from eggs.gnu.org ([2001:4830:134:3::10]:42332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOzZ-0005Ka-3W
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOzT-0004fk-NW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Sep 2017 15:18:53 -0500
Message-Id: <20170919201910.25656-4-eblake@redhat.com>
In-Reply-To: <20170919201910.25656-1-eblake@redhat.com>
References: <20170919201910.25656-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 03/20] qcow2: Ensure bitmap serialization is
 aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

When subdividing a bitmap serialization, the code in hbitmap.c
enforces that start/count parameters are aligned (except that
count can end early at end-of-bitmap).  We exposed this required
alignment through bdrv_dirty_bitmap_serialization_align(), but
forgot to actually check that we comply with it.

Fortunately, qcow2 is never dividing bitmap serialization smaller
than one cluster (which is a minimum of 512 bytes); so we are
always compliant with the serialization alignment (which insists
that we partition at least 64 bits per chunk) because we are doing
at least 4k bits per chunk.

Still, it's safer to add an assertion (for the unlikely case that
we'd ever support a cluster smaller than 512 bytes, or if the
hbitmap implementation changes what it considers to be aligned),
rather than leaving bdrv_dirty_bitmap_serialization_align()
without a caller.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v5: no change
v4: new patch
---
 block/qcow2-bitmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index e8d3bdbd6e..b3ee4c794a 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -274,10 +274,13 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
 static uint64_t sectors_covered_by_bitmap_cluster(const BDRVQcow2State *s,
                                                   const BdrvDirtyBitmap *bitmap)
 {
-    uint32_t sector_granularity =
+    uint64_t sector_granularity =
             bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+    uint64_t sbc = sector_granularity * (s->cluster_size << 3);

-    return (uint64_t)sector_granularity * (s->cluster_size << 3);
+    assert(QEMU_IS_ALIGNED(sbc,
+                           bdrv_dirty_bitmap_serialization_align(bitmap)));
+    return sbc;
 }

 /* load_bitmap_data
-- 
2.13.5
