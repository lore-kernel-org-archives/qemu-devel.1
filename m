Received: from eggs.gnu.org ([2001:4830:134:3::10]:51067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxu-0002EV-OL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxu-0005By-2Z
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:28 +0200
Message-Id: <20180723164530.26599-6-kwolf@redhat.com>
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] iotest: Fix filtering order in 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Max Reitz <mreitz@redhat.com>

The test directory should be filtered before the image format, otherwise
the test will fail if the image format is part of the test directory,
like so:

[...]
-can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+can't open: Could not open '/tmp/test-IMGFMT/t.IMGFMT': Is a directory
[...]

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/226 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 34987d43f9..211ea9888a 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -55,10 +55,10 @@ for PROTO in "file" "host_device" "host_cdrom"; do
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
2.13.6
