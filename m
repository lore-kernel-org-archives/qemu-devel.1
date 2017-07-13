Received: from eggs.gnu.org ([2001:4830:134:3::10]:53987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLL-0004yv-1B
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLJ-0005tv-8K
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:47:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:46:58 -0500
Message-Id: <20170713154711.32374-11-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/23] block: Switch
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
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v3: rebase to allocation/mapping sense change, simple enough to keep R-b
v2: new patch
---
 block/io.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/block/io.c b/block/io.c
index 68d383d..b639e10 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1938,19 +1938,18 @@ static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
 static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
                                               BlockDriverState *base,
                                               bool mapping,
-                                              int64_t sector_num,
-                                              int nb_sectors, int *pnum,
+                                              int64_t offset,
+                                              int64_t bytes, int64_t *pnum,
                                               BlockDriverState **file)
 {
     Coroutine *co;
-    int64_t n;
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
         .file = file,
-        .offset = sector_num * BDRV_SECTOR_SIZE,
-        .bytes = nb_sectors * BDRV_SECTOR_SIZE,
-        .pnum = &n,
+        .offset = offset,
+        .bytes = bytes,
+        .pnum = pnum,
         .mapping = mapping,
         .done = false,
     };
@@ -1964,8 +1963,6 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
-    assert(data.ret < 0 || QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE));
-    *pnum = n >> BDRV_SECTOR_BITS;
     return data.ret;
 }

@@ -1975,8 +1972,19 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                     int nb_sectors, int *pnum,
                                     BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, sector_num,
-                                          nb_sectors, pnum, file);
+    int64_t ret;
+    int64_t n;
+
+    ret = bdrv_common_block_status_above(bs, base, true,
+                                         sector_num * BDRV_SECTOR_SIZE,
+                                         nb_sectors * BDRV_SECTOR_SIZE,
+                                         &n, file);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE));
+    *pnum = n >> BDRV_SECTOR_BITS;
+    return ret;
 }

 int64_t bdrv_block_status(BlockDriverState *bs,
@@ -2001,20 +2009,13 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
     int64_t ret;
-    int psectors;
+    int64_t dummy;

-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) && bytes < INT_MAX);
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false,
-                                         offset >> BDRV_SECTOR_BITS,
-                                         bytes >> BDRV_SECTOR_BITS, &psectors,
-                                         NULL);
+    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+                                         bytes, pnum ? pnum : &dummy, NULL);
     if (ret < 0) {
         return ret;
     }
-    if (pnum) {
-        *pnum = psectors * BDRV_SECTOR_SIZE;
-    }
     return !!(ret & BDRV_BLOCK_ALLOCATED);
 }

-- 
2.9.4
