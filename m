Received: from eggs.gnu.org ([2001:4830:134:3::10]:46974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZL-0001ZW-BE
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZF-0007F4-DB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:44 +0100
Message-Id: <20181119142944.29061-10-kwolf@redhat.com>
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] iotests: Test file-posix locking and reopen
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/182     | 71 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/182.out |  9 +++++
 2 files changed, 80 insertions(+)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 4b31592fb8..3b7689c1d5 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -31,6 +31,7 @@ status=3D1	# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    rm -f "$TEST_IMG.overlay"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -71,6 +72,76 @@ echo 'quit' | $QEMU -nographic -monitor stdio \
=20
 _cleanup_qemu
=20
+echo
+echo '=3D=3D=3D Testing reopen =3D=3D=3D'
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
+success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
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
+success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
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
+success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
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
+success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
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
 QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddrive0,file.loc=
king=3Don: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
+
+=3D=3D=3D Testing reopen =3D=3D=3D
+
+{"return": {}}
+{"return": {}}
+Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=3D197120 backing=
_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile cluster_size=3D65536 lazy_ref=
counts=3Doff refcount_bits=3D16
+{"return": {}}
+{"return": {}}
+{"return": {}}
 *** done
--=20
2.19.1
