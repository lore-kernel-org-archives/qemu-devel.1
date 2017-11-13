Received: from eggs.gnu.org ([2001:4830:134:3::10]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU6-0007Zz-Oe
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU2-00039f-TL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:18 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:1060 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eEHU2-00037r-Gc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Nov 2017 19:20:52 +0300
Message-Id: <20171113162053.58795-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171113162053.58795-1-vsementsov@virtuozzo.com>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/4] qmp: transaction support for
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/transaction.json |  4 +++
 blockdev.c            | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index bd312792da..b643d848f8 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -46,6 +46,8 @@
 # - @abort: since 1.6
 # - @block-dirty-bitmap-add: since 2.5
 # - @block-dirty-bitmap-clear: since 2.5
+# - @block-dirty-bitmap-enable: since 2.12
+# - @block-dirty-bitmap-disable: since 2.12
 # - @blockdev-backup: since 2.3
 # - @blockdev-snapshot: since 2.5
 # - @blockdev-snapshot-internal-sync: since 1.7
@@ -59,6 +61,8 @@
        'abort': 'Abort',
        'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
        'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
+       'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
+       'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
        'blockdev-backup': 'BlockdevBackup',
        'blockdev-snapshot': 'BlockdevSnapshot',
        'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
diff --git a/blockdev.c b/blockdev.c
index fe1eb751f0..f6595ddcd3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1962,6 +1962,7 @@ typedef struct BlockDirtyBitmapState {
     AioContext *aio_context;
     HBitmap *backup;
     bool prepared;
+    bool was_enabled;
 } BlockDirtyBitmapState;
 
 static void block_dirty_bitmap_add_prepare(BlkActionState *common,
@@ -2069,6 +2070,74 @@ static void block_dirty_bitmap_clear_clean(BlkActionState *common)
     }
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
+    action = common->action->u.block_dirty_bitmap_enable.data;
+    state->bitmap = block_dirty_bitmap_lookup(action->node,
+                                              action->name,
+                                              &state->bs,
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
+    action = common->action->u.block_dirty_bitmap_disable.data;
+    state->bitmap = block_dirty_bitmap_lookup(action->node,
+                                              action->name,
+                                              &state->bs,
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
@@ -2130,6 +2199,16 @@ static const BlkActionOps actions[] = {
         .commit = block_dirty_bitmap_clear_commit,
         .abort = block_dirty_bitmap_clear_abort,
         .clean = block_dirty_bitmap_clear_clean,
+    },
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE] = {
+        .instance_size = sizeof(BlockDirtyBitmapState),
+        .prepare = block_dirty_bitmap_enable_prepare,
+        .abort = block_dirty_bitmap_enable_abort,
+    },
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE] = {
+        .instance_size = sizeof(BlockDirtyBitmapState),
+        .prepare = block_dirty_bitmap_disable_prepare,
+        .abort = block_dirty_bitmap_disable_abort,
     }
 };
 
-- 
2.11.1
