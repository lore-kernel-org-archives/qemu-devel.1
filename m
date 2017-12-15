Received: from eggs.gnu.org ([2001:4830:134:3::10]:55497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVG-0000Wm-Rn
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003Io-Rw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:14 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:54:00 +0100
Message-Id: <da113a5225f62056c387ac87eb61aa85f918bb84.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 32/32] iotests: Add test for
 l2-cache-entry-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

The l2-cache-entry-size setting can only contain values that are
powers of two between 512 and the cluster size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/103     | 17 +++++++++++++++++
 tests/qemu-iotests/103.out |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index ecbd8ebd71..6d9aab986b 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -64,6 +64,14 @@ $QEMU_IO -c "open -o cache-size=1M,refcount-cache-size=2M $TEST_IMG" 2>&1 \
 $QEMU_IO -c "open -o cache-size=0,l2-cache-size=0,refcount-cache-size=0 $TEST_IMG" \
     2>&1 | _filter_testdir | _filter_imgfmt
 
+# Invalid cache entry sizes
+$QEMU_IO -c "open -o l2-cache-entry-size=256 $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o l2-cache-entry-size=300 $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o l2-cache-entry-size=128k $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+
 echo
 echo '=== Testing valid option combinations ==='
 echo
@@ -92,6 +100,15 @@ $QEMU_IO -c "open -o l2-cache-size=1M,refcount-cache-size=0.25M $TEST_IMG" \
          -c 'read -P 42 0 64k' \
     | _filter_qemu_io
 
+# Valid cache entry sizes
+$QEMU_IO -c "open -o l2-cache-entry-size=512 $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o l2-cache-entry-size=16k $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o l2-cache-entry-size=64k $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+
+
 echo
 echo '=== Testing minimal L2 cache and COW ==='
 echo
diff --git a/tests/qemu-iotests/103.out b/tests/qemu-iotests/103.out
index b7aaadf89a..bd45d3875a 100644
--- a/tests/qemu-iotests/103.out
+++ b/tests/qemu-iotests/103.out
@@ -9,6 +9,9 @@ can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cach
 can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed cache-size
 can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not exceed cache-size
 can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
+can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 
 === Testing valid option combinations ===
 
-- 
2.11.0
