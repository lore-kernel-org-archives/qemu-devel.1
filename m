Received: from eggs.gnu.org ([2001:4830:134:3::10]:45214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF27-000413-RT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF26-0002H3-NE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF26-0002Gj-ET
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:10 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:48 -0400
Message-Id: <20181029212501.5897-7-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 06/19] qapi: add transaction support for
 x-block-dirty-bitmap-merge
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

New action is like clean action: do the whole thing in .prepare and
undo in .abort. This behavior for bitmap-changing actions is needed
because backup job actions use bitmap in .prepare.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c            | 35 +++++++++++++++++++++++++++++++++++
 qapi/transaction.json |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index d7776cbd4c..d685bb7746 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2113,6 +2113,35 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
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
@@ -2184,6 +2213,12 @@ static const BlkActionOps actions[] = {
         .prepare = block_dirty_bitmap_disable_prepare,
         .abort = block_dirty_bitmap_disable_abort,
     },
+    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_MERGE] = {
+        .instance_size = sizeof(BlockDirtyBitmapState),
+        .prepare = block_dirty_bitmap_merge_prepare,
+        .commit = block_dirty_bitmap_free_backup,
+        .abort = block_dirty_bitmap_restore,
+    },
     /* Where are transactions for MIRROR, COMMIT and STREAM?
      * Although these blockjobs use transaction callbacks like the backup job,
      * these jobs do not necessarily adhere to transaction semantics.
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
-- 
2.14.5
