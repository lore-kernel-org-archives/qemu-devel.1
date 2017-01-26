Received: from eggs.gnu.org ([2001:4830:134:3::10]:45764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9I-0001vh-0w
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9G-0006IV-7B
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:23 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:23 +0000
Message-Id: <20170126101827.22378-15-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/18] qcow2: add iotests to cover LUKS
 encryption support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This extends the 087 iotest to cover LUKS encryption when doing
blockdev-add.

Two further tests are added to validate read/write of LUKS
encrypted images with a single file and with a backing file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/087     | 32 ++++++++++++++++-
 tests/qemu-iotests/087.out | 14 +++++++-
 tests/qemu-iotests/174     | 76 ++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/174.out | 19 ++++++++++
 tests/qemu-iotests/175     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/175.out | 26 ++++++++++++++
 tests/qemu-iotests/group   |  2 ++
 7 files changed, 253 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/174
 create mode 100644 tests/qemu-iotests/174.out
 create mode 100755 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 55a9e06..1c3ca9f 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -121,7 +121,7 @@ run_qemu <<EOF
 EOF
 
 echo
-echo === Encrypted image ===
+echo === Encrypted image QCow ===
 echo
 
 _make_test_img --object secret,id=sec0,data=123456 -o encryption=on,aes-key-secret=sec0 $size
@@ -151,6 +151,36 @@ run_qemu <<EOF
 EOF
 
 echo
+echo === Encrypted image LUKS ===
+echo
+
+_make_test_img --object secret,id=sec0,data=123456 -o encryption-format=luks,luks-key-secret=sec0 $size
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "object-add",
+  "arguments": {
+      "qom-type": "secret",
+      "id": "sec0",
+      "props": {
+          "data": "123456"
+      }
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "node-name": "disk",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "luks-key-secret": "sec0"
+    }
+  }
+{ "execute": "quit" }
+EOF
+
+echo
 echo === Missing driver ===
 echo
 
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 8a08d06..c609c3c 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -32,7 +32,7 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
 
 
-=== Encrypted image ===
+=== Encrypted image QCow ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on aes-key-secret=sec0
 Testing:
@@ -44,6 +44,18 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
 
 
+=== Encrypted image LUKS ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption-format=luks luks-key-secret=sec0
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+
+
 === Missing driver ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on aes-key-secret=sec0
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
new file mode 100755
index 0000000..bb12b55
--- /dev/null
+++ b/tests/qemu-iotests/174
@@ -0,0 +1,76 @@
+#!/bin/bash
+#
+# Test encrypted read/write using plain bdrv_read/bdrv_write
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+owner=berrange@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+
+size=16M
+
+SECRET="secret,id=sec0,data=astrochicken"
+SECRETALT="secret,id=sec0,data=platypus"
+
+_make_test_img --object $SECRET -o "encryption-format=luks,luks-key-secret=sec0,luks-iter-time=10" $size
+
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,luks-key-secret=sec0"
+
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "== reading whole image =="
+$QEMU_IO --object $SECRET -c "read -P 0 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== rewriting whole image =="
+$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size"  --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify open failure with wrong password =="
+$QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/174.out b/tests/qemu-iotests/174.out
new file mode 100644
index 0000000..bf1a23a
--- /dev/null
+++ b/tests/qemu-iotests/174.out
@@ -0,0 +1,19 @@
+QA output created by 174
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 encryption-format=luks luks-key-secret=sec0 luks-iter-time=10
+
+== reading whole image ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== rewriting whole image ==
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify open failure with wrong password ==
+can't open: Invalid password, cannot unlock any keyslot
+no file open, try 'help open'
+*** done
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
new file mode 100755
index 0000000..9dd03d5
--- /dev/null
+++ b/tests/qemu-iotests/175
@@ -0,0 +1,86 @@
+#!/bin/bash
+#
+# Test encrypted read/write using backing files
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+owner=berrange@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+
+size=16M
+TEST_IMG_BASE=$TEST_IMG.base
+SECRET0="secret,id=sec0,data=astrochicken"
+SECRET1="secret,id=sec1,data=furby"
+
+TEST_IMG_SAVE=$TEST_IMG
+TEST_IMG=$TEST_IMG_BASE
+echo "== create base =="
+_make_test_img --object $SECRET0 -o "encryption-format=luks,luks-key-secret=sec0,luks-iter-time=10" $size
+TEST_IMG=$TEST_IMG_SAVE
+
+IMGSPECBASE="driver=$IMGFMT,file.filename=$TEST_IMG_BASE,luks-key-secret=sec0"
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,backing.driver=$IMGFMT,backing.file.filename=$TEST_IMG_BASE,backing.luks-key-secret=sec0,luks-key-secret=sec1"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "== writing whole image =="
+$QEMU_IO --object $SECRET0 -c "write -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET0 -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
+
+echo "== create overlay =="
+_make_test_img --object $SECRET1 -o "encryption-format=luks,luks-key-secret=sec1,luks-iter-time=10" -b "$TEST_IMG_BASE" $size
+
+echo
+echo "== writing part of a cluster =="
+$QEMU_IO --object $SECRET0 --object $SECRET1 -c "write -P 0xe 0 1024" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0xe 0 1024" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0xa 1024 64512" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
new file mode 100644
index 0000000..1925eec
--- /dev/null
+++ b/tests/qemu-iotests/175.out
@@ -0,0 +1,26 @@
+QA output created by 175
+== create base ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encryption-format=luks luks-key-secret=sec0 luks-iter-time=10
+
+== writing whole image ==
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== create overlay ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encryption-format=luks luks-key-secret=sec1 luks-iter-time=10
+
+== writing part of a cluster ==
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 64512/64512 bytes at offset 1024
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f5d7bc8..dd510d0 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -166,3 +166,5 @@
 171 rw auto quick
 172 auto
 173 rw auto backing
+174 rw auto quick
+175 rw auto quick
-- 
2.9.3
