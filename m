Received: from eggs.gnu.org ([2001:4830:134:3::10]:45791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWv-0006hr-1S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWu-00078c-2L
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwWt-00078E-QB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:17 +0000
Message-Id: <20171218143530.12082-11-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 10/23] block: don't keep AioContext acquired
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171206144550.22295-5-stefanha@redhat.com
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
