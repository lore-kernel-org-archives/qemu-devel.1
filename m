Received: from eggs.gnu.org ([2001:4830:134:3::10]:57558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJPsq-0007tg-Ix
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJPsp-0007LH-K7
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:15:32 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 20 Dec 2016 13:15:17 -0600
Message-Id: <20161220191523.5779-2-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-1-eblake@redhat.com>
References: <20161220191523.5779-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/7] qcow2: Assert that cluster operations
 are aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

qcow2_discard_clusters() is set up to silently ignore sub-cluster
head or tail on unaligned requests.  However, it is easy to audit
the various callers: qcow2_snapshot_create() has always passed
aligned data since the call was introduced in 1ebf561;
qcow2_co_pdiscard() has passed aligned clusters since commit
ecdbead taught the block layer the preferred discard alignment (the
block layer can still pass sub-cluster values, but those are
handled directly in qcow2_co_pdiscard()); and qcow2_make_empty()
was fixed to pass aligned clusters in commit a3e1505.  Replace
rounding with assertions to hold us to the tighter contract,
eliminating the now-impossible case of an early exit for a
sub-cluster request.

qcow2_zero_clusters() has always been called with cluster-aligned
arguments from its lone caller qcow2_co_pwrite_zeroes() (like
qcow2_co_pdiscard(), the caller takes care of sub-cluster requests
from the block layer; and qcow2_zero_clusters() would have
misbehaved on unaligned requests), but it deserves the same
assertion for symmetry.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: new patch
---
 block/qcow2-cluster.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 928c1e2..3304a15 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1521,13 +1521,9 @@ int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,

     end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);

-    /* Round start up and end down */
-    offset = align_offset(offset, s->cluster_size);
-    end_offset = start_of_cluster(s, end_offset);
-
-    if (offset > end_offset) {
-        return 0;
-    }
+    /* Caller must pass aligned values */
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size));

     nb_clusters = size_to_clusters(s, end_offset - offset);

@@ -1602,6 +1598,10 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
     uint64_t nb_clusters;
     int ret;

+    /* Caller must pass aligned values */
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(nb_sectors, s->cluster_size >> BDRV_SECTOR_BITS));
+
     /* The zero flag is only supported by version 3 and newer */
     if (s->qcow_version < 3) {
         return -ENOTSUP;
-- 
2.9.3
