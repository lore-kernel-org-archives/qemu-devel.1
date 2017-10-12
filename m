Received: from eggs.gnu.org ([2001:4830:134:3::10]:58311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UTX-0002jf-5C
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UTU-0007U1-Ko
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:47:59 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 11 Oct 2017 22:47:05 -0500
Message-Id: <20171012034720.11947-10-eblake@redhat.com>
In-Reply-To: <20171012034720.11947-1-eblake@redhat.com>
References: <20171012034720.11947-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 09/24] block: Switch
 BdrvCoGetBlockStatusData to byte-based
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
type (no semantic change), and rename it to match the corresponding
public function rename.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: fix -O2 compilation [Jeff], rebase to split return interface
change [Kevin], drop R-b
v4-v5: no change
v3: rebase to context conflicts, simple enough to keep R-b
v2: rebase to earlier changes
---
 block/io.c | 56 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5805929ef0..da600a8dc3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1745,17 +1745,18 @@ int bdrv_flush_all(void)
 }


-typedef struct BdrvCoGetBlockStatusData {
+typedef struct BdrvCoBlockStatusData {
     BlockDriverState *bs;
     BlockDriverState *base;
     bool want_zero;
-    int64_t sector_num;
-    int nb_sectors;
-    int *pnum;
+    int64_t offset;
+    int64_t bytes;
+    int64_t *pnum;
+    int64_t *map;
     BlockDriverState **file;
-    int64_t ret;
+    int ret;
     bool done;
-} BdrvCoGetBlockStatusData;
+} BdrvCoBlockStatusData;

 int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
                                                         int64_t sector_num,
@@ -2005,14 +2006,24 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
 /* Coroutine wrapper for bdrv_get_block_status_above() */
 static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
 {
-    BdrvCoGetBlockStatusData *data = opaque;
+    BdrvCoBlockStatusData *data = opaque;
+    int n = 0;
+    int64_t ret;

-    data->ret = bdrv_co_get_block_status_above(data->bs, data->base,
-                                               data->want_zero,
-                                               data->sector_num,
-                                               data->nb_sectors,
-                                               data->pnum,
-                                               data->file);
+    ret = bdrv_co_get_block_status_above(data->bs, data->base,
+                                         data->want_zero,
+                                         data->offset >> BDRV_SECTOR_BITS,
+                                         data->bytes >> BDRV_SECTOR_BITS,
+                                         &n,
+                                         data->file);
+    if (ret < 0) {
+        assert(INT_MIN <= ret);
+        data->ret = ret;
+    } else {
+        *data->pnum = n * BDRV_SECTOR_SIZE;
+        *data->map = ret & BDRV_BLOCK_OFFSET_MASK;
+        data->ret = ret & ~BDRV_BLOCK_OFFSET_MASK;
+    }
     data->done = true;
 }

@@ -2029,13 +2040,16 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
                                               BlockDriverState **file)
 {
     Coroutine *co;
-    BdrvCoGetBlockStatusData data = {
+    int64_t n;
+    int64_t map;
+    BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
         .want_zero = want_zero,
-        .sector_num = sector_num,
-        .nb_sectors = nb_sectors,
-        .pnum = pnum,
+        .offset = sector_num * BDRV_SECTOR_SIZE,
+        .bytes = nb_sectors * BDRV_SECTOR_SIZE,
+        .pnum = &n,
+        .map = &map,
         .file = file,
         .done = false,
     };
@@ -2049,7 +2063,13 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
-    return data.ret;
+    if (data.ret < 0) {
+        *pnum = 0;
+        return data.ret;
+    }
+    assert(QEMU_IS_ALIGNED(n | map, BDRV_SECTOR_SIZE));
+    *pnum = n >> BDRV_SECTOR_BITS;
+    return data.ret | map;
 }

 int64_t bdrv_get_block_status_above(BlockDriverState *bs,
-- 
2.13.6
