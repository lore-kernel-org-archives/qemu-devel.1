Received: from eggs.gnu.org ([2001:4830:134:3::10]:59798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdS-0001gh-7u
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdQ-0004nd-4f
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:49 +0100
Message-Id: <20180313161803.1814-28-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/41] qemu-iotests: Test luks QMP image creation
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
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/209       | 210 +++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/209.out   | 136 ++++++++++++++++++++++++++++
 tests/qemu-iotests/common.rc |   2 +-
 tests/qemu-iotests/group     |   1 +
 4 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/209
 create mode 100644 tests/qemu-iotests/209.out

diff --git a/tests/qemu-iotests/209 b/tests/qemu-iotests/209
new file mode 100755
index 0000000000..96a5213e77
--- /dev/null
+++ b/tests/qemu-iotests/209
@@ -0,0 +1,210 @@
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
+owner=3Dkwolf@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+here=3D`pwd`
+status=3D1	# failure is the default!
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
+echo "=3D=3D=3D Successful image creation (defaults) =3D=3D=3D"
+echo
+
+size=3D$((128 * 1024 * 1024))
+
+run_qemu -object secret,id=3Dkeysec0,data=3D"foo" <<EOF
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
+      "key-secret": "keysec0",
+      "size": $size,
+      "iter-time": 10
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+
+echo
+echo "=3D=3D=3D Successful image creation (with non-default options) =3D=
=3D=3D"
+echo
+
+# Choose a different size to show that we got a new image
+size=3D$((64 * 1024 * 1024))
+
+run_qemu -object secret,id=3Dkeysec0,data=3D"foo" <<EOF
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
+      "key-secret": "keysec0",
+      "cipher-alg": "twofish-128",
+      "cipher-mode": "ctr",
+      "ivgen-alg": "plain64",
+      "ivgen-hash-alg": "md5",
+      "hash-alg": "sha1",
+      "iter-time": 10
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info --format-specific | _filter_img_info --format-specific
+
+echo
+echo "=3D=3D=3D Invalid BlockdevRef =3D=3D=3D"
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
+echo
+echo "=3D=3D=3D Zero size =3D=3D=3D"
+echo
+
+run_qemu -blockdev driver=3Dfile,filename=3D"$TEST_IMG_FILE",node-name=3D=
node0 \
+         -object secret,id=3Dkeysec0,data=3D"foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "key-secret": "keysec0",
+      "size": 0,
+      "iter-time": 10
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+
+echo
+echo "=3D=3D=3D Invalid sizes =3D=3D=3D"
+echo
+
+# TODO Negative image sizes aren't handled correctly, but this is a prob=
lem
+# with QAPI's implementation of the 'size' type and affects other comman=
ds as
+# well. Once this is fixed, we may want to add a test case here.
+
+# 1. 2^64 - 512
+# 2. 2^63 =3D 8 EB (qemu-img enforces image sizes less than this)
+# 3. 2^63 - 512 (generally valid, but with the crypto header the file wi=
ll
+#                exceed 63 bits)
+
+run_qemu -blockdev driver=3Dfile,filename=3D"$TEST_IMG_FILE",node-name=3D=
node0 \
+         -object secret,id=3Dkeysec0,data=3D"foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "key-secret": "keysec0",
+      "size": 18446744073709551104
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "key-secret": "keysec0",
+      "size": 9223372036854775808
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "file": "node0",
+      "key-secret": "keysec0",
+      "size": 9223372036854775296
+  }
+}
+{ "execute": "quit" }
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/209.out b/tests/qemu-iotests/209.out
new file mode 100644
index 0000000000..f3dd2074a3
--- /dev/null
+++ b/tests/qemu-iotests/209.out
@@ -0,0 +1,136 @@
+QA output created by 209
+
+=3D=3D=3D Successful image creation (defaults) =3D=3D=3D
+
+Testing: -object secret,id=3Dkeysec0,data=3Dfoo
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
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
+=3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
+
+Testing: -object secret,id=3Dkeysec0,data=3Dfoo
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
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
+=3D=3D=3D Invalid BlockdevRef =3D=3D=3D
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=3Dthis d=
oesn't exist nor node_name=3Dthis doesn't exist"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+
+=3D=3D=3D Zero size =3D=3D=3D
+
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=3D=
node0 -object secret,id=3Dkeysec0,data=3Dfoo
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
+file format: IMGFMT
+virtual size: 0 (0 bytes)
+
+=3D=3D=3D Invalid sizes =3D=3D=3D
+
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=3D=
node0 -object secret,id=3Dkeysec0,data=3Dfoo
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "The requested file size is =
too large"}}
+{"error": {"class": "GenericError", "desc": "The requested file size is =
too large"}}
+{"error": {"class": "GenericError", "desc": "The requested file size is =
too large"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+*** done
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 6fa0495e10..9a65a11026 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -332,7 +332,7 @@ _img_info()
=20
     discard=3D0
     regex_json_spec_start=3D'^ *"format-specific": \{'
-    $QEMU_IMG info "$@" "$TEST_IMG" 2>&1 | \
+    $QEMU_IMG info $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" 2>&1 | \
         sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
             -e "s#$IMGFMT#IMGFMT#g" \
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index c401791fcd..b8d0fd6177 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -204,3 +204,4 @@
 205 rw auto quick
 206 rw auto
 207 rw auto
+209 rw auto
--=20
2.13.6
