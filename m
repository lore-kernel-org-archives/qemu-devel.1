Received: from eggs.gnu.org ([2001:4830:134:3::10]:52619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elhAh-0008A5-1l
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elhAf-0007fq-1Q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:27:22 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Feb 2018 14:26:42 -0600
Message-Id: <20180213202701.15858-3-eblake@redhat.com>
In-Reply-To: <20180213202701.15858-1-eblake@redhat.com>
References: <20180213202701.15858-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v8 02/21] nvme: Drop pointless
 .bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

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

---
v8: new patch
---
 block/nvme.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 10bffbbf2f4..4e561b08df3 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1068,18 +1068,6 @@ static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
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
@@ -1179,8 +1167,6 @@ static BlockDriver bdrv_nvme = {
     .bdrv_co_flush_to_disk    = nvme_co_flush,
     .bdrv_reopen_prepare      = nvme_reopen_prepare,

-    .bdrv_co_get_block_status = nvme_co_get_block_status,
-
     .bdrv_refresh_filename    = nvme_refresh_filename,
     .bdrv_refresh_limits      = nvme_refresh_limits,

-- 
2.14.3
