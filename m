Received: from eggs.gnu.org ([2001:4830:134:3::10]:34859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsOs-0007zu-FD
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsOr-0006rr-AK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:38 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:43 +0100
Message-Id: <20171120201004.14999-5-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 04/25] iotests: Drop explicit base
 blockdev in 191
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Overriding the backing image should result in a json:{} pseudo-filename.
Then, you can no longer use the commit block job with filename
parameters.  Therefore, do not explicitly add the base and override the
middle image in iotest 191, since we do not need to anyway.  This will
allow us to continue to use the middle image's filename to identify it.

In the long run, we want block-commit to accept node names for base and
top (just like block-stream does).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/191     |  3 +-
 tests/qemu-iotests/191.out | 70 +++++++++++++++++++++++-----------------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index ad785e10b1..92805e9ca2 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -67,8 +67,7 @@ qemu_comm_method="qmp"
 qmp_pretty="y"
 
 _launch_qemu \
-    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.base,node-name=base" \
-    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.mid,node-name=mid,backing=base" \
+    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.mid,node-name=mid" \
     -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG},node-name=top,backing=mid" \
     -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.ovl2,node-name=top2,backing=mid"
 h=$QEMU_HANDLE
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 73c0ed454c..26ff0a315d 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -220,26 +220,8 @@ wrote 65536/65536 bytes at offset 1048576
             "iops_rd": 0,
             "detect_zeroes": "off",
             "image": {
-                "backing-image": {
-                    "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.base",
-                    "cluster-size": 65536,
-                    "format": "qcow2",
-                    "actual-size": SIZE,
-                    "format-specific": {
-                        "type": "qcow2",
-                        "data": {
-                            "compat": "1.1",
-                            "lazy-refcounts": false,
-                            "refcount-bits": 16,
-                            "corrupt": false
-                        }
-                    },
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.mid",
+                "filename": "TEST_DIR/t.qcow2.base",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -252,19 +234,16 @@ wrote 65536/65536 bytes at offset 1048576
                         "corrupt": false
                     }
                 },
-                "full-backing-filename": "TEST_DIR/t.qcow2.base",
-                "backing-filename": "TEST_DIR/t.qcow2.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
-            "ro": false,
-            "node-name": "mid",
-            "backing_file_depth": 1,
+            "ro": true,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
             "drv": "qcow2",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -273,7 +252,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.mid",
+            "file": "TEST_DIR/t.qcow2.base",
             "encryption_key_missing": false
         },
         {
@@ -281,13 +260,13 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 393216,
-                "filename": "TEST_DIR/t.qcow2.mid",
+                "filename": "TEST_DIR/t.qcow2.base",
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
@@ -302,15 +281,33 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.mid",
+            "file": "TEST_DIR/t.qcow2.base",
             "encryption_key_missing": false
         },
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
             "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.base",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": SIZE,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "qcow2",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.base",
+                "filename": "TEST_DIR/t.qcow2.mid",
                 "cluster-size": 65536,
                 "format": "qcow2",
                 "actual-size": SIZE,
@@ -323,16 +320,19 @@ wrote 65536/65536 bytes at offset 1048576
                         "corrupt": false
                     }
                 },
+                "full-backing-filename": "TEST_DIR/t.qcow2.base",
+                "backing-filename": "TEST_DIR/t.qcow2.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
-            "node-name": "base",
-            "backing_file_depth": 0,
+            "node-name": "mid",
+            "backing_file_depth": 1,
             "drv": "qcow2",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -341,7 +341,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.base",
+            "file": "TEST_DIR/t.qcow2.mid",
             "encryption_key_missing": false
         },
         {
@@ -349,7 +349,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 393216,
-                "filename": "TEST_DIR/t.qcow2.base",
+                "filename": "TEST_DIR/t.qcow2.mid",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -370,7 +370,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.base",
+            "file": "TEST_DIR/t.qcow2.mid",
             "encryption_key_missing": false
         }
     ]
-- 
2.13.6
