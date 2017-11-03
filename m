Received: from eggs.gnu.org ([2001:4830:134:3::10]:53555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdAB-0007Ba-Hb
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdA9-0007d0-Rb
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:41:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Nov 2017 14:41:13 +0000
Message-Id: <20171103144113.7188-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] qcow2: fix image corruption after committing
 qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

After committing the qcow2 image contents into the base image, qemu-img
will call bdrv_make_empty to drop the payload in the layered image.

When this is done for qcow2 images, it blows away the LUKS encryption
header, making the resulting image unusable. There are two codepaths
for emptying a qcow2 image, and the second (slower) codepaths leaves
the LUKS header intact, so force use of that codepath.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---

NB, ideally we would fix the faster codepath in make_completely_empty, but
having looked at the code, I've really no idea how to even start on fixing that
to not kill the LUKS header clusters.

 block/qcow2.c                    |   3 +-
 tests/qemu-iotests/198           | 104 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/198.out       | 128 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/common.filter |   4 +-
 tests/qemu-iotests/group         |   1 +
 5 files changed, 238 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/198
 create mode 100644 tests/qemu-iotests/198.out

diff --git a/block/qcow2.c b/block/qcow2.c
index 8edf8ac3c7..618aab114a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3594,7 +3594,8 @@ static int qcow2_make_empty(BlockDriverState *bs)
     l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / sizeof(uint64_t));
 
     if (s->qcow_version >= 3 && !s->snapshots &&
-        3 + l1_clusters <= s->refcount_block_size) {
+        3 + l1_clusters <= s->refcount_block_size &&
+        s->crypt_method_header != QCOW_CRYPT_LUKS) {
         /* The following function only works for qcow2 v3 images (it requires
          * the dirty flag) and only as long as there are no snapshots (because
          * it completely empties the image). Furthermore, the L1 table and three
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
new file mode 100755
index 0000000000..5197c90af5
--- /dev/null
+++ b/tests/qemu-iotests/198
@@ -0,0 +1,104 @@
+#!/bin/bash
+#
+# Test commit of encrypted qcow2 files
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
+IMGSPECLAYER="driver=$IMGFMT,file.filename=$TEST_IMG,encrypt.key-secret=sec1"
+IMGSPEC="$IMGSPECLAYER,backing.driver=$IMGFMT,backing.file.filename=$TEST_IMG_BASE,backing.encrypt.key-secret=sec0"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "== writing whole image base =="
+$QEMU_IO --object $SECRET0 -c "write -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
+
+echo "== create overlay =="
+_make_test_img --object $SECRET1 -o "encrypt.format=luks,encrypt.key-secret=sec1,encrypt.iter-time=10" -u -b "$TEST_IMG_BASE" $size
+
+echo
+echo "== writing whole image layer =="
+$QEMU_IO --object $SECRET0 --object $SECRET1 -c "write -P 0x9 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern base =="
+$QEMU_IO --object $SECRET0 -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern layer =="
+$QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0x9 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== committing layer into base =="
+$QEMU_IMG commit --object $SECRET0 --object $SECRET1 --image-opts $IMGSPEC | _filter_testdir
+
+echo
+echo "== verify pattern base =="
+$QEMU_IO --object $SECRET0 -c "read -P 0x9 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern layer =="
+$QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0x9 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== checking image base =="
+$QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info | _filter_testdir
+
+echo
+echo "== checking image layer =="
+$QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info | _filter_testdir
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
new file mode 100644
index 0000000000..fac00d2c1a
--- /dev/null
+++ b/tests/qemu-iotests/198.out
@@ -0,0 +1,128 @@
+QA output created by 198
+== create base ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+
+== writing whole image base ==
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== create overlay ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
+
+== writing whole image layer ==
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern base ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern layer ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== committing layer into base ==
+Image committed.
+
+== verify pattern base ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern layer ==
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== checking image base ==
+image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
+file format: IMGFMT
+virtual size: 16M (16777216 bytes)
+disk size: 17M
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    encrypt:
+        ivgen alg: plain64
+        hash alg: sha256
+        cipher alg: aes-256
+        uuid: 00000000-0000-0000-0000-000000000000
+        format: luks
+        cipher mode: xts
+        slots:
+            [0]:
+                active: true
+                iters: 1024
+                key offset: 4096
+                stripes: 4000
+            [1]:
+                active: false
+                key offset: 262144
+            [2]:
+                active: false
+                key offset: 520192
+            [3]:
+                active: false
+                key offset: 778240
+            [4]:
+                active: false
+                key offset: 1036288
+            [5]:
+                active: false
+                key offset: 1294336
+            [6]:
+                active: false
+                key offset: 1552384
+            [7]:
+                active: false
+                key offset: 1810432
+        payload offset: 2068480
+        master key iters: 1024
+    corrupt: false
+
+== checking image layer ==
+image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
+file format: IMGFMT
+virtual size: 16M (16777216 bytes)
+disk size: 548K
+backing file: TEST_DIR/t.IMGFMT.base
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    encrypt:
+        ivgen alg: plain64
+        hash alg: sha256
+        cipher alg: aes-256
+        uuid: 00000000-0000-0000-0000-000000000000
+        format: luks
+        cipher mode: xts
+        slots:
+            [0]:
+                active: true
+                iters: 1024
+                key offset: 4096
+                stripes: 4000
+            [1]:
+                active: false
+                key offset: 262144
+            [2]:
+                active: false
+                key offset: 520192
+            [3]:
+                active: false
+                key offset: 778240
+            [4]:
+                active: false
+                key offset: 1036288
+            [5]:
+                active: false
+                key offset: 1294336
+            [6]:
+                active: false
+                key offset: 1552384
+            [7]:
+                active: false
+                key offset: 1810432
+        payload offset: 2068480
+        master key iters: 1024
+    corrupt: false
+*** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 873ca6b104..d9237799e9 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -157,7 +157,9 @@ _filter_img_info()
         -e "/lazy_refcounts: \\(on\\|off\\)/d" \
         -e "/block_size: [0-9]\\+/d" \
         -e "/block_state_zero: \\(on\\|off\\)/d" \
-        -e "/log_size: [0-9]\\+/d"
+        -e "/log_size: [0-9]\\+/d" \
+        -e "s/iters: [0-9]\\+/iters: 1024/" \
+        -e "s/uuid: [-a-f0-9]\\+/uuid: 00000000-0000-0000-0000-000000000000/"
 }
 
 # filter out offsets and file names from qemu-img map; good for both
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 24e5ad1b79..83b839bbe3 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -194,3 +194,4 @@
 194 rw auto migration quick
 195 rw auto quick
 197 rw auto quick
+198 rw auto
-- 
2.13.6
