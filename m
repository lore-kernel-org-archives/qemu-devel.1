Received: from eggs.gnu.org ([2001:4830:134:3::10]:33472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0pog-0004m2-JZ
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0poZ-0001Vh-W8
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:15:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Sep 2018 18:15:15 +0300
Message-Id: <20180914151515.21242-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180914151515.21242-1-vsementsov@virtuozzo.com>
References: <20180914151515.21242-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 5/5] qapi: add transaction support for
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

New action is like clean action: do the whole thing in .prepare and
undo in .abort. This behavior for bitmap-changing actions is needed
because backup job actions use bitmap in .prepare.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qapi/transaction.json |  2 ++
 blockdev.c            | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index d7e4274550..5875cdb16c 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -48,6 +48,7 @@
 # - @block-dirty-bitmap-clear: since 2.5
 # - @x-block-dirty-bitmap-enable: since 3.0
 # - @x-block-dirty-bitmap-disable: since 3.0
+# - @x-block-dirty-bitmap-merge: since 3.1
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
index 5348e8ba9b..2917bf6e09 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2112,6 +2112,35 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
     }
 }
 
+static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
+                                             Error **errp)
+{
+    BlockDirtyBitmapMerge *action;
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+    BdrvDirtyBitmap *merge_source;
+
+    if (action_check_completion_mode(common, errp) < 0) {
+        return;
+    }
+
+    action = common->action->u.x_block_dirty_bitmap_merge.data;
+    state->bitmap = block_dirty_bitmap_lookup(action->node,
+                                              action->dst_name,
+                                              &state->bs,
+                                              errp);
+    if (!state->bitmap) {
+        return;
+    }
+
+    merge_source = bdrv_find_dirty_bitmap(state->bs, action->src_name);
+    if (!merge_source) {
+        return;
+    }
+
+    bdrv_merge_dirty_bitmap(state->bitmap, merge_source, &state->backup, errp);
+}
+
 static void abort_prepare(BlkActionState *common, Error **errp)
 {
     error_setg(errp, "Transaction aborted using Abort action");
@@ -2182,7 +2211,13 @@ static const BlkActionOps actions[] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
         .prepare = block_dirty_bitmap_disable_prepare,
         .abort = block_dirty_bitmap_disable_abort,
-     }
+    },
+    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_MERGE] = {
+        .instance_size = sizeof(BlockDirtyBitmapState),
+        .prepare = block_dirty_bitmap_merge_prepare,
+        .commit = block_dirty_bitmap_free_backup,
+        .abort = block_dirty_bitmap_restore,
+    }
 };
 
 /**
-- 
2.18.0
