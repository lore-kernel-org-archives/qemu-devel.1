Received: from eggs.gnu.org ([2001:4830:134:3::10]:59073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3f-0000qi-B3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3e-0002Mi-7z
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:31 +0200
Message-Id: <20171026131741.5059-26-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/35] qcow2: Reduce is_zero() rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Now that bdrv_is_allocated accepts non-aligned inputs, we can
remove the TODO added in earlier refactoring.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 29d0a50955..fbf9464d3a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2976,22 +2976,16 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     int64_t nr;
     int res;
-    int64_t start;
-
-    /* TODO: Widening to sector boundaries should only be needed as
-     * long as we can't query finer granularity. */
-    start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
-    bytes = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start;
 
     /* Clamp to image length, before checking status of underlying sectors */
-    if (start + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
-        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - start;
+    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
+        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - offset;
     }
 
     if (!bytes) {
         return true;
     }
-    res = bdrv_block_status_above(bs, NULL, start, bytes, &nr, NULL, NULL);
+    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }
 
-- 
2.13.6
