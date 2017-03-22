Received: from eggs.gnu.org ([2001:4830:134:3::10]:51677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfNc-0001Lv-HY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfNZ-0004I1-91
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cqfNY-0004Hi-VL
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Mar 2017 11:16:08 +0000
Message-Id: <20170322111608.31230-9-stefanha@redhat.com>
In-Reply-To: <20170322111608.31230-1-stefanha@redhat.com>
References: <20170322111608.31230-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 8/8] iotests: add test 178 for qemu-img
 measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/178           | 144 +++++++++++++++++++++++
 tests/qemu-iotests/178.out.qcow2 | 242 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/178.out.raw   | 130 +++++++++++++++++++++
 tests/qemu-iotests/group         |   1 +
 4 files changed, 517 insertions(+)
 create mode 100755 tests/qemu-iotests/178
 create mode 100644 tests/qemu-iotests/178.out.qcow2
 create mode 100644 tests/qemu-iotests/178.out.raw

diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
new file mode 100755
index 0000000..b777870
--- /dev/null
+++ b/tests/qemu-iotests/178
@@ -0,0 +1,144 @@
+#!/bin/bash
+#
+# qemu-img measure sub-command tests
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
+owner=stefanha@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+_supported_fmt raw qcow2
+_supported_proto file
+_supported_os Linux
+
+echo "== Input validation =="
+echo
+
+_make_test_img 1G
+
+$QEMU_IMG measure # missing arguments
+$QEMU_IMG measure --size 2G "$TEST_IMG" # only one allowed
+$QEMU_IMG measure "$TEST_IMG" a # only one filename allowed
+$QEMU_IMG measure --object secret,id=sec0,data=MTIzNDU2,format=base64 # missing filename
+$QEMU_IMG measure --image-opts # missing filename
+$QEMU_IMG measure -f qcow2 # missing filename
+$QEMU_IMG measure -l snap1 # missing filename
+$QEMU_IMG measure -o , # invalid option list
+$QEMU_IMG measure -l snapshot.foo # invalid snapshot option
+$QEMU_IMG measure --output foo # invalid output format
+$QEMU_IMG measure --size -1 # invalid image size
+$QEMU_IMG measure -O foo "$TEST_IMG" # unknown image file format
+
+make_test_img_with_fmt() {
+    # Shadow global variables within this function
+    local IMGFMT="$1" IMGOPTS=""
+    _make_test_img "$2"
+}
+
+qemu_io_with_fmt() {
+    # Shadow global variables within this function
+    local QEMU_IO_OPTIONS=$(echo "$QEMU_IO_OPTIONS" | sed "s/-f $IMGFMT/-f $1/")
+    shift
+    $QEMU_IO "$@"
+}
+
+for ofmt in human json; do
+    echo
+    echo "== Size calculation for a new file ($ofmt) =="
+    echo
+
+    # Try a few interesting sizes
+    $QEMU_IMG measure --output=$ofmt -O "$IMGFMT" --size 0
+    $QEMU_IMG measure --output=$ofmt -O "$IMGFMT" --size 2G
+    $QEMU_IMG measure --output=$ofmt -O "$IMGFMT" --size 64G
+    $QEMU_IMG measure --output=$ofmt -O "$IMGFMT" --size 256G
+    $QEMU_IMG measure --output=$ofmt -O "$IMGFMT" --size 1T
+
+    # Always test the raw input files but also IMGFMT
+    for fmt in $(echo -e "raw\n$IMGFMT\n" | sort -u); do
+        echo
+        echo "== Empty $fmt input image ($ofmt) =="
+        echo
+        make_test_img_with_fmt "$fmt" 0
+        $QEMU_IMG measure --output=$ofmt -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
+
+        echo
+        echo "== $fmt input image with data ($ofmt) =="
+        echo
+        make_test_img_with_fmt "$fmt" 1G
+        $QEMU_IMG measure --output=$ofmt -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
+        qemu_io_with_fmt "$fmt" -c "write 512 512" "$TEST_IMG" | _filter_qemu_io
+        qemu_io_with_fmt "$fmt" -c "write 64K 64K" "$TEST_IMG" | _filter_qemu_io
+        if [ "$fmt" = "qcow2" ]; then
+            $QEMU_IMG snapshot -c snapshot1 "$TEST_IMG"
+        fi
+        qemu_io_with_fmt "$fmt" -c "write 128M 63K" "$TEST_IMG" | _filter_qemu_io
+        $QEMU_IMG measure --output=$ofmt -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
+
+        if [ "$fmt" = "qcow2" ]; then
+            echo
+            echo "== $fmt input image with internal snapshot ($ofmt) =="
+            echo
+            $QEMU_IMG measure --output=$ofmt -f "$fmt" -l snapshot1 \
+                              -O "$IMGFMT" "$TEST_IMG"
+        fi
+
+        if [ "$IMGFMT" = "qcow2" ]; then
+            echo
+            echo "== $fmt input image and a backing file ($ofmt) =="
+            echo
+            # The backing file doesn't need to exist :)
+            $QEMU_IMG measure --output=$ofmt -o backing_file=x \
+                              -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
+        fi
+
+        echo
+        echo "== $fmt input image and preallocation ($ofmt) =="
+        echo
+        $QEMU_IMG measure --output=$ofmt -o preallocation=full \
+                          -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
+
+        echo
+        echo "== Fully-allocated $fmt input image ($ofmt) =="
+        echo
+        make_test_img_with_fmt "$fmt" 8M
+        qemu_io_with_fmt "$fmt" -c "write 0 8M" "$TEST_IMG" | _filter_qemu_io
+        $QEMU_IMG measure --output=$ofmt -f "$fmt" -O "$IMGFMT" "$TEST_IMG"
+    done
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
new file mode 100644
index 0000000..3e217c8
--- /dev/null
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -0,0 +1,242 @@
+QA output created by 178
+== Input validation ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+qemu-img: Either --size N or one filename must be specified.
+qemu-img: --size N cannot be used together with a filename.
+qemu-img: At most one filename argument is allowed.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: Invalid option list: ,
+qemu-img: Invalid parameter 'snapshot.foo'
+qemu-img: Failed in parsing snapshot param 'snapshot.foo'
+qemu-img: --output must be used with human or json as argument.
+qemu-img: Image size must be less than 8 EiB!
+qemu-img: Unknown file format 'foo'
+
+== Size calculation for a new file (human) ==
+
+required size: 131072
+fully allocated size: 131072
+required size: 589824
+fully allocated size: 2148073472
+required size: 10747904
+fully allocated size: 68730224640
+required size: 42205184
+fully allocated size: 274920112128
+required size: 168034304
+fully allocated size: 1099679662080
+
+== Empty qcow2 input image (human) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
+required size: 131072
+fully allocated size: 131072
+
+== qcow2 input image with data (human) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+required size: 327680
+fully allocated size: 1074069504
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 64512/64512 bytes at offset 134217728
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+required size: 524288
+fully allocated size: 1074069504
+
+== qcow2 input image with internal snapshot (human) ==
+
+required size: 458752
+fully allocated size: 1074069504
+
+== qcow2 input image and a backing file (human) ==
+
+required size: 1074069504
+fully allocated size: 1074069504
+
+== qcow2 input image and preallocation (human) ==
+
+required size: 1074069504
+fully allocated size: 1074069504
+
+== Fully-allocated qcow2 input image (human) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=8388608
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+required size: 8650752
+fully allocated size: 8650752
+
+== Empty raw input image (human) ==
+
+Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=0
+required size: 131072
+fully allocated size: 131072
+
+== raw input image with data (human) ==
+
+Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=1073741824
+required size: 327680
+fully allocated size: 1074069504
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 64512/64512 bytes at offset 134217728
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+required size: 524288
+fully allocated size: 1074069504
+
+== raw input image and a backing file (human) ==
+
+required size: 1074069504
+fully allocated size: 1074069504
+
+== raw input image and preallocation (human) ==
+
+required size: 1074069504
+fully allocated size: 1074069504
+
+== Fully-allocated raw input image (human) ==
+
+Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=8388608
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+required size: 8650752
+fully allocated size: 8650752
+
+== Size calculation for a new file (json) ==
+
+{
+    "required": 131072,
+    "fully-allocated": 131072
+}
+{
+    "required": 589824,
+    "fully-allocated": 2148073472
+}
+{
+    "required": 10747904,
+    "fully-allocated": 68730224640
+}
+{
+    "required": 42205184,
+    "fully-allocated": 274920112128
+}
+{
+    "required": 168034304,
+    "fully-allocated": 1099679662080
+}
+
+== Empty qcow2 input image (json) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
+{
+    "required": 131072,
+    "fully-allocated": 131072
+}
+
+== qcow2 input image with data (json) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+{
+    "required": 327680,
+    "fully-allocated": 1074069504
+}
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 64512/64512 bytes at offset 134217728
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "required": 524288,
+    "fully-allocated": 1074069504
+}
+
+== qcow2 input image with internal snapshot (json) ==
+
+{
+    "required": 458752,
+    "fully-allocated": 1074069504
+}
+
+== qcow2 input image and a backing file (json) ==
+
+{
+    "required": 1074069504,
+    "fully-allocated": 1074069504
+}
+
+== qcow2 input image and preallocation (json) ==
+
+{
+    "required": 1074069504,
+    "fully-allocated": 1074069504
+}
+
+== Fully-allocated qcow2 input image (json) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=8388608
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "required": 8650752,
+    "fully-allocated": 8650752
+}
+
+== Empty raw input image (json) ==
+
+Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=0
+{
+    "required": 131072,
+    "fully-allocated": 131072
+}
+
+== raw input image with data (json) ==
+
+Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=1073741824
+{
+    "required": 327680,
+    "fully-allocated": 1074069504
+}
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 64512/64512 bytes at offset 134217728
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "required": 524288,
+    "fully-allocated": 1074069504
+}
+
+== raw input image and a backing file (json) ==
+
+{
+    "required": 1074069504,
+    "fully-allocated": 1074069504
+}
+
+== raw input image and preallocation (json) ==
+
+{
+    "required": 1074069504,
+    "fully-allocated": 1074069504
+}
+
+== Fully-allocated raw input image (json) ==
+
+Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=8388608
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "required": 8650752,
+    "fully-allocated": 8650752
+}
+*** done
diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.raw
new file mode 100644
index 0000000..5d75962
--- /dev/null
+++ b/tests/qemu-iotests/178.out.raw
@@ -0,0 +1,130 @@
+QA output created by 178
+== Input validation ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+qemu-img: Either --size N or one filename must be specified.
+qemu-img: --size N cannot be used together with a filename.
+qemu-img: At most one filename argument is allowed.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: --object, --image-opts, -f, and -l require a filename argument.
+qemu-img: Invalid option list: ,
+qemu-img: Invalid parameter 'snapshot.foo'
+qemu-img: Failed in parsing snapshot param 'snapshot.foo'
+qemu-img: --output must be used with human or json as argument.
+qemu-img: Image size must be less than 8 EiB!
+qemu-img: Unknown file format 'foo'
+
+== Size calculation for a new file (human) ==
+
+required size: 0
+fully allocated size: 0
+required size: 2147483648
+fully allocated size: 2147483648
+required size: 68719476736
+fully allocated size: 68719476736
+required size: 274877906944
+fully allocated size: 274877906944
+required size: 1099511627776
+fully allocated size: 1099511627776
+
+== Empty raw input image (human) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
+required size: 0
+fully allocated size: 0
+
+== raw input image with data (human) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+required size: 1073741824
+fully allocated size: 1073741824
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 64512/64512 bytes at offset 134217728
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+required size: 1073741824
+fully allocated size: 1073741824
+
+== raw input image and preallocation (human) ==
+
+required size: 1073741824
+fully allocated size: 1073741824
+
+== Fully-allocated raw input image (human) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=8388608
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+required size: 8388608
+fully allocated size: 8388608
+
+== Size calculation for a new file (json) ==
+
+{
+    "required": 0,
+    "fully-allocated": 0
+}
+{
+    "required": 2147483648,
+    "fully-allocated": 2147483648
+}
+{
+    "required": 68719476736,
+    "fully-allocated": 68719476736
+}
+{
+    "required": 274877906944,
+    "fully-allocated": 274877906944
+}
+{
+    "required": 1099511627776,
+    "fully-allocated": 1099511627776
+}
+
+== Empty raw input image (json) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
+{
+    "required": 0,
+    "fully-allocated": 0
+}
+
+== raw input image with data (json) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+{
+    "required": 1073741824,
+    "fully-allocated": 1073741824
+}
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 64512/64512 bytes at offset 134217728
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "required": 1073741824,
+    "fully-allocated": 1073741824
+}
+
+== raw input image and preallocation (json) ==
+
+{
+    "required": 1073741824,
+    "fully-allocated": 1073741824
+}
+
+== Fully-allocated raw input image (json) ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=8388608
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "required": 8388608,
+    "fully-allocated": 8388608
+}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1f4bf03..846f962 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -168,3 +168,4 @@
 173 rw auto
 174 auto
 175 auto quick
+178 auto quick
-- 
2.9.3
