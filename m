Received: from eggs.gnu.org ([2001:4830:134:3::10]:37457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFsC-0001CC-0X
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFsA-0008VS-DF
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:40 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:14 -0500
Message-Id: <20180127020515.27137-14-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 13/14] blockjobs: Expose manual property
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
 blockdev.c                | 14 ++++++++++----
 include/block/block_int.h |  3 +++
 qapi/block-core.json      | 32 ++++++++++++++++++++++++++------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index d387ef6ec0..e7c3fc0607 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3281,6 +3281,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_manual) {
+        backup->manual = false;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3373,8 +3376,8 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         }
     }
 
-    job = backup_job_create(backup->job_id, false, bs, target_bs, backup->speed,
-                            backup->sync, bmap, backup->compress,
+    job = backup_job_create(backup->job_id, backup->manual, bs, target_bs,
+                            backup->speed, backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
     bdrv_unref(target_bs);
@@ -3424,6 +3427,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_manual) {
+        backup->manual = false;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3452,8 +3458,8 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
-    job = backup_job_create(backup->job_id, false, bs, target_bs, backup->speed,
-                            backup->sync, NULL, backup->compress,
+    job = backup_job_create(backup->job_id, backup->manual, bs, target_bs,
+                            backup->speed, backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
     if (local_err != NULL) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 08f5046c63..d91f50ca60 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -965,6 +965,9 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * backup_job_create:
  * @job_id: The id of the newly-created job, or %NULL to use the
  * device name of @bs.
+ * @manual: Whether or not this job requires manual intervention to transition
+ *          from "PENDING" state to "CONCLUDED" state, and again, manual
+ *          intervention to dismiss CONCLUDED jobs.
  * @bs: Block device to operate on.
  * @target: Block device to write to.
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index bd4458bf57..d8d82404da 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1119,6 +1119,16 @@
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
@@ -1159,9 +1169,10 @@
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
 
@@ -1171,6 +1182,16 @@
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
@@ -1200,9 +1221,8 @@
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
