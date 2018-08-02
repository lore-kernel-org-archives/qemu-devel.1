Received: from eggs.gnu.org ([2001:4830:134:3::10]:36401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuF-0002Fi-0l
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEuD-000058-9M
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:47 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  2 Aug 2018 09:48:33 -0500
Message-Id: <20180802144834.520904-4-eblake@redhat.com>
In-Reply-To: <20180802144834.520904-1-eblake@redhat.com>
References: <20180802144834.520904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] iotests: Add 228 to test NBD on unaligned
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Add a test for the NBD server fix in the previous patch.  In
short, when serving a raw POSIX file that is not aligned to
sector boundaries, qemu must not split a structured read or
block status result any smaller than the block size that it
advertised to the client; since qemu as client rejects servers
that split up a block status.

Not tested yet, but worth adding to this test: an NBD server
that can advertise a non-sector-aligned size (such as nbdkit)
causes qemu as the NBD client to misbehave when it rounds the
size up and accesses beyond the advertised size. Qemu as NBD
server never advertises a non-sector-aligned size (since
bdrv_getlength() currently rounds up to sector boundaries);
until qemu can act as such a server, testing this flaw will
have to rely on external binaries.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/228     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/228.out |  8 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/qemu-iotests/228
 create mode 100644 tests/qemu-iotests/228.out

diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
new file mode 100755
index 00000000000..390fe5f6512
--- /dev/null
+++ b/tests/qemu-iotests/228
@@ -0,0 +1,96 @@
+#!/bin/bash
+#
+# Test qemu-nbd vs. unaligned images
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+status=1 # failure is the default!
+
+nbd_unix_socket=$TEST_DIR/test_qemu_nbd_socket
+rm -f "${TEST_DIR}/qemu-nbd.pid"
+
+_cleanup_nbd()
+{
+    local NBD_PID
+    if [ -f "${TEST_DIR}/qemu-nbd.pid" ]; then
+        read NBD_PID < "${TEST_DIR}/qemu-nbd.pid"
+        rm -f "${TEST_DIR}/qemu-nbd.pid"
+        if [ -n "$NBD_PID" ]; then
+            kill "$NBD_PID"
+        fi
+    fi
+    rm -f "$nbd_unix_socket"
+}
+
+_wait_for_nbd()
+{
+    for ((i = 0; i < 300; i++))
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
+_cleanup()
+{
+    _cleanup_test_img
+    _cleanup_nbd
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw
+_supported_proto nbd
+_supported_os Linux
+_require_command QEMU_NBD
+
+echo
+echo "=== Exporting unaligned raw image ==="
+echo
+
+# can't use _make_test_img, because qemu-img rounds image size up,
+# and because we want to use Unix socket rather than TCP port. Likewise,
+# we have to redirect TEST_IMG to our server.
+printf %01000d 0 > "$TEST_IMG_FILE"
+_cleanup_nbd
+$QEMU_NBD -f $IMGFMT -v -t -k "$nbd_unix_socket" -e 42 -x '' "$TEST_IMG_FILE" &
+_wait_for_nbd
+TEST_IMG="nbd:unix:$nbd_unix_socket"
+
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IO -c map "$TEST_IMG"
+
+# Not tested yet: we also want to ensure that qemu as NBD client does
+# not access beyond the end of a server's advertised unaligned size.
+# However, since qemu as server always rounds up to a sector alignment,
+# we would have to use nbdkit to provoke the current client failures.
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
new file mode 100644
index 00000000000..057e3732f8c
--- /dev/null
+++ b/tests/qemu-iotests/228.out
@@ -0,0 +1,8 @@
+QA output created by 228
+
+=== Exporting unaligned raw image ===
+
+[{ "start": 0, "length": 1000, "depth": 0, "zero": false, "data": true},
+{ "start": 1000, "length": 24, "depth": 0, "zero": true, "data": true}]
+1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b973dc842d9..5bfe2e246d5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -225,3 +225,4 @@
 225 rw auto quick
 226 auto quick
 227 auto quick
+228 rw auto quick
-- 
2.14.4
