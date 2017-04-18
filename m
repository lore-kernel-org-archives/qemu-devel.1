Received: from eggs.gnu.org ([2001:4830:134:3::10]:33982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I28-0005BV-Sw
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I27-0003gE-Qz
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:20 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:33 -0500
Message-Id: <20170418013356.3578-9-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 08/31] block: Switch BdrvCoGetBlockStatusData
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
type (no semantic change), and rename it to match the corresponding
public function rename.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index e804bdd..f7ece8d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1680,16 +1680,16 @@ int bdrv_flush_all(void)
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
     bool done;
-} BdrvCoGetBlockStatusData;
+} BdrvCoBlockStatusData;

 /*
  * Returns the allocation status of the specified sectors.
@@ -1850,13 +1850,15 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
 /* Coroutine wrapper for bdrv_get_block_status_above() */
 static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
 {
-    BdrvCoGetBlockStatusData *data = opaque;
+    BdrvCoBlockStatusData *data = opaque;
+    int n;

     data->ret = bdrv_co_get_block_status_above(data->bs, data->base,
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

@@ -1872,13 +1874,14 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
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
         .done = false,
     };

@@ -1891,6 +1894,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
+    *pnum = n >> BDRV_SECTOR_BITS;
     return data.ret;
 }

-- 
2.9.3
