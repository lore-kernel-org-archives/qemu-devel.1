Received: from eggs.gnu.org ([2001:4830:134:3::10]:47824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQ7A-0006T6-Of
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQ79-0000Da-3Y
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  6 Jul 2018 14:36:29 +0300
Message-Id: <20180706113630.25222-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180706113630.25222-1-vsementsov@virtuozzo.com>
References: <20180706113630.25222-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/4] blockdev: rename
 block-dirty-bitmap-clear transaction handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Rename block-dirty-bitmap-clear transaction handlers to reuse them for
x-block-dirty-bitmap-merge transaction in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 9cb29ca63e..5348e8ba9b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2026,7 +2026,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
 }
 
-static void block_dirty_bitmap_clear_abort(BlkActionState *common)
+static void block_dirty_bitmap_restore(BlkActionState *common)
 {
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
@@ -2036,7 +2036,7 @@ static void block_dirty_bitmap_clear_abort(BlkActionState *common)
     }
 }
 
-static void block_dirty_bitmap_clear_commit(BlkActionState *common)
+static void block_dirty_bitmap_free_backup(BlkActionState *common)
 {
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
@@ -2170,8 +2170,8 @@ static const BlkActionOps actions[] = {
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
2.11.1
