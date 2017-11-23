Received: from eggs.gnu.org ([2001:4830:134:3::10]:34332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxu-0005ZN-JQ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxt-0002Nk-C4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:10:10 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:30 +0100
Message-Id: <20171123020832.8165-16-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 15/17] iotests: Make 184 image-less
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

184 does not need an image, so don't use one.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/184     | 25 ++++--------------
 tests/qemu-iotests/184.out | 63 +++++++---------------------------------------
 2 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index ee96c99af3..2b68284d58 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -27,18 +27,12 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2
-_supported_proto file
 _supported_os Linux
 
 function do_run_qemu()
@@ -55,7 +49,6 @@ function run_qemu()
                           | _filter_actual_image_size
 }
 
-_make_test_img 64M
 test_throttle=$($QEMU_IMG --help|grep throttle)
 [ "$test_throttle" = "" ] && _supported_fmt throttle
 
@@ -66,12 +59,8 @@ run_qemu <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "blockdev-add",
   "arguments": {
-    "driver": "$IMGFMT",
-    "node-name": "disk0",
-    "file": {
-      "driver": "file",
-      "filename": "$TEST_IMG"
-    }
+    "driver": "null-co",
+    "node-name": "disk0"
   }
 }
 { "execute": "object-add",
@@ -181,12 +170,8 @@ run_qemu <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "blockdev-add",
   "arguments": {
-    "driver": "$IMGFMT",
-    "node-name": "disk0",
-    "file": {
-      "driver": "file",
-      "filename": "$TEST_IMG"
-    }
+    "driver": "null-co",
+    "node-name": "disk0"
   }
 }
 { "execute": "blockdev-add",
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 4dc7984a85..672650cde8 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -1,5 +1,4 @@
 QA output created by 184
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 == checking interface ==
 Testing:
@@ -28,12 +27,9 @@ Testing:
             "iops_rd": 0,
             "detect_zeroes": "off",
             "image": {
-                "virtual-size": 67108864,
-                "filename": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
-                "cluster-size": 65536,
-                "format": "throttle",
-                "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 1073741824,
+                "filename": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
+                "format": "throttle"
             },
             "iops_wr": 0,
             "ro": false,
@@ -51,34 +47,22 @@ Testing:
                 "direct": false,
                 "writeback": true
             },
-            "file": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+            "file": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
             "encryption_key_missing": false
         },
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
             "image": {
-                "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.qcow2",
-                "cluster-size": 65536,
-                "format": "qcow2",
-                "actual-size": SIZE,
-                "format-specific": {
-                    "type": "qcow2",
-                    "data": {
-                        "compat": "1.1",
-                        "lazy-refcounts": false,
-                        "refcount-bits": 16,
-                        "corrupt": false
-                    }
-                },
-                "dirty-flag": false
+                "virtual-size": 1073741824,
+                "filename": "null-co://",
+                "format": "null-co"
             },
             "iops_wr": 0,
             "ro": false,
             "node-name": "disk0",
             "backing_file_depth": 0,
-            "drv": "qcow2",
+            "drv": "null-co",
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
@@ -90,36 +74,7 @@ Testing:
                 "direct": false,
                 "writeback": true
             },
-            "file": "TEST_DIR/t.qcow2",
-            "encryption_key_missing": false
-        },
-        {
-            "iops_rd": 0,
-            "detect_zeroes": "off",
-            "image": {
-                "virtual-size": 197120,
-                "filename": "TEST_DIR/t.qcow2",
-                "format": "file",
-                "actual-size": SIZE,
-                "dirty-flag": false
-            },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
-            "cache": {
-                "no-flush": false,
-                "direct": false,
-                "writeback": true
-            },
-            "file": "TEST_DIR/t.qcow2",
+            "file": "null-co://",
             "encryption_key_missing": false
         }
     ]
-- 
2.13.6
