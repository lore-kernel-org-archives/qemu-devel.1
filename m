Received: from eggs.gnu.org ([2001:4830:134:3::10]:53445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2P-0003li-Bp
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2M-0005ur-6q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:27 +0100
Message-Id: <20180213170529.10858-54-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 53/55] iotests: Test valid values of
 l2-cache-entry-size
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

From: Alberto Garcia <berto@igalia.com>

The l2-cache-entry-size setting can only contain values that are
powers of two between 512 and the cluster size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: bd3547b670b8d0af11480c760991a22bcae5b48c.1517840877.git.berto@igalia.com
[mreitz: Changed non-power-of-two test value from 300 to 4242]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/103     | 17 +++++++++++++++++
 tests/qemu-iotests/103.out |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index d0cfab8844..2841318492 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -66,6 +66,14 @@ $QEMU_IO -c "open -o cache-size=1M,refcount-cache-size=2M $TEST_IMG" 2>&1 \
 $QEMU_IO -c "open -o cache-size=0,l2-cache-size=0,refcount-cache-size=0 $TEST_IMG" \
     2>&1 | _filter_testdir | _filter_imgfmt
 
+# Invalid cache entry sizes
+$QEMU_IO -c "open -o l2-cache-entry-size=256 $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o l2-cache-entry-size=4242 $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o l2-cache-entry-size=128k $TEST_IMG" \
+    2>&1 | _filter_testdir | _filter_imgfmt
+
 echo
 echo '=== Testing valid option combinations ==='
 echo
@@ -94,6 +102,15 @@ $QEMU_IO -c "open -o l2-cache-size=1M,refcount-cache-size=0.25M $TEST_IMG" \
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
2.13.6
