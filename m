Received: from eggs.gnu.org ([2001:4830:134:3::10]:59622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdM-0001a5-5v
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdI-0004hk-75
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:42 +0100
Message-Id: <20180313161803.1814-21-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/41] iotests: test manual job dismissal
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

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/056     | 187 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/056.out |   4 +-
 2 files changed, 189 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 04f2c3c841..223292175a 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -29,6 +29,26 @@ backing_img = os.path.join(iotests.test_dir, 'backing.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
 target_img = os.path.join(iotests.test_dir, 'target.img')
 
+def img_create(img, fmt=iotests.imgfmt, size='64M', **kwargs):
+    fullname = os.path.join(iotests.test_dir, '%s.%s' % (img, fmt))
+    optargs = []
+    for k,v in kwargs.iteritems():
+        optargs = optargs + ['-o', '%s=%s' % (k,v)]
+    args = ['create', '-f', fmt] + optargs + [fullname, size]
+    iotests.qemu_img(*args)
+    return fullname
+
+def try_remove(img):
+    try:
+        os.remove(img)
+    except OSError:
+        pass
+
+def io_write_patterns(img, patterns):
+    for pattern in patterns:
+        iotests.qemu_io('-c', 'write -P%s %s %s' % pattern, img)
+
+
 class TestSyncModesNoneAndTop(iotests.QMPTestCase):
     image_len = 64 * 1024 * 1024 # MB
 
@@ -108,5 +128,172 @@ class TestBeforeWriteNotifier(iotests.QMPTestCase):
         event = self.cancel_and_wait()
         self.assert_qmp(event, 'data/type', 'backup')
 
+class BackupTest(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.test_img = img_create('test')
+        self.dest_img = img_create('dest')
+        self.vm.add_drive(self.test_img)
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        try_remove(self.test_img)
+        try_remove(self.dest_img)
+
+    def hmp_io_writes(self, drive, patterns):
+        for pattern in patterns:
+            self.vm.hmp_qemu_io(drive, 'write -P%s %s %s' % pattern)
+        self.vm.hmp_qemu_io(drive, 'flush')
+
+    def qmp_backup_and_wait(self, cmd='drive-backup', serror=None,
+                            aerror=None, **kwargs):
+        if not self.qmp_backup(cmd, serror, **kwargs):
+            return False
+        return self.qmp_backup_wait(kwargs['device'], aerror)
+
+    def qmp_backup(self, cmd='drive-backup',
+                   error=None, **kwargs):
+        self.assertTrue('device' in kwargs)
+        res = self.vm.qmp(cmd, **kwargs)
+        if error:
+            self.assert_qmp(res, 'error/desc', error)
+            return False
+        self.assert_qmp(res, 'return', {})
+        return True
+
+    def qmp_backup_wait(self, device, error=None):
+        event = self.vm.event_wait(name="BLOCK_JOB_COMPLETED",
+                                   match={'data': {'device': device}})
+        self.assertNotEqual(event, None)
+        try:
+            failure = self.dictpath(event, 'data/error')
+        except AssertionError:
+            # Backup succeeded.
+            self.assert_qmp(event, 'data/offset', event['data']['len'])
+            return True
+        else:
+            # Failure.
+            self.assert_qmp(event, 'data/error', qerror)
+            return False
+
+    def test_dismiss_false(self):
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+        self.qmp_backup_and_wait(device='drive0', format=iotests.imgfmt,
+                                 sync='full', target=self.dest_img,
+                                 auto_dismiss=True)
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+
+    def test_dismiss_true(self):
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+        self.qmp_backup_and_wait(device='drive0', format=iotests.imgfmt,
+                                 sync='full', target=self.dest_img,
+                                 auto_dismiss=False)
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return[0]/status', 'concluded')
+        res = self.vm.qmp('block-job-dismiss', id='drive0')
+        self.assert_qmp(res, 'return', {})
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+
+    def test_dismiss_bad_id(self):
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+        res = self.vm.qmp('block-job-dismiss', id='foobar')
+        self.assert_qmp(res, 'error/class', 'DeviceNotActive')
+
+    def test_dismiss_collision(self):
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+        self.qmp_backup_and_wait(device='drive0', format=iotests.imgfmt,
+                                 sync='full', target=self.dest_img,
+                                 auto_dismiss=False)
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return[0]/status', 'concluded')
+        # Leave zombie job un-dismissed, observe a failure:
+        res = self.qmp_backup_and_wait(serror='Need a root block node',
+                                       device='drive0', format=iotests.imgfmt,
+                                       sync='full', target=self.dest_img,
+                                       auto_dismiss=False)
+        self.assertEqual(res, False)
+        # OK, dismiss the zombie.
+        res = self.vm.qmp('block-job-dismiss', id='drive0')
+        self.assert_qmp(res, 'return', {})
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+        # Ensure it's really gone.
+        self.qmp_backup_and_wait(device='drive0', format=iotests.imgfmt,
+                                 sync='full', target=self.dest_img,
+                                 auto_dismiss=False)
+
+    def dismissal_failure(self, dismissal_opt):
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return', [])
+        # Give blkdebug something to chew on
+        self.hmp_io_writes('drive0',
+                           (('0x9a', 0, 512),
+                           ('0x55', '8M', '352k'),
+                           ('0x78', '15872k', '1M')))
+        # Add destination node via blkdebug
+        res = self.vm.qmp('blockdev-add',
+                          node_name='target0',
+                          driver=iotests.imgfmt,
+                          file={
+                              'driver': 'blkdebug',
+                              'image': {
+                                  'driver': 'file',
+                                  'filename': self.dest_img
+                              },
+                              'inject-error': [{
+                                  'event': 'write_aio',
+                                  'errno': 5,
+                                  'immediately': False,
+                                  'once': True
+                              }],
+                          })
+        self.assert_qmp(res, 'return', {})
+
+        res = self.qmp_backup(cmd='blockdev-backup',
+                              device='drive0', target='target0',
+                              on_target_error='stop',
+                              sync='full',
+                              auto_dismiss=dismissal_opt)
+        self.assertTrue(res)
+        event = self.vm.event_wait(name="BLOCK_JOB_ERROR",
+                                   match={'data': {'device': 'drive0'}})
+        self.assertNotEqual(event, None)
+        # OK, job should be wedged
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return[0]/status', 'paused')
+        res = self.vm.qmp('block-job-dismiss', id='drive0')
+        self.assert_qmp(res, 'error/desc',
+                        "Job 'drive0' in state 'paused' cannot accept"
+                        " command verb 'dismiss'")
+        res = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(res, 'return[0]/status', 'paused')
+        # OK, unstick job and move forward.
+        res = self.vm.qmp('block-job-resume', device='drive0')
+        self.assert_qmp(res, 'return', {})
+        # And now we need to wait for it to conclude;
+        res = self.qmp_backup_wait(device='drive0')
+        self.assertTrue(res)
+        if not dismissal_opt:
+            # Job should now be languishing:
+            res = self.vm.qmp('query-block-jobs')
+            self.assert_qmp(res, 'return[0]/status', 'concluded')
+            res = self.vm.qmp('block-job-dismiss', id='drive0')
+            self.assert_qmp(res, 'return', {})
+            res = self.vm.qmp('query-block-jobs')
+            self.assert_qmp(res, 'return', [])
+
+    def test_dismiss_premature(self):
+        self.dismissal_failure(False)
+
+    def test_dismiss_erroneous(self):
+        self.dismissal_failure(True)
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/056.out b/tests/qemu-iotests/056.out
index 8d7e996700..dae404e278 100644
--- a/tests/qemu-iotests/056.out
+++ b/tests/qemu-iotests/056.out
@@ -1,5 +1,5 @@
-...
+.........
 ----------------------------------------------------------------------
-Ran 3 tests
+Ran 9 tests
 
 OK
-- 
2.13.6
