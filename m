Received: from eggs.gnu.org ([2001:4830:134:3::10]:54469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRk-0002fy-Jx
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRj-0000nA-Cj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:16 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 16 Nov 2018 15:53:22 +0000
Message-Id: <20181116155325.22428-4-berrange@redhat.com>
In-Reply-To: <20181116155325.22428-1-berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] tests: pull qemu-nbd iotest helpers into
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The helpers for starting/stopping qemu-nbd in 058 will be useful in
other test cases, so move them into a common.nbd file.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/058        | 47 +++++------------------------
 tests/qemu-iotests/common.nbd | 56 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 39 deletions(-)
 create mode 100644 tests/qemu-iotests/common.nbd

diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 5eb8784669..cd73250c48 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -29,55 +29,19 @@ echo "QA output created by $seq"
 here=3D`pwd`
 status=3D1	# failure is the default!
=20
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
=20
 _export_nbd_snapshot1()
 {
-    _cleanup_nbd
-    $QEMU_NBD -v -t -k "$nbd_unix_socket" "$TEST_IMG" -l snapshot.name=3D=
$1 &
-    _wait_for_nbd
+    nbd_server_start_unix_socket "$TEST_IMG" -l snapshot.name=3D$1
 }
=20
 _cleanup()
 {
-    _cleanup_nbd
+    nbd_server_stop
     _cleanup_test_img
     rm -f "$converted_image"
 }
@@ -87,6 +51,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 . ./common.pattern
+. ./common.nbd
=20
 _supported_fmt qcow2
 _supported_proto file
@@ -95,6 +60,10 @@ _require_command QEMU_NBD
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'
=20
+nbd_snapshot_img=3D"nbd:unix:$nbd_unix_socket"
+
+converted_image=3D$TEST_IMG.converted
+
 # Use -f raw instead of -f $IMGFMT for the NBD connection
 QEMU_IO_NBD=3D"$QEMU_IO -f raw --cache=3D$CACHEMODE"
=20
diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
new file mode 100644
index 0000000000..f920a578f1
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
+    $QEMU_NBD -v -t -k "$nbd_unix_socket" $@ &
+    nbd_server_wait_for_unix_socket
+}
--=20
2.19.1
