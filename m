Received: from eggs.gnu.org ([2001:4830:134:3::10]:45456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er1Y5-0000Fu-L9
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er1Y4-0001vi-Na
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:13:33 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 14:13:15 +0100
Message-Id: <20180228131315.30194-3-mreitz@redhat.com>
In-Reply-To: <20180228131315.30194-1-mreitz@redhat.com>
References: <20180228131315.30194-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iotests: Test preallocated truncate of 2G
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-stable@nongnu.org

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/106     | 24 ++++++++++++++++++++++++
 tests/qemu-iotests/106.out | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index bfe71f4e60..5e51f88a78 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -86,6 +86,30 @@ for growth_mode in falloc full off; do
     $QEMU_IMG resize -f "$IMGFMT" --shrink --preallocation=$growth_mode "$TEST_IMG" -${GROWTH_SIZE}K
 done
 
+echo
+echo '=== Testing image growth on 2G empty image ==='
+
+for growth_mode in falloc full; do
+    echo
+    echo "--- growth_mode=$growth_mode ---"
+
+    # Maybe we want to do an lseek() to the end of the file before the
+    # preallocation; if the file has a length of 2 GB, that would
+    # return an integer that overflows to negative when put into a
+    # plain int.  We should use the correct type for the result, and
+    # this tests we do.
+
+    _make_test_img 2G
+    $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" +${GROWTH_SIZE}K
+
+    actual_size=$($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep 'disk size')
+    actual_size=$(echo "$actual_size" | sed -e 's/^[^0-9]*\([0-9]\+\).*$/\1/')
+
+    if [ $actual_size -lt $GROWTH_SIZE ]; then
+        echo "ERROR: Image should have at least ${GROWTH_SIZE}K, but has ${actual_size}K"
+    fi
+done
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/106.out b/tests/qemu-iotests/106.out
index 0a42312301..c459957660 100644
--- a/tests/qemu-iotests/106.out
+++ b/tests/qemu-iotests/106.out
@@ -47,4 +47,14 @@ qemu-img: Preallocation can only be used for growing images
 
 --- growth_mode=off ---
 Image resized.
+
+=== Testing image growth on 2G empty image ===
+
+--- growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2147483648
+Image resized.
+
+--- growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2147483648
+Image resized.
 *** done
-- 
2.14.3
