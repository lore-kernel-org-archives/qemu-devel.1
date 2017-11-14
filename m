Received: from eggs.gnu.org ([2001:4830:134:3::10]:53572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEewq-0005S8-Ry
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEewp-0004AM-Ov
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:32 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:00 +0100
Message-Id: <20171114172417.7654-4-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 03/20] qcow2: Prevent allocating compressed
 clusters at offset 0
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

If the refcount data is corrupted then we can end up trying to
allocate a new compressed cluster at offset 0 in the image, triggering
an assertion in qcow2_alloc_bytes() that would crash QEMU:

  qcow2_alloc_bytes: Assertion `offset' failed.

This patch adds an explicit check for this scenario and a new test
case.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c     |  7 +++++++
 tests/qemu-iotests/060     | 10 ++++++++++
 tests/qemu-iotests/060.out |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 9059996c4b..60b8eef3e8 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1082,6 +1082,13 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, int size)
                 return new_cluster;
             }
 
+            if (new_cluster == 0) {
+                qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
+                                        "allocation of compressed cluster "
+                                        "at offset 0");
+                return -EIO;
+            }
+
             if (!offset || ROUND_UP(offset, s->cluster_size) != new_cluster) {
                 offset = new_cluster;
                 free_in_cluster = s->cluster_size;
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 40f85cc216..c3bce27b33 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -260,6 +260,16 @@ _make_test_img 64M
 poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
 
+echo
+echo "=== Testing empty refcount block with compressed write ==="
+echo
+_make_test_img 64M
+$QEMU_IO -c "write 64k 64k" "$TEST_IMG" | _filter_qemu_io
+poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
+# The previous write already allocated an L2 table, so now this new
+# write will try to allocate a compressed data cluster at offset 0.
+$QEMU_IO -c "write -c 0k 64k" "$TEST_IMG" | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 5b8b518486..cf8790ff57 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -195,4 +195,12 @@ write failed: Input/output error
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+
+=== Testing empty refcount block with compressed write ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qcow2: Marking image as corrupt: Preventing invalid allocation of compressed cluster at offset 0; further corruption events will be suppressed
+write failed: Input/output error
 *** done
-- 
2.13.6
