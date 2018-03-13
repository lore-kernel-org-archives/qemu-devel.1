Received: from eggs.gnu.org ([2001:4830:134:3::10]:59559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdI-0001WY-Ky
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdF-0004fx-S5
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:41 +0100
Message-Id: <20180313161803.1814-20-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/41] blockjobs: Expose manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

Expose the "manual" property via QAPI for the backup-related jobs.
As of this commit, this allows the management API to request the
"concluded" and "dismiss" semantics for backup jobs.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       | 48 ++++++++++++++++++++++++++++++++++++++--------
 blockdev.c                 | 31 +++++++++++++++++++++++++++---
 blockjob.c                 |  2 ++
 tests/qemu-iotests/109.out | 24 +++++++++++------------
 4 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2c32fc69f9..3e52d248eb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1054,13 +1054,20 @@
 #
 # @status: Current job state/status (since 2.12)
 #
+# @auto-finalize: Job will finalize itself when PENDING, moving to
+#                 the CONCLUDED state. (since 2.12)
+#
+# @auto-dismiss: Job will dismiss itself when CONCLUDED, moving to the NULL
+#                state and disappearing from the query list. (since 2.12)
+#
 # Since: 1.1
 ##
 { 'struct': 'BlockJobInfo',
   'data': {'type': 'str', 'device': 'str', 'len': 'int',
            'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
            'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
-           'status': 'BlockJobStatus' } }
+           'status': 'BlockJobStatus',
+           'auto-finalize': 'bool', 'auto-dismiss': 'bool' } }
 
 ##
 # @query-block-jobs:
@@ -1210,6 +1217,18 @@
 #                   default 'report' (no limitations, since this applies to
 #                   a different block device than @device).
 #
+# @auto-finalize: When false, this job will wait in a PENDING state after it has
+#                 finished its work, waiting for @block-job-finalize.
+#                 When true, this job will automatically perform its abort or
+#                 commit actions.
+#                 Defaults to true. (Since 2.12)
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
+#                has completed ceased all work, and wait for @block-job-dismiss.
+#                When true, this job will automatically disappear from the query
+#                list without user intervention.
+#                Defaults to true. (Since 2.12)
+#
 # Note: @on-source-error and @on-target-error only affect background
 # I/O.  If an error occurs during a guest write request, the device's
 # rerror/werror actions will be used.
@@ -1218,10 +1237,12 @@
 ##
 { 'struct': 'DriveBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            '*format': 'str', 'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*bitmap': 'str', '*compress': 'bool',
+            '*format': 'str', 'sync': 'MirrorSyncMode',
+            '*mode': 'NewImageMode', '*speed': 'int',
+            '*bitmap': 'str', '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError' } }
+            '*on-target-error': 'BlockdevOnError',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
 # @BlockdevBackup:
@@ -1251,6 +1272,18 @@
 #                   default 'report' (no limitations, since this applies to
 #                   a different block device than @device).
 #
+# @auto-finalize: When false, this job will wait in a PENDING state after it has
+#                 finished its work, waiting for @block-job-finalize.
+#                 When true, this job will automatically perform its abort or
+#                 commit actions.
+#                 Defaults to true. (Since 2.12)
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
+#                has completed ceased all work, and wait for @block-job-dismiss.
+#                When true, this job will automatically disappear from the query
+#                list without user intervention.
+#                Defaults to true. (Since 2.12)
+#
 # Note: @on-source-error and @on-target-error only affect background
 # I/O.  If an error occurs during a guest write request, the device's
 # rerror/werror actions will be used.
@@ -1259,11 +1292,10 @@
 ##
 { 'struct': 'BlockdevBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            'sync': 'MirrorSyncMode',
-            '*speed': 'int',
-            '*compress': 'bool',
+            'sync': 'MirrorSyncMode', '*speed': 'int', '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError' } }
+            '*on-target-error': 'BlockdevOnError',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
 # @blockdev-snapshot-sync:
diff --git a/blockdev.c b/blockdev.c
index efd3ab2e99..809adbe7f9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3261,7 +3261,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     AioContext *aio_context;
     QDict *options = NULL;
     Error *local_err = NULL;
-    int flags;
+    int flags, job_flags = BLOCK_JOB_DEFAULT;
     int64_t size;
     bool set_backing_hd = false;
 
@@ -3280,6 +3280,12 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_auto_finalize) {
+        backup->auto_finalize = true;
+    }
+    if (!backup->has_auto_dismiss) {
+        backup->auto_dismiss = true;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3371,11 +3377,17 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
+    if (!backup->auto_finalize) {
+        job_flags |= BLOCK_JOB_MANUAL_FINALIZE;
+    }
+    if (!backup->auto_dismiss) {
+        job_flags |= BLOCK_JOB_MANUAL_DISMISS;
+    }
 
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
-                            BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
+                            job_flags, NULL, NULL, txn, &local_err);
     bdrv_unref(target_bs);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -3410,6 +3422,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
     Error *local_err = NULL;
     AioContext *aio_context;
     BlockJob *job = NULL;
+    int job_flags = BLOCK_JOB_DEFAULT;
 
     if (!backup->has_speed) {
         backup->speed = 0;
@@ -3423,6 +3436,12 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
     if (!backup->has_job_id) {
         backup->job_id = NULL;
     }
+    if (!backup->has_auto_finalize) {
+        backup->auto_finalize = true;
+    }
+    if (!backup->has_auto_dismiss) {
+        backup->auto_dismiss = true;
+    }
     if (!backup->has_compress) {
         backup->compress = false;
     }
@@ -3451,10 +3470,16 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
+    if (!backup->auto_finalize) {
+        job_flags |= BLOCK_JOB_MANUAL_FINALIZE;
+    }
+    if (!backup->auto_dismiss) {
+        job_flags |= BLOCK_JOB_MANUAL_DISMISS;
+    }
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
-                            BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
+                            job_flags, NULL, NULL, txn, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
     }
diff --git a/blockjob.c b/blockjob.c
index 4b73cb0263..ba538c93dd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -821,6 +821,8 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->io_status = job->iostatus;
     info->ready     = job->ready;
     info->status    = job->status;
+    info->auto_finalize = job->auto_finalize;
+    info->auto_dismiss  = job->auto_dismiss;
     return info;
 }
 
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index d288f2eef6..8a9b93672b 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -19,7 +19,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -45,7 +45,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
@@ -71,7 +71,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -97,7 +97,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -123,7 +123,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
@@ -149,7 +149,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -174,7 +174,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -199,7 +199,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
@@ -224,7 +224,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -249,7 +249,7 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
@@ -265,7 +265,7 @@ Automatically detecting the format is dangerous for raw images, write operations
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
@@ -274,7 +274,7 @@ Images are identical.
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
-{"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
-- 
2.13.6
