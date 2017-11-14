Received: from eggs.gnu.org ([2001:4830:134:3::10]:53834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEex8-0005yJ-7S
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEex7-0004JG-4x
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:50 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:05 +0100
Message-Id: <20171114172417.7654-9-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 08/20] iotests: Make 030 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

This patch fixes two race conditions in 030:

1. The first is in TestENOSPC.test_enospc().  After resuming the job,
   querying it to confirm it is no longer paused may fail because in the
   meantime it might have completed already.  The same was fixed in
   TestEIO.test_ignore() already (in commit
   2c3b44da07d341557a8203cc509ea07fe3605e11).

2. The second is in TestSetSpeed.test_set_speed_invalid(): Here, a
   stream job is started on a drive without any break points, with a
   block-job-set-speed invoked subsequently.  However, without any break
   points, the job might have completed in the meantime (on tmpfs at
   least); or it might complete before cancel_and_wait() which expects
   the job to still exist.  This can be fixed like everywhere else by
   pausing the drive (installing break points) before starting the job
   and letting cancel_and_wait() resume it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171109203025.27493-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/030 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 18838948fa..457984b8e9 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -666,6 +666,7 @@ class TestENOSPC(TestErrors):
                 if event['event'] == 'BLOCK_JOB_ERROR':
                     self.assert_qmp(event, 'data/device', 'drive0')
                     self.assert_qmp(event, 'data/operation', 'read')
+                    error = True
 
                     result = self.vm.qmp('query-block-jobs')
                     self.assert_qmp(result, 'return[0]/paused', True)
@@ -676,9 +677,11 @@ class TestENOSPC(TestErrors):
                     self.assert_qmp(result, 'return', {})
 
                     result = self.vm.qmp('query-block-jobs')
+                    if result == {'return': []}:
+                        # Race; likely already finished. Check.
+                        continue
                     self.assert_qmp(result, 'return[0]/paused', False)
                     self.assert_qmp(result, 'return[0]/io-status', 'ok')
-                    error = True
                 elif event['event'] == 'BLOCK_JOB_COMPLETED':
                     self.assertTrue(error, 'job completed unexpectedly')
                     self.assert_qmp(event, 'data/type', 'stream')
@@ -792,13 +795,14 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.assert_no_active_block_jobs()
 
+        self.vm.pause_drive('drive0')
         result = self.vm.qmp('block-stream', device='drive0')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        self.cancel_and_wait()
+        self.cancel_and_wait(resume=True)
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'])
-- 
2.13.6
