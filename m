Received: from eggs.gnu.org ([2001:4830:134:3::10]:58341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UTY-0002kp-6C
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UTX-0007WQ-BT
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:48:00 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 11 Oct 2017 22:47:06 -0500
Message-Id: <20171012034720.11947-11-eblake@redhat.com>
In-Reply-To: <20171012034720.11947-1-eblake@redhat.com>
References: <20171012034720.11947-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 10/24] block: Switch
 bdrv_common_block_status_above() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: rebase to split return interface change [Kevin], R-b dropped
v4-v5: no change
v3: rebase to allocation/mapping sense change, simple enough to keep R-b
v2: new patch
---
 block/io.c | 61 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/block/io.c b/block/io.c
index da600a8dc3..e8fda1a4b8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2032,24 +2032,22 @@ static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
  *
  * See bdrv_co_get_block_status_above() for details.
  */
-static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
-                                              BlockDriverState *base,
-                                              bool want_zero,
-                                              int64_t sector_num,
-                                              int nb_sectors, int *pnum,
-                                              BlockDriverState **file)
+static int bdrv_common_block_status_above(BlockDriverState *bs,
+                                          BlockDriverState *base,
+                                          bool want_zero, int64_t offset,
+                                          int64_t bytes, int64_t *pnum,
+                                          int64_t *map,
+                                          BlockDriverState **file)
 {
     Coroutine *co;
-    int64_t n;
-    int64_t map;
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
         .want_zero = want_zero,
-        .offset = sector_num * BDRV_SECTOR_SIZE,
-        .bytes = nb_sectors * BDRV_SECTOR_SIZE,
-        .pnum = &n,
-        .map = &map,
+        .offset = offset,
+        .bytes = bytes,
+        .pnum = pnum,
+        .map = map,
         .file = file,
         .done = false,
     };
@@ -2063,13 +2061,7 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
-    if (data.ret < 0) {
-        *pnum = 0;
-        return data.ret;
-    }
-    assert(QEMU_IS_ALIGNED(n | map, BDRV_SECTOR_SIZE));
-    *pnum = n >> BDRV_SECTOR_BITS;
-    return data.ret | map;
+    return data.ret;
 }

 int64_t bdrv_get_block_status_above(BlockDriverState *bs,
@@ -2078,8 +2070,21 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                     int nb_sectors, int *pnum,
                                     BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, sector_num,
-                                          nb_sectors, pnum, file);
+    int64_t ret;
+    int64_t n;
+    int64_t map;
+
+    ret = bdrv_common_block_status_above(bs, base, true,
+                                         sector_num * BDRV_SECTOR_SIZE,
+                                         nb_sectors * BDRV_SECTOR_SIZE,
+                                         &n, &map, file);
+    if (ret < 0) {
+        *pnum = 0;
+        return ret;
+    }
+    assert(QEMU_IS_ALIGNED(n | map, BDRV_SECTOR_SIZE));
+    *pnum = n >> BDRV_SECTOR_BITS;
+    return ret | map;
 }

 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
@@ -2116,21 +2121,15 @@ int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
-    int64_t ret;
-    int psectors;
+    int ret;
+    int64_t dummy;

-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) && bytes < INT_MAX);
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false,
-                                         offset >> BDRV_SECTOR_BITS,
-                                         bytes >> BDRV_SECTOR_BITS, &psectors,
+    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+                                         bytes, pnum ? pnum : &dummy, NULL,
                                          NULL);
     if (ret < 0) {
         return ret;
     }
-    if (pnum) {
-        *pnum = psectors * BDRV_SECTOR_SIZE;
-    }
     return !!(ret & BDRV_BLOCK_ALLOCATED);
 }

-- 
2.13.6
