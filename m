Received: from eggs.gnu.org ([2001:4830:134:3::10]:49326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJK-0007gE-6L
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ3-00046i-GS
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:14 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:50 +0200
Message-Id: <1502117160-24655-47-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 46/56] blockjob: Make job commands' speed
 parameter unsigned in QAPI/QMP
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

Byte rates should use QAPI type 'size' (uint64_t).  drive-backup,
blockdev-backup, block-commit, drive-mirror, blockdev-mirror,
block-stream and block-job-set-speed parameter @size is 'int'
(int64_t).  Their QMP command handlers all ensure it's non-negative
before they pass it on to the next lower layer, which expects
uint64_t.

Change these @speed parameters to 'size', and drop the range checks.
You can now set rate limits between 2^63 and 2^64-1.  Good luck
finding hardware where that actually limits.

Negative values are accepted and interpreted modulo 2^64, because
that's how the QObject input visitor works for backward compatibility.
Drop the tests for negative size.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c                 | 50 ++++------------------------------------------
 qapi/block-core.json       | 14 ++++++-------
 tests/qemu-iotests/030     | 16 ---------------
 tests/qemu-iotests/030.out |  4 ++--
 tests/qemu-iotests/041     | 18 -----------------
 tests/qemu-iotests/041.out |  4 ++--
 tests/qemu-iotests/055     | 26 ------------------------
 tests/qemu-iotests/055.out |  4 ++--
 8 files changed, 17 insertions(+), 119 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index e679f5d..7feed7a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2970,7 +2970,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
                       bool has_base, const char *base,
                       bool has_base_node, const char *base_node,
                       bool has_backing_file, const char *backing_file,
-                      bool has_speed, int64_t speed,
+                      bool has_speed, uint64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
                       Error **errp)
 {
@@ -2989,12 +2989,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3063,7 +3057,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
                       bool has_base, const char *base,
                       bool has_top, const char *top,
                       bool has_backing_file, const char *backing_file,
-                      bool has_speed, int64_t speed,
+                      bool has_speed, uint64_t speed,
                       bool has_filter_node_name, const char *filter_node_name,
                       Error **errp)
 {
@@ -3102,12 +3096,6 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        goto out;
-    }
-
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3222,12 +3210,6 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         return NULL;
     }
 
-    if (backup->speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return NULL;
-    }
-
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3371,12 +3353,6 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
         return NULL;
     }
 
-    if (backup->speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return NULL;
-    }
-
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3509,12 +3485,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
-    if (arg->speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3647,7 +3617,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          const char *device, const char *target,
                          bool has_replaces, const char *replaces,
                          MirrorSyncMode sync,
-                         bool has_speed, int64_t speed,
+                         bool has_speed, uint64_t speed,
                          bool has_granularity, uint64_t granularity,
                          bool has_buf_size, int64_t buf_size,
                          bool has_on_source_error,
@@ -3674,12 +3644,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
         return;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3724,7 +3688,7 @@ static BlockJob *find_block_job(const char *id, AioContext **aio_context,
     return job;
 }
 
-void qmp_block_job_set_speed(const char *device, int64_t speed, Error **errp)
+void qmp_block_job_set_speed(const char *device, uint64_t speed, Error **errp)
 {
     AioContext *aio_context;
     BlockJob *job = find_block_job(device, &aio_context, errp);
@@ -3733,12 +3697,6 @@ void qmp_block_job_set_speed(const char *device, int64_t speed, Error **errp)
         return;
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     block_job_set_speed(job, speed, errp);
     aio_context_release(aio_context);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ceaab43..9e9f2d8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1117,7 +1117,7 @@
 { 'struct': 'DriveBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', 'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*bitmap': 'str', '*compress': 'bool',
+            '*speed': 'size', '*bitmap': 'str', '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError' } }
 
@@ -1158,7 +1158,7 @@
 { 'struct': 'BlockdevBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             'sync': 'MirrorSyncMode',
-            '*speed': 'int',
+            '*speed': 'size',
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError' } }
@@ -1329,7 +1329,7 @@
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str', '*top': 'str',
-            '*backing-file': 'str', '*speed': 'int',
+            '*backing-file': 'str', '*speed': 'size',
             '*filter-node-name': 'str' } }
 
 ##
