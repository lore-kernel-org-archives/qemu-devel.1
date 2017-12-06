Received: from eggs.gnu.org ([2001:4830:134:3::10]:52242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMayL-0007VA-8w
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMayF-0003kN-9x
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:46:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  6 Dec 2017 14:45:45 +0000
Message-Id: <20171206144550.22295-5-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-1-stefanha@redhat.com>
References: <20171206144550.22295-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/9] block: don't keep AioContext acquired
 after blockdev_backup_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5a56a1abf2..d7ad76416e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1936,7 +1936,6 @@ typedef struct BlockdevBackupState {
     BlkActionState common;
     BlockDriverState *bs;
     BlockJob *job;
-    AioContext *aio_context;
 } BlockdevBackupState;
 
 static BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
@@ -1947,6 +1946,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
     BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
     BlockdevBackup *backup;
     BlockDriverState *bs, *target;
+    AioContext *aio_context;
     Error *local_err = NULL;
 
     assert(common->action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP);
@@ -1962,29 +1962,39 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
         return;
     }
 
-    /* AioContext is released in .clean() */
-    state->aio_context = bdrv_get_aio_context(bs);
-    if (state->aio_context != bdrv_get_aio_context(target)) {
-        state->aio_context = NULL;
+    aio_context = bdrv_get_aio_context(bs);
+    if (aio_context != bdrv_get_aio_context(target)) {
         error_setg(errp, "Backup between two IO threads is not implemented");
         return;
     }
-    aio_context_acquire(state->aio_context);
+    aio_context_acquire(aio_context);
     state->bs = bs;
+
+    /* Paired with .clean() */
     bdrv_drained_begin(state->bs);
 
     state->job = do_blockdev_backup(backup, common->block_job_txn, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return;
+        goto out;
     }
+
+out:
+    aio_context_release(aio_context);
 }
 
 static void blockdev_backup_commit(BlkActionState *common)
 {
     BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    AioContext *aio_context;
+
+    aio_context = bdrv_get_aio_context(state->bs);
+    aio_context_acquire(aio_context);
+
     assert(state->job);
     block_job_start(state->job);
+
+    aio_context_release(aio_context);
 }
 
 static void blockdev_backup_abort(BlkActionState *common)
@@ -1992,18 +2002,32 @@ static void blockdev_backup_abort(BlkActionState *common)
     BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
 
     if (state->job) {
+        AioContext *aio_context;
+
+        aio_context = bdrv_get_aio_context(state->bs);
+        aio_context_acquire(aio_context);
+
         block_job_cancel_sync(state->job);
+
+        aio_context_release(aio_context);
     }
 }
 
 static void blockdev_backup_clean(BlkActionState *common)
 {
     BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    AioContext *aio_context;
 
-    if (state->aio_context) {
-        bdrv_drained_end(state->bs);
-        aio_context_release(state->aio_context);
+    if (!state->bs) {
+        return;
     }
+
+    aio_context = bdrv_get_aio_context(state->bs);
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_end(state->bs);
+
+    aio_context_release(aio_context);
 }
 
 typedef struct BlockDirtyBitmapState {
-- 
2.14.3
