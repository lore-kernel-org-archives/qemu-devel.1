Received: from eggs.gnu.org ([2001:4830:134:3::10]:59153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd3-0001G6-30
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcz-0004UP-38
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:28 +0100
Message-Id: <20180313161803.1814-7-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/41] iotests: add pause_wait
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

Split out the pause command into the actual pause and the wait.
Not every usage presently needs to resubmit a pause request.

The intent with the next commit will be to explicitly disallow
redundant or meaningless pause/resume requests, so the tests
need to become more judicious to reflect that.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/030        |  6 ++----
 tests/qemu-iotests/055        | 17 ++++++-----------
 tests/qemu-iotests/iotests.py | 12 ++++++++----
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index b5f88959aa..640a6dfd10 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -86,11 +86,9 @@ class TestSingleDrive(iotests.QMPTestCase):
         result = self.vm.qmp('block-stream', device='drive0')
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-job-pause', device='drive0')
-        self.assert_qmp(result, 'return', {})
-
+        self.pause_job('drive0', wait=False)
         self.vm.resume_drive('drive0')
-        self.pause_job('drive0')
+        self.pause_wait('drive0')
 
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 8a5d9fd269..3437c11507 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -86,11 +86,9 @@ class TestSingleDrive(iotests.QMPTestCase):
                              target=target, sync='full')
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-job-pause', device='drive0')
-        self.assert_qmp(result, 'return', {})
-
+        self.pause_job('drive0', wait=False)
         self.vm.resume_drive('drive0')
-        self.pause_job('drive0')
+        self.pause_wait('drive0')
 
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
@@ -303,13 +301,12 @@ class TestSingleTransaction(iotests.QMPTestCase):
         ])
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-job-pause', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.pause_job('drive0', wait=False)
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
         self.assert_qmp(result, 'return', {})
 
-        self.pause_job('drive0')
+        self.pause_wait('drive0')
 
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
@@ -534,11 +531,9 @@ class TestDriveCompression(iotests.QMPTestCase):
         result = self.vm.qmp(cmd, device='drive0', sync='full', compress=True, **args)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-job-pause', device='drive0')
-        self.assert_qmp(result, 'return', {})
-
+        self.pause_job('drive0', wait=False)
         self.vm.resume_drive('drive0')
-        self.pause_job('drive0')
+        self.pause_wait('drive0')
 
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 1bcc9ca57d..5303bbc8e2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -473,10 +473,7 @@ class QMPTestCase(unittest.TestCase):
         event = self.wait_until_completed(drive=drive)
         self.assert_qmp(event, 'data/type', 'mirror')
 
-    def pause_job(self, job_id='job0'):
-        result = self.vm.qmp('block-job-pause', device=job_id)
-        self.assert_qmp(result, 'return', {})
-
+    def pause_wait(self, job_id='job0'):
         with Timeout(1, "Timeout waiting for job to pause"):
             while True:
                 result = self.vm.qmp('query-block-jobs')
@@ -484,6 +481,13 @@ class QMPTestCase(unittest.TestCase):
                     if job['device'] == job_id and job['paused'] == True and job['busy'] == False:
                         return job
 
+    def pause_job(self, job_id='job0', wait=True):
+        result = self.vm.qmp('block-job-pause', device=job_id)
+        self.assert_qmp(result, 'return', {})
+        if wait:
+            return self.pause_wait(job_id)
+        return result
+
 
 def notrun(reason):
     '''Skip this test suite'''
-- 
2.13.6
