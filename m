Received: from eggs.gnu.org ([2001:4830:134:3::10]:52273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJg-0004Ml-Hy
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJe-0004JM-Ns
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 18 Jan 2018 20:49:05 +0300
Message-Id: <1516297747-107232-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 7/9] qcow2: move is_zero() up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

To be used in the following commit without a forward declaration.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4348b2c..2ed21ff 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1858,6 +1858,23 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
+static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
+{
+    int64_t nr;
+    int res;
+
+    /* Clamp to image length, before checking status of underlying sectors */
+    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
+        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - offset;
+    }
+
+    if (!bytes) {
+        return true;
+    }
+    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -2975,24 +2992,6 @@ finish:
     return ret;
 }
 
-
-static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
-{
-    int64_t nr;
-    int res;
-
-    /* Clamp to image length, before checking status of underlying sectors */
-    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
-        bytes = bs->total_sectors * BDRV_SECTOR_SIZE - offset;
-    }
-
-    if (!bytes) {
-        return true;
-    }
-    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
-}
-
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-- 
2.7.4
