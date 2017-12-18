Received: from eggs.gnu.org ([2001:4830:134:3::10]:45773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWt-0006g6-2w
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWs-00077W-6m
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwWr-000771-Tx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:16 +0000
Message-Id: <20171218143530.12082-10-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 09/23] block: don't keep AioContext acquired
 after drive_backup_prepare()
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
Message-id: 20171206144550.22295-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3b598f8f0e..5a56a1abf2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1845,7 +1845,6 @@ static void external_snapshot_clean(BlkActionState *common)
 typedef struct DriveBackupState {
     BlkActionState common;
     BlockDriverState *bs;
-    AioContext *aio_context;
     BlockJob *job;
 } DriveBackupState;
 
@@ -1857,6 +1856,7 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
     BlockDriverState *bs;
     DriveBackup *backup;
+    AioContext *aio_context;
     Error *local_err = NULL;
 
     assert(common->action->type == TRANSACTION_ACTION_KIND_DRIVE_BACKUP);
@@ -1867,24 +1867,36 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
         return;
     }
 
-    /* AioContext is released in .clean() */
-    state->aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(state->aio_context);
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    /* Paired with .clean() */
     bdrv_drained_begin(bs);
+
     state->bs = bs;
 
     state->job = do_drive_backup(backup, common->block_job_txn, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return;
+        goto out;
     }
+
+out:
+    aio_context_release(aio_context);
 }
 
 static void drive_backup_commit(BlkActionState *common)
 {
     DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
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
 
 static void drive_backup_abort(BlkActionState *common)
@@ -1892,18 +1904,32 @@ static void drive_backup_abort(BlkActionState *common)
     DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
 
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
 
 static void drive_backup_clean(BlkActionState *common)
 {
     DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
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
 
 typedef struct BlockdevBackupState {
-- 
2.14.3
