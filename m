Received: from eggs.gnu.org ([2001:4830:134:3::10]:58556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fe3wE-0001t2-Oh
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 15:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fe3wE-0000v4-2D
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 15:41:10 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jul 2018 21:41:00 +0200
Message-Id: <20180713194100.7511-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotest: Fix filtering order in 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

The test directory should be filtered before the image format, otherwise
the test will fail if the image format is part of the test directory,
like so:

[...]
-can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+can't open: Could not open '/tmp/test-IMGFMT/t.IMGFMT': Is a directory
[...]

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/226 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 460aea2fc9..a5a1f6720a 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -52,10 +52,10 @@ for PROTO in "file" "host_device" "host_cdrom"; do
     echo "=== Testing with driver:$PROTO ==="
     echo
     echo "== Testing RO =="
-    $QEMU_IO -c "open -r -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_imgfmt | _filter_testdir
+    $QEMU_IO -c "open -r -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
     $QEMU_IO -c "open -r -o driver=$PROTO,filename=/dev/null" 2>&1 | _filter_imgfmt
     echo "== Testing RW =="
-    $QEMU_IO -c "open -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_imgfmt | _filter_testdir
+    $QEMU_IO -c "open -o driver=$PROTO,filename=$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
     $QEMU_IO -c "open -o driver=$PROTO,filename=/dev/null" 2>&1 | _filter_imgfmt
 done
 
-- 
2.17.1