@@ -1533,7 +1533,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
             'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*granularity': 'size',
+            '*speed': 'size', '*granularity': 'size',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*unmap': 'bool' } }
@@ -1732,7 +1732,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*replaces': 'str',
             'sync': 'MirrorSyncMode',
-            '*speed': 'int', '*granularity': 'size',
+            '*speed': 'size', '*granularity': 'size',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*filter-node-name': 'str' } }
@@ -1949,7 +1949,7 @@
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
-            '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
+            '*base-node': 'str', '*backing-file': 'str', '*speed': 'size',
             '*on-error': 'BlockdevOnError' } }
 
 ##
@@ -1974,7 +1974,7 @@
 # Since: 1.1
 ##
 { 'command': 'block-job-set-speed',
-  'data': { 'device': 'str', 'speed': 'int' } }
+  'data': { 'device': 'str', 'speed': 'size' } }
 
 ##
 # @block-job-cancel:
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index d745cb4..7fc365b 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -788,21 +788,5 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.cancel_and_wait(resume=True)
 
-    def test_set_speed_invalid(self):
-        self.assert_no_active_block_jobs()
-
-        result = self.vm.qmp('block-stream', device='drive0', speed=-1)
-        self.assert_qmp(result, 'error/class', 'GenericError')
-
-        self.assert_no_active_block_jobs()
-
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
-
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
-        self.assert_qmp(result, 'error/class', 'GenericError')
-
-        self.cancel_and_wait()
-
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 391c857..84bfd63 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-.......................
+......................
 ----------------------------------------------------------------------
-Ran 23 tests
+Ran 22 tests
 
 OK
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index a860a31..6c2dd50 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -701,24 +701,6 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.wait_ready_and_cancel()
 
-    def test_set_speed_invalid(self):
-        self.assert_no_active_block_jobs()
-
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, speed=-1)
-        self.assert_qmp(result, 'error/class', 'GenericError')
-
-        self.assert_no_active_block_jobs()
-
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
-        self.assert_qmp(result, 'return', {})
-
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
-        self.assert_qmp(result, 'error/class', 'GenericError')
-
-        self.wait_ready_and_cancel()
-
 class TestUnbackedSource(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index c28b392..1eb95f3 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.....................................................................................
+....................................................................................
 ----------------------------------------------------------------------
-Ran 85 tests
+Ran 84 tests
 
 OK
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index e1206ca..c703fbb 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -220,32 +220,6 @@ class TestSetSpeed(iotests.QMPTestCase):
     def test_set_speed_blockdev_backup(self):
         self.do_test_set_speed('blockdev-backup', 'drive1')
 
-    def do_test_set_speed_invalid(self, cmd, target):
-        self.assert_no_active_block_jobs()
-
-        result = self.vm.qmp(cmd, device='drive0',
-                             target=target, sync='full', speed=-1)
-        self.assert_qmp(result, 'error/class', 'GenericError')
-
-        self.assert_no_active_block_jobs()
-
-        self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0',
-                             target=target, sync='full')
-        self.assert_qmp(result, 'return', {})
-
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
-        self.assert_qmp(result, 'error/class', 'GenericError')
-
-        event = self.cancel_and_wait(resume=True)
-        self.assert_qmp(event, 'data/type', 'backup')
-
-    def test_set_speed_invalid_drive_backup(self):
-        self.do_test_set_speed_invalid('drive-backup', target_img)
-
-    def test_set_speed_invalid_blockdev_backup(self):
-        self.do_test_set_speed_invalid('blockdev-backup',  'drive1')
-
 class TestSingleTransaction(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
diff --git a/tests/qemu-iotests/055.out b/tests/qemu-iotests/055.out
index 5ce2f9a..af8dac1 100644
--- a/tests/qemu-iotests/055.out
+++ b/tests/qemu-iotests/055.out
@@ -1,5 +1,5 @@
-..............................
+............................
 ----------------------------------------------------------------------
-Ran 30 tests
+Ran 28 tests
 
 OK
-- 
2.7.5
