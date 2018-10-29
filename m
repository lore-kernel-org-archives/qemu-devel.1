Received: from eggs.gnu.org ([2001:4830:134:3::10]:45186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF27-00040y-7h
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF26-0002Gn-08
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF25-0002GL-OB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:09 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:47 -0400
Message-Id: <20181029212501.5897-6-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 05/19] blockdev: rename block-dirty-bitmap-clear
 transaction handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rename block-dirty-bitmap-clear transaction handlers to reuse them for
x-block-dirty-bitmap-merge transaction in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index b8a854fba5..d7776cbd4c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2027,7 +2027,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
 }
 
-static void block_dirty_bitmap_clear_abort(BlkActionState *common)
+static void block_dirty_bitmap_restore(BlkActionState *common)
 {
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
@@ -2037,7 +2037,7 @@ static void block_dirty_bitmap_clear_abort(BlkActionState *common)
     }
 }
 
-static void block_dirty_bitmap_clear_commit(BlkActionState *common)
+static void block_dirty_bitmap_free_backup(BlkActionState *common)
 {
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
@@ -2171,8 +2171,8 @@ static const BlkActionOps actions[] = {
     [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_CLEAR] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
         .prepare = block_dirty_bitmap_clear_prepare,
-        .commit = block_dirty_bitmap_clear_commit,
-        .abort = block_dirty_bitmap_clear_abort,
+        .commit = block_dirty_bitmap_free_backup,
+        .abort = block_dirty_bitmap_restore,
     },
     [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_ENABLE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
-- 
2.14.5
