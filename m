Received: from eggs.gnu.org ([2001:4830:134:3::10]:40131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAJF-0002Dr-NS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAJE-0000rQ-NS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:18:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:25 +0800
Message-Id: <20170321031635.22123-7-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 06/16] backup: Do initial aio context move
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The old aio context check is hacky because when it was added we didn't
have the permission system to enforce a general rule. It only checks if
the target BDS has a BB, which is in fact insufficient because there may
be other BBs in the graph that cannot handle the aio context change.

Do this through blk_set_aio_context interface, in backup_job_create() as a
central place for both drive-backup and blockdev-backup, to take care of the
compatibility check.

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
index c5b2c2c..5d89a9a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3259,8 +3259,6 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         goto out;
     }
 
-    bdrv_set_aio_context(target_bs, aio_context);
-
     if (backup->has_bitmap) {
         bmap = bdrv_find_dirty_bitmap(bs, backup->bitmap);
         if (!bmap) {
@@ -3337,18 +3335,6 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
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
2.9.3
