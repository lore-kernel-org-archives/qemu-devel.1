Received: from eggs.gnu.org ([2001:4830:134:3::10]:34121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQJ-0000be-3F
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQI-00071m-4t
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:26 +0800
Message-Id: <20170524025235.32190-8-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/16] backup: Do initial aio context move
 of target via BB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The old aio context check is hacky because when it was added we didn't
have the permission system to enforce a general rule. It only checks if
the target BDS has a BB, which is in fact insufficient because there may
be other BBs in the graph that cannot handle the aio context change.

Do this through blk_set_aio_context interface, in backup_job_create()
which is a central place for both drive-backup and blockdev-backup, to
take care of the compatibility check.

Also the bdrv_set_aio_context in do_drive_backup could have been
conditional, to save a recursion when possible.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/backup.c |  9 +++++++++
 blockdev.c     | 14 --------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 546c5c5..9136f91 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -564,6 +564,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     BlockDriverInfo bdi;
     BackupBlockJob *job = NULL;
     int ret;
+    AioContext *aio_context, *target_context;
 
     assert(bs);
     assert(target);
@@ -644,6 +645,14 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
+    aio_context = bdrv_get_aio_context(bs);
+    target_context = bdrv_get_aio_context(target);
+    if (target_context != aio_context) {
+        aio_context_acquire(target_context);
+        blk_set_aio_context(job->target, aio_context);
+        aio_context_release(target_context);
+    }
+
     job->on_source_error = on_source_error;
     job->on_target_error = on_target_error;
     job->sync_mode = sync_mode;
diff --git a/blockdev.c b/blockdev.c
index c63f4e8..e8f72a1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3240,8 +3240,6 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         goto out;
     }
 
-    bdrv_set_aio_context(target_bs, aio_context);
-
     if (set_backing_hd) {
         bdrv_set_backing_hd(target_bs, source, &local_err);
         if (local_err) {
@@ -3326,18 +3324,6 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
     if (!target_bs) {
         goto out;
     }
-
-    if (bdrv_get_aio_context(target_bs) != aio_context) {
-        if (!bdrv_has_blk(target_bs)) {
-            /* The target BDS is not attached, we can safely move it to another
-             * AioContext. */
-            bdrv_set_aio_context(target_bs, aio_context);
-        } else {
-            error_setg(errp, "Target is attached to a different thread from "
-                             "source.");
-            goto out;
-        }
-    }
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
-- 
2.9.4
