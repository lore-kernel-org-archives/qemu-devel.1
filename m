Received: from eggs.gnu.org ([2001:4830:134:3::10]:37004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy451-0001yj-70
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy44z-0000Sg-W1
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:16:07 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 11 Apr 2017 17:15:55 -0500
Message-Id: <20170411221555.24863-1-eblake@redhat.com>
In-Reply-To: <20170411011718.9152-8-eblake@redhat.com>
References: <20170411011718.9152-8-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9.5 07/13] fixup! qcow2: Discard/zero clusters
 by byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Squash this to keep iotest 154 happy.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v9.5: fixup
v9: rebase to earlier changes, drop R-b
v7, v8: only earlier half of series submitted for 2.9
v6: rebase due to context
v5: s/count/byte/ to make the units obvious, and rework the math
to ensure no 32-bit integer overflow on large clusters
v4: improve function names, split assertion additions into earlier patch
[no v3 or v2]
v1: https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00339.html
---
 block/qcow2-cluster.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 595e6e3..bc59cb8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1597,18 +1597,15 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t end_offset;
+    uint64_t end_offset = offset + bytes;
     uint64_t nb_clusters;
     int64_t cleared;
     int ret;

-    end_offset = offset + bytes;
-
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
            end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
-    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));

     /* The zero flag is only supported by version 3 and newer; we
      * require the use of that flag if there is a backing file or if
-- 
2.9.3
