Received: from eggs.gnu.org ([209.51.188.92]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F6C-0000W9-KC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F68-00015r-JX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:19 +0100
Message-Id: <20190308125823.32535-30-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/33] qemu-iotests: General tests for qcow2
 with external data file
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/244     | 200 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/244.out | 125 +++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 326 insertions(+)
 create mode 100755 tests/qemu-iotests/244
 create mode 100644 tests/qemu-iotests/244.out

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
new file mode 100755
index 0000000000..d8e7122305
--- /dev/null
+++ b/tests/qemu-iotests/244
@@ -0,0 +1,200 @@
+#!/bin/bash
+#
+# Test qcow2 with external data files
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+# creator
+owner=3Dkwolf@redhat.com
+
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f $TEST_IMG.data
+    rm -f $TEST_IMG.src
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "=3D=3D=3D Create and open image with external data file =3D=3D=3D"
+echo
+
+echo "With data file name in the image:"
+IMGOPTS=3D"data_file=3D$TEST_IMG.data" _make_test_img 64M
+_check_test_img
+
+$QEMU_IO -c "open $TEST_IMG" -c "read -P 0 0 64k" 2>&1 | _filter_qemu_io=
 | _filter_testdir
+$QEMU_IO -c "open -odata-file.filename=3D$TEST_IMG.data $TEST_IMG" -c "r=
ead -P 0 0 64k" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -c "open -odata-file.filename=3Dinexistent $TEST_IMG" -c "read =
-P 0 0 64k" 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "Data file required, but without data file name in the image:"
+$QEMU_IMG amend -odata_file=3D $TEST_IMG
+
+$QEMU_IO -c "open $TEST_IMG" -c "read -P 0 0 64k" 2>&1 | _filter_qemu_io=
 | _filter_testdir
+$QEMU_IO -c "open -odata-file.filename=3D$TEST_IMG.data $TEST_IMG" -c "r=
ead -P 0 0 64k" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -c "open -odata-file.filename=3Dinexistent $TEST_IMG" -c "read =
-P 0 0 64k" 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "Setting data-file for an image with internal data:"
+_make_test_img 64M
+
+$QEMU_IO -c "open -odata-file.filename=3D$TEST_IMG.data $TEST_IMG" -c "r=
ead -P 0 0 64k" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -c "open -odata-file.filename=3Dinexistent $TEST_IMG" -c "read =
-P 0 0 64k" 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "=3D=3D=3D Conflicting features =3D=3D=3D"
+echo
+
+echo "Convert to compressed target with data file:"
+TEST_IMG=3D"$TEST_IMG.src" _make_test_img 64M
+
+$QEMU_IO -c 'write -P 0x11 0 1M' \
+         -f $IMGFMT "$TEST_IMG.src" |
+         _filter_qemu_io
+
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -c -odata_file=3D"$TEST_IMG.data=
" \
+    "$TEST_IMG.src" "$TEST_IMG"
+
+echo
+echo "Convert uncompressed, then write compressed data manually:"
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -odata_file=3D"$TEST_IMG.data" \
+    "$TEST_IMG.src" "$TEST_IMG"
+$QEMU_IMG compare "$TEST_IMG.src" "$TEST_IMG"
+
+$QEMU_IO -c 'write -c -P 0x22 0 1M' \
+         -f $IMGFMT "$TEST_IMG" |
+         _filter_qemu_io
+_check_test_img
+
+echo
+echo "Take an internal snapshot:"
+
+$QEMU_IMG snapshot -c test "$TEST_IMG"
+_check_test_img
+
+echo
+echo "=3D=3D=3D Standalone image with external data file (efficient) =3D=
=3D=3D"
+echo
+
+IMGOPTS=3D"data_file=3D$TEST_IMG.data" _make_test_img 64M
+
+echo -n "qcow2 file size before I/O: "
+du -b $TEST_IMG | cut -f1
+
+# Create image with the following layout
+# 0-1 MB: Unallocated
+# 1-2 MB: Written (pattern 0x11)
+# 2-3 MB: Discarded
+# 3-4 MB: Zero write over discarded space
+# 4-5 MB: Zero write over written space
+# 5-6 MB: Zero write over unallocated space
+
+echo
+$QEMU_IO -c 'write -P 0x11 1M 4M' \
+         -c 'discard 2M 2M' \
+         -c 'write -z 3M 3M' \
+         -f $IMGFMT "$TEST_IMG" |
+         _filter_qemu_io
+_check_test_img
+
+echo
+$QEMU_IMG map --output=3Djson "$TEST_IMG"
+
+echo
+$QEMU_IO -c 'read -P 0 0 1M' \
+         -c 'read -P 0x11 1M 1M' \
+         -c 'read -P 0 2M 4M' \
+         -f $IMGFMT "$TEST_IMG" |
+         _filter_qemu_io
+
+# Zero clusters are only marked as such in the qcow2 metadata, but conta=
in
+# stale data in the external data file
+echo
+$QEMU_IO -c 'read -P 0 0 1M' \
+         -c 'read -P 0x11 1M 1M' \
+         -c 'read -P 0 2M 2M' \
+         -c 'read -P 0x11 4M 1M' \
+         -c 'read -P 0 5M 1M' \
+         -f raw "$TEST_IMG.data" |
+         _filter_qemu_io
+
+
+echo -n "qcow2 file size after I/O: "
+du -b $TEST_IMG | cut -f1
+
+echo
+echo "=3D=3D=3D Standalone image with external data file (valid raw) =3D=
=3D=3D"
+echo
+
+IMGOPTS=3D"data_file=3D$TEST_IMG.data,data_file_raw=3Don" _make_test_img=
 64M
