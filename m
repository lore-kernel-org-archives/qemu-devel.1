Received: from eggs.gnu.org ([2001:4830:134:3::10]:44519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxj2-0006zd-4J
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxj0-0005Vt-7z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:24 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:03 +0200
Message-Id: <20170711160814.20941-15-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 14/85] qcow2: add iotests to cover LUKS
 encryption support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

This extends the 087 iotest to cover LUKS encryption when doing
blockdev-add.

Two further tests are added to validate read/write of LUKS
encrypted images with a single file and with a backing file.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-15-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/087     | 35 ++++++++++++++++++-
 tests/qemu-iotests/087.out | 14 +++++++-
 tests/qemu-iotests/188     | 76 ++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/188.out | 18 ++++++++++
 tests/qemu-iotests/189     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/189.out | 26 ++++++++++++++
 tests/qemu-iotests/group   |  2 ++
 7 files changed, 255 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/188
 create mode 100644 tests/qemu-iotests/188.out
 create mode 100755 tests/qemu-iotests/189
 create mode 100644 tests/qemu-iotests/189.out

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 1d595b2..f8e4903 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -119,7 +119,7 @@ run_qemu <<EOF
 EOF
 
 echo
-echo === Encrypted image ===
+echo === Encrypted image QCow ===
 echo
 
 _make_test_img --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 $size
@@ -152,6 +152,39 @@ run_qemu <<EOF
 EOF
 
 echo
+echo === Encrypted image LUKS ===
+echo
+
+_make_test_img --object secret,id=sec0,data=123456 -o encrypt.format=luks,encrypt.key-secret=sec0 $size
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
+      "encrypt": {
+        "format": "luks",
+        "key-secret": "sec0"
+      }
+    }
+  }
+{ "execute": "quit" }
+EOF
+
+echo
 echo === Missing driver ===
 echo
 
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 69e4c3b..b1318c6 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -32,7 +32,7 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
-=== Encrypted image ===
+=== Encrypted image QCow ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
 Testing:
@@ -44,6 +44,18 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
 
+=== Encrypted image LUKS ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encrypt.format=luks encrypt.key-secret=sec0
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
 === Missing driver ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
new file mode 100755
index 0000000..83ed03e
--- /dev/null
+++ b/tests/qemu-iotests/188
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
+_make_test_img --object $SECRET -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10" $size
+
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,encrypt.key-secret=sec0"
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
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
new file mode 100644
index 0000000..8af24e5
--- /dev/null
+++ b/tests/qemu-iotests/188.out
@@ -0,0 +1,18 @@
+QA output created by 188
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
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
+*** done
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
new file mode 100755
index 0000000..54ad980
--- /dev/null
+++ b/tests/qemu-iotests/189
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
+_make_test_img --object $SECRET0 -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10" $size
+TEST_IMG=$TEST_IMG_SAVE
+
+IMGSPECBASE="driver=$IMGFMT,file.filename=$TEST_IMG_BASE,encrypt.key-secret=sec0"
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,backing.driver=$IMGFMT,backing.file.filename=$TEST_IMG_BASE,backing.encrypt.key-secret=sec0,encrypt.key-secret=sec1"
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
+_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -b "$TEST_IMG_BASE" $size
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
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
new file mode 100644
index 0000000..a0b7c9c
--- /dev/null
+++ b/tests/qemu-iotests/189.out
@@ -0,0 +1,26 @@
+QA output created by 189
+== create base ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+
+== writing whole image ==
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== create overlay ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
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
index 318ae74..613d596 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -176,3 +176,5 @@
 182 rw auto quick
 183 rw auto migration
 185 rw auto
+188 rw auto quick
+189 rw auto quick
-- 
2.9.4
