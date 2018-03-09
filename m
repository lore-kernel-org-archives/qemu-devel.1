Received: from eggs.gnu.org ([2001:4830:134:3::10]:60187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnu-0000ym-K8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLns-0006fx-Uo
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 18:27:13 +0100
Message-Id: <20180309172713.26318-7-kwolf@redhat.com>
In-Reply-To: <20180309172713.26318-1-kwolf@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] qemu-iotests: Test luks QMP image creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/208       | 211 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/208.out   | 136 ++++++++++++++++++++++++++++
 tests/qemu-iotests/common.rc |   2 +-
 tests/qemu-iotests/group     |   1 +
 4 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/208
 create mode 100644 tests/qemu-iotests/208.out

diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
new file mode 100755
index 0000000000..ab4650d0ae
--- /dev/null
+++ b/tests/qemu-iotests/208
@@ -0,0 +1,211 @@
+#!/bin/bash
+#
+# Test luks and file image creation
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
+# creator
+owner=kwolf@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt luks
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
+                          | _filter_qemu | _filter_imgfmt \
+                          | _filter_actual_image_size
+}
+
+echo
+echo "=== Successful image creation (defaults) ==="
+echo
+
+size=$((128 * 1024 * 1024))
+
+run_qemu -object secret,id=keysec0,data="foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG_FILE",
+      "size": 0
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+      "driver": "file",
+      "node-name": "imgfile",
+      "filename": "$TEST_IMG_FILE"
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "imgfile",
+      "qcrypto": { "key-secret": "keysec0" },
+      "size": $size
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+
+echo
+echo "=== Successful image creation (with non-default options) ==="
+echo
+
+# Choose a different size to show that we got a new image
+size=$((64 * 1024 * 1024))
+
+run_qemu -object secret,id=keysec0,data="foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG_FILE",
+      "size": 0
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG_FILE"
+      },
+      "size": $size,
+      "qcrypto": {
+          "key-secret": "keysec0",
+          "cipher-alg": "twofish-128",
+          "cipher-mode": "ctr",
+          "ivgen-alg": "plain64",
+          "ivgen-hash-alg": "md5",
+          "hash-alg": "sha1",
+          "iter-time": 10
+      }
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+
+echo
+echo "=== Invalid BlockdevRef ==="
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "this doesn't exist",
+      "qcrypto": {},
+      "size": $size
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Zero size ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG_FILE",node-name=node0 \
+         -object secret,id=keysec0,data="foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "qcrypto": { "key-secret": "keysec0" },
+      "size": 0
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+
+echo
+echo "=== Invalid sizes ==="
+echo
+
+# TODO Negative image sizes aren't handled correctly, but this is a problem
+# with QAPI's implementation of the 'size' type and affects other commands as
+# well. Once this is fixed, we may want to add a test case here.
+
+# 1. 2^64 - 512
+# 2. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
+# 3. 2^63 - 512 (generally valid, but with the crypto header the file will
+#                exceed 63 bits)
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG_FILE",node-name=node0 \
+         -object secret,id=keysec0,data="foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "qcrypto": { "key-secret": "keysec0" },
+      "size": 18446744073709551104
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "qcrypto": { "key-secret": "keysec0" },
+      "size": 9223372036854775808
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "qcrypto": { "key-secret": "keysec0" },
+      "size": 9223372036854775296
+  }
+}
+{ "execute": "quit" }
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/208.out b/tests/qemu-iotests/208.out
new file mode 100644
index 0000000000..1123661f68
--- /dev/null
+++ b/tests/qemu-iotests/208.out
@@ -0,0 +1,136 @@
+QA output created by 208
+
+=== Successful image creation (defaults) ===
+
+Testing: -object secret,id=keysec0,data=foo
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
+file format: IMGFMT
+virtual size: 128M (134217728 bytes)
+Format specific information:
+    ivgen alg: plain64
+    hash alg: sha256
+    cipher alg: aes-256
+    uuid: 00000000-0000-0000-0000-000000000000
+    cipher mode: xts
+    slots:
+        [0]:
+            active: true
+            iters: 1024
+            key offset: 4096
+            stripes: 4000
+        [1]:
+            active: false
+            key offset: 262144
+        [2]:
+            active: false
+            key offset: 520192
+        [3]:
+            active: false
+            key offset: 778240
+        [4]:
+            active: false
+            key offset: 1036288
+        [5]:
+            active: false
+            key offset: 1294336
+        [6]:
+            active: false
+            key offset: 1552384
+        [7]:
+            active: false
+            key offset: 1810432
+    payload offset: 2068480
+    master key iters: 1024
+
+=== Successful image creation (with non-default options) ===
+
+Testing: -object secret,id=keysec0,data=foo
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+Format specific information:
+    ivgen alg: plain64
+    hash alg: sha1
+    cipher alg: twofish-128
+    uuid: 00000000-0000-0000-0000-000000000000
+    cipher mode: ctr
+    slots:
+        [0]:
+            active: true
+            iters: 1024
+            key offset: 4096
+            stripes: 4000
+        [1]:
+            active: false
+            key offset: 69632
+        [2]:
+            active: false
+            key offset: 135168
+        [3]:
+            active: false
+            key offset: 200704
+        [4]:
+            active: false
+            key offset: 266240
+        [5]:
+            active: false
+            key offset: 331776
+        [6]:
+            active: false
+            key offset: 397312
+        [7]:
+            active: false
+            key offset: 462848
+    payload offset: 528384
+    master key iters: 1024
+
+=== Invalid BlockdevRef ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Zero size ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0 -object secret,id=keysec0,data=foo
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
+file format: IMGFMT
+virtual size: 0 (0 bytes)
+
+=== Invalid sizes ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0 -object secret,id=keysec0,data=foo
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "The requested file size is too large"}}
+{"error": {"class": "GenericError", "desc": "Image size cannot be negative"}}
+{"error": {"class": "GenericError", "desc": "Image size cannot be negative"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+*** done
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 6fa0495e10..9a65a11026 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -332,7 +332,7 @@ _img_info()
 
     discard=0
     regex_json_spec_start='^ *"format-specific": \{'
-    $QEMU_IMG info "$@" "$TEST_IMG" 2>&1 | \
+    $QEMU_IMG info $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" 2>&1 | \
         sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
             -e "s#$IMGFMT#IMGFMT#g" \
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index c401791fcd..574227e761 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -204,3 +204,4 @@
 205 rw auto quick
 206 rw auto
 207 rw auto
+208 rw auto
-- 
2.13.6
