Received: from eggs.gnu.org ([2001:4830:134:3::10]:53485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2Tc-0003uh-S4
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2Tb-00005Z-SK
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:21:00 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:20:06 +0200
Message-Id: <20180813022006.7216-18-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 17/17] iotests: Add test for active mirror with
 COR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/151     | 56 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 +--
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index fe53b9f446..e5515c2d37 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -114,6 +114,62 @@ class TestActiveMirror(iotests.QMPTestCase):
     def testActiveIOFlushed(self):
         self.doActiveIO(True)
 
+    def testCOR(self):
+        # Fill the source image
+        self.vm.hmp_qemu_io('source',
+                            'write -P 1 0 %i' % self.image_len);
+
+        # Start some background requests
+        for offset in range(0, self.image_len / 2, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -P 2 %i 1M' % offset)
+
+        # Start the block job
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             filter_node_name='mirror-node',
+                             device='source-node',
+                             target='target-node',
+                             sync='full',
+                             copy_mode='write-blocking')
+        self.assert_qmp(result, 'return', {})
+
+        # Stop background request processing
+        result = self.vm.qmp('job-pause', id='mirror')
+
+        result = self.vm.qmp('blockdev-add',
+                             node_name='cor-node',
+                             driver='copy-on-read',
+                             file='mirror-node')
+        self.assert_qmp(result, 'return', {})
+
+        # Now read everything, thus synchronously copying it to the
+        # target
+        for offset in range(0, self.image_len, 1024 * 1024):
+            self.vm.hmp_qemu_io('cor-node', 'read %i 1M' % offset)
+
+        # Resuming the job should make it READY immediately, because
+        # the read requests from cor-node above should have copied
+        # everything to target already.
+        # Set the job speed to 1 before resuming it, so that we can
+        # see that the READY event really comes immediately.
+
+        result = self.vm.qmp('block-job-set-speed',
+                             device='mirror',
+                             speed=1)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('job-resume', id='mirror')
+        self.assert_qmp(result, 'return', {})
+
+        # Wait for the READY event; if we get a timeout here, reading
+        # from cor-node has failed to copy something to target
+        self.vm.event_wait(name='BLOCK_JOB_READY', timeout=5.0)
+
+        self.vm.hmp_qemu_io('source', 'aio_flush')
+        self.potential_writes_in_flight = False
+
+        self.complete_and_wait(drive='mirror', wait_ready=False)
+
 
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
index fbc63e62f8..8d7e996700 100644
--- a/tests/qemu-iotests/151.out
+++ b/tests/qemu-iotests/151.out
@@ -1,5 +1,5 @@
-..
+...
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 3 tests
 
 OK
-- 
2.17.1
