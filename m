Received: from eggs.gnu.org ([2001:4830:134:3::10]:35330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNn-0005sP-57
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNm-00030D-El
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:55:08 +0100
Message-Id: <1489416908-3771-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] commit: Implement .bdrv_refresh_filename
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

We want query-block to return the right filename, even if a commit job
put a bdrv_commit_top on top of the actual image format driver. Let
bdrv_commit_top.bdrv_refresh_filename get the filename from its backing
file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/commit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 932d1e6..2832482 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
@@ -242,6 +243,12 @@ static int64_t coroutine_fn bdrv_commit_top_get_block_status(
            (sector_num << BDRV_SECTOR_BITS);
 }
 
+static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
+{
+    bdrv_refresh_filename(bs->backing->bs);
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+            bs->backing->bs->filename);
+}
 
 static void bdrv_commit_top_close(BlockDriverState *bs)
 {
@@ -262,6 +269,7 @@ static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
     .bdrv_co_get_block_status   = bdrv_commit_top_get_block_status,
+    .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
 };
-- 
1.8.3.1
