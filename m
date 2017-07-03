Received: from eggs.gnu.org ([2001:4830:134:3::10]:56045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9d6-0007nM-4N
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9d5-0004mD-5a
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:52 -0500
Message-Id: <20170703221456.30817-12-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/15] block: Switch
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: new patch
---
 block/io.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/block/io.c b/block/io.c
index 888f7a1..697db75 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1934,19 +1934,18 @@ static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
 static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
                                               BlockDriverState *base,
                                               bool allocation,
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
         .allocation = allocation,
         .done = false,
     };
@@ -1960,8 +1959,6 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
-    assert(data.ret < 0 || QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE));
-    *pnum = n >> BDRV_SECTOR_BITS;
     return data.ret;
 }

@@ -1971,8 +1968,19 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                     int nb_sectors, int *pnum,
                                     BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, false, sector_num,
-                                          nb_sectors, pnum, file);
+    int64_t ret;
+    int64_t n;
+
+    ret = bdrv_common_block_status_above(bs, base, false,
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
@@ -1997,21 +2005,13 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
     int64_t ret;
-    int psectors;
+    int64_t dummy;

-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) &&
-           bytes < INT_MAX * BDRV_SECTOR_SIZE);
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), true,
-                                         offset >> BDRV_SECTOR_BITS,
-                                         bytes >> BDRV_SECTOR_BITS, &psectors,
-                                         NULL);
+    ret = bdrv_common_block_status_above(bs, backing_bs(bs), true, offset,
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
