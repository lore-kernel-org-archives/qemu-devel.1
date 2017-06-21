Received: from eggs.gnu.org ([2001:4830:134:3::10]:34264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6w-0008HZ-HQ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6r-0005OW-Jh
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:39 +0200
Message-Id: <20170621125047.30294-18-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 17/25] iotests: Add quorum case to test 110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

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
index ba1b3c6..d96b656 100755
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
index 5370bc1..e1845d8 100644
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
2.9.4
