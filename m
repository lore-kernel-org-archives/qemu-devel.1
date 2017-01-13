Received: from eggs.gnu.org ([2001:4830:134:3::10]:51274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8q8-00027s-Pk
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8q7-0001qs-Nc
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:48 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jan 2017 21:52:29 +0100
Message-Id: <20170113205237.30386-2-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 1/9] block: Always set *file in
 get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

*file should always be set (to NULL, if nothing else) instead of leaving
it dangling sometimes. This should also be documented so callers can
rely on this behavior.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4f005623f7..ff693d7f73 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1709,7 +1709,8 @@ typedef struct BdrvCoGetBlockStatusData {
  * beyond the end of the disk image it will be clamped.
  *
  * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is set, 'file'
- * points to the BDS which the sector range is allocated in.
+ * points to the BDS which the sector range is allocated in. If the block driver
+ * does not set 'file', it will be set to NULL.
  */
 static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
                                                      int64_t sector_num,
@@ -1720,6 +1721,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     int64_t n;
     int64_t ret, ret2;
 
+    *file = NULL;
+
     total_sectors = bdrv_nb_sectors(bs);
     if (total_sectors < 0) {
         return total_sectors;
@@ -1744,7 +1747,6 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         return ret;
     }
 
-    *file = NULL;
     bdrv_inc_in_flight(bs);
     ret = bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors, pnum,
                                             file);
-- 
2.11.0
