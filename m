Received: from eggs.gnu.org ([2001:4830:134:3::10]:42846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5E-0007b3-Pu
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5A-0000YX-9x
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:24 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:38 +0200
Message-Id: <3e5662dce5e4926c8fabbad4c0b9142b2a506dd4.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 38/39] iotests: Test downgrading an image
 using a small L2 slice size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

expand_zero_clusters_in_l1() is used when downgrading qcow2 images
from v3 to v2 (compat=0.10). This is one of the functions that needed
more changes to support L2 slices, so this patch extends iotest 061 to
test downgrading a qcow2 image using a smaller slice size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/061     | 16 ++++++++++++
 tests/qemu-iotests/061.out | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index f5678b10c9..911b6f2894 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -54,6 +54,22 @@ $QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_qemu_io
 _check_test_img
 
 echo
+echo "=== Testing version downgrade with zero expansion and 4K cache entries ==="
+echo
+IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
+$QEMU_IO -c "write -z 0 128k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z 32M 128k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c map "$TEST_IMG" | _filter_qemu_io
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+$QEMU_IMG amend -o "compat=0.10" --image-opts \
+          driver=qcow2,file.filename=$TEST_IMG,l2-cache-entry-size=4096
+$PYTHON qcow2.py "$TEST_IMG" dump-header
+$QEMU_IO -c "read -P 0 0 128k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 32M 128k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c map "$TEST_IMG" | _filter_qemu_io
+_check_test_img
+
+echo
 echo "=== Testing dirty version downgrade ==="
 echo
 IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 942485de99..e857ef9a7d 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -52,6 +52,67 @@ read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 
+=== Testing version downgrade with zero expansion and 4K cache entries ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 33554432
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+128 KiB (0x20000) bytes     allocated at offset 0 bytes (0x0)
+31.875 MiB (0x1fe0000) bytes not allocated at offset 128 KiB (0x20000)
+128 KiB (0x20000) bytes     allocated at offset 32 MiB (0x2000000)
+31.875 MiB (0x1fe0000) bytes not allocated at offset 32.125 MiB (0x2020000)
+magic                     0x514649fb
+version                   3
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      67108864
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              0
+snapshot_offset           0x0
+incompatible_features     0x0
+compatible_features       0x1
+autoclear_features        0x0
+refcount_order            4
+header_length             104
+
+Header extension:
+magic                     0x6803f857
+length                    144
+data                      <binary>
+
+magic                     0x514649fb
+version                   2
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      67108864
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              0
+snapshot_offset           0x0
+incompatible_features     0x0
+compatible_features       0x0
+autoclear_features        0x0
+refcount_order            4
+header_length             72
+
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 33554432
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+64 MiB (0x4000000) bytes not allocated at offset 0 bytes (0x0)
+No errors were found on the image.
+
 === Testing dirty version downgrade ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.11.0
