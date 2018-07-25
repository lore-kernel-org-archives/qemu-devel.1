Received: from eggs.gnu.org ([2001:4830:134:3::10]:47547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmQ-0005Bb-Mb
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmN-0000Jj-MZ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:42 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed, 25 Jul 2018 17:27:58 +0300
Message-Id: <20180725142758.9980-5-lbloch@janustech.com>
In-Reply-To: <20180725142758.9980-1-lbloch@janustech.com>
References: <20180725142758.9980-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/4] iotests: Add tests for the new
 l2-cache-full option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 tests/qemu-iotests/103     | 6 ++++++
 tests/qemu-iotests/103.out | 2 ++
 tests/qemu-iotests/137     | 2 ++
 tests/qemu-iotests/137.out | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 2841318492..85010c6a6d 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -52,9 +52,15 @@ echo
 echo '=== Testing invalid option combinations ==='
 echo
 
+# l2-cache-size and l2-cache-full at the same time
+$QEMU_IO -c "open -o l2-cache-full,l2-cache-size=1M $TEST_IMG" 2>&1 |
+    _filter_testdir | _filter_imgfmt
 # all sizes set at the same time
 $QEMU_IO -c "open -o cache-size=1.25M,l2-cache-size=1M,refcount-cache-size=0.25M $TEST_IMG" \
     2>&1 | _filter_testdir | _filter_imgfmt
+# cache-size may not be smaller than the full L2 size if l2-cache-full is used
+$QEMU_IO -c "open -o l2-cache-full,cache-size=6 $TEST_IMG" 2>&1 |
+    _filter_testdir | _filter_imgfmt
 # l2-cache-size may not exceed cache-size
 $QEMU_IO -c "open -o cache-size=1M,l2-cache-size=2M $TEST_IMG" 2>&1 \
     | _filter_testdir | _filter_imgfmt
diff --git a/tests/qemu-iotests/103.out b/tests/qemu-iotests/103.out
index bd9eec3250..f4bac5371b 100644
--- a/tests/qemu-iotests/103.out
+++ b/tests/qemu-iotests/103.out
@@ -5,7 +5,9 @@ wrote 65536/65536 bytes at offset 0
 
 === Testing invalid option combinations ===
 
+can't open device TEST_DIR/t.IMGFMT: l2-cache-size and l2-cache-full may not be set at the same time
 can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
+can't open device TEST_DIR/t.IMGFMT: cache-size must be greater than the full L2 cache if l2-cache-full is used
 can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed cache-size
 can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not exceed cache-size
 can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 87965625d8..f460b5bfe1 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -106,7 +106,9 @@ echo
 
 $QEMU_IO \
     -c "reopen -o lazy-refcounts=42" \
+    -c "reopen -o l2-cache-full,l2-cache-size=64k" \
     -c "reopen -o cache-size=1M,l2-cache-size=64k,refcount-cache-size=64k" \
+    -c "reopen -o l2-cache-full,cache-size=6K" \
     -c "reopen -o cache-size=1M,l2-cache-size=2M" \
     -c "reopen -o cache-size=1M,refcount-cache-size=2M" \
     -c "reopen -o l2-cache-size=256T" \
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 6a2ffc71fd..1ef10ac554 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -16,7 +16,9 @@ read 33554432/33554432 bytes at offset 0
 === Try setting some invalid values ===
 
 Parameter 'lazy-refcounts' expects 'on' or 'off'
+l2-cache-size and l2-cache-full may not be set at the same time
 cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
+cache-size must be greater than the full L2 cache if l2-cache-full is used
 l2-cache-size may not exceed cache-size
 refcount-cache-size may not exceed cache-size
 L2 cache size too big
-- 
2.14.1
