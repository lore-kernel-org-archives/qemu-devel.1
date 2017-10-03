Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzDgm-00070e-BE
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 23:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzDgl-0005sY-5E
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 23:16:08 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon,  2 Oct 2017 23:15:56 -0400
Message-Id: <20171003031556.15173-4-jsnow@redhat.com>
In-Reply-To: <20171003031556.15173-1-jsnow@redhat.com>
References: <20171003031556.15173-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] blockjob: expose manual-cull property
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

For drive-backup and blockdev-backup, expose the manual-cull
property, having it default to false. There are no universal
creation parameters, so it must be added to each job type that
it makes sense for individually.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 10 ++++++++--
 qapi/block-core.json | 21 ++++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index ee07bca..ba2ebfb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3198,6 +3198,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_manual_cull) {
+        backup->manual_cull = false;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3290,7 +3293,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         }
     }
 
-    job = backup_job_create(backup->job_id, false, bs, target_bs,
+    job = backup_job_create(backup->job_id, backup->manual_cull, bs, target_bs,
                             backup->speed, backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
@@ -3341,6 +3344,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_manual_cull) {
+        backup->manual_cull = false;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3369,7 +3375,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
-    job = backup_job_create(backup->job_id, false, bs, target_bs,
+    job = backup_job_create(backup->job_id, backup->manual_cull, bs, target_bs,
                             backup->speed, backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index de322d1..c646743 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1104,6 +1104,11 @@
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
+# @manual-cull: Whether or not the job created by this command needs to be
+#               cleaned up manually via block-job-cull or not. The default is
+#               false. When true, the job will remain in a "completed" state
+#               until culled manually with block-job-cull. (Since 2.11)
+#
 # @device: the device name or node-name of a root node which should be copied.
 #
 # @target: the target of the new image. If the file exists, or if it
@@ -1144,9 +1149,10 @@
 # Since: 1.6
 ##
 { 'struct': 'DriveBackup',
-  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            '*format': 'str', 'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*bitmap': 'str', '*compress': 'bool',
+  'data': { '*job-id': 'str', '*manual-cull': 'bool', 'device': 'str',
+            'target': 'str', '*format': 'str', 'sync': 'MirrorSyncMode',
+            '*mode': 'NewImageMode', '*speed': 'int', '*bitmap': 'str',
+            '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError' } }
 
@@ -1156,6 +1162,11 @@
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
+# @manual-cull: Whether or not the job created by this command needs to be
+#               cleaned up manually via block-job-cull or not. The default is
+#               false. When true, the job will remain in a "completed" state
+#               until culled manually with block-job-cull. (Since 2.11)
+#
 # @device: the device name or node-name of a root node which should be copied.
 #
 # @target: the device name or node-name of the backup target node.
@@ -1185,8 +1196,8 @@
 # Since: 2.3
 ##
 { 'struct': 'BlockdevBackup',
-  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            'sync': 'MirrorSyncMode',
+  'data': { '*job-id': 'str', '*manual-cull': 'bool', 'device': 'str',
+            'target': 'str', 'sync': 'MirrorSyncMode',
             '*speed': 'int',
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
-- 
2.9.5
