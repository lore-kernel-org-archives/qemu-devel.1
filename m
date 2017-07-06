Received: from eggs.gnu.org ([2001:4830:134:3::10]:33334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9o1-0005AP-Ig
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nz-0006E6-N7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:39:05 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:28 +0200
Message-Id: <20170706163828.24082-12-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] block/snapshot: do not take AioContext
 lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Snapshots are only created/destroyed/loaded under the BQL, while no
other I/O is happening.  Snapshot information could be accessed while
other I/O is happening, but also under the BQL so they cannot be
modified concurrently.  The AioContext lock is overkill.  If needed,
in the future the BQL could be split to a separate lock covering all
snapshot operations, and the create/destroy/goto callbacks changed
to run in a coroutine (so the driver can do mutual exclusion as usual).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/snapshot.c          | 28 +---------------------------
 blockdev.c                | 43 ++++++++++++-------------------------------
 hmp.c                     |  7 -------
 include/block/block_int.h |  5 +++++
 include/block/snapshot.h  |  4 +---
 migration/savevm.c        | 22 ----------------------
 monitor.c                 | 10 ++--------
 7 files changed, 21 insertions(+), 98 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index a46564e7b7..08c59d6166 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -384,9 +384,7 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
 }
 
 
-/* Group operations. All block drivers are involved.
- * These functions will properly handle dataplane (take aio_context_acquire
- * when appropriate for appropriate block drivers) */
+/* Group operations. All block drivers are involved.  */
 
 bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
 {
@@ -395,13 +393,9 @@ bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
-
-        aio_context_acquire(ctx);
         if (bdrv_is_inserted(bs) && !bdrv_is_read_only(bs)) {
             ok = bdrv_can_snapshot(bs);
         }
-        aio_context_release(ctx);
         if (!ok) {
             goto fail;
         }
@@ -421,14 +415,10 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
     QEMUSnapshotInfo sn1, *snapshot = &sn1;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
-
-        aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs) &&
                 bdrv_snapshot_find(bs, snapshot, name) >= 0) {
             ret = bdrv_snapshot_delete_by_id_or_name(bs, name, err);
         }
-        aio_context_release(ctx);
         if (ret < 0) {
             goto fail;
         }
@@ -447,13 +437,9 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
-
-        aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs)) {
             err = bdrv_snapshot_goto(bs, name);
         }
-        aio_context_release(ctx);
         if (err < 0) {
             goto fail;
         }
@@ -472,13 +458,9 @@ int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
-
-        aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs)) {
             err = bdrv_snapshot_find(bs, &sn, name);
         }
-        aio_context_release(ctx);
         if (err < 0) {
             goto fail;
         }
@@ -499,9 +481,6 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
-
-        aio_context_acquire(ctx);
         if (bs == vm_state_bs) {
             sn->vm_state_size = vm_state_size;
             err = bdrv_snapshot_create(bs, sn);
@@ -509,7 +488,6 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
             sn->vm_state_size = 0;
             err = bdrv_snapshot_create(bs, sn);
         }
-        aio_context_release(ctx);
         if (err < 0) {
             goto fail;
         }
@@ -526,13 +504,9 @@ BlockDriverState *bdrv_all_find_vmstate_bs(void)
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
         bool found;
 
-        aio_context_acquire(ctx);
         found = bdrv_can_snapshot(bs);
-        aio_context_release(ctx);
-
         if (found) {
             break;
         }
diff --git a/blockdev.c b/blockdev.c
index 88ab606949..56ef9c41a3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1280,7 +1280,6 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
                                                          Error **errp)
 {
     BlockDriverState *bs;
-    AioContext *aio_context;
     QEMUSnapshotInfo sn;
     Error *local_err = NULL;
     SnapshotInfo *info = NULL;
@@ -1290,8 +1289,6 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     if (!bs) {
         return NULL;
     }
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
 
     if (!has_id) {
         id = NULL;
@@ -1303,34 +1300,32 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
 
     if (!id && !name) {
         error_setg(errp, "Name or id must be provided");
-        goto out_aio_context;
+        return NULL;
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_INTERNAL_SNAPSHOT_DELETE, errp)) {
-        goto out_aio_context;
+        return NULL;
     }
 
     ret = bdrv_snapshot_find_by_id_and_name(bs, id, name, &sn, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out_aio_context;
+        return NULL;
     }
     if (!ret) {
         error_setg(errp,
                    "Snapshot with id '%s' and name '%s' does not exist on "
                    "device '%s'",
                    STR_OR_NULL(id), STR_OR_NULL(name), device);
-        goto out_aio_context;
+        return NULL;
     }
 
     bdrv_snapshot_delete(bs, id, name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out_aio_context;
+        return NULL;
     }
 
-    aio_context_release(aio_context);
-
     info = g_new0(SnapshotInfo, 1);
     info->id = g_strdup(sn.id_str);
     info->name = g_strdup(sn.name);
@@ -1341,10 +1336,6 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     info->vm_clock_sec = sn.vm_clock_nsec / 1000000000;
 
     return info;
-
-out_aio_context:
-    aio_context_release(aio_context);
-    return NULL;
 }
 
 /**
@@ -1446,7 +1437,6 @@ struct BlkActionState {
 typedef struct InternalSnapshotState {
     BlkActionState common;
     BlockDriverState *bs;
-    AioContext *aio_context;
     QEMUSnapshotInfo sn;
     bool created;
 } InternalSnapshotState;
@@ -1498,10 +1488,6 @@ static void internal_snapshot_prepare(BlkActionState *common,
         return;
     }
 
-    /* AioContext is released in .clean() */
-    state->aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(state->aio_context);
-
     state->bs = bs;
     bdrv_drained_begin(bs);
 
