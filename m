Received: from eggs.gnu.org ([2001:4830:134:3::10]:34361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlU-0001iQ-GZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlM-0007Wt-Ts
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:21:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:27 +0100
Message-Id: <20180309161933.8168-51-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 50/56] qemu-iotests: Test qcow2 over file image
 creation with QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/206     | 436 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/206.out | 209 ++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 646 insertions(+)
 create mode 100755 tests/qemu-iotests/206
 create mode 100644 tests/qemu-iotests/206.out

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
new file mode 100755
index 0000000000..0a18b2b19a
--- /dev/null
+++ b/tests/qemu-iotests/206
@@ -0,0 +1,436 @@
+#!/bin/bash
+#
+# Test qcow2 and file image creation
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
+_supported_fmt qcow2
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
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG",
+      "size": 0
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+      "driver": "file",
+      "node-name": "imgfile",
+      "filename": "$TEST_IMG"
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "imgfile",
+      "size": $size
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific
+
+echo
+echo "=== Successful image creation (inline blockdev-add, explicit defaults) ==="
+echo
+
+# Choose a different size to show that we got a new image
+size=$((64 * 1024 * 1024))
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG",
+      "size": 0,
+      "preallocation": "off",
+      "nocow": false
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "size": $size,
+      "version": "v3",
+      "cluster-size": 65536,
+      "preallocation": "off",
+      "lazy-refcounts": false,
+      "refcount-bits": 16
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific
+
+echo
+echo "=== Successful image creation (v3 non-default options) ==="
+echo
+
+# Choose a different size to show that we got a new image
+size=$((32 * 1024 * 1024))
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG",
+      "size": 0,
+      "preallocation": "falloc",
+      "nocow": true
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "size": $size,
+      "version": "v3",
+      "cluster-size": 2097152,
+      "preallocation": "metadata",
+      "lazy-refcounts": true,
+      "refcount-bits": 1
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific
+
+echo
+echo "=== Successful image creation (v2 non-default options) ==="
+echo
+
+mv $TEST_IMG $TEST_IMG.base
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "file",
+      "filename": "$TEST_IMG",
+      "size": 0
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "size": $size,
+      "backing-file": "$TEST_IMG.base",
+      "backing-fmt": "qcow2",
+      "version": "v2",
+      "cluster-size": 512
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific
+
+echo
+echo "=== Successful image creation (encrypted) ==="
+echo
+
+run_qemu -object secret,id=keysec0,data="foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "size": $size,
+      "encrypt": {
+          "format": "luks",
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
+      "size": $size
+  }
+}
+{ "execute": "quit" }
+EOF
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
+# 1. Misaligned image size
+# 2. 2^64 - 512
+# 3. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
+# 4. 2^63 - 512 (generally valid, but qcow2 can't handle images this size)
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 1234
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 18446744073709551104
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 9223372036854775808
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 9223372036854775296
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Invalid version ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "version": "v1"
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "version": "v2",
+      "lazy-refcounts": true
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "version": "v2",
+      "refcount-bits": 8
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Invalid backing file options ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "backing-file": "/dev/null",
+      "preallocation": "full"
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "backing-fmt": "$IMGFMT"
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Invalid cluster size ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 1234
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 128
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 4194304
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "cluster-size": 0
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 281474976710656,
+      "cluster-size": 512
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=== Invalid refcount width ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "refcount-bits": 128
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "refcount-bits": 0
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "size": 67108864,
+      "refcount-bits": 7
+  }
+}
+{ "execute": "quit" }
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
new file mode 100644
index 0000000000..042342ae9d
--- /dev/null
+++ b/tests/qemu-iotests/206.out
@@ -0,0 +1,209 @@
+QA output created by 206
+
+=== Successful image creation (defaults) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 128M (134217728 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=== Successful image creation (inline blockdev-add, explicit defaults) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=== Successful image creation (v3 non-default options) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32M (33554432 bytes)
+cluster_size: 2097152
+Format specific information:
+    compat: 1.1
+    lazy refcounts: true
+    refcount bits: 1
+    corrupt: false
+
+=== Successful image creation (v2 non-default options) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32M (33554432 bytes)
+cluster_size: 512
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+Format specific information:
+    compat: 0.10
+    refcount bits: 16
+
+=== Successful image creation (encrypted) ===
+
+Testing: -object secret,id=keysec0,data=foo
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32M (33554432 bytes)
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    encrypt:
+        ivgen alg: plain64
+        hash alg: sha1
+        cipher alg: twofish-128
+        uuid: 00000000-0000-0000-0000-000000000000
+        format: luks
+        cipher mode: ctr
+        slots:
+            [0]:
+                active: true
+                iters: 1024
+                key offset: 4096
+                stripes: 4000
+            [1]:
+                active: false
+                key offset: 69632
+            [2]:
+                active: false
+                key offset: 135168
+            [3]:
+                active: false
+                key offset: 200704
+            [4]:
+                active: false
+                key offset: 266240
+            [5]:
+                active: false
+                key offset: 331776
+            [6]:
+                active: false
+                key offset: 397312
+            [7]:
+                active: false
+                key offset: 462848
+        payload offset: 528384
+        master key iters: 1024
+    corrupt: false
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
+=== Invalid sizes ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Image size must be a multiple of 512 bytes"}}
+{"error": {"class": "GenericError", "desc": "Could not resize image: Image size cannot be negative"}}
+{"error": {"class": "GenericError", "desc": "Could not resize image: Image size cannot be negative"}}
+{"error": {"class": "GenericError", "desc": "Could not resize image: Failed to grow the L1 table: File too large"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Invalid version ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Invalid parameter 'v1'"}}
+{"error": {"class": "GenericError", "desc": "Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)"}}
+{"error": {"class": "GenericError", "desc": "Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Invalid backing file options ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Backing file and preallocation cannot be used at the same time"}}
+{"error": {"class": "GenericError", "desc": "Backing format cannot be used without backing file"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Invalid cluster size ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
+{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
+{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
+{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
+{"error": {"class": "GenericError", "desc": "Could not resize image: Failed to grow the L1 table: File too large"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+=== Invalid refcount width ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
+{"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
+{"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a2dfe79d86..69b6504f67 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -202,3 +202,4 @@
 203 rw auto
 204 rw auto quick
 205 rw auto quick
+206 rw auto
-- 
2.13.6
