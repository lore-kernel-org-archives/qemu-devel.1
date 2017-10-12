Received: from eggs.gnu.org ([2001:4830:134:3::10]:45520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2ioV-0008GA-7Y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2ioU-0003vI-D9
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:06:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 12 Oct 2017 13:59:15 -0500
Message-Id: <20171012185916.22776-20-eblake@redhat.com>
In-Reply-To: <20171012185916.22776-1-eblake@redhat.com>
References: <20171012185916.22776-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 19/20] vvfat: Switch to
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vvfat driver accordingly.  Note that we
can rely on the block driver having already clamped limits to our
block size, and simplify accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: rebase to interface tweak
v3: no change
v2: rebase to earlier changes, simplify
---
 block/vvfat.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index a0f2335894..9142117fc6 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3082,15 +3082,13 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     return ret;
 }

-static int64_t coroutine_fn vvfat_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *n, BlockDriverState **file)
+static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
+                                              bool want_zero, int64_t offset,
+                                              int64_t bytes, int64_t *n,
+                                              int64_t *map,
+                                              BlockDriverState **file)
 {
-    *n = bs->total_sectors - sector_num;
-    if (*n > nb_sectors) {
-        *n = nb_sectors;
-    } else if (*n < 0) {
-        return 0;
-    }
+    *n = bytes;
     return BDRV_BLOCK_DATA;
 }

@@ -3251,7 +3249,7 @@ static BlockDriver bdrv_vvfat = {

     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
-    .bdrv_co_get_block_status = vvfat_co_get_block_status,
+    .bdrv_co_block_status   = vvfat_co_block_status,
 };

 static void bdrv_vvfat_init(void)
-- 
2.13.6
