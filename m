Received: from eggs.gnu.org ([2001:4830:134:3::10]:60610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCE-0008An-8J
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vC9-0006fa-Ez
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:50 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:44:00 +0300
Message-Id: <1509551048-129830-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 07/15] qcow2: move is_zero() up
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
---
 block/qcow2.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 92cb9f9..db759ce 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1881,6 +1881,23 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
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
@@ -2998,24 +3015,6 @@ finish:
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
