Received: from eggs.gnu.org ([2001:4830:134:3::10]:52874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiXv-0008EE-US
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiXu-0005lS-OJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:19:03 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 16:18:13 +0100
Message-Id: <20180205151835.20812-5-mreitz@redhat.com>
In-Reply-To: <20180205151835.20812-1-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v8 04/26] iotests: Drop explicit base blockdev
 in 191
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

Overriding the backing image should result in a json:{} pseudo-filename.
Then, you can no longer use the commit block job with filename
parameters.  Therefore, do not explicitly add the base and override the
middle image in iotest 191, since we do not need to anyway.  This will
allow us to continue to use the middle image's filename to identify it.

In the long run, we want block-commit to accept node names for base and
top (just like block-stream does).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/191     |  3 +--
 tests/qemu-iotests/191.out | 52 +++++++++++++++++++++++-----------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index dfad6555e4..af93e932bf 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -66,8 +66,7 @@ qemu_comm_method="qmp"
 qmp_pretty="y"
 
 _launch_qemu \
-    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.base,node-name=base" \
-    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.mid,node-name=mid,backing=base" \
+    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.mid,node-name=mid" \
     -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG},node-name=top,backing=mid" \
     -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.ovl2,node-name=top2,backing=mid"
 h=$QEMU_HANDLE
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 190c5f049a..575cd3ea2d 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -184,33 +184,21 @@ wrote 65536/65536 bytes at offset 1048576
             "iops_rd": 0,
             "detect_zeroes": "off",
             "image": {
-                "backing-image": {
-                    "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.IMGFMT.base",
-                    "cluster-size": 65536,
-                    "format": "IMGFMT",
-                    "actual-size": SIZE,
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT.mid",
+                "filename": "TEST_DIR/t.IMGFMT.base",
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
-                "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
-            "ro": false,
-            "node-name": "mid",
-            "backing_file_depth": 1,
+            "ro": true,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
             "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -219,7 +207,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT.mid",
+            "file": "TEST_DIR/t.IMGFMT.base",
             "encryption_key_missing": false
         },
         {
@@ -227,13 +215,13 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 393216,
-                "filename": "TEST_DIR/t.IMGFMT.mid",
+                "filename": "TEST_DIR/t.IMGFMT.base",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
-            "ro": false,
+            "ro": true,
             "node-name": "NODE_NAME",
             "backing_file_depth": 0,
             "drv": "file",
@@ -248,28 +236,40 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT.mid",
+            "file": "TEST_DIR/t.IMGFMT.base",
             "encryption_key_missing": false
         },
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
             "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "cluster-size": 65536,
+                    "format": "IMGFMT",
+                    "actual-size": SIZE,
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT.base",
+                "filename": "TEST_DIR/t.IMGFMT.mid",
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
-            "node-name": "base",
-            "backing_file_depth": 0,
+            "node-name": "mid",
+            "backing_file_depth": 1,
             "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -278,7 +278,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT.base",
+            "file": "TEST_DIR/t.IMGFMT.mid",
             "encryption_key_missing": false
         },
         {
@@ -286,7 +286,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 393216,
-                "filename": "TEST_DIR/t.IMGFMT.base",
+                "filename": "TEST_DIR/t.IMGFMT.mid",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -307,7 +307,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.IMGFMT.base",
+            "file": "TEST_DIR/t.IMGFMT.mid",
             "encryption_key_missing": false
         }
     ]
-- 
2.14.3
