Received: from eggs.gnu.org ([2001:4830:134:3::10]:47600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawZ-00037u-NU
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawV-0000ET-Ql
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:31 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:41 -0600
Message-Id: <20180105225753.30509-9-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 08/20] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the null driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v6-v7: no change
v5: minor fix to type of 'ret'
v4: rebase to interface tweak
v3: no change
v2: rebase to mapping parameter
---
 block/null.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/null.c b/block/null.c
index 0cdabaa440..2c16935f3c 100644
--- a/block/null.c
+++ b/block/null.c
@@ -222,22 +222,23 @@ static int null_reopen_prepare(BDRVReopenState *reopen_state,
     return 0;
 }

-static int64_t coroutine_fn null_co_get_block_status(BlockDriverState *bs,
-                                                     int64_t sector_num,
-                                                     int nb_sectors, int *pnum,
-                                                     BlockDriverState **file)
+static int coroutine_fn null_co_block_status(BlockDriverState *bs,
+                                             bool want_zero, int64_t offset,
+                                             int64_t bytes, int64_t *pnum,
+                                             int64_t *map,
+                                             BlockDriverState **file)
 {
     BDRVNullState *s = bs->opaque;
-    off_t start = sector_num * BDRV_SECTOR_SIZE;
+    int ret = BDRV_BLOCK_OFFSET_VALID;

-    *pnum = nb_sectors;
+    *pnum = bytes;
+    *map = offset;
     *file = bs;

     if (s->read_zeroes) {
-        return BDRV_BLOCK_OFFSET_VALID | start | BDRV_BLOCK_ZERO;
-    } else {
-        return BDRV_BLOCK_OFFSET_VALID | start;
+        ret |= BDRV_BLOCK_ZERO;
     }
+    return ret;
 }

 static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
@@ -269,7 +270,7 @@ static BlockDriver bdrv_null_co = {
     .bdrv_co_flush_to_disk  = null_co_flush,
     .bdrv_reopen_prepare    = null_reopen_prepare,

-    .bdrv_co_get_block_status   = null_co_get_block_status,
+    .bdrv_co_block_status   = null_co_block_status,

     .bdrv_refresh_filename  = null_refresh_filename,
 };
@@ -289,7 +290,7 @@ static BlockDriver bdrv_null_aio = {
     .bdrv_aio_flush         = null_aio_flush,
     .bdrv_reopen_prepare    = null_reopen_prepare,

-    .bdrv_co_get_block_status   = null_co_get_block_status,
+    .bdrv_co_block_status   = null_co_block_status,

     .bdrv_refresh_filename  = null_refresh_filename,
 };
-- 
2.14.3
