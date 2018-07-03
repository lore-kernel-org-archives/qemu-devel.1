Received: from eggs.gnu.org ([2001:4830:134:3::10]:52899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faIvp-000387-BD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faIvl-0004lS-GM
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:53:13 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  3 Jul 2018 13:53:05 +0300
Message-Id: <20180703105305.45398-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180703105305.45398-1-vsementsov@virtuozzo.com>
References: <20180703105305.45398-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] qapi: add transaction support for
 x-block-dirty-bitmap-merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/transaction.json |  2 ++
 blockdev.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index d7e4274550..f9da6ad47f 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -48,6 +48,7 @@
 # - @block-dirty-bitmap-clear: since 2.5
 # - @x-block-dirty-bitmap-enable: since 3.0
 # - @x-block-dirty-bitmap-disable: since 3.0
+# - @x-block-dirty-bitmap-merge: since 3.0
 # - @blockdev-backup: since 2.3
 # - @blockdev-snapshot: since 2.5
 # - @blockdev-snapshot-internal-sync: since 1.7
@@ -63,6 +64,7 @@
        'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
        'x-block-dirty-bitmap-enable': 'BlockDirtyBitmap',
        'x-block-dirty-bitmap-disable': 'BlockDirtyBitmap',
+       'x-block-dirty-bitmap-merge': 'BlockDirtyBitmapMerge',
        'blockdev-backup': 'BlockdevBackup',
        'blockdev-snapshot': 'BlockdevSnapshot',
        'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
diff --git a/blockdev.c b/blockdev.c
index 63c4d33124..d0f2d1a4e9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1946,6 +1946,13 @@ typedef struct BlockDirtyBitmapState {
     bool was_enabled;
 } BlockDirtyBitmapState;
 
+typedef struct BlockDirtyBitmapMergeState {
+    BlkActionState common;
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *dst;
+    BdrvDirtyBitmap *src;
+} BlockDirtyBitmapMergeState;
+
 static void block_dirty_bitmap_add_prepare(BlkActionState *common,
                                            Error **errp)
 {
@@ -2112,6 +2119,45 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
     }
 }
 
+static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
+                                             Error **errp)
+{
+    BlockDirtyBitmapMerge *action;
+    BlockDirtyBitmapMergeState *state = DO_UPCAST(BlockDirtyBitmapMergeState,
+                                                  common, common);
+
+    if (action_check_completion_mode(common, errp) < 0) {
+        return;
+    }
+
+    action = common->action->u.x_block_dirty_bitmap_merge.data;
+    state->dst = block_dirty_bitmap_lookup(action->node,
+                                           action->dst_name,
+                                           &state->bs,
+                                           errp);
+    if (!state->dst) {
+        return;
+    }
+
+    state->src = bdrv_find_dirty_bitmap(state->bs, action->src_name);
+    if (!state->src) {
+        return;
+    }
+
+    if (!bdrv_can_merge_dirty_bitmap(state->dst, state->src, errp)) {
+        return;
+    }
+}
+
+static void block_dirty_bitmap_merge_commit(BlkActionState *common)
+{
+    BlockDirtyBitmapMergeState *state = DO_UPCAST(BlockDirtyBitmapMergeState,
+                                                  common, common);
+
+    /* success is guaranteed by bdrv_can_merge_dirty_bitmap() */
+    bdrv_merge_dirty_bitmap(state->dst, state->src, &error_abort);
+}
+
 static void abort_prepare(BlkActionState *common, Error **errp)
 {
     error_setg(errp, "Transaction aborted using Abort action");
@@ -2182,7 +2228,12 @@ static const BlkActionOps actions[] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
         .prepare = block_dirty_bitmap_disable_prepare,
         .abort = block_dirty_bitmap_disable_abort,
-     }
+    },
+    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_MERGE] = {
+        .instance_size = sizeof(BlockDirtyBitmapMergeState),
+        .prepare = block_dirty_bitmap_merge_prepare,
+        .commit = block_dirty_bitmap_merge_commit,
+    }
 };
 
 /**
-- 
2.11.1
