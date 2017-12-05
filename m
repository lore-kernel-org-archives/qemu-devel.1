Received: from eggs.gnu.org ([2001:4830:134:3::10]:54574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMAfu-0002EE-Kq
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMAfp-0002QX-OQ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:42:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Dec 2017 10:41:35 +0000
Message-Id: <20171205104141.28882-4-stefanha@redhat.com>
In-Reply-To: <20171205104141.28882-1-stefanha@redhat.com>
References: <20171205104141.28882-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] block: don't keep AioContext acquired
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
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
