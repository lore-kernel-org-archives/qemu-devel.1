Received: from eggs.gnu.org ([2001:4830:134:3::10]:35316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNl-0005r0-UU
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNl-0002zT-8X
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:55:07 +0100
Message-Id: <1489416908-3771-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] mirror: Implement .bdrv_refresh_filename
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

We want query-block to return the right filename, even if a mirror job
put a bdrv_mirror_top on top of the actual image format driver. Let
bdrv_mirror_top.bdrv_refresh_filename get the filename from its backing
file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/mirror.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index a5d30ee..4f3a5cb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
@@ -1060,6 +1061,13 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->backing->bs, offset, count);
 }
 
+static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
+{
+    bdrv_refresh_filename(bs->backing->bs);
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+            bs->backing->bs->filename);
+}
+
 static void bdrv_mirror_top_close(BlockDriverState *bs)
 {
 }
@@ -1088,6 +1096,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
     .bdrv_co_get_block_status   = bdrv_mirror_top_get_block_status,
+    .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
 };
-- 
1.8.3.1
