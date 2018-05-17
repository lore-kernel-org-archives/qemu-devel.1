Received: from eggs.gnu.org ([2001:4830:134:3::10]:40460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9I-0006lm-NP
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9H-0006y3-OO
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 17 May 2018 18:52:52 +0200
Message-Id: <20180517165253.19958-3-kwolf@redhat.com>
In-Reply-To: <20180517165253.19958-1-kwolf@redhat.com>
References: <20180517165253.19958-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-iotests: Filter NFS paths
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

NFS paths were only partially filtered in _filter_img_create, _img_info
and _filter_img_info, resulting in "nfs://127.0.0.1TEST_DIR/t.IMGFMT".
This adds another replacement to the sed calls that matches $TEST_IMG as
a whole.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.filter | 6 ++++--
 tests/qemu-iotests/common.rc     | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index c5f4bcf578..ae83591337 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -119,7 +119,8 @@ _filter_actual_image_size()
 # replace driver-specific options in the "Formatting..." line
 _filter_img_create()
 {
-    sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
+    sed -e "s#$TEST_IMG#TEST_DIR/t.IMGFMT#g" \
+        -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
@@ -154,7 +155,8 @@ _filter_img_info()
 
     discard=0
     regex_json_spec_start='^ *"format-specific": \{'
-    sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
+    sed -e "s#$TEST_IMG#TEST_DIR/t.IMGFMT#g" \
+        -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index cb5fa14e7f..a055d8b032 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -333,7 +333,8 @@ _img_info()
     discard=0
     regex_json_spec_start='^ *"format-specific": \{'
     $QEMU_IMG info $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" 2>&1 | \
-        sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
+        sed -e "s#$TEST_IMG#TEST_DIR/t.IMGFMT#g" \
+            -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
             -e "s#$IMGFMT#IMGFMT#g" \
             -e "/^disk size:/ D" \
-- 
2.13.6
