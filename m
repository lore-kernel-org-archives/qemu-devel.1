Received: from eggs.gnu.org ([2001:4830:134:3::10]:42982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbP-0002nM-Cw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbO-0008Km-CQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:15 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:17 +0200
Message-Id: <20180809213528.14738-21-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 20/31] iotests: Add quorum case to
 test 110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

Test 110 tests relative backing filenames for complex BDS trees.  Now
that the originally supposedly failing test passes, let us add a new
failing test: Quorum can never work automatically (without detecting
whether all child nodes have the same base directory, but that would be
rather inconsistent behavior).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/110     | 26 ++++++++++++++++++++++++++
 tests/qemu-iotests/110.out |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index ba1b3c6c7d..08976c8a61 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -30,6 +30,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_test_img
+        rm -f "$TEST_IMG.copy"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -87,6 +88,31 @@ echo
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
 
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index 5370bc1d26..1d0b2475cc 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -19,4 +19,11 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
 === Backing name is always relative to the backed image ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=t.IMGFMT.base
+
+=== Nodes without a common directory ===
+
+image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.copy"}], "driver": "quorum", "blkverify": false, "rewrite-corrupted": false, "vote-threshold": 1}}
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+backing file: t.IMGFMT.base (cannot determine actual path)
 *** done
-- 
2.17.1
