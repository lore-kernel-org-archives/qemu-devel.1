Received: from eggs.gnu.org ([2001:4830:134:3::10]:56717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaO-0001uY-Ja
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaM-0003Xk-Q6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fSSaM-0003XA-K3
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Jun 2018 15:34:32 -0400
Message-Id: <20180611193434.19004-6-jsnow@redhat.com>
In-Reply-To: <20180611193434.19004-1-jsnow@redhat.com>
References: <20180611193434.19004-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] qmp: transaction support for
 x-block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180606182449.1607-4-jsnow@redhat.com
[Added x- prefix. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c            | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 qapi/transaction.json |  4 +++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 4a353c934a..2ac15601d9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2052,6 +2052,7 @@ typedef struct BlockDirtyBitmapState {
     BlockDriverState *bs;
     HBitmap *backup;
     bool prepared;
+    bool was_enabled;
 } BlockDirtyBitmapState;
 
 static void block_dirty_bitmap_add_prepare(BlkActionState *common,
@@ -2151,6 +2152,74 @@ static void block_dirty_bitmap_clear_commit(BlkActionState *common)
     hbitmap_free(state->backup);
 }
 
+static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
+                                              Error **errp)
+{
+    BlockDirtyBitmap *action;
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    if (action_check_completion_mode(common, errp) < 0) {
+        return;
+    }
+
+    action = common->action->u.x_block_dirty_bitmap_enable.data;
+    state->bitmap = block_dirty_bitmap_lookup(action->node,
+                                              action->name,
+                                              NULL,
+                                              errp);
+    if (!state->bitmap) {
+        return;
+    }
+
+    state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
+    bdrv_enable_dirty_bitmap(state->bitmap);
+}
+
+static void block_dirty_bitmap_enable_abort(BlkActionState *common)
+{
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    if (!state->was_enabled) {
+        bdrv_disable_dirty_bitmap(state->bitmap);
+    }
+}
+
+static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
+                                               Error **errp)
+{
+    BlockDirtyBitmap *action;
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    if (action_check_completion_mode(common, errp) < 0) {
+        return;
+    }
+
+    action = common->action->u.x_block_dirty_bitmap_disable.data;
+    state->bitmap = block_dirty_bitmap_lookup(action->node,
+                                              action->name,
+                                              NULL,
+                                              errp);
+    if (!state->bitmap) {
+        return;
+    }
+
+    state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
+    bdrv_disable_dirty_bitmap(state->bitmap);
+}
+
+static void block_dirty_bitmap_disable_abort(BlkActionState *common)
+{
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    if (state->was_enabled) {
+        bdrv_enable_dirty_bitmap(state->bitmap);
+    }
+}
+
 static void abort_prepare(BlkActionState *common, Error **errp)
 {
     error_setg(errp, "Transaction aborted using Abort action");
@@ -2211,7 +2280,17 @@ static const BlkActionOps actions[] = {
         .prepare = block_dirty_bitmap_clear_prepare,
         .commit = block_dirty_bitmap_clear_commit,
         .abort = block_dirty_bitmap_clear_abort,
-    }
+    },
+    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_ENABLE] = {
+        .instance_size = sizeof(BlockDirtyBitmapState),
+        .prepare = block_dirty_bitmap_enable_prepare,
+        .abort = block_dirty_bitmap_enable_abort,
+    },
+    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_DISABLE] = {
+        .instance_size = sizeof(BlockDirtyBitmapState),
+        .prepare = block_dirty_bitmap_disable_prepare,
+        .abort = block_dirty_bitmap_disable_abort,
+     }
 };
 
 /**
diff --git a/qapi/transaction.json b/qapi/transaction.json
index bd312792da..d7e4274550 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -46,6 +46,8 @@
 # - @abort: since 1.6
 # - @block-dirty-bitmap-add: since 2.5
 # - @block-dirty-bitmap-clear: since 2.5
+# - @x-block-dirty-bitmap-enable: since 3.0
+# - @x-block-dirty-bitmap-disable: since 3.0
 # - @blockdev-backup: since 2.3
 # - @blockdev-snapshot: since 2.5
 # - @blockdev-snapshot-internal-sync: since 1.7
@@ -59,6 +61,8 @@
        'abort': 'Abort',
        'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
        'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
+       'x-block-dirty-bitmap-enable': 'BlockDirtyBitmap',
+       'x-block-dirty-bitmap-disable': 'BlockDirtyBitmap',
        'blockdev-backup': 'BlockdevBackup',
        'blockdev-snapshot': 'BlockdevSnapshot',
        'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
-- 
2.14.3