+
+echo -n "qcow2 file size before I/O: "
+du -b $TEST_IMG | cut -f1
+
+echo
+$QEMU_IO -c 'write -P 0x11 1M 4M' \
+         -c 'discard 2M 2M' \
+         -c 'write -z 3M 3M' \
+         -f $IMGFMT "$TEST_IMG" |
+         _filter_qemu_io
+_check_test_img
+
+echo
+$QEMU_IMG map --output=3Djson "$TEST_IMG"
+
+echo
+$QEMU_IO -c 'read -P 0 0 1M' \
+         -c 'read -P 0x11 1M 1M' \
+         -c 'read -P 0 2M 4M' \
+         -f $IMGFMT "$TEST_IMG" |
+         _filter_qemu_io
+
+echo
+$QEMU_IMG compare "$TEST_IMG" "$TEST_IMG.data"
+
+echo -n "qcow2 file size after I/O: "
+du -b $TEST_IMG | cut -f1
+
+echo
+echo "=3D=3D=3D bdrv_co_block_status test for file and offset=3D0 =3D=3D=
=3D"
+echo
+
+IMGOPTS=3D"data_file=3D$TEST_IMG.data" _make_test_img 64M
+
+$QEMU_IO -c 'write -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_i=
o
+$QEMU_IO -c 'read -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=3Dhuman "$TEST_IMG" | _filter_testdir
+$QEMU_IMG map --output=3Djson "$TEST_IMG"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
new file mode 100644
index 0000000000..98e5946976
--- /dev/null
+++ b/tests/qemu-iotests/244.out
@@ -0,0 +1,125 @@
+QA output created by 244
+
+=3D=3D=3D Create and open image with external data file =3D=3D=3D
+
+With data file name in the image:
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data
+No errors were found on the image.
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such=
 file or directory
+no file open, try 'help open'
+
+Data file required, but without data file name in the image:
+can't open device TEST_DIR/t.qcow2: 'data-file' is required for this ima=
ge
+no file open, try 'help open'
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such=
 file or directory
+no file open, try 'help open'
+
+Setting data-file for an image with internal data:
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+can't open device TEST_DIR/t.qcow2: 'data-file' can only be set for imag=
es with an external data file
+no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such=
 file or directory
+no file open, try 'help open'
+
+=3D=3D=3D Conflicting features =3D=3D=3D
+
+Convert to compressed target with data file:
+Formatting 'TEST_DIR/t.IMGFMT.src', fmt=3DIMGFMT size=3D67108864
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: error while writing sector 0: Operation not supported
+
+Convert uncompressed, then write compressed data manually:
+Images are identical.
+write failed: Operation not supported
+No errors were found on the image.
+
+Take an internal snapshot:
+qemu-img: Could not create snapshot 'test': -95 (Operation not supported=
)
+No errors were found on the image.
+
+=3D=3D=3D Standalone image with external data file (efficient) =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data
+qcow2 file size before I/O: 196616
+
+wrote 4194304/4194304 bytes at offset 1048576
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 2097152/2097152 bytes at offset 2097152
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 3145728/3145728 bytes at offset 3145728
+3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fals=
e},
+{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false, "data"=
: true, "offset": 1048576},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": true, "data":=
 false},
+{ "start": 4194304, "length": 1048576, "depth": 0, "zero": true, "data":=
 false, "offset": 4194304},
+{ "start": 5242880, "length": 61865984, "depth": 0, "zero": true, "data"=
: false}]
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 2097152
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2097152/2097152 bytes at offset 2097152
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 4194304
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 5242880
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qcow2 file size after I/O: 327680
+
+=3D=3D=3D Standalone image with external data file (valid raw) =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data data_file_raw=3Don
+qcow2 file size before I/O: 196616
+
+wrote 4194304/4194304 bytes at offset 1048576
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 2097152/2097152 bytes at offset 2097152
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 3145728/3145728 bytes at offset 3145728
+3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fals=
e},
+{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false, "data"=
: true, "offset": 1048576},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": true, "data":=
 false},
+{ "start": 4194304, "length": 1048576, "depth": 0, "zero": true, "data":=
 false, "offset": 4194304},
+{ "start": 5242880, "length": 61865984, "depth": 0, "zero": true, "data"=
: false}]
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 2097152
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Images are identical.
+qcow2 file size after I/O: 327680
+
+=3D=3D=3D bdrv_co_block_status test for file and offset=3D0 =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3D=
TEST_DIR/t.IMGFMT.data
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          Mapped to       File
+0               0x100000        0               TEST_DIR/t.qcow2.data
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": tru=
e, "offset": 0},
+{ "start": 1048576, "length": 66060288, "depth": 0, "zero": true, "data"=
: false}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 03aa93dbf5..36100b803c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -242,3 +242,4 @@
 240 auto quick
 242 rw auto quick
 243 rw auto quick
+244 rw auto quick
--=20
2.20.1
