Received: from eggs.gnu.org ([2001:4830:134:3::10]:34162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxh-0005PM-N1
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxg-0002CT-Dr
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:57 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:28 +0100
Message-Id: <20171123020832.8165-14-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 13/17] iotests: Fix 067 for compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

067 works very well with compat=0.10 once you remove format-specific
information from the QMP output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/067     |  3 +-
 tests/qemu-iotests/067.out | 97 +++++++++++++---------------------------------
 2 files changed, 28 insertions(+), 72 deletions(-)

diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 9d561ef786..fe259f6165 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -57,7 +57,8 @@ function run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp | _filter_qemu \
                           | _filter_actual_image_size \
-                          | _filter_generated_node_ids | _filter_qmp_events
+                          | _filter_generated_node_ids | _filter_qmp_events \
+                          | _filter_img_info
 }
 
 size=128M
diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
index 58e83c4505..2e71cff3ce 100644
--- a/tests/qemu-iotests/067.out
+++ b/tests/qemu-iotests/067.out
@@ -3,7 +3,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
 === -drive/-device and device_del ===
 
-Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk -device virtio-blk,drive=disk,id=virtio0
+Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk -device virtio-blk,drive=disk,id=virtio0
 {
     QMP_VERSION
 }
@@ -23,26 +23,17 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk -device virti
                 "detect_zeroes": "off",
                 "image": {
                     "virtual-size": 134217728,
-                    "filename": "TEST_DIR/t.qcow2",
+                    "filename": "TEST_DIR/t.IMGFMT",
                     "cluster-size": 65536,
-                    "format": "qcow2",
+                    "format": "IMGFMT",
                     "actual-size": SIZE,
-                    "format-specific": {
-                        "type": "qcow2",
-                        "data": {
-                            "compat": "1.1",
-                            "lazy-refcounts": false,
-                            "refcount-bits": 16,
-                            "corrupt": false
-                        }
-                    },
                     "dirty-flag": false
                 },
                 "iops_wr": 0,
                 "ro": false,
                 "node-name": "NODE_NAME",
                 "backing_file_depth": 0,
-                "drv": "qcow2",
+                "drv": "IMGFMT",
                 "iops": 0,
                 "bps_wr": 0,
                 "write_threshold": 0,
@@ -54,7 +45,7 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk -device virti
                     "direct": false,
                     "writeback": true
                 },
-                "file": "TEST_DIR/t.qcow2",
+                "file": "TEST_DIR/t.IMGFMT",
                 "encryption_key_missing": false
             },
             "qdev": "/machine/peripheral/virtio0/virtio-backend",
@@ -81,7 +72,7 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk -device virti
 
 === -drive/device_add and device_del ===
 
-Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk
+Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk
 {
     QMP_VERSION
 }
@@ -100,26 +91,17 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk
                 "detect_zeroes": "off",
                 "image": {
                     "virtual-size": 134217728,
-                    "filename": "TEST_DIR/t.qcow2",
+                    "filename": "TEST_DIR/t.IMGFMT",
                     "cluster-size": 65536,
-                    "format": "qcow2",
+                    "format": "IMGFMT",
                     "actual-size": SIZE,
-                    "format-specific": {
-                        "type": "qcow2",
-                        "data": {
-                            "compat": "1.1",
-                            "lazy-refcounts": false,
-                            "refcount-bits": 16,
-                            "corrupt": false
-                        }
-                    },
                     "dirty-flag": false
                 },
                 "iops_wr": 0,
                 "ro": false,
                 "node-name": "NODE_NAME",
                 "backing_file_depth": 0,
-                "drv": "qcow2",
+                "drv": "IMGFMT",
                 "iops": 0,
                 "bps_wr": 0,
                 "write_threshold": 0,
@@ -131,7 +113,7 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk
                     "direct": false,
                     "writeback": true
                 },
-                "file": "TEST_DIR/t.qcow2",
+                "file": "TEST_DIR/t.IMGFMT",
                 "encryption_key_missing": false
             },
             "type": "unknown"
@@ -183,26 +165,17 @@ Testing:
                 "detect_zeroes": "off",
                 "image": {
                     "virtual-size": 134217728,
-                    "filename": "TEST_DIR/t.qcow2",
+                    "filename": "TEST_DIR/t.IMGFMT",
                     "cluster-size": 65536,
-                    "format": "qcow2",
+                    "format": "IMGFMT",
                     "actual-size": SIZE,
-                    "format-specific": {
-                        "type": "qcow2",
-                        "data": {
-                            "compat": "1.1",
-                            "lazy-refcounts": false,
-                            "refcount-bits": 16,
-                            "corrupt": false
-                        }
-                    },
                     "dirty-flag": false
                 },
                 "iops_wr": 0,
                 "ro": false,
                 "node-name": "NODE_NAME",
                 "backing_file_depth": 0,
-                "drv": "qcow2",
+                "drv": "IMGFMT",
                 "iops": 0,
                 "bps_wr": 0,
                 "write_threshold": 0,
@@ -214,7 +187,7 @@ Testing:
                     "direct": false,
                     "writeback": true
                 },
-                "file": "TEST_DIR/t.qcow2",
+                "file": "TEST_DIR/t.IMGFMT",
                 "encryption_key_missing": false
             },
             "type": "unknown"
@@ -263,26 +236,17 @@ Testing:
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 134217728,
-                "filename": "TEST_DIR/t.qcow2",
+                "filename": "TEST_DIR/t.IMGFMT",
                 "cluster-size": 65536,
-                "format": "qcow2",
+                "format": "IMGFMT",
                 "actual-size": SIZE,
-                "format-specific": {
-                    "type": "qcow2",
-                    "data": {
-                        "compat": "1.1",
-                        "lazy-refcounts": false,
-                        "refcount-bits": 16,
-                        "corrupt": false
-                    }
-                },
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "disk",
             "backing_file_depth": 0,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
@@ -294,7 +258,7 @@ Testing:
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "TEST_DIR/t.IMGFMT",
             "encryption_key_missing": false
         },
         {
@@ -302,7 +266,7 @@ Testing:
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2",
+                "filename": "TEST_DIR/t.IMGFMT",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -323,7 +287,7 @@ Testing:
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "TEST_DIR/t.IMGFMT",
             "encryption_key_missing": false
         }
     ]
@@ -347,26 +311,17 @@ Testing:
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 134217728,
-                "filename": "TEST_DIR/t.qcow2",
+                "filename": "TEST_DIR/t.IMGFMT",
                 "cluster-size": 65536,
-                "format": "qcow2",
+                "format": "IMGFMT",
                 "actual-size": SIZE,
-                "format-specific": {
-                    "type": "qcow2",
-                    "data": {
-                        "compat": "1.1",
-                        "lazy-refcounts": false,
-                        "refcount-bits": 16,
-                        "corrupt": false
-                    }
-                },
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "disk",
             "backing_file_depth": 0,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
@@ -378,7 +333,7 @@ Testing:
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "TEST_DIR/t.IMGFMT",
             "encryption_key_missing": false
         },
         {
@@ -386,7 +341,7 @@ Testing:
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2",
+                "filename": "TEST_DIR/t.IMGFMT",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -407,7 +362,7 @@ Testing:
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "TEST_DIR/t.IMGFMT",
             "encryption_key_missing": false
         }
     ]
-- 
2.13.6
