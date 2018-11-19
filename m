Received: from eggs.gnu.org ([2001:4830:134:3::10]:51419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl2-0000Dm-Kh
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl1-0002cP-F6
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:22 -0600
Message-Id: <20181119175427.2298497-8-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/12] tests: pull qemu-nbd iotest helpers into
 common.nbd file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The helpers for starting/stopping qemu-nbd in 058 will be useful in
other test cases, so move them into a common.nbd file.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20181116155325.22428-4-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: fix shell quoting]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.nbd | 56 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/058        | 47 +++++------------------------
 2 files changed, 64 insertions(+), 39 deletions(-)
 create mode 100644 tests/qemu-iotests/common.nbd

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
new file mode 100644
index 00000000000..27357f3151d
--- /dev/null
+++ b/tests/qemu-iotests/common.nbd
@@ -0,0 +1,56 @@
+#!/bin/bash
+# -*- shell-script-mode -*-
+#
+# Helpers for NBD server related config
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
+nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
+
+function nbd_server_stop()
+{
+    local NBD_PID
+    if [ -f "$nbd_pid_file" ]; then
+        read NBD_PID < "$nbd_pid_file"
+        rm -f "$nbd_pid_file"
+        if [ -n "$NBD_PID" ]; then
+            kill "$NBD_PID"
+        fi
+    fi
+    rm -f "$nbd_unix_socket"
+}
+
+function nbd_server_wait_for_unix_socket()
+{
+    for ((i =3D 0; i < 300; i++))
+    do
+        if [ -r "$nbd_unix_socket" ]; then
+            return
+        fi
+        sleep 0.1
+    done
+    echo "Failed in check of unix socket created by qemu-nbd"
+    exit 1
+}
+
+function nbd_server_start_unix_socket()
+{
+    nbd_server_stop
+    $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
+    nbd_server_wait_for_unix_socket
+}
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 0d741a7cac2..d6d4f94d5d2 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -28,55 +28,19 @@ echo "QA output created by $seq"

 status=3D1	# failure is the default!

-nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
-nbd_snapshot_img=3D"nbd:unix:$nbd_unix_socket"
-rm -f "${TEST_DIR}/qemu-nbd.pid"
-
-_cleanup_nbd()
-{
-    local NBD_SNAPSHOT_PID
-    if [ -f "${TEST_DIR}/qemu-nbd.pid" ]; then
-        read NBD_SNAPSHOT_PID < "${TEST_DIR}/qemu-nbd.pid"
-        rm -f "${TEST_DIR}/qemu-nbd.pid"
-        if [ -n "$NBD_SNAPSHOT_PID" ]; then
-            kill "$NBD_SNAPSHOT_PID"
-        fi
-    fi
-    rm -f "$nbd_unix_socket"
-}
-
-_wait_for_nbd()
-{
-    for ((i =3D 0; i < 300; i++))
-    do
-        if [ -r "$nbd_unix_socket" ]; then
-            return
-        fi
-        sleep 0.1
-    done
-    echo "Failed in check of unix socket created by qemu-nbd"
-    exit 1
-}
-
-converted_image=3D$TEST_IMG.converted
-
 _export_nbd_snapshot()
 {
-    _cleanup_nbd
-    $QEMU_NBD -v -t -k "$nbd_unix_socket" "$TEST_IMG" -l $1 &
-    _wait_for_nbd
+    nbd_server_start_unix_socket "$TEST_IMG" -l $1
 }

 _export_nbd_snapshot1()
 {
-    _cleanup_nbd
-    $QEMU_NBD -v -t -k "$nbd_unix_socket" "$TEST_IMG" -l snapshot.name=3D=
$1 &
-    _wait_for_nbd
+    nbd_server_start_unix_socket "$TEST_IMG" -l snapshot.name=3D$1
 }

 _cleanup()
 {
-    _cleanup_nbd
+    nbd_server_stop
     _cleanup_test_img
     rm -f "$converted_image"
 }
@@ -86,6 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 . ./common.pattern
+. ./common.nbd

 _supported_fmt qcow2
 _supported_proto file
@@ -94,6 +59,10 @@ _require_command QEMU_NBD
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'

+nbd_snapshot_img=3D"nbd:unix:$nbd_unix_socket"
+
+converted_image=3D$TEST_IMG.converted
+
 # Use -f raw instead of -f $IMGFMT for the NBD connection
 QEMU_IO_NBD=3D"$QEMU_IO -f raw --cache=3D$CACHEMODE"

--=20
2.17.2
