Received: from eggs.gnu.org ([2001:4830:134:3::10]:59834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9vAt-000714-4T
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9vAo-0005b2-6e
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:43:27 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  1 Nov 2017 17:42:22 +0200
Message-Id: <49d365124cf0bffb3fe705678b50b86445d42605.1509550787.git.berto@igalia.com>
In-Reply-To: <cover.1509550787.git.berto@igalia.com>
References: <cover.1509550787.git.berto@igalia.com>
In-Reply-To: <cover.1509550787.git.berto@igalia.com>
References: <cover.1509550787.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/4] qcow2: Prevent allocating refcount blocks
 at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

Each entry in the qcow2 cache contains an offset field indicating the
location of the data in the qcow2 image. If the offset is 0 then it
means that the entry contains no data and is available to be used when
needed.

Because of that it is not possible to store in the cache the first
cluster of the qcow2 image (offset = 0). This is not a problem because
that cluster always contains the qcow2 header and we're not using this
cache for that.

However, if the qcow2 image is corrupted it can happen that we try to
allocate a new refcount block at offset 0, triggering this assertion
and crashing QEMU:

  qcow2_cache_entry_mark_dirty: Assertion `c->entries[i].offset != 0' failed

This patch adds an explicit check for this scenario and a new test
case.

This problem was originally reported here:

   https://bugs.launchpad.net/qemu/+bug/1728615

Reported-by: R.Nageswara Sastry <nasastry@in.ibm.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c     |  7 +++++++
 tests/qemu-iotests/060     | 11 +++++++++++
 tests/qemu-iotests/060.out |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index aa3fd6cf17..9059996c4b 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -367,6 +367,13 @@ static int alloc_refcount_block(BlockDriverState *bs,
         return new_block;
     }
 
+    /* If we're allocating the block at offset 0 then something is wrong */
+    if (new_block == 0) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
+                                "allocation of refcount block at offset 0");
+        return -EIO;
+    }
+
 #ifdef DEBUG_ALLOC2
     fprintf(stderr, "qcow2: Allocate refcount block %d for %" PRIx64
         " at %" PRIx64 "\n",
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 8e95c450eb..dead26aeaf 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -242,6 +242,17 @@ poke_file "$TEST_IMG" "$(($l2_offset+8))" "\x80\x00\x00\x00\x00\x06\x2a\x00"
 # Should emit two error messages
 $QEMU_IO -c "discard 0 64k" -c "read 64k 64k" "$TEST_IMG" | _filter_qemu_io
 
+echo
+echo "=== Testing empty refcount table with valid L1 and L2 tables ==="
+echo
+_make_test_img 64M
+$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
+poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
+# Since the first data cluster is already allocated this triggers an
+# allocation with an explicit offset (using qcow2_alloc_clusters_at())
+# causing a refcount block to be allocated at offset 0
+$QEMU_IO -c "write 0 128k" "$TEST_IMG" | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 5ca3af491f..872719009c 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -181,4 +181,12 @@ qcow2: Marking image as corrupt: Cluster allocation offset 0x62a00 unaligned (L2
 discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read failed: Input/output error
+
+=== Testing empty refcount table with valid L1 and L2 tables ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qcow2: Marking image as corrupt: Preventing invalid allocation of refcount block at offset 0; further corruption events will be suppressed
+write failed: Input/output error
 *** done
-- 
2.11.0
