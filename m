Received: from eggs.gnu.org ([2001:4830:134:3::10]:34421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgy2-0005ja-IK
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxz-0002RU-BH
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:10:18 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:31 +0100
Message-Id: <20171123020832.8165-17-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 16/17] iotests: Make 191 work with qcow2 options
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

In order for 191 to work with an explicit refcount_bits or compat=0.10,
we should strip format-specific information from the output--and we can
do so by using _filter_img_info.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/191     |   5 +-
 tests/qemu-iotests/191.out | 313 +++++++++++++--------------------------------
 2 files changed, 91 insertions(+), 227 deletions(-)

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index ad785e10b1..dfad6555e4 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -45,7 +45,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_unsupported_imgopts compat=0.10
 _supported_proto file
 _supported_os Linux
 
@@ -92,7 +91,7 @@ echo === Check that both top and top2 point to base now ===
 echo
 
 _send_qemu_cmd $h "{ 'execute': 'query-named-block-nodes' }" "^}" |
-    _filter_generated_node_ids | _filter_actual_image_size
+    _filter_generated_node_ids | _filter_actual_image_size | _filter_img_info
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "^}"
 wait=1 _cleanup_qemu
@@ -140,7 +139,7 @@ echo === Check that both top and top2 point to base now ===
 echo
 
 _send_qemu_cmd $h "{ 'execute': 'query-named-block-nodes' }" "^}" |
-    _filter_generated_node_ids | _filter_actual_image_size
+    _filter_generated_node_ids | _filter_actual_image_size | _filter_img_info
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "^}"
 wait=1 _cleanup_qemu
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 73c0ed454c..190c5f049a 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -44,49 +44,31 @@ wrote 65536/65536 bytes at offset 1048576
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.base",
+                    "filename": "TEST_DIR/t.IMGFMT.base",
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
-                "backing-filename-format": "qcow2",
+                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "filename": "TEST_DIR/t.IMGFMT.ovl2",
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
-                "full-backing-filename": "TEST_DIR/t.qcow2.base",
-                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "top2",
             "backing_file_depth": 1,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.base",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -95,7 +77,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl2",
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
             "encryption_key_missing": false
         },
         {
@@ -103,7 +85,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "filename": "TEST_DIR/t.IMGFMT.ovl2",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -124,7 +106,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl2",
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
             "encryption_key_missing": false
         },
         {
@@ -133,49 +115,31 @@ wrote 65536/65536 bytes at offset 1048576
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.base",
+                    "filename": "TEST_DIR/t.IMGFMT.base",
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
-                "backing-filename-format": "qcow2",
+                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
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
-                "full-backing-filename": "TEST_DIR/t.qcow2.base",
-                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "top",
             "backing_file_depth": 1,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.base",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -184,7 +148,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "TEST_DIR/t.IMGFMT",
             "encryption_key_missing": false
         },
         {
@@ -192,7 +156,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2",
+                "filename": "TEST_DIR/t.IMGFMT",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -213,7 +177,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "TEST_DIR/t.IMGFMT",
             "encryption_key_missing": false
         },
         {
@@ -222,49 +186,31 @@ wrote 65536/65536 bytes at offset 1048576
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.base",
+                    "filename": "TEST_DIR/t.IMGFMT.base",
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
-                "backing-filename-format": "qcow2",
+                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.mid",
+                "filename": "TEST_DIR/t.IMGFMT.mid",
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
-                "full-backing-filename": "TEST_DIR/t.qcow2.base",
-                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "mid",
             "backing_file_depth": 1,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.base",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -273,7 +219,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.mid",
+            "file": "TEST_DIR/t.IMGFMT.mid",
             "encryption_key_missing": false
         },
         {
@@ -281,7 +227,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 393216,
-                "filename": "TEST_DIR/t.qcow2.mid",
+                "filename": "TEST_DIR/t.IMGFMT.mid",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -302,7 +248,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.mid",
+            "file": "TEST_DIR/t.IMGFMT.mid",
             "encryption_key_missing": false
         },
         {
@@ -310,26 +256,17 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.base",
+                "filename": "TEST_DIR/t.IMGFMT.base",
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
             "node-name": "base",
             "backing_file_depth": 0,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
@@ -341,7 +278,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.base",
+            "file": "TEST_DIR/t.IMGFMT.base",
             "encryption_key_missing": false
         },
         {
@@ -349,7 +286,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 393216,
-                "filename": "TEST_DIR/t.qcow2.base",
+                "filename": "TEST_DIR/t.IMGFMT.base",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -370,7 +307,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.base",
+            "file": "TEST_DIR/t.IMGFMT.base",
             "encryption_key_missing": false
         }
     ]
