Received: from eggs.gnu.org ([2001:4830:134:3::10]:34839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPc-0000JA-AV
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPb-0006Xz-6u
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:16 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  9 Mar 2017 12:38:59 +0100
Message-Id: <1489059542-14232-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
References: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] commit: Implement
 bdrv_commit_top.bdrv_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

In some cases, bdrv_co_get_block_status() is called recursively for the
whole backing chain. The automatically inserted bdrv_commit_top filter
driver must not stop the recursion, so implement a callback that simply
forwards the request to bs->backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 9c41988..932d1e6 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -232,6 +232,17 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
 
+static int64_t coroutine_fn bdrv_commit_top_get_block_status(
+    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
+    BlockDriverState **file)
+{
+    *pnum = nb_sectors;
+    *file = bs->backing->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+
+
 static void bdrv_commit_top_close(BlockDriverState *bs)
 {
 }
@@ -248,10 +259,11 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 /* Dummy node that provides consistent read to its users without requiring it
  * from its backing file and that allows writes on the backing file chain. */
 static BlockDriver bdrv_commit_top = {
-    .format_name        = "commit_top",
-    .bdrv_co_preadv     = bdrv_commit_top_preadv,
-    .bdrv_close         = bdrv_commit_top_close,
-    .bdrv_child_perm    = bdrv_commit_top_child_perm,
+    .format_name                = "commit_top",
+    .bdrv_co_preadv             = bdrv_commit_top_preadv,
+    .bdrv_co_get_block_status   = bdrv_commit_top_get_block_status,
+    .bdrv_close                 = bdrv_commit_top_close,
+    .bdrv_child_perm            = bdrv_commit_top_child_perm,
 };
 
 void commit_start(const char *job_id, BlockDriverState *bs,
-- 
1.8.3.1
