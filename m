Received: from eggs.gnu.org ([2001:4830:134:3::10]:55277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8L-0005qh-FS
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8H-0005pW-Hv
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:09 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:40 -0500
Message-Id: <20180223235142.21501-20-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 19/21] blockjobs: Expose manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Expose the "manual" property via QAPI for the backup-related jobs.
As of this commit, this allows the management API to request the
"concluded" and "dismiss" semantics for backup jobs.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 19 ++++++++++++++++---
 qapi/block-core.json | 32 ++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 05fd421cdc..2eddb0e726 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3260,7 +3260,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     AioContext *aio_context;
     QDict *options = NULL;
     Error *local_err = NULL;
-    int flags;
+    int flags, job_flags = BLOCK_JOB_DEFAULT;
     int64_t size;
     bool set_backing_hd = false;
 
@@ -3279,6 +3279,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_manual) {
+        backup->manual = false;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3370,11 +3373,14 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
+    if (backup->manual) {
+        job_flags |= BLOCK_JOB_MANUAL;
+    }
 
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
-                            BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
+                            job_flags, NULL, NULL, txn, &local_err);
     bdrv_unref(target_bs);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -3409,6 +3415,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
     Error *local_err = NULL;
     AioContext *aio_context;
     BlockJob *job = NULL;
+    int job_flags = BLOCK_JOB_DEFAULT;
 
     if (!backup->has_speed) {
         backup->speed = 0;
@@ -3422,6 +3429,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_manual) {
+        backup->manual = false;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3450,10 +3460,13 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
+    if (backup->manual) {
+        job_flags |= BLOCK_JOB_MANUAL;
+    }
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
-                            BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
+                            job_flags, NULL, NULL, txn, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 549c6c02d8..7b3af93682 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1177,6 +1177,16 @@
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
+# @manual: True to use an expanded, more explicit job control flow.
+#          Jobs may transition from a running state to a pending state,
+#          where they must be instructed to complete manually via
+#          block-job-finalize.
+#          Jobs belonging to a transaction must either all or all not use this
+#          setting. Once a transaction reaches a pending state, issuing the
+#          finalize command to any one job in the transaction is sufficient
+#          to finalize the entire transaction.
+#          (Since 2.12)
+#
 # @device: the device name or node-name of a root node which should be copied.
 #
 # @target: the target of the new image. If the file exists, or if it
@@ -1217,9 +1227,10 @@
 # Since: 1.6
 ##
 { 'struct': 'DriveBackup',
-  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            '*format': 'str', 'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*bitmap': 'str', '*compress': 'bool',
+  'data': { '*job-id': 'str', '*manual': 'bool', 'device': 'str',
+            'target': 'str', '*format': 'str', 'sync': 'MirrorSyncMode',
+            '*mode': 'NewImageMode', '*speed': 'int',
+            '*bitmap': 'str', '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError' } }
 
@@ -1229,6 +1240,16 @@
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
+# @manual: True to use an expanded, more explicit job control flow.
+#          Jobs may transition from a running state to a pending state,
+#          where they must be instructed to complete manually via
+#          block-job-finalize.
+#          Jobs belonging to a transaction must either all or all not use this
+#          setting. Once a transaction reaches a pending state, issuing the
+#          finalize command to any one job in the transaction is sufficient
+#          to finalize the entire transaction.
+#          (Since 2.12)
+#
 # @device: the device name or node-name of a root node which should be copied.
 #
 # @target: the device name or node-name of the backup target node.
@@ -1258,9 +1279,8 @@
 # Since: 2.3
 ##
 { 'struct': 'BlockdevBackup',
-  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            'sync': 'MirrorSyncMode',
-            '*speed': 'int',
+  'data': { '*job-id': 'str', '*manual': 'bool', 'device': 'str',
+            'target': 'str', 'sync': 'MirrorSyncMode', '*speed': 'int',
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError' } }
-- 
2.14.3
