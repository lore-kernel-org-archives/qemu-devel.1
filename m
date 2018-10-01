Received: from eggs.gnu.org ([2001:4830:134:3::10]:40377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSN-0004qZ-Kv
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSK-0002LD-OF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:16 +0300
Message-Id: <20181001102928.20533-7-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 06/18] block/backup: give a name to
 copy-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

The bitmap should be named to be shared with special filter node in
further patches. Make it possible to set this name in qmp command.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json      | 18 ++++++++++++++++--
 include/block/block_int.h |  2 +-
 block/backup.c            | 10 ++++++++--
 block/replication.c       |  2 +-
 blockdev.c                | 12 ++++++++++--
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ac3b48ee54..c4774af18e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1260,6 +1260,12 @@
 #          Must be present if sync is "incremental", must NOT be present
 #          otherwise. (Since 2.4)
 #
+# @x-copy-bitmap: the name for the copy-bitmap - the bitmap which drives the
+#                 backup process. At backup start it corresponds to @bitmap (or
+#                 just all bits set for full backup) and at the finish it
+#                 should be zero. If the bitmap already exists it will be used
+#                 as is. (Since 3.1)
+#
 # @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
 #
@@ -1297,7 +1303,8 @@
             '*bitmap': 'str', '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
+            '*x-copy-bitmap': 'str' } }
 
 ##
 # @BlockdevBackup:
@@ -1340,6 +1347,12 @@
 #                list without user intervention.
 #                Defaults to true. (Since 2.12)
 #
+# @x-copy-bitmap: the name for the copy-bitmap - the bitmap which drives the
+#                 backup process. At backup start it corresponds to @bitmap (or
+#                 just all bits set for full backup) and at the finish it
+#                 should be zero. If the bitmap already exists it will be used
+#                 as is. (Since 3.1)
+#
 # Note: @on-source-error and @on-target-error only affect background
 # I/O.  If an error occurs during a guest write request, the device's
 # rerror/werror actions will be used.
@@ -1351,7 +1364,8 @@
             'sync': 'MirrorSyncMode', '*speed': 'int', '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
+            '*x-copy-bitmap': 'str' } }
 
 ##
 # @blockdev-snapshot-sync:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 92ecbd866e..13f4a0f98e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1087,7 +1087,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             bool compress,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
-                            int creation_flags,
+                            int creation_flags, const char *x_copy_bitmap,
                             BlockCompletionFunc *cb, void *opaque,
                             JobTxn *txn, Error **errp);
 
diff --git a/block/backup.c b/block/backup.c
index 45212d54c9..ad143ea735 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -25,6 +25,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
+#include "qemu/id.h"
 
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
 
@@ -559,7 +560,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   bool compress,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
-                  int creation_flags,
+                  int creation_flags, const char *x_copy_bitmap,
                   BlockCompletionFunc *cb, void *opaque,
                   JobTxn *txn, Error **errp)
 {
@@ -567,6 +568,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     BlockDriverInfo bdi;
     BackupBlockJob *job = NULL;
     int ret;
+    char *gen_bitmap_name = NULL;
 
     assert(bs);
     assert(target);
@@ -684,8 +686,12 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
 
+    if (!x_copy_bitmap) {
+        x_copy_bitmap = gen_bitmap_name = id_generate(ID_BLOCK_BITMAP);
+    }
     job->copy_bitmap = bdrv_create_dirty_bitmap(bs, job->cluster_size,
-                                                NULL, errp);
+                                                x_copy_bitmap, errp);
+    g_free(gen_bitmap_name);
     if (!job->copy_bitmap) {
         goto error;
     }
diff --git a/block/replication.c b/block/replication.c
index 0c2989d2cb..f4ff0bb034 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -548,7 +548,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         job = backup_job_create(NULL, s->secondary_disk->bs, s->hidden_disk->bs,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, false,
                                 BLOCKDEV_ON_ERROR_REPORT,
-                                BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
+                                BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL, NULL,
                                 backup_job_completed, bs, NULL, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
diff --git a/blockdev.c b/blockdev.c
index a8755bd908..407e03d22a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3407,6 +3407,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
     if (!backup->has_compress) {
         backup->compress = false;
     }
+    if (!backup->has_x_copy_bitmap) {
+        backup->x_copy_bitmap = NULL;
+    }
 
     bs = qmp_get_root_bs(backup->device, errp);
     if (!bs) {
@@ -3511,7 +3514,8 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
-                            job_flags, NULL, NULL, txn, &local_err);
+                            job_flags, backup->x_copy_bitmap,
+                            NULL, NULL, txn, &local_err);
     bdrv_unref(target_bs);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -3569,6 +3573,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
     if (!backup->has_compress) {
         backup->compress = false;
     }
+    if (!backup->has_x_copy_bitmap) {
+        backup->x_copy_bitmap = NULL;
+    }
 
     bs = bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
@@ -3603,7 +3610,8 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
-                            job_flags, NULL, NULL, txn, &local_err);
+                            job_flags, backup->x_copy_bitmap,
+                            NULL, NULL, txn, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
     }
-- 
2.18.0
