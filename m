Received: from eggs.gnu.org ([2001:4830:134:3::10]:38421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbT-0006zP-K2
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbO-0003QO-Qq
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:51 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 25 Aug 2017 16:23:26 +0300
Message-Id: <20170825132332.6734-2-el13635@mail.ntua.gr>
In-Reply-To: <20170825132332.6734-1-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 1/7] block: skip implicit nodes in snapshots,
 blockjobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Implicit filter nodes added at the top of nodes can interfere with block
jobs. This is not a problem when they are added by other jobs since
adding another job will issue a QERR_DEVICE_IN_USE, but it can happen in
the next commit which introduces an implicitly created throttle filter
node below BlockBackend, which we want to be skipped during automatic
operations on the graph since the user does not necessarily know about
their existence.

All implicit filters will have either bs->file or bs->backing set. This
is a needed assumption so we can know which direction we will skip down
the graph.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 include/block/block_int.h | 17 +++++++++++++++++
 block.c                   | 10 ++++++++++
 block/qapi.c              | 14 +++++---------
 blockdev.c                | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7571c0aaaf..9e0f70e055 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -699,6 +699,21 @@ static inline BlockDriverState *backing_bs(BlockDriverState *bs)
     return bs->backing ? bs->backing->bs : NULL;
 }
 
+static inline BlockDriverState *file_bs(BlockDriverState *bs)
+{
+    return bs->file ? bs->file->bs : NULL;
+}
+
+/* This is a convenience function to get either bs->file->bs or
+ * bs->backing->bs * */
+static inline BlockDriverState *child_bs(BlockDriverState *bs)
+{
+    BlockDriverState *backing = backing_bs(bs);
+    BlockDriverState *file = file_bs(bs);
+    assert(!(file && backing));
+    return backing ?: file;
+}
+
 
 /* Essential block drivers which must always be statically linked into qemu, and
  * which therefore can be accessed without using bdrv_find_format() */
@@ -980,4 +995,6 @@ void bdrv_dec_in_flight(BlockDriverState *bs);
 
 void blockdev_close_all_bdrv_states(void);
 
+BlockDriverState *bdrv_get_first_explicit(BlockDriverState *bs);
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index 3615a6809e..e35d546c08 100644
--- a/block.c
+++ b/block.c
@@ -4945,3 +4945,13 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
 
     return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
 }
+
+/* Get first explicit node down a bs chain. */
+BlockDriverState *bdrv_get_first_explicit(BlockDriverState *bs)
+{
+    while (bs && bs->drv && bs->implicit) {
+        bs = child_bs(bs);
+        assert(bs);
+    }
+    return bs;
+}
diff --git a/block/qapi.c b/block/qapi.c
index 7fa2437923..847b044d13 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -147,9 +147,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
         /* Skip automatically inserted nodes that the user isn't aware of for
          * query-block (blk != NULL), but not for query-named-block-nodes */
-        while (blk && bs0->drv && bs0->implicit) {
-            bs0 = backing_bs(bs0);
-            assert(bs0);
+        if (blk) {
+            bs0 = bdrv_get_first_explicit(bs0);
         }
     }
 
@@ -336,9 +335,7 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
     char *qdev;
 
     /* Skip automatically inserted nodes that the user isn't aware of */
-    while (bs && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
-    }
+    bs = bdrv_get_first_explicit(bs);
 
     info->device = g_strdup(blk_name(blk));
     info->type = g_strdup("unknown");
@@ -465,9 +462,8 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
     /* Skip automatically inserted nodes that the user isn't aware of in
      * a BlockBackend-level command. Stay at the exact node for a node-level
      * command. */
-    while (blk_level && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
-        assert(bs);
+    if (blk_level) {
+        bs = bdrv_get_first_explicit(bs);
     }
 
     if (bdrv_get_node_name(bs)[0]) {
diff --git a/blockdev.c b/blockdev.c
index 23475abb72..fc7b65c3f0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1300,6 +1300,10 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     if (!bs) {
         return NULL;
     }
+
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -1508,6 +1512,9 @@ static void internal_snapshot_prepare(BlkActionState *common,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     /* AioContext is released in .clean() */
     state->aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(state->aio_context);
@@ -1664,6 +1671,9 @@ static void external_snapshot_prepare(BlkActionState *common,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    state->old_bs = bdrv_get_first_explicit(state->old_bs);
+
     /* Acquire AioContext now so any threads operating on old_bs stop */
     state->aio_context = bdrv_get_aio_context(state->old_bs);
     aio_context_acquire(state->aio_context);
@@ -1844,6 +1854,9 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     /* AioContext is released in .clean() */
     state->aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(state->aio_context);
@@ -1908,6 +1921,9 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     target = bdrv_lookup_bs(backup->target, backup->target, errp);
     if (!target) {
         return;
@@ -2988,6 +3004,9 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3095,6 +3114,9 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3209,6 +3231,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         return NULL;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3484,6 +3509,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3638,6 +3666,9 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     target_bs = bdrv_lookup_bs(target, target, errp);
     if (!target_bs) {
         return;
@@ -3786,6 +3817,9 @@ void qmp_change_backing_file(const char *device,
         return;
     }
 
+    /* Skip implicit filter nodes */
+    bs = bdrv_get_first_explicit(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
-- 
2.11.0
