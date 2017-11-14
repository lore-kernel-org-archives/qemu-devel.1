Received: from eggs.gnu.org ([2001:4830:134:3::10]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEewx-0005YG-D5
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEeww-0004Di-GN
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:02 +0100
Message-Id: <20171114172417.7654-6-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 05/20] qcow2: Add iotest for an image with
 header.refcount_table_offset == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

From: Alberto Garcia <berto@igalia.com>

This patch adds a simple iotest in which we try to write to an image
with the refcount table offset set to 0.

This scenario was already handled by the existing consistency checks,
but we add an explicit test case for completeness.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: feeceada92486bb8790b90f303fc9fe82a27391a.1509718618.git.berto@igalia.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/060     | 7 +++++++
 tests/qemu-iotests/060.out | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 656af50883..dc5a517673 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -277,6 +277,13 @@ _make_test_img 64M
 poke_file "$TEST_IMG" "56"                "\x00\x00\x00\x00"
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
 
+echo
+echo "=== Testing incorrect refcount table offset ==="
+echo
+_make_test_img 64M
+poke_file "$TEST_IMG" "48"                "\x00\x00\x00\x00\x00\x00\x00\x00"
+$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 58456e8487..98f314c16d 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -208,4 +208,10 @@ write failed: Input/output error
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.IMGFMT: Image does not contain a reference count table
+
+=== Testing incorrect refcount table offset ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
+write failed: Input/output error
 *** done
-- 
2.13.6