@@ -1585,11 +1571,8 @@ static void internal_snapshot_clean(BlkActionState *common)
     InternalSnapshotState *state = DO_UPCAST(InternalSnapshotState,
                                              common, common);
 
-    if (state->aio_context) {
-        if (state->bs) {
-            bdrv_drained_end(state->bs);
-        }
-        aio_context_release(state->aio_context);
+    if (state->bs) {
+        bdrv_drained_end(state->bs);
     }
 }
 
@@ -1598,7 +1581,6 @@ typedef struct ExternalSnapshotState {
     BlkActionState common;
     BlockDriverState *old_bs;
     BlockDriverState *new_bs;
-    AioContext *aio_context;
     bool overlay_appended;
 } ExternalSnapshotState;
 
@@ -1654,9 +1636,7 @@ static void external_snapshot_prepare(BlkActionState *common,
         return;
     }
 
-    /* Acquire AioContext now so any threads operating on old_bs stop */
-    state->aio_context = bdrv_get_aio_context(state->old_bs);
-    aio_context_acquire(state->aio_context);
+    /* Make any threads operating on old_bs stop */
     bdrv_drained_begin(state->old_bs);
 
     if (!bdrv_is_inserted(state->old_bs)) {
@@ -1756,7 +1736,7 @@ static void external_snapshot_prepare(BlkActionState *common,
         return;
     }
 
-    bdrv_set_aio_context(state->new_bs, state->aio_context);
+    bdrv_set_aio_context(state->new_bs, bdrv_get_aio_context(state->old_bs));
 
     /* This removes our old bs and adds the new bs. This is an operation that
      * can fail, so we need to do it in .prepare; undoing it for abort is
@@ -1775,6 +1755,8 @@ static void external_snapshot_commit(BlkActionState *common)
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
 
+    bdrv_set_aio_context(state->new_bs, bdrv_get_aio_context(state->old_bs));
+
     /* We don't need (or want) to use the transactional
      * bdrv_reopen_multiple() across all the entries at once, because we
      * don't want to abort all of them if one of them fails the reopen */
@@ -1803,9 +1785,8 @@ static void external_snapshot_clean(BlkActionState *common)
 {
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
-    if (state->aio_context) {
+    if (state->old_bs) {
         bdrv_drained_end(state->old_bs);
-        aio_context_release(state->aio_context);
         bdrv_unref(state->new_bs);
     }
 }
diff --git a/hmp.c b/hmp.c
index 8c72c58b20..3c63ea7a72 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1321,7 +1321,6 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     int nb_sns, i;
     int total;
     int *global_snapshots;
-    AioContext *aio_context;
 
     typedef struct SnapshotEntry {
         QEMUSnapshotInfo sn;
@@ -1345,11 +1344,8 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No available block device supports snapshots\n");
         return;
     }
-    aio_context = bdrv_get_aio_context(bs);
 
-    aio_context_acquire(aio_context);
     nb_sns = bdrv_snapshot_list(bs, &sn_tab);
-    aio_context_release(aio_context);
 
     if (nb_sns < 0) {
         monitor_printf(mon, "bdrv_snapshot_list: error %d\n", nb_sns);
@@ -1360,9 +1356,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
         int bs1_nb_sns = 0;
         ImageEntry *ie;
         SnapshotEntry *se;
-        AioContext *ctx = bdrv_get_aio_context(bs1);
 
-        aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs1)) {
             sn = NULL;
             bs1_nb_sns = bdrv_snapshot_list(bs1, &sn);
@@ -1380,7 +1374,6 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
             }
             g_free(sn);
         }
