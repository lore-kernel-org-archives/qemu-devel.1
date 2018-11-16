Received: from eggs.gnu.org ([2001:4830:134:3::10]:54204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNgRL-0002JI-Pr
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNgRE-0000b4-A0
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:49 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 16 Nov 2018 16:53:02 +0100
Message-Id: <20181116155302.22472-4-mreitz@redhat.com>
In-Reply-To: <20181116155302.22472-1-mreitz@redhat.com>
References: <20181116155302.22472-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1? 3/3] iotests: Test file-posix locking
 and reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/182     | 71 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/182.out |  9 +++++
 2 files changed, 80 insertions(+)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 4b31592fb8..3b7689c1d5 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -31,6 +31,7 @@ status=1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    rm -f "$TEST_IMG.overlay"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -71,6 +72,76 @@ echo 'quit' | $QEMU -nographic -monitor stdio \
 
 _cleanup_qemu
 
+echo
+echo '=== Testing reopen ==='
+echo
+
+# This tests that reopening does not unshare any permissions it should
+# not unshare
+# (There was a bug where reopening shared exactly the opposite of the
+# permissions it was supposed to share)
+
+_launch_qemu
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'qmp_capabilities'}" \
+    'return'
+
+# Open the image without any format layer (we are not going to access
+# it, so that is fine)
+# This should keep all permissions shared.
+success_or_failure=y _send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-add',
+      'arguments': {
+          'node-name': 'node0',
+          'driver': 'file',
+          'filename': '$TEST_IMG',
+          'locking': 'on'
+          } }" \
+    'return' \
+    'error'
+
+# This snapshot will perform a reopen to drop R/W to RO.
+# It should still keep all permissions shared.
+success_or_failure=y _send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-snapshot-sync',
+      'arguments': {
+          'node-name': 'node0',
+          'snapshot-file': '$TEST_IMG.overlay',
+          'snapshot-node-name': 'node1'
+      } }" \
+    'return' \
+    'error'
+
+# Now open the same file again
+# This does not require any permissions (and does not unshare any), so
+# this will not conflict with node0.
+success_or_failure=y _send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-add',
+      'arguments': {
+          'node-name': 'node1',
+          'driver': 'file',
+          'filename': '$TEST_IMG',
+          'locking': 'on'
+          } }" \
+    'return' \
+    'error'
+
+# Now we attach the image to a virtio-blk device.  This device does
+# require some permissions (at least WRITE and READ_CONSISTENT), so if
+# reopening node0 unshared any (which it should not have), this will
+# fail (but it should not).
+success_or_failure=y _send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'device_add',
+      'arguments': {
+          'driver': 'virtio-blk',
+          'drive': 'node1'
+      } }" \
+    'return' \
+    'error'
+
+_cleanup_qemu
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index f1463c8862..af501ca3f3 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -5,4 +5,13 @@ Starting QEMU
 Starting a second QEMU using the same image should fail
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
+
+=== Testing reopen ===
+
+{"return": {}}
+{"return": {}}
+Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 size=197120 backing_file=TEST_DIR/t.qcow2 backing_fmt=file cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{"return": {}}
+{"return": {}}
+{"return": {}}
 *** done
-- 
2.17.2
