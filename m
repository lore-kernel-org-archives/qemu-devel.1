Received: from eggs.gnu.org ([2001:4830:134:3::10]:33395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctigZ-00073t-Rz
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctigY-0000qn-RS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:36:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 30 Mar 2017 17:36:45 -0500
Message-Id: <20170330223645.349-4-eblake@redhat.com>
In-Reply-To: <20170330223645.349-1-eblake@redhat.com>
References: <20170330223645.349-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 3/3] qcow2: Discard unaligned tail when
 wiping image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

The previous commit pointed out a subtle difference between the
fast and slow path of qcow2_make_empty(), where we failed to discard
the final (partial) cluster of an unaligned image.

The problem stems from the fact that qcow2_discard_clusters() was
silently ignoring sub-cluster head and tail on unaligned requests.
A quick audit of all callers shows that qcow2_snapshot_create() has
always passed a cluster-aligned request since the call was added
in commit 1ebf561; qcow2_co_pdiscard() has passed a cluster-aligned
request since commit ecdbead taught the block layer about preferred
discard alignment; and qcow2_make_empty() was fixed to pass an
aligned start (but not necessarily end) in commit a3e1505.

Asserting that the start is always aligned also points out that we
now have a dead check: rounding the end offset down can never result
in a value less than the aligned start offset (the check was rendered
dead with commit ecdbead).  Meanwhile, we do not want to round the
end cluster down in the one case of the end offset matching the
(unaligned) file size - that final partial cluster should still be
discarded.

With those fixes in place, we can adjust the testsuite so that
qemu-iotests 97 and 176 are once again identical for qcow2, showing
that fast and slow paths are back in sync.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: new patch
---
 block/qcow2-cluster.c      | 10 ++++------
 tests/qemu-iotests/176.out |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 78c11d4..100398c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1519,12 +1519,10 @@ int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,

     end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);

-    /* Round start up and end down */
-    offset = align_offset(offset, s->cluster_size);
-    end_offset = start_of_cluster(s, end_offset);
-
-    if (offset > end_offset) {
-        return 0;
+    /* The caller must cluster-align start; round end down except at EOF */
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+    if (end_offset != bs->total_sectors * BDRV_SECTOR_SIZE) {
+        end_offset = start_of_cluster(s, end_offset);
     }

     nb_clusters = size_to_clusters(s, end_offset - offset);
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index 990a41c..6271fa7 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -35,7 +35,7 @@ Offset          Length          File
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
-0x83400000      0x200           TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd

 === Test pass 1 ===

-- 
2.9.3
