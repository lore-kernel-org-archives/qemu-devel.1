Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5VY-0003rc-1W
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5VT-0005n0-FG
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:01:36 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 16:59:39 +0200
Message-Id: <d3c1ce653a6e8ba3bbbf2419109add9254dfe51b.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 12/39] qcow2: Add offset_to_l1_index()
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
---
 block/qcow2-cluster.c | 4 ++--
 block/qcow2.h         | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 4a7b46038b..6369a74efe 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -541,7 +541,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     /* seek to the l2 offset in the l1 table */
 
-    l1_index = offset >> l1_bits;
+    l1_index = offset_to_l1_index(s, offset);
     if (l1_index >= s->l1_size) {
         type = QCOW2_CLUSTER_UNALLOCATED;
         goto out;
@@ -664,7 +664,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
 
     /* seek to the l2 offset in the l1 table */
 
-    l1_index = offset >> (s->l2_bits + s->cluster_bits);
+    l1_index = offset_to_l1_index(s, offset);
     if (l1_index >= s->l1_size) {
         ret = qcow2_grow_l1_table(bs, l1_index + 1, false);
         if (ret < 0) {
diff --git a/block/qcow2.h b/block/qcow2.h
index cb8dd784fa..0559afbc63 100644
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
-- 
2.11.0
