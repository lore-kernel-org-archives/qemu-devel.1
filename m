Received: from eggs.gnu.org ([209.51.188.92]:33505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGmVt-0006fn-QV
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGmVs-0002Rs-Q3
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:30:17 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 17 Apr 2019 17:30:05 +0200
Message-Id: <20190417153005.30096-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] iotests: Make 182 do without device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

182 fails if qemu has no support for hotplugging of a virtio-blk device.
Using an NBD server instead works just as well for the test, even on
qemus without hotplugging support.

Fixes: 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963
Reported-by: Danilo C. L. de Paula <ddepaula@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
To reintroduce the bug for which this test was written, revert the
following commits:

$ git revert -n \
    23dece19da41724349809873923e20a48b619cb7 \
    6ceabe6f77e4ae5ac2fa3d2ac1be11dc95021941 \
    a6aeca0ca530f104b5a5dd6704fca22b2c5edefa \
    577a133988c76e4ebf01d050d0d758d207a1baf7
---
 tests/qemu-iotests/182     | 22 +++++++++++++++++-----
 tests/qemu-iotests/182.out |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index ff3d7e7ec1..38959bf276 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -31,6 +31,7 @@ _cleanup()
 {
     _cleanup_test_img
     rm -f "$TEST_IMG.overlay"
+    rm -f "$TEST_DIR/nbd.socket"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -126,15 +127,26 @@ success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE =
\
     'return' \
     'error'
=20
-# Now we attach the image to a virtio-blk device.  This device does
-# require some permissions (at least WRITE and READ_CONSISTENT), so if
+# Start an NBD server to which we can attach node1
+success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'nbd-server-start',
+      'arguments': {
+          'addr': {
+              'type': 'unix',
+              'data': {
+                  'path': '$TEST_DIR/nbd.socket'
+              } } } }" \
+    'return' \
+    'error'
+
+# Now we attach the image to the NBD server.  This server does require
+# some permissions (at least WRITE and READ_CONSISTENT), so if
 # reopening node0 unshared any (which it should not have), this will
 # fail (but it should not).
 success_or_failure=3Dy _send_qemu_cmd $QEMU_HANDLE \
-    "{'execute': 'device_add',
+    "{'execute': 'nbd-server-add',
       'arguments': {
-          'driver': 'virtio-blk',
-          'drive': 'node1'
+          'device': 'node1'
       } }" \
     'return' \
     'error'
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index af501ca3f3..33d41eea91 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -14,4 +14,5 @@ Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=
=3D197120 backing_file=3DTEST_D
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"return": {}}
 *** done
--=20
2.20.1
