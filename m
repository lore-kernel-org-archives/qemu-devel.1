Received: from eggs.gnu.org ([2001:4830:134:3::10]:59302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3w-00017o-HF
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3r-0002YX-7Y
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:37 +0200
Message-Id: <20171026131741.5059-32-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 31/35] iotests: Filter actual image size in 184
 and 191
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

From: Max Reitz <mreitz@redhat.com>

Whenever the actual image size is not part of the test, it should be
filtered as it depends on the host filesystem.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171009163456.485-3-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/184     |  3 ++-
 tests/qemu-iotests/184.out |  6 +++---
 tests/qemu-iotests/191     |  4 ++--
 tests/qemu-iotests/191.out | 46 +++++++++++++++++++++++-----------------------
 4 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 704f38f936..ee96c99af3 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -51,7 +51,8 @@ function do_run_qemu()
 function run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp\
-                          | _filter_qemu_io | _filter_generated_node_ids
+                          | _filter_qemu_io | _filter_generated_node_ids \
+                          | _filter_actual_image_size
 }
 
 _make_test_img 64M
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 0aed1a2220..4dc7984a85 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -32,7 +32,7 @@ Testing:
                 "filename": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
                 "cluster-size": 65536,
                 "format": "throttle",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -62,7 +62,7 @@ Testing:
                 "filename": "TEST_DIR/t.qcow2",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -100,7 +100,7 @@ Testing:
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.qcow2",
                 "format": "file",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 28bdea8f98..ad785e10b1 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -92,7 +92,7 @@ echo === Check that both top and top2 point to base now ===
 echo
 
 _send_qemu_cmd $h "{ 'execute': 'query-named-block-nodes' }" "^}" |
-    _filter_generated_node_ids
+    _filter_generated_node_ids | _filter_actual_image_size
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "^}"
 wait=1 _cleanup_qemu
@@ -140,7 +140,7 @@ echo === Check that both top and top2 point to base now ===
 echo
 
 _send_qemu_cmd $h "{ 'execute': 'query-named-block-nodes' }" "^}" |
-    _filter_generated_node_ids
+    _filter_generated_node_ids | _filter_actual_image_size
 
 _send_qemu_cmd $h "{ 'execute': 'quit' }" "^}"
 wait=1 _cleanup_qemu
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 6157fa520f..73c0ed454c 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -47,7 +47,7 @@ wrote 65536/65536 bytes at offset 1048576
                     "filename": "TEST_DIR/t.qcow2.base",
                     "cluster-size": 65536,
                     "format": "qcow2",
-                    "actual-size": 397312,
+                    "actual-size": SIZE,
                     "format-specific": {
                         "type": "qcow2",
                         "data": {
@@ -64,7 +64,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2.ovl2",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -105,7 +105,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.qcow2.ovl2",
                 "format": "file",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -136,7 +136,7 @@ wrote 65536/65536 bytes at offset 1048576
                     "filename": "TEST_DIR/t.qcow2.base",
                     "cluster-size": 65536,
                     "format": "qcow2",
-                    "actual-size": 397312,
+                    "actual-size": SIZE,
                     "format-specific": {
                         "type": "qcow2",
                         "data": {
@@ -153,7 +153,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -194,7 +194,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.qcow2",
                 "format": "file",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -225,7 +225,7 @@ wrote 65536/65536 bytes at offset 1048576
                     "filename": "TEST_DIR/t.qcow2.base",
                     "cluster-size": 65536,
                     "format": "qcow2",
-                    "actual-size": 397312,
+                    "actual-size": SIZE,
                     "format-specific": {
                         "type": "qcow2",
                         "data": {
@@ -242,7 +242,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2.mid",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 397312,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -283,7 +283,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 393216,
                 "filename": "TEST_DIR/t.qcow2.mid",
                 "format": "file",
-                "actual-size": 397312,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -313,7 +313,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2.base",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 397312,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -351,7 +351,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 393216,
                 "filename": "TEST_DIR/t.qcow2.base",
                 "format": "file",
-                "actual-size": 397312,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -450,7 +450,7 @@ wrote 65536/65536 bytes at offset 1048576
                     "filename": "TEST_DIR/t.qcow2.base",
                     "cluster-size": 65536,
                     "format": "qcow2",
-                    "actual-size": 397312,
+                    "actual-size": SIZE,
                     "format-specific": {
                         "type": "qcow2",
                         "data": {
@@ -467,7 +467,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2.ovl2",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -508,7 +508,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.qcow2.ovl2",
                 "format": "file",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -540,7 +540,7 @@ wrote 65536/65536 bytes at offset 1048576
                         "filename": "TEST_DIR/t.qcow2.base",
                         "cluster-size": 65536,
                         "format": "qcow2",
-                        "actual-size": 397312,
+                        "actual-size": SIZE,
                         "format-specific": {
                             "type": "qcow2",
                             "data": {
@@ -557,7 +557,7 @@ wrote 65536/65536 bytes at offset 1048576
                     "filename": "TEST_DIR/t.qcow2.ovl2",
                     "cluster-size": 65536,
                     "format": "qcow2",
-                    "actual-size": 200704,
+                    "actual-size": SIZE,
                     "format-specific": {
                         "type": "qcow2",
                         "data": {
@@ -576,7 +576,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2.ovl3",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -617,7 +617,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.qcow2.ovl3",
                 "format": "file",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -647,7 +647,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2.base",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 397312,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -685,7 +685,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 393216,
                 "filename": "TEST_DIR/t.qcow2.base",
                 "format": "file",
-                "actual-size": 397312,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
@@ -716,7 +716,7 @@ wrote 65536/65536 bytes at offset 1048576
                     "filename": "TEST_DIR/t.qcow2.base",
                     "cluster-size": 65536,
                     "format": "qcow2",
-                    "actual-size": 397312,
+                    "actual-size": SIZE,
                     "format-specific": {
                         "type": "qcow2",
                         "data": {
@@ -733,7 +733,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "filename": "TEST_DIR/t.qcow2",
                 "cluster-size": 65536,
                 "format": "qcow2",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "format-specific": {
                     "type": "qcow2",
                     "data": {
@@ -774,7 +774,7 @@ wrote 65536/65536 bytes at offset 1048576
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.qcow2",
                 "format": "file",
-                "actual-size": 200704,
+                "actual-size": SIZE,
                 "dirty-flag": false
             },
             "iops_wr": 0,
-- 
2.13.6