-        aio_context_release(ctx);
     }
 
     if (no_snapshot) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 43c9f4fcae..38d1067fa8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -217,6 +217,11 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
 
+    /*
+     * Snapshots are only created/destroyed/loaded under the BQL, while no
+     * other I/O is happening.  snapshots/nb_snapshots is read while other
+     * I/O is happening, but also under the BQL.
+     */
     int (*bdrv_snapshot_create)(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info);
     int (*bdrv_snapshot_goto)(BlockDriverState *bs,
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index e5c0553115..735d0f694c 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -76,9 +76,7 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
                                          Error **errp);
 
 
-/* Group operations. All block drivers are involved.
- * These functions will properly handle dataplane (take aio_context_acquire
- * when appropriate for appropriate block drivers */
+/* Group operations. All block drivers are involved.  */
 
 bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs);
 int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bsd_bs,
diff --git a/migration/savevm.c b/migration/savevm.c
index c7a49c93c5..1b168c3ba8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2073,7 +2073,6 @@ int save_snapshot(const char *name, Error **errp)
     uint64_t vm_state_size;
     qemu_timeval tv;
     struct tm tm;
-    AioContext *aio_context;
 
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp, "Device '%s' is writable but does not support "
@@ -2096,7 +2095,6 @@ int save_snapshot(const char *name, Error **errp)
         error_setg(errp, "No block device can accept snapshots");
         return ret;
     }
-    aio_context = bdrv_get_aio_context(bs);
 
     saved_vm_running = runstate_is_running();
 
@@ -2109,8 +2107,6 @@ int save_snapshot(const char *name, Error **errp)
 
     bdrv_drain_all_begin();
 
-    aio_context_acquire(aio_context);
-
     memset(sn, 0, sizeof(*sn));
 
     /* fill auxiliary fields */
@@ -2146,14 +2142,6 @@ int save_snapshot(const char *name, Error **errp)
         goto the_end;
     }
 
-    /* The bdrv_all_create_snapshot() call that follows acquires the AioContext
-     * for itself.  BDRV_POLL_WHILE() does not support nested locking because
-     * it only releases the lock once.  Therefore synchronous I/O will deadlock
-     * unless we release the AioContext before bdrv_all_create_snapshot().
-     */
-    aio_context_release(aio_context);
-    aio_context = NULL;
-
     ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
     if (ret < 0) {
         error_setg(errp, "Error while creating snapshot on '%s'",
@@ -2164,10 +2152,6 @@ int save_snapshot(const char *name, Error **errp)
     ret = 0;
 
  the_end:
-    if (aio_context) {
-        aio_context_release(aio_context);
-    }
-
     bdrv_drain_all_end();
 
     if (saved_vm_running) {
@@ -2241,7 +2225,6 @@ int load_snapshot(const char *name, Error **errp)
     QEMUSnapshotInfo sn;
     QEMUFile *f;
     int ret;
-    AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (!bdrv_all_can_snapshot(&bs)) {
@@ -2263,12 +2246,9 @@ int load_snapshot(const char *name, Error **errp)
         error_setg(errp, "No block device supports snapshots");
         return -ENOTSUP;
     }
-    aio_context = bdrv_get_aio_context(bs_vm_state);
 
     /* Don't even try to load empty VM states */
-    aio_context_acquire(aio_context);
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
-    aio_context_release(aio_context);
     if (ret < 0) {
         return ret;
     } else if (sn.vm_state_size == 0) {
@@ -2298,10 +2278,8 @@ int load_snapshot(const char *name, Error **errp)
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     mis->from_src_file = f;
 
-    aio_context_acquire(aio_context);
     ret = qemu_loadvm_state(f);
     migration_incoming_state_destroy();
-    aio_context_release(aio_context);
 
     bdrv_drain_all_end();
 
diff --git a/monitor.c b/monitor.c
index 3c369f4dd5..48687aa94d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3639,15 +3639,9 @@ static void vm_completion(ReadLineState *rs, const char *str)
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         SnapshotInfoList *snapshots, *snapshot;
-        AioContext *ctx = bdrv_get_aio_context(bs);
-        bool ok = false;
 
-        aio_context_acquire(ctx);
-        if (bdrv_can_snapshot(bs)) {
-            ok = bdrv_query_snapshot_info_list(bs, &snapshots, NULL) == 0;
-        }
-        aio_context_release(ctx);
-        if (!ok) {
+        if (!bdrv_can_snapshot(bs) ||
+            bdrv_query_snapshot_info_list(bs, &snapshots, NULL) != 0) {
             continue;
         }
 
-- 
2.13.0
