Received: from eggs.gnu.org ([2001:4830:134:3::10]:49188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJE-0007XJ-3L
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIy-00041v-0i
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:44 +0200
Message-Id: <1502117160-24655-41-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 40/56] blockjob: Lift speed sign conversion
 out of backup_job_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

backup_job_create() takes int64_t speed.  The underlying BlockJob
abstraction takes uint64_t.  backup_job_create() converts from int64_t
to uint64_t, rejecting negative speed.

Lift this check and conversion out of backup_job_create() into its
callers.  I'm going to lift it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/backup.c            |  7 +------
 blockdev.c                | 12 ++++++++++++
 include/block/block_int.h |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 3a97836..eddc17a 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -529,7 +529,7 @@ static const BlockJobDriver backup_job_driver = {
 };
 
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *target, int64_t speed,
+                  BlockDriverState *target, uint64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
                   bool compress,
                   BlockdevOnError on_source_error,
@@ -577,11 +577,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return NULL;
-    }
-
     if (sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         if (!sync_bitmap) {
             error_setg(errp, "must provide a valid bitmap name for "
diff --git a/blockdev.c b/blockdev.c
index f9afc32..1deea49 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3210,6 +3210,12 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         return NULL;
     }
 
+    if (backup->speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return NULL;
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3353,6 +3359,12 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
         return NULL;
     }
 
+    if (backup->speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return NULL;
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c09076e..19639c0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -923,7 +923,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * until the job is cancelled or manually completed.
  */
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
-                            BlockDriverState *target, int64_t speed,
+                            BlockDriverState *target, uint64_t speed,
                             MirrorSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
                             bool compress,
-- 
2.7.5
