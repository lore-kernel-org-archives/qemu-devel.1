Received: from eggs.gnu.org ([209.51.188.92]:46010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcs-0002B8-2x
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxco-0004wP-JT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:56 -0500
Message-Id: <20190401140903.19186-8-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] iotests: Add 241 to test NBD on unaligned
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Add a test for the NBD client workaround in the previous patch.  It's
not really feasible for an iotest to assume a specific tracing engine,
so we can't really probe trace_nbd_parse_blockstatus_compliance to see
if the server was fixed vs. whether the client just worked around the
server (other than by rearranging order between code patches and this
test). But having a successful exchange sure beats the previous state
of an error message. Since format probing can change alignment, we can
use that as an easy way to test several configurations.

Not tested yet, but worth adding to this test in future patches: an
NBD server that can advertise a non-sector-aligned size (such as
nbdkit) causes qemu as the NBD client to misbehave when it rounds the
size up and accesses beyond the advertised size. Qemu as NBD server
never advertises a non-sector-aligned size (since bdrv_getlength()
currently rounds up to sector boundaries); until qemu can act as such
a server, testing that flaw will have to rely on external binaries.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190329042750.14704-2-eblake@redhat.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: add forced-512 alignment, and nbdkit reproducer comment]
---
 tests/qemu-iotests/241     | 100 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/241.out |  26 ++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 127 insertions(+)
 create mode 100755 tests/qemu-iotests/241
 create mode 100644 tests/qemu-iotests/241.out

diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
new file mode 100755
index 00000000000..4b196857387
--- /dev/null
+++ b/tests/qemu-iotests/241
@@ -0,0 +1,100 @@
+#!/bin/bash
+#
+# Test qemu-nbd vs. unaligned images
+#
+# Copyright (C) 2018-2019 Red Hat, Inc.
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
+seq=3D"$(basename $0)"
+echo "QA output created by $seq"
+
+status=3D1 # failure is the default!
+
+nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
+
+_cleanup()
+{
+    _cleanup_test_img
+    nbd_server_stop
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.nbd
+
+_supported_fmt raw
+_supported_proto nbd
+_supported_os Linux
+_require_command QEMU_NBD
+
+# can't use _make_test_img, because qemu-img rounds image size up,
+# and because we want to use Unix socket rather than TCP port. Likewise,
+# we have to redirect TEST_IMG to our server.
+# This tests that we can deal with the hole at the end of an unaligned
+# raw file (either because the server doesn't advertise alignment too
+# large, or because the client ignores the server's noncompliance - even
+# though we can't actually wire iotests into checking trace messages).
+printf %01000d 0 > "$TEST_IMG_FILE"
+TEST_IMG=3D"nbd:unix:$nbd_unix_socket"
+
+echo
+echo "=3D=3D=3D Exporting unaligned raw image, natural alignment =3D=3D=3D=
"
+echo
+
+nbd_server_start_unix_socket -f $IMGFMT "$TEST_IMG_FILE"
+
+$QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
+$QEMU_IMG map -f raw --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IO -f raw -c map "$TEST_IMG"
+nbd_server_stop
+
+echo
+echo "=3D=3D=3D Exporting unaligned raw image, forced server sector alig=
nment =3D=3D=3D"
+echo
+
+# Intentionally omit '-f' to force image probing, which in turn forces
+# sector alignment, here at the server.
+nbd_server_start_unix_socket "$TEST_IMG_FILE"
+
+$QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
+$QEMU_IMG map -f raw --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IO -f raw -c map "$TEST_IMG"
+nbd_server_stop
+
+echo
+echo "=3D=3D=3D Exporting unaligned raw image, forced client sector alig=
nment =3D=3D=3D"
+echo
+
+# Now force sector alignment at the client.
+nbd_server_start_unix_socket -f $IMGFMT "$TEST_IMG_FILE"
+
+$QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
+$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IO -c map "$TEST_IMG"
+nbd_server_stop
+
+# Not tested yet: we also want to ensure that qemu as NBD client does
+# not access beyond the end of a server's advertised unaligned size:
+#  nbdkit -U - memory size=3D513 --run 'qemu-io -f raw -c "r 512 512" $n=
bd'
+# However, since qemu as server always rounds up to a sector alignment,
+# we would have to use nbdkit to provoke the current client failures.
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
new file mode 100644
index 00000000000..b76a6234d72
--- /dev/null
+++ b/tests/qemu-iotests/241.out
@@ -0,0 +1,26 @@
+QA output created by 241
+
+=3D=3D=3D Exporting unaligned raw image, natural alignment =3D=3D=3D
+
+  size:  1024
+  min block: 512
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true}]
+1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+
+=3D=3D=3D Exporting unaligned raw image, forced server sector alignment =
=3D=3D=3D
+
+WARNING: Image format was not specified for '/home/eblake/qemu/tests/qem=
u-iotests/scratch/t.raw' and probing guessed raw.
+         Automatically detecting the format is dangerous for raw images,=
 write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
+  size:  1024
+  min block: 512
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true}]
+1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+
+=3D=3D=3D Exporting unaligned raw image, forced client sector alignment =
=3D=3D=3D
+
+  size:  1024
+  min block: 512
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true}]
+1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 41da10c6cf5..bae77183809 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -240,6 +240,7 @@
 238 auto quick
 239 rw auto quick
 240 auto quick
+241 rw auto quick
 242 rw auto quick
 243 rw auto quick
 244 rw auto quick
--=20
2.20.1
