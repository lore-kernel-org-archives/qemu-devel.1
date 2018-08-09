Received: from eggs.gnu.org ([2001:4830:134:3::10]:43944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdc-0004nm-OD
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdb-0004cc-N0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:32 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:38:00 +0200
Message-Id: <20180809213801.15098-11-mreitz@redhat.com>
In-Reply-To: <20180809213801.15098-1-mreitz@redhat.com>
References: <20180809213801.15098-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] iotests: Add test for commit in sub
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Add a test for committing an overlay in a sub directory to one of the
images in its backing chain, using both relative and absolute filenames.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/020     | 36 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/020.out | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index eac5080f83..d0ac33922d 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -32,6 +32,11 @@ _cleanup()
 	_cleanup_test_img
     rm -f "$TEST_IMG.base"
     rm -f "$TEST_IMG.orig"
+
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base"
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT.mid"
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT"
+    rmdir "$TEST_DIR/subdir" &> /dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -135,6 +140,37 @@ $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG commit "$TEST_IMG"
 _cleanup
 
+
+echo
+echo 'Testing commit in sub-directory with relative filenames'
+echo
+
+pushd "$TEST_DIR" > /dev/null
+
+mkdir subdir
+
+TEST_IMG="subdir/t.$IMGFMT.base" _make_test_img 1M
+TEST_IMG="subdir/t.$IMGFMT.mid" _make_test_img -b "t.$IMGFMT.base"
+TEST_IMG="subdir/t.$IMGFMT" _make_test_img -b "t.$IMGFMT.mid"
+
+# Should work
+$QEMU_IMG commit -b "t.$IMGFMT.mid" "subdir/t.$IMGFMT"
+
+# Might theoretically work, but does not in practice (we have to
+# decide between this and the above; and since we always represent
+# backing file names as relative to the overlay, we go for the above)
+$QEMU_IMG commit -b "subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT" 2>&1 | \
+    _filter_imgfmt
+
+# This should work as well
+$QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT"
+
+popd > /dev/null
+
+# Now let's try with just absolute filenames
+$QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" \
+    "$TEST_DIR/subdir/t.$IMGFMT"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 4b722b2dd0..228c37dded 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1094,4 +1094,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driv
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Block job failed: No space left on device
+
+Testing commit in sub-directory with relative filenames
+
+Formatting 'subdir/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'subdir/t.IMGFMT.mid', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.base
+Formatting 'subdir/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.mid
+Image committed.
+qemu-img: Did not find 'subdir/t.IMGFMT.mid' in the backing chain of 'subdir/t.IMGFMT'
+Image committed.
+Image committed.
 *** done
-- 
2.17.1
