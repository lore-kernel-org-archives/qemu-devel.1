Received: from eggs.gnu.org ([2001:4830:134:3::10]:51034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eKB5j-0006r9-W9
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 17:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eKB5j-0005Tm-55
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 17:44:32 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Nov 2017 17:44:21 -0500
Message-Id: <20171129224421.18192-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

VPC has some difficulty creating geometries of particular size.
However, we can indeed force it to use a literal one, so let's
do that for the sake of test 197, which is testing some specific
offsets.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/197           | 3 +++
 tests/qemu-iotests/common.filter | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 887eb4f496..e1292689c1 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -60,6 +60,9 @@ echo '=== Copy-on-read ==='
 echo
 
 # Prep the images
+if [ "$IMGFMT" = "vpc" ]; then
+    IMGOPTS=$(_optstr_add "$IMGOPTS" "force_size")
+fi
 _make_test_img 4G
 $QEMU_IO -c "write -P 55 3G 1k" "$TEST_IMG" | _filter_qemu_io
 IMGPROTO=file IMGFMT=qcow2 IMGOPTS= TEST_IMG_FILE="$TEST_WRAP" \
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index d9237799e9..f08248bfd9 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -134,7 +134,8 @@ _filter_img_create()
         -e "s# log_size=[0-9]\\+##g" \
         -e "s# refcount_bits=[0-9]\\+##g" \
         -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=[0-9]\\+##g"
+        -e "s# iter-time=[0-9]\\+##g" \
+        -e "s# force_size=\\(on\\|off\\)##g"
 }
 
 _filter_img_info()
-- 
2.14.3
