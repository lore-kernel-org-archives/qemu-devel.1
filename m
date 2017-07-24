Received: from eggs.gnu.org ([2001:4830:134:3::10]:45565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePT-0001m0-Qf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePQ-0007C0-FX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 24 Jul 2017 16:32:10 +0200
Message-Id: <1500906730-26467-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
References: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] qemu-iotests: Avoid unnecessary sleeps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Test cases 030, 041 and 055 used to sleep for a second after calling
block-job-pause to make sure that the block job had time to actually
get into paused state. We can instead poll its status and use that one
second only as a timeout.

The tests also slept a second for checking that the block jobs don't
make progress while being paused. Half a second is more than enough for
this.

These changes reduce the total time for the three tests by 25 seconds on
my laptop (from 155 seconds to 130).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/030        |  7 ++++---
 tests/qemu-iotests/041        | 12 ++++--------
 tests/qemu-iotests/055        | 15 +++++++++------
 tests/qemu-iotests/iotests.py | 27 +++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index feee861..d745cb4 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -89,18 +89,19 @@ class TestSingleDrive(iotests.QMPTestCase):
         result = self.vm.qmp('block-job-pause', device='drive0')
         self.assert_qmp(result, 'return', {})
 
-        time.sleep(1)
+        self.vm.resume_drive('drive0')
+        self.pause_job('drive0')
+
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
 
-        time.sleep(1)
+        time.sleep(0.5)
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
         result = self.vm.qmp('block-job-resume', device='drive0')
         self.assert_qmp(result, 'return', {})
 
-        self.vm.resume_drive('drive0')
         self.wait_until_completed()
 
         self.assert_no_active_block_jobs()
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 60f09cc..4cda540 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -103,14 +103,12 @@ class TestSingleDrive(iotests.QMPTestCase):
                              target=self.qmp_target)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-job-pause', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.pause_job('drive0')
 
-        time.sleep(1)
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
 
-        time.sleep(1)
+        time.sleep(0.5)
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
@@ -896,14 +894,12 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              target=quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-job-pause', device='job0')
-        self.assert_qmp(result, 'return', {})
+        self.pause_job('job0')
 
-        time.sleep(1)
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
 
-        time.sleep(1)
+        time.sleep(0.5)
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index ba4da65..e1206ca 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -89,11 +89,12 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         self.vm.resume_drive('drive0')
-        time.sleep(1)
+        self.pause_job('drive0')
+
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
 
-        time.sleep(1)
+        time.sleep(0.5)
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
@@ -302,11 +303,12 @@ class TestSingleTransaction(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         self.vm.resume_drive('drive0')
-        time.sleep(1)
+        self.pause_job('drive0')
+
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
 
-        time.sleep(1)
+        time.sleep(0.5)
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
@@ -529,11 +531,12 @@ class TestDriveCompression(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         self.vm.resume_drive('drive0')
-        time.sleep(1)
+        self.pause_job('drive0')
+
         result = self.vm.qmp('query-block-jobs')
         offset = self.dictpath(result, 'return[0]/offset')
 
-        time.sleep(1)
+        time.sleep(0.5)
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index abcf3c1..22439c4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -27,6 +27,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
 import qtest
 import struct
 import json
+import signal
 
 
 # This will not work if arguments contain spaces but is necessary if we
@@ -137,6 +138,20 @@ def log(msg, filters=[]):
         msg = flt(msg)
     print msg
 
+class Timeout:
+    def __init__(self, seconds, errmsg = "Timeout"):
+        self.seconds = seconds
+        self.errmsg = errmsg
+    def __enter__(self):
+        signal.signal(signal.SIGALRM, self.timeout)
+        signal.setitimer(signal.ITIMER_REAL, self.seconds)
+        return self
+    def __exit__(self, type, value, traceback):
+        signal.setitimer(signal.ITIMER_REAL, 0)
+        return False
+    def timeout(self, signum, frame):
+        raise Exception(self.errmsg)
+
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
 
@@ -346,6 +361,18 @@ class QMPTestCase(unittest.TestCase):
         event = self.wait_until_completed(drive=drive)
         self.assert_qmp(event, 'data/type', 'mirror')
 
+    def pause_job(self, job_id='job0'):
+        result = self.vm.qmp('block-job-pause', device=job_id)
+        self.assert_qmp(result, 'return', {})
+
+        with Timeout(1, "Timeout waiting for job to pause"):
+            while True:
+                result = self.vm.qmp('query-block-jobs')
+                for job in result['return']:
+                    if job['device'] == job_id and job['paused'] == True and job['busy'] == False:
+                        return job
+
+
 def notrun(reason):
     '''Skip this test suite'''
     # Each test in qemu-iotests has a number ("seq")
-- 
1.8.3.1
