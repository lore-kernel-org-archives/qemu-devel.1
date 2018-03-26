Received: from eggs.gnu.org ([2001:4830:134:3::10]:45569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEV-00036Z-QH
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEU-0004Av-3o
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:48 +0200
Message-Id: <20180326143600.7724-8-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/19] qcow2: Reset free_cluster_index when
 allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

When we try to allocate new clusters we first look for available ones
starting from s->free_cluster_index and once we find them we increase
their reference counts. Before we get to call update_refcount() to do
this last step s->free_cluster_index is already pointing to the next
cluster after the ones we are trying to allocate.

During update_refcount() it may happen however that we also need to
allocate a new refcount block in order to store the refcounts of these
new clusters (and to complicate things further that may also require
us to grow the refcount table). After all this we don't know if the
clusters that we originally tried to allocate are still available, so
we return -EAGAIN to ask the caller to restart the search for free
clusters.

This is what can happen in a common scenario:

  1) We want to allocate a new cluster and we see that cluster N is
     free.

  2) We try to increase N's refcount but all refcount blocks are full,
     so we allocate a new one at N+1 (where s->free_cluster_index was
     pointing at).

  3) Once we're done we return -EAGAIN to look again for a free
     cluster, but now s->free_cluster_index points at N+2, so that's
     the one we allocate. Cluster N remains unallocated and we have a
     hole in the qcow2 file.

This can be reproduced easily:

     qemu-img create -f qcow2 -o cluster_size=512 hd.qcow2 1M
     qemu-io -c 'write 0 124k' hd.qcow2

After this the image has 132608 bytes (256 clusters), and the refcount
block is full. If we write 512 more bytes it should allocate two new
clusters: the data cluster itself and a new refcount block.

     qemu-io -c 'write 124k 512' hd.qcow2

However the image has now three new clusters (259 in total), and the
first one of them is empty (and unallocated):

     dd if=hd.qcow2 bs=512c skip=256 count=1 | hexdump -C

If we write larger amounts of data in the last step instead of the 512
bytes used in this example we can create larger holes in the qcow2
file.

What this patch does is reset s->free_cluster_index to its previous
value when alloc_refcount_block() returns -EAGAIN. This way the caller
will try to allocate again the original clusters if they are still
free.

The output of iotest 026 also needs to be updated because now that
images have no holes some tests fail at a different point and the
number of leaked clusters is different.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c     |  7 +++++++
 tests/qemu-iotests/026.out |  6 +++---
 tests/qemu-iotests/121     | 20 ++++++++++++++++++++
 tests/qemu-iotests/121.out | 10 ++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 362deaf303..6b8b63514a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -839,6 +839,13 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
                 qcow2_cache_put(s->refcount_block_cache, &refcount_block);
             }
             ret = alloc_refcount_block(bs, cluster_index, &refcount_block);
+            /* If the caller needs to restart the search for free clusters,
+             * try the same ones first to see if they're still free. */
+            if (ret == -EAGAIN) {
+                if (s->free_cluster_index > (start >> s->cluster_bits)) {
+                    s->free_cluster_index = (start >> s->cluster_bits);
+                }
+            }
             if (ret < 0) {
                 goto fail;
             }
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 86a50a2e13..8e89416a86 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -533,7 +533,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-11 leaked clusters were found on the image.
+10 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -561,7 +561,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-11 leaked clusters were found on the image.
+10 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -589,7 +589,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-11 leaked clusters were found on the image.
+10 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 1307b4e327..6d6f55a5dc 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -93,6 +93,26 @@ $QEMU_IO -c 'write 63M 130K' "$TEST_IMG" | _filter_qemu_io
 
 _check_test_img
 
+echo
+echo '=== Allocating a new refcount block must not leave holes in the image ==='
+echo
+
+IMGOPTS='cluster_size=512,refcount_bits=16' _make_test_img 1M
+
+# This results in an image with 256 used clusters: the qcow2 header,
+# the refcount table, one refcount block, the L1 table, four L2 tables
+# and 248 data clusters
+$QEMU_IO -c 'write 0 124k' "$TEST_IMG" | _filter_qemu_io
+
+# 256 clusters of 512 bytes each give us a 128K image
+stat -c "size=%s (expected 131072)" $TEST_IMG
+
+# All 256 entries of the refcount block are used, so writing a new
+# data cluster also allocates a new refcount block
+$QEMU_IO -c 'write 124k 512' "$TEST_IMG" | _filter_qemu_io
+
+# Two more clusters, the image size should be 129K now
+stat -c "size=%s (expected 132096)" $TEST_IMG
 
 # success, all done
 echo
diff --git a/tests/qemu-iotests/121.out b/tests/qemu-iotests/121.out
index 5961a44cd9..613d56185e 100644
--- a/tests/qemu-iotests/121.out
+++ b/tests/qemu-iotests/121.out
@@ -20,4 +20,14 @@ wrote 133120/133120 bytes at offset 66060288
 130 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 
+=== Allocating a new refcount block must not leave holes in the image ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+wrote 126976/126976 bytes at offset 0
+124 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+size=131072 (expected 131072)
+wrote 512/512 bytes at offset 126976
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+size=132096 (expected 132096)
+
 *** done
-- 
2.13.6
