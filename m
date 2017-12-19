Received: from eggs.gnu.org ([2001:4830:134:3::10]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZX-0004cp-07
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZV-0006s6-D4
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJZV-0006qg-2S
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:29 +0000
Message-Id: <20171219151144.11120-9-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/23] block: don't keep AioContext acquired
 after external_snapshot_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

It is not necessary to hold AioContext across transactions anymore since
bdrv_drained_begin/end() is used to keep the nodes quiesced.  In fact,
using the AioContext lock for this purpose was always buggy.

This patch reduces the scope of AioContext locked regions.  This is not
just a cleanup but also fixes hangs that occur in BDRV_POLL_WHILE()
because it is unware of recursive locking and does not release the
AioContext the necessary number of times to allow progress to be made.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171206144550.22295-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c | 71 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3c8d994ced..3b598f8f0e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1606,7 +1606,6 @@ typedef struct ExternalSnapshotState {
     BlkActionState common;
     BlockDriverState *old_bs;
     BlockDriverState *new_bs;
-    AioContext *aio_context;
     bool overlay_appended;
 } ExternalSnapshotState;
 
@@ -1626,6 +1625,7 @@ static void external_snapshot_prepare(BlkActionState *common,
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
     TransactionAction *action = common->action;
+    AioContext *aio_context;
 
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
      * purpose but a different set of parameters */
@@ -1662,31 +1662,32 @@ static void external_snapshot_prepare(BlkActionState *common,
         return;
     }
 
-    /* Acquire AioContext now so any threads operating on old_bs stop */
-    state->aio_context = bdrv_get_aio_context(state->old_bs);
-    aio_context_acquire(state->aio_context);
+    aio_context = bdrv_get_aio_context(state->old_bs);
+    aio_context_acquire(aio_context);
+
+    /* Paired with .clean() */
     bdrv_drained_begin(state->old_bs);
 
     if (!bdrv_is_inserted(state->old_bs)) {
         error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
-        return;
+        goto out;
     }
 
     if (bdrv_op_is_blocked(state->old_bs,
                            BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT, errp)) {
-        return;
+        goto out;
     }
 
     if (!bdrv_is_read_only(state->old_bs)) {
         if (bdrv_flush(state->old_bs)) {
             error_setg(errp, QERR_IO_ERROR);
-            return;
+            goto out;
         }
     }
 
     if (!bdrv_is_first_non_filter(state->old_bs)) {
         error_setg(errp, QERR_FEATURE_DISABLED, "snapshot");
-        return;
+        goto out;
     }
 
     if (action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC) {
@@ -1698,13 +1699,13 @@ static void external_snapshot_prepare(BlkActionState *common,
 
         if (node_name && !snapshot_node_name) {
             error_setg(errp, "New snapshot node name missing");
-            return;
+            goto out;
         }
 
         if (snapshot_node_name &&
             bdrv_lookup_bs(snapshot_node_name, snapshot_node_name, NULL)) {
             error_setg(errp, "New snapshot node name already in use");
-            return;
+            goto out;
         }
 
         flags = state->old_bs->open_flags;
@@ -1717,7 +1718,7 @@ static void external_snapshot_prepare(BlkActionState *common,
             int64_t size = bdrv_getlength(state->old_bs);
             if (size < 0) {
                 error_setg_errno(errp, -size, "bdrv_getlength failed");
-                return;
+                goto out;
             }
             bdrv_img_create(new_image_file, format,
                             state->old_bs->filename,
@@ -1725,7 +1726,7 @@ static void external_snapshot_prepare(BlkActionState *common,
                             NULL, size, flags, false, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
-                return;
+                goto out;
             }
         }
 
@@ -1740,30 +1741,30 @@ static void external_snapshot_prepare(BlkActionState *common,
                               errp);
     /* We will manually add the backing_hd field to the bs later */
     if (!state->new_bs) {
-        return;
+        goto out;
     }
 
     if (bdrv_has_blk(state->new_bs)) {
         error_setg(errp, "The snapshot is already in use");
-        return;
+        goto out;
     }
 
     if (bdrv_op_is_blocked(state->new_bs, BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT,
                            errp)) {
-        return;
+        goto out;
     }
 
     if (state->new_bs->backing != NULL) {
         error_setg(errp, "The snapshot already has a backing image");
-        return;
+        goto out;
     }
 
     if (!state->new_bs->drv->supports_backing) {
         error_setg(errp, "The snapshot does not support backing images");
-        return;
+        goto out;
     }
 
-    bdrv_set_aio_context(state->new_bs, state->aio_context);
+    bdrv_set_aio_context(state->new_bs, aio_context);
 
     /* This removes our old bs and adds the new bs. This is an operation that
      * can fail, so we need to do it in .prepare; undoing it for abort is
@@ -1772,15 +1773,22 @@ static void external_snapshot_prepare(BlkActionState *common,
     bdrv_append(state->new_bs, state->old_bs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return;
+        goto out;
     }
     state->overlay_appended = true;
+
+out:
+    aio_context_release(aio_context);
 }
 
 static void external_snapshot_commit(BlkActionState *common)
 {
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
+    AioContext *aio_context;
+
+    aio_context = bdrv_get_aio_context(state->old_bs);
+    aio_context_acquire(aio_context);
 
     /* We don't need (or want) to use the transactional
      * bdrv_reopen_multiple() across all the entries at once, because we
@@ -1789,6 +1797,8 @@ static void external_snapshot_commit(BlkActionState *common)
         bdrv_reopen(state->old_bs, state->old_bs->open_flags & ~BDRV_O_RDWR,
                     NULL);
     }
+
+    aio_context_release(aio_context);
 }
 
 static void external_snapshot_abort(BlkActionState *common)
@@ -1797,11 +1807,18 @@ static void external_snapshot_abort(BlkActionState *common)
                              DO_UPCAST(ExternalSnapshotState, common, common);
     if (state->new_bs) {
         if (state->overlay_appended) {
+            AioContext *aio_context;
+
+            aio_context = bdrv_get_aio_context(state->old_bs);
+            aio_context_acquire(aio_context);
+
             bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backind_hd()
                                           close state->old_bs; we need it */
             bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_bs */
+
+            aio_context_release(aio_context);
         }
     }
 }
@@ -1810,11 +1827,19 @@ static void external_snapshot_clean(BlkActionState *common)
 {
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
-    if (state->aio_context) {
-        bdrv_drained_end(state->old_bs);
-        bdrv_unref(state->new_bs);
-        aio_context_release(state->aio_context);
+    AioContext *aio_context;
+
+    if (!state->old_bs) {
+        return;
     }
+
+    aio_context = bdrv_get_aio_context(state->old_bs);
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_end(state->old_bs);
+    bdrv_unref(state->new_bs);
+
+    aio_context_release(aio_context);
 }
 
 typedef struct DriveBackupState {
-- 
2.14.3
