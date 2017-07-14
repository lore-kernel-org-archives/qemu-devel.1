Received: from eggs.gnu.org ([2001:4830:134:3::10]:46587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVO-0003jr-RN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVN-0003on-U6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:34 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:45 -0500
Message-Id: <20170714121457.10322-9-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/20] null: Switch to
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
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the null driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to mapping parameter
---
 block/null.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/null.c b/block/null.c
index 876f909..ef61fc0 100644
--- a/block/null.c
+++ b/block/null.c
@@ -204,22 +204,22 @@ static int null_reopen_prepare(BDRVReopenState *reopen_state,
     return 0;
 }

-static int64_t coroutine_fn null_co_get_block_status(BlockDriverState *bs,
-                                                     int64_t sector_num,
-                                                     int nb_sectors, int *pnum,
-                                                     BlockDriverState **file)
+static int64_t coroutine_fn null_co_block_status(BlockDriverState *bs,
+                                                 bool mapping,
+                                                 int64_t offset,
+                                                 int64_t bytes, int64_t *pnum,
+                                                 BlockDriverState **file)
 {
     BDRVNullState *s = bs->opaque;
-    off_t start = sector_num * BDRV_SECTOR_SIZE;
+    int64_t ret = BDRV_BLOCK_OFFSET_VALID | (offset & BDRV_BLOCK_OFFSET_MASK);

-    *pnum = nb_sectors;
+    *pnum = bytes;
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
@@ -250,7 +250,7 @@ static BlockDriver bdrv_null_co = {
     .bdrv_co_flush_to_disk  = null_co_flush,
     .bdrv_reopen_prepare    = null_reopen_prepare,

-    .bdrv_co_get_block_status   = null_co_get_block_status,
+    .bdrv_co_block_status   = null_co_block_status,

     .bdrv_refresh_filename  = null_refresh_filename,
 };
@@ -269,7 +269,7 @@ static BlockDriver bdrv_null_aio = {
     .bdrv_aio_flush         = null_aio_flush,
     .bdrv_reopen_prepare    = null_reopen_prepare,

-    .bdrv_co_get_block_status   = null_co_get_block_status,
+    .bdrv_co_block_status   = null_co_block_status,

     .bdrv_refresh_filename  = null_refresh_filename,
 };
-- 
2.9.4
