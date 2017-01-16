Received: from eggs.gnu.org ([2001:4830:134:3::10]:45748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDu-00011N-9y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDt-0003rR-Cv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:50 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:49:13 +0100
Message-Id: <20170116204921.31578-10-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 17/25] iotests: Add quorum case to test 110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Test 110 tests relative backing filenames for complex BDS trees. Add
quorum as an example that can never work automatically (without
special-casing if all child nodes have the same base directory), and an
example on how to make it work manually (using the base-directory
option).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/110     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/110.out | 12 ++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index ba1b3c6c7d..d96b656b6b 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -30,6 +30,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_test_img
+        rm -f "$TEST_IMG.copy"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -87,6 +88,53 @@ echo
 # omit the image size; it should work anyway
 _make_test_img -b "$TEST_IMG_REL.base"
 
+echo
+echo '=== Nodes without a common directory ==='
+echo
+
+cp "$TEST_IMG" "$TEST_IMG.copy"
+
+# Should inform us that the actual path of the backing file cannot be determined
+TEST_IMG="json:{
+    'driver': '$IMGFMT',
+    'file': {
+        'driver': 'quorum',
+        'vote-threshold': 1,
+        'children': [
+            {
+                'driver': 'file',
+                'filename': '$TEST_IMG'
+            },
+            {
+                'driver': 'file',
+                'filename': '$TEST_IMG.copy'
+            }
+        ]
+    }
+}" _img_info | _filter_img_info
+
+echo
+
+# Should work fine
+TEST_IMG="json:{
+    'driver': '$IMGFMT',
+    'file': {
+        'driver': 'quorum',
+        'base-directory': '$TEST_DIR/',
+        'vote-threshold': 1,
+        'children': [
+            {
+                'driver': 'file',
+                'filename': '$TEST_IMG'
+            },
+            {
+                'driver': 'file',
+                'filename': '$TEST_IMG.copy'
+            }
+        ]
+    }
+}" _img_info | _filter_img_info
+
 
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 5370bc1d26..e1845d8026 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -19,4 +19,16 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
 === Backing name is always relative to the backed image ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=t.IMGFMT.base
+
+=== Nodes without a common directory ===
+
+image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.copy"}], "driver": "quorum", "blkverify": false, "rewrite-corrupted": false, "vote-threshold": 1}}
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+backing file: t.IMGFMT.base (cannot determine actual path)
+
+image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.copy"}], "driver": "quorum", "blkverify": false, "rewrite-corrupted": false, "vote-threshold": 1}}
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
 *** done
-- 
2.11.0
