Received: from eggs.gnu.org ([2001:4830:134:3::10]:56026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9d5-0007mo-48
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9d3-0004lB-TP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:38 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:51 -0500
Message-Id: <20170703221456.30817-11-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/15] block: Switch
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
type (no semantic change), and rename it to match the corresponding
public function rename.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to earlier changes
---
 block/io.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index 2d324af..888f7a1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1676,17 +1676,17 @@ int bdrv_flush_all(void)
 }


-typedef struct BdrvCoGetBlockStatusData {
+typedef struct BdrvCoBlockStatusData {
     BlockDriverState *bs;
     BlockDriverState *base;
     BlockDriverState **file;
-    int64_t sector_num;
-    int nb_sectors;
-    int *pnum;
+    int64_t offset;
+    int64_t bytes;
+    int64_t *pnum;
     int64_t ret;
     bool allocation;
     bool done;
-} BdrvCoGetBlockStatusData;
+} BdrvCoBlockStatusData;

 int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
                                                      int64_t sector_num,
@@ -1913,14 +1913,16 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
 /* Coroutine wrapper for bdrv_get_block_status_above() */
 static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
 {
-    BdrvCoGetBlockStatusData *data = opaque;
+    BdrvCoBlockStatusData *data = opaque;
+    int n;

     data->ret = bdrv_co_get_block_status_above(data->bs, data->base,
                                                data->allocation,
-                                               data->sector_num,
-                                               data->nb_sectors,
-                                               data->pnum,
+                                               data->offset >> BDRV_SECTOR_BITS,
+                                               data->bytes >> BDRV_SECTOR_BITS,
+                                               &n,
                                                data->file);
+    *data->pnum = n * BDRV_SECTOR_SIZE;
     data->done = true;
 }

@@ -1937,13 +1939,14 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
                                               BlockDriverState **file)
 {
     Coroutine *co;
-    BdrvCoGetBlockStatusData data = {
+    int64_t n;
+    BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
         .file = file,
-        .sector_num = sector_num,
-        .nb_sectors = nb_sectors,
-        .pnum = pnum,
+        .offset = sector_num * BDRV_SECTOR_SIZE,
+        .bytes = nb_sectors * BDRV_SECTOR_SIZE,
+        .pnum = &n,
         .allocation = allocation,
         .done = false,
     };
@@ -1957,6 +1960,8 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
+    assert(data.ret < 0 || QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE));
+    *pnum = n >> BDRV_SECTOR_BITS;
     return data.ret;
 }

-- 
2.9.4
