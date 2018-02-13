Received: from eggs.gnu.org ([2001:4830:134:3::10]:52589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1t-00038x-Ly
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1s-0005UO-O1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:02 +0100
Message-Id: <20180213170529.10858-29-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/55] qcow2: Add offset_to_l1_index()
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

Similar to offset_to_l2_index(), this function returns the index in
the L1 table for a given guest offset. This is only used in a couple
of places and it's not a particularly complex calculation, but it
makes the code a bit more readable.

Although in the qcow2_get_cluster_offset() case the old code was
taking advantage of the l1_bits variable, we're going to get rid of
the other uses of l1_bits in a later patch anyway, so it doesn't make
sense to keep it just for this.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: a5f626fed526b7459a0425fad06d823d18df8522.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         | 5 +++++
 block/qcow2-cluster.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index edc5d8d57d..d9ba57c030 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -463,6 +463,11 @@ static inline int64_t size_to_l1(BDRVQcow2State *s, int64_t size)
     return (size + (1ULL << shift) - 1) >> shift;
 }
 
+static inline int offset_to_l1_index(BDRVQcow2State *s, uint64_t offset)
+{
+    return offset >> (s->l2_bits + s->cluster_bits);
+}
+
 static inline int offset_to_l2_index(BDRVQcow2State *s, int64_t offset)
 {
     return (offset >> s->cluster_bits) & (s->l2_size - 1);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ab5715c97e..ce7591dc3d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -540,7 +540,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     /* seek to the l2 offset in the l1 table */
 
-    l1_index = offset >> l1_bits;
+    l1_index = offset_to_l1_index(s, offset);
     if (l1_index >= s->l1_size) {
         type = QCOW2_CLUSTER_UNALLOCATED;
         goto out;
@@ -663,7 +663,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
 
     /* seek to the l2 offset in the l1 table */
 
-    l1_index = offset >> (s->l2_bits + s->cluster_bits);
+    l1_index = offset_to_l1_index(s, offset);
     if (l1_index >= s->l1_size) {
         ret = qcow2_grow_l1_table(bs, l1_index + 1, false);
         if (ret < 0) {
-- 
2.13.6
