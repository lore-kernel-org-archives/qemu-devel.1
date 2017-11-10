Received: from eggs.gnu.org ([2001:4830:134:3::10]:54865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxb-0001E9-Qj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxa-00045O-PJ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:31 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 21:31:08 +0100
Message-Id: <20171110203111.7666-3-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-1-mreitz@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 2/5] qcow2: Unaligned zero cluster in
 handle_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

We should check whether the cluster offset we are about to use is
actually valid; that is, whether it is aligned to cluster boundaries.

Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1728643
Buglink: https://bugs.launchpad.net/qemu/+bug/1728657
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c      | 13 ++++++++++++-
 tests/qemu-iotests/060     | 16 ++++++++++++++++
 tests/qemu-iotests/060.out | 10 ++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 2e072ed155..a3fec27bf9 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1308,10 +1308,21 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         (!*host_offset ||
          start_of_cluster(s, *host_offset) == (entry & L2E_OFFSET_MASK)))
     {
+        int preallocated_nb_clusters;
+
+        if (offset_into_cluster(s, entry & L2E_OFFSET_MASK)) {
+            qcow2_signal_corruption(bs, true, -1, -1, "Preallocated zero "
+                                    "cluster offset %#llx unaligned (guest "
+                                    "offset: %#" PRIx64 ")",
+                                    entry & L2E_OFFSET_MASK, guest_offset);
+            ret = -EIO;
+            goto fail;
+        }
+
         /* Try to reuse preallocated zero clusters; contiguous normal clusters
          * would be fine, too, but count_cow_clusters() above has limited
          * nb_clusters already to a range of COW clusters */
-        int preallocated_nb_clusters =
+        preallocated_nb_clusters =
             count_contiguous_clusters(nb_clusters, s->cluster_size,
                                       &l2_table[l2_index], QCOW_OFLAG_COPIED);
         assert(preallocated_nb_clusters > 0);
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 56bdf1ee2e..49bc89df38 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -321,6 +321,22 @@ echo '--- Repairing ---'
 # because the image was already marked corrupt by that point
 _check_test_img -r all
 
+echo
+echo "=== Writing to an unaligned preallocated zero cluster ==="
+echo
+
+_make_test_img 64M
+
+# Allocate the L2 table
+$QEMU_IO -c "write 0 64k" -c "discard 0 64k" "$TEST_IMG" | _filter_qemu_io
+# Pretend there is a preallocated zero cluster somewhere inside the
+# image header
+poke_file "$TEST_IMG" "$l2_offset" "\x80\x00\x00\x00\x00\x00\x2a\x01"
+# Let's write to it!
+$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
+
+# Can't repair this yet (TODO: We can just deallocate the cluster)
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index f013fe73c0..c583076808 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -307,4 +307,14 @@ The following inconsistencies were found and repaired:
 
 Double checking the fixed image now...
 No errors were found on the image.
+
+=== Writing to an unaligned preallocated zero cluster ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qcow2: Marking image as corrupt: Preallocated zero cluster offset 0x2a00 unaligned (guest offset: 0); further corruption events will be suppressed
+write failed: Input/output error
 *** done
-- 
2.13.6
