Received: from eggs.gnu.org ([2001:4830:134:3::10]:43276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1N-0000VY-6l
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1K-0002WM-9S
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:41 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  1 Aug 2017 17:19:08 +0300
Message-Id: <1501597152-25342-12-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 11/15] qcow2: move is_zero() up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

To be used in the following commit without a forward declaration.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index f522ba9..2ec8b03 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1946,6 +1946,28 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
+static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
+{
+    int64_t nr;
+    int64_t res;
+    int64_t start;
+
+    /* Widen to sector boundaries, then clamp to image length, before
+     * checking status of underlying sectors */
+    start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
+    bytes = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start;
+
+    if (start + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
+        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - start;
+    }
+
+    if (!bytes) {
+        return true;
+    }
+    res = bdrv_block_status_above(bs, NULL, start, bytes, &nr, NULL);
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
+}
+
 /*
  * If the specified area is beyond EOF, allocates it + prealloc_size
  * bytes ahead.
@@ -3088,29 +3110,6 @@ finish:
     return ret;
 }
 
-
-static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
-{
-    int64_t nr;
-    int64_t res;
-    int64_t start;
-
-    /* Widen to sector boundaries, then clamp to image length, before
-     * checking status of underlying sectors */
-    start = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
-    bytes = QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE) - start;
-
-    if (start + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
-        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - start;
-    }
-
-    if (!bytes) {
-        return true;
-    }
-    res = bdrv_block_status_above(bs, NULL, start, bytes, &nr, NULL);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
-}
-
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-- 
2.7.4