@@ -447,49 +384,31 @@ wrote 65536/65536 bytes at offset 1048576
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.base",
+                    "filename": "TEST_DIR/t.IMGFMT.base",
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
-                "backing-filename-format": "qcow2",
+                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "filename": "TEST_DIR/t.IMGFMT.ovl2",
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
-                "full-backing-filename": "TEST_DIR/t.qcow2.base",
-                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": true,
             "node-name": "NODE_NAME",
             "backing_file_depth": 1,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.base",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -498,7 +417,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl2",
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
             "encryption_key_missing": false
         },
         {
@@ -506,7 +425,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "filename": "TEST_DIR/t.IMGFMT.ovl2",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -527,7 +446,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl2",
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
             "encryption_key_missing": false
         },
         {
@@ -537,68 +456,41 @@ wrote 65536/65536 bytes at offset 1048576
                 "backing-image": {
                     "backing-image": {
                         "virtual-size": 67108864,
-                        "filename": "TEST_DIR/t.qcow2.base",
+                        "filename": "TEST_DIR/t.IMGFMT.base",
                         "cluster-size": 65536,
-                        "format": "qcow2",
+                        "format": "IMGFMT",
                         "actual-size": SIZE,
-                        "format-specific": {
-                            "type": "qcow2",
-                            "data": {
-                                "compat": "1.1",
-                                "lazy-refcounts": false,
-                                "refcount-bits": 16,
-                                "corrupt": false
-                            }
-                        },
                         "dirty-flag": false
                     },
-                    "backing-filename-format": "qcow2",
+                    "backing-filename-format": "IMGFMT",
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.ovl2",
+                    "filename": "TEST_DIR/t.IMGFMT.ovl2",
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
-                    "full-backing-filename": "TEST_DIR/t.qcow2.base",
-                    "backing-filename": "TEST_DIR/t.qcow2.base",
+                    "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                    "backing-filename": "TEST_DIR/t.IMGFMT.base",
                     "dirty-flag": false
                 },
-                "backing-filename-format": "qcow2",
+                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.ovl3",
+                "filename": "TEST_DIR/t.IMGFMT.ovl3",
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
-                "full-backing-filename": "TEST_DIR/t.qcow2.ovl2",
-                "backing-filename": "TEST_DIR/t.qcow2.ovl2",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
+                "backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "top2",
             "backing_file_depth": 2,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.ovl2",
+            "backing_file": "TEST_DIR/t.IMGFMT.ovl2",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -607,7 +499,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl3",
+            "file": "TEST_DIR/t.IMGFMT.ovl3",
             "encryption_key_missing": false
         },
         {
@@ -615,7 +507,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2.ovl3",
+                "filename": "TEST_DIR/t.IMGFMT.ovl3",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -636,7 +528,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.ovl3",
+            "file": "TEST_DIR/t.IMGFMT.ovl3",
             "encryption_key_missing": false
         },
         {
@@ -644,26 +536,17 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2.base",
+                "filename": "TEST_DIR/t.IMGFMT.base",
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
             "ro": true,
             "node-name": "NODE_NAME",
             "backing_file_depth": 0,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
@@ -675,7 +558,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.base",
+            "file": "TEST_DIR/t.IMGFMT.base",
             "encryption_key_missing": false
         },
         {
@@ -683,7 +566,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 393216,
-                "filename": "TEST_DIR/t.qcow2.base",
+                "filename": "TEST_DIR/t.IMGFMT.base",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -704,7 +587,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2.base",
+            "file": "TEST_DIR/t.IMGFMT.base",
             "encryption_key_missing": false
         },
         {
@@ -713,49 +596,31 @@ wrote 65536/65536 bytes at offset 1048576
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.qcow2.base",
+                    "filename": "TEST_DIR/t.IMGFMT.base",
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
-                "backing-filename-format": "qcow2",
+                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
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
-                "full-backing-filename": "TEST_DIR/t.qcow2.base",
-                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "top",
             "backing_file_depth": 1,
-            "drv": "qcow2",
+            "drv": "IMGFMT",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.qcow2.base",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -764,7 +629,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "TEST_DIR/t.IMGFMT",
             "encryption_key_missing": false
         },
         {
@@ -772,7 +637,7 @@ wrote 65536/65536 bytes at offset 1048576
             "detect_zeroes": "off",
             "image": {
                 "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2",
+                "filename": "TEST_DIR/t.IMGFMT",
                 "format": "file",
                 "actual-size": SIZE,
                 "dirty-flag": false
@@ -793,7 +658,7 @@ wrote 65536/65536 bytes at offset 1048576
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
