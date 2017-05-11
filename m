Received: from eggs.gnu.org ([2001:4830:134:3::10]:36688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAI-00029N-4S
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAG-0007Bv-NS
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:30 +0200
Message-Id: <1494513181-7900-28-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 27/58] iotests: Extend test 066
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

066 was supposed to be a test "for discarding preallocated zero
clusters", but it did so incompletely: While it did check the image
file's integrity after the operation, it did not confirm that the
clusters are indeed freed. This patch adds this test.

In addition, new cases for writing to preallocated zero clusters are
added.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/066     | 128 ++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/066.out |  46 ++++++++++++++++
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index c2116a3..8638217 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -1,6 +1,6 @@
 #!/bin/bash
 #
-# Test case for discarding preallocated zero clusters in qcow2
+# Test case for preallocated zero clusters in qcow2
 #
 # Copyright (C) 2013 Red Hat, Inc.
 #
@@ -55,8 +55,134 @@ _make_test_img $IMG_SIZE
 $QEMU_IO -c "write 0 256k" -c "write -z 0 256k" -c "write 64M 512" \
 	 -c "discard 0 $IMG_SIZE" -c "read -P 0 0 $IMG_SIZE" "$TEST_IMG" \
          | _filter_qemu_io
+
 # Check the image (there shouldn't be any leaks)
 _check_test_img
+# Map the image (we want all clusters to be gone)
+$QEMU_IMG map "$TEST_IMG"
+
+_cleanup_test_img
+
+
+echo
+echo '=== Writing to preallocated zero clusters ==='
+echo
+
+_make_test_img $IMG_SIZE
+
+# Create data clusters (not aligned to an L2 table)
+$QEMU_IO -c 'write -P 42 1M 256k' "$TEST_IMG" | _filter_qemu_io
+orig_map=$($QEMU_IMG map --output=json "$TEST_IMG")
+
+# Convert the data clusters to preallocated zero clusters
+$QEMU_IO -c 'write -z 1M 256k' "$TEST_IMG" | _filter_qemu_io
+
+# Now write to them (with a COW needed for the head and tail)
+$QEMU_IO -c "write -P 23 $(((1024 + 32) * 1024)) 192k" "$TEST_IMG" \
+    | _filter_qemu_io
+
+# Check metadata correctness
+_check_test_img
+
+# Check data correctness
+$QEMU_IO -c "read -P  0 $(( 1024             * 1024)) 32k" \
+         -c "read -P 23 $(((1024 + 32)       * 1024)) 192k" \
+         -c "read -P  0 $(((1024 + 32 + 192) * 1024)) 32k" \
+         "$TEST_IMG" \
+         | _filter_qemu_io
+
+# Check that we have actually reused the original area
+new_map=$($QEMU_IMG map --output=json "$TEST_IMG")
+if [ "$new_map" = "$orig_map" ]; then
+    echo 'Successfully reused original clusters.'
+else
+    echo 'Failed to reuse original clusters.'
+    echo 'Original map:'
+    echo "$orig_map"
+    echo 'New map:'
+    echo "$new_map"
+fi
+
+_cleanup_test_img
+
+
+echo
+echo '=== Writing to a snapshotted preallocated zero cluster ==='
+echo
+
+_make_test_img 64k
+
+# Create a preallocated zero cluster
+$QEMU_IO -c 'write -P 42 0 64k' -c 'write -z 0 64k' "$TEST_IMG" \
+    | _filter_qemu_io
+
+# Snapshot it
+$QEMU_IMG snapshot -c foo "$TEST_IMG"
+
+# Write to the cluster
+$QEMU_IO -c 'write -P 23 0 64k' "$TEST_IMG" | _filter_qemu_io
+
+# Check metadata correctness
+_check_test_img
+
+# Check data correctness
+$QEMU_IO -c 'read -P 23 0 64k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -a foo "$TEST_IMG"
+$QEMU_IO -c 'read -P 0 0 64k' "$TEST_IMG" | _filter_qemu_io
+
+_cleanup_test_img
+
+
+echo
+echo '=== Consecutive write to a preallocated zero cluster ==='
+echo
+
+_make_test_img 192k
+
+# Create three normal clusters
+$QEMU_IO -c 'write -P 42 0 192k' "$TEST_IMG" | _filter_qemu_io
+orig_map=$($QEMU_IMG map --output=json "$TEST_IMG")
+
+# Make the middle cluster a preallocated zero cluster
+$QEMU_IO -c 'write -z 64k 64k' "$TEST_IMG" | _filter_qemu_io
+
+# Try to overwrite everything: This should reuse the whole range. To test that
+# this only issues a single continuous write request, use blkdebug.
+$QEMU_IO -c 'write -P 42 0 192k' \
+    "json:{
+        'driver': '$IMGFMT',
+        'file': {
+            'driver': 'blkdebug',
+            'image.filename': '$TEST_IMG',
+            'set-state': [{
+                'event': 'write_aio',
+                'new_state': 2
+            }],
+            'inject-error': [{
+                'event': 'write_aio',
+                'state': 2
+            }]
+        }
+    }" \
+    | _filter_qemu_io
+
+# Check metadata correctness
+_check_test_img
+
+# Check that we have actually reused the original area
+new_map=$($QEMU_IMG map --output=json "$TEST_IMG")
+if [ "$new_map" = "$orig_map" ]; then
+    echo 'Successfully reused original clusters.'
+else
+    echo 'Failed to reuse original clusters.'
+    echo 'Original map:'
+    echo "$orig_map"
+    echo 'New map:'
+    echo "$new_map"
+fi
+
+_cleanup_test_img
+
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/066.out b/tests/qemu-iotests/066.out
index 7c1f31a..3d9da9b 100644
--- a/tests/qemu-iotests/066.out
+++ b/tests/qemu-iotests/066.out
@@ -14,4 +14,50 @@ discard 67109376/67109376 bytes at offset 0
 read 67109376/67109376 bytes at offset 0
 64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+Offset          Length          Mapped to       File
+
+=== Writing to preallocated zero clusters ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67109376
+wrote 262144/262144 bytes at offset 1048576
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 1048576
+256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 196608/196608 bytes at offset 1081344
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+read 32768/32768 bytes at offset 1048576
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 196608/196608 bytes at offset 1081344
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 32768/32768 bytes at offset 1277952
+32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Successfully reused original clusters.
+
+=== Writing to a snapshotted preallocated zero cluster ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Consecutive write to a preallocated zero cluster ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=196608
+wrote 196608/196608 bytes at offset 0
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 196608/196608 bytes at offset 0
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+Successfully reused original clusters.
 *** done
-- 
1.8.3.1
