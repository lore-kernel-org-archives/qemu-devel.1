Received: from eggs.gnu.org ([2001:4830:134:3::10]:39555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSq-0004uF-JH
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSo-0005Uf-35
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:40 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:22:01 +0300
Message-Id: <1501518125-29851-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 09/13] qcow2: move is_zero_sectors() up
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
 block/qcow2.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0f4de40..5c7c2b5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1943,6 +1943,25 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
+static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
+                            uint32_t count)
+{
+    int nr;
+    BlockDriverState *file;
+    int64_t res;
+
+    if (start + count > bs->total_sectors) {
+        count = bs->total_sectors - start;
+    }
+
+    if (!count) {
+        return true;
+    }
+    res = bdrv_get_block_status_above(bs, NULL, start, count,
+                                      &nr, &file);
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
+}
+
 /*
  * If the specified area is beyond EOF, allocates it + prealloc_size
  * bytes ahead.
@@ -3086,26 +3105,6 @@ finish:
     return ret;
 }
 
-
-static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
-                            uint32_t count)
-{
-    int nr;
-    BlockDriverState *file;
-    int64_t res;
-
-    if (start + count > bs->total_sectors) {
-        count = bs->total_sectors - start;
-    }
-
-    if (!count) {
-        return true;
-    }
-    res = bdrv_get_block_status_above(bs, NULL, start, count,
-                                      &nr, &file);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
-}
-
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-- 
2.7.4
