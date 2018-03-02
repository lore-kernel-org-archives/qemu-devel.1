Received: from eggs.gnu.org ([2001:4830:134:3::10]:52364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erppy-00010q-JK
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erppw-0002cK-QI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:13 +0100
Message-Id: <20180302185448.6314-3-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/37] nvme: Drop pointless
 .bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Commit bdd6a90 has a bug: drivers should never directly set
BDRV_BLOCK_ALLOCATED, but only io.c should do that (as needed).
Instead, drivers should report BDRV_BLOCK_DATA if it knows that
data comes from this BDS.

But let's look at the bigger picture: semantically, the nvme
driver is similar to the nbd, null, and raw drivers (no backing
file, all data comes from this BDS).  But while two of those
other drivers have to supply the callback (null because it can
special-case BDRV_BLOCK_ZERO, raw because it can special-case
a different offset), in this case the block layer defaults are
good enough without the callback at all (similar to nbd).

So, fix the bug by deletion ;)

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nvme.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 75078022f6..8bca57aae6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1072,18 +1072,6 @@ static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
     return 0;
 }
 
-static int64_t coroutine_fn nvme_co_get_block_status(BlockDriverState *bs,
-                                                     int64_t sector_num,
-                                                     int nb_sectors, int *pnum,
-                                                     BlockDriverState **file)
-{
-    *pnum = nb_sectors;
-    *file = bs;
-
-    return BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
-}
-
 static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
     QINCREF(opts);
@@ -1183,8 +1171,6 @@ static BlockDriver bdrv_nvme = {
     .bdrv_co_flush_to_disk    = nvme_co_flush,
     .bdrv_reopen_prepare      = nvme_reopen_prepare,
 
-    .bdrv_co_get_block_status = nvme_co_get_block_status,
-
     .bdrv_refresh_filename    = nvme_refresh_filename,
     .bdrv_refresh_limits      = nvme_refresh_limits,
 
-- 
2.13.6
