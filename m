Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIC-0001Md-3r
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIA-0002MI-Ld
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:52 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:22 -0500
Message-Id: <20180723201748.25573-14-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/99] iotests: Add test for rebasing with
 relative paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509182002.8044-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 28036a7f7044fddb79819e3c8fcb4ae5605c60e0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/024     | 82 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/024.out | 30 ++++++++++++++
 2 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index e0d77ce2f5..4071ed6093 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -29,9 +29,14 @@ status=1	# failure is the default!
 
 _cleanup()
 {
-	_cleanup_test_img
-	rm -f "$TEST_DIR/t.$IMGFMT.base_old"
-	rm -f "$TEST_DIR/t.$IMGFMT.base_new"
+    _cleanup_test_img
+    rm -f "$TEST_DIR/t.$IMGFMT.base_old"
+    rm -f "$TEST_DIR/t.$IMGFMT.base_new"
+
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT"
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_old"
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base_new"
+    rmdir "$TEST_DIR/subdir" 2> /dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -123,6 +128,77 @@ io_pattern readv $((13 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x00
 io_pattern readv $((14 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x11
 io_pattern readv $((15 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x00
 
+echo
+echo "=== Test rebase in a subdirectory of the working directory ==="
+echo
+
+# Clean up the old images beforehand so they do not interfere with
+# this test
+_cleanup
+
+mkdir "$TEST_DIR/subdir"
+
+# Relative to the overlay
+BASE_OLD_OREL="t.$IMGFMT.base_old"
+BASE_NEW_OREL="t.$IMGFMT.base_new"
+
+# Relative to $TEST_DIR (which is going to be our working directory)
+OVERLAY_WREL="subdir/t.$IMGFMT"
+
+BASE_OLD="$TEST_DIR/subdir/$BASE_OLD_OREL"
+BASE_NEW="$TEST_DIR/subdir/$BASE_NEW_OREL"
+OVERLAY="$TEST_DIR/$OVERLAY_WREL"
+
+# Test done here:
+#
+# Backing (old): 11 11 -- 11
+# Backing (new): -- 22 22 11
+# Overlay:       -- -- -- --
+#
+# Rebasing works, we have verified that above.  Here, we just want to
+# see that rebasing is done for the correct target backing file.
+
+TEST_IMG=$BASE_OLD _make_test_img 1M
+TEST_IMG=$BASE_NEW _make_test_img 1M
+TEST_IMG=$OVERLAY _make_test_img -b "$BASE_OLD_OREL" 1M
+
+echo
+
+$QEMU_IO "$BASE_OLD" \
+    -c "write -P 0x11 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "write -P 0x11 $((3 * CLUSTER_SIZE)) $((1 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+$QEMU_IO "$BASE_NEW" \
+    -c "write -P 0x22 $((1 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "write -P 0x11 $((3 * CLUSTER_SIZE)) $((1 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+echo
+
+pushd "$TEST_DIR" >/dev/null
+$QEMU_IMG rebase -f "$IMGFMT" -b "$BASE_NEW_OREL" "$OVERLAY_WREL"
+popd >/dev/null
+
+# Verify the backing path is correct
+TEST_IMG=$OVERLAY _img_info | grep '^backing file'
+
+echo
+
+# Verify the data is correct
+$QEMU_IO "$OVERLAY" \
+    -c "read -P 0x11 $((0 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "read -P 0x11 $((1 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "read -P 0x00 $((2 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "read -P 0x11 $((3 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
+
+# Verify that cluster #3 is not allocated (because it is the same in
+# $BASE_OLD and $BASE_NEW)
+$QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
+
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 33cfaf5cfc..024dc786b3 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -141,4 +141,34 @@ read 65536/65536 bytes at offset 917504
 === IO: pattern 0x00
 read 65536/65536 bytes at offset 983040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Test rebase in a subdirectory of the working directory ===
+
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.base_old
+
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 196608
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 65536
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 196608
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+backing file: t.IMGFMT.base_new (actual path: TEST_DIR/subdir/t.IMGFMT.base_new)
+
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 196608
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Offset          Length          File
+0               0x30000         TEST_DIR/subdir/t.IMGFMT
+0x30000         0x10000         TEST_DIR/subdir/t.IMGFMT.base_new
 *** done
-- 
2.17.1
