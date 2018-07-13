Received: from eggs.gnu.org ([2001:4830:134:3::10]:43941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw21-0005nn-LA
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw20-0002es-BE
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jul 2018 13:14:24 +0200
Message-Id: <20180713111424.23670-4-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
References: <20180713111424.23670-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] iotests: Add test for rebase without input
 base
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

This patch adds a test for rebasing an image that currently does not
have a backing file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/024     | 70 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 37 ++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 4071ed6093..471fa629ac 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -199,6 +199,76 @@ echo
 # $BASE_OLD and $BASE_NEW)
 $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
 
+echo
+echo "=== Test rebase without input base ==="
+echo
+
+# Cluster allocations to be tested:
+#
+# Backing (new) 11 -- 11 -- 11 --
+# COW image     22 22 11 11 -- --
+#
+# Expected result:
+#
+# COW image     22 22 11 11 00 --
+#
+# (Cluster 2 might be "--" after the rebase, too, but rebase just
+#  compares the new backing file to the old one and disregards the
+#  overlay.  Therefore, it will never discard overlay clusters.)
+
+_make_test_img $((6 * CLUSTER_SIZE))
+TEST_IMG="$TEST_IMG_SAVE.base_new" _make_test_img $((6 * CLUSTER_SIZE))
+
+echo
+
+$QEMU_IO "$TEST_IMG" \
+    -c "write -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "write -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+$QEMU_IO "$TEST_IMG.base_new" \
+    -c "write -P 0x11 $((0 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "write -P 0x11 $((2 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "write -P 0x11 $((4 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
+
+# This should be a no-op
+$QEMU_IMG rebase -b "" "$TEST_IMG"
+
+# Verify the data is correct
+$QEMU_IO "$TEST_IMG" \
+    -c "read -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x00 $((4 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+echo
+
+# Verify the allocation status (first four cluster should be allocated
+# in TEST_IMG, clusters 4 and 5 should be unallocated (marked as zero
+# clusters here because there is no backing file))
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+echo
+
+$QEMU_IMG rebase -b "$TEST_IMG.base_new" "$TEST_IMG"
+
+# Verify the data is correct
+$QEMU_IO "$TEST_IMG" \
+    -c "read -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x00 $((4 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+echo
+
+# Verify the allocation status (first four cluster should be allocated
+# in TEST_IMG, cluster 4 should be zero, and cluster 5 should be
+# unallocated (signified by '"depth": 1'))
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 024dc786b3..830abe013d 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -171,4 +171,41 @@ read 65536/65536 bytes at offset 196608
 Offset          Length          File
 0               0x30000         TEST_DIR/subdir/t.IMGFMT
 0x30000         0x10000         TEST_DIR/subdir/t.IMGFMT.base_new
+
+=== Test rebase without input base ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=393216
+Formatting 'TEST_DIR/t.IMGFMT.base_new', fmt=IMGFMT size=393216
+
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 262144
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+[{ "start": 0, "length": 262144, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 262144, "length": 131072, "depth": 0, "zero": true, "data": false}]
+
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 262144
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+[{ "start": 0, "length": 262144, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 262144, "length": 65536, "depth": 0, "zero": true, "data": false},
+{ "start": 327680, "length": 65536, "depth": 1, "zero": true, "data": false}]
 *** done
-- 
2.17.1
