Received: from eggs.gnu.org ([2001:4830:134:3::10]:36819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSa2-0004pQ-OQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSa1-0001YH-Tu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Jul 2017 20:05:40 -0500
Message-Id: <20170713010555.6769-4-eblake@redhat.com>
In-Reply-To: <20170713010555.6769-1-eblake@redhat.com>
References: <20170713010555.6769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/18] qcow2: Ensure bitmap serialization is
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

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

---
v5: no change
v4: new patch
---
 block/qcow2-bitmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3e8735a..5aa0b8d 100644
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
2.9.4
