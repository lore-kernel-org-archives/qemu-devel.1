Received: from eggs.gnu.org ([2001:4830:134:3::10]:35810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwH2-00057w-QK
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwGz-0006Ld-Ko
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:40 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 24 Jul 2018 15:17:53 +0300
Message-Id: <20180724121753.5753-5-lbloch@janustech.com>
In-Reply-To: <20180724121753.5753-1-lbloch@janustech.com>
References: <20180724121753.5753-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] iotests: Add tests for the new
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch adds tests for the l2-cache-full option, and also intcoduces
a small change due to a grammar fix in block/qcow2.c

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 tests/qemu-iotests/103     | 6 ++++++
 tests/qemu-iotests/103.out | 4 +++-
 tests/qemu-iotests/137     | 2 ++
 tests/qemu-iotests/137.out | 4 +++-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 2841318492..a2886e8569 100755
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
+$QEMU_IO -c "open -o l2-cache-full,cache-size=6K $TEST_IMG" 2>&1 |
+    _filter_testdir | _filter_imgfmt
 # l2-cache-size may not exceed cache-size
 $QEMU_IO -c "open -o cache-size=1M,l2-cache-size=2M $TEST_IMG" 2>&1 \
     | _filter_testdir | _filter_imgfmt
diff --git a/tests/qemu-iotests/103.out b/tests/qemu-iotests/103.out
index bd45d3875a..92afbff024 100644
--- a/tests/qemu-iotests/103.out
+++ b/tests/qemu-iotests/103.out
@@ -5,7 +5,9 @@ wrote 65536/65536 bytes at offset 0
 
 === Testing invalid option combinations ===
 
-can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
+can't open device TEST_DIR/t.IMGFMT: l2-cache-full and l2-cache-size may not be set at the same time
+can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
+can't open device TEST_DIR/t.IMGFMT: cache-size must be greater than the full L2 cache if l2-cache-full is used
 can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed cache-size
 can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not exceed cache-size
 can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
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
index 96724a6c33..b15dfc391a 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -16,7 +16,9 @@ read 33554432/33554432 bytes at offset 0
 === Try setting some invalid values ===
 
 Parameter 'lazy-refcounts' expects 'on' or 'off'
-cache-size, l2-cache-size and refcount-cache-size may not be set the same time
+l2-cache-full and l2-cache-size may not be set at the same time
+cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
+cache-size must be greater than the full L2 cache if l2-cache-full is used
 l2-cache-size may not exceed cache-size
 refcount-cache-size may not exceed cache-size
 L2 cache size too big
-- 
2.14.1
