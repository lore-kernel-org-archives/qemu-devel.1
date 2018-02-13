Received: from eggs.gnu.org ([2001:4830:134:3::10]:53119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2C-0003X5-8Q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2A-0005jp-Nj
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:18 +0100
Message-Id: <20180213170529.10858-45-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 44/55] qcow2: Read refcount before L2 table in
 expand_zero_clusters_in_l1()
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

At the moment it doesn't really make a difference whether we call
qcow2_get_refcount() before of after reading the L2 table, but if we
want to support L2 slices we'll need to read the refcount first.

This patch simply changes the order of those two operations to prepare
for that. The patch with the actual semantic changes will be easier to
read because of this.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 947a91d934053a2dbfef979aeb9568f57ef57c5d.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f440105f6c..1041dcb6dd 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1898,6 +1898,12 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             goto fail;
         }
 
+        ret = qcow2_get_refcount(bs, l2_offset >> s->cluster_bits,
+                                 &l2_refcount);
+        if (ret < 0) {
+            goto fail;
+        }
+
         if (is_active_l1) {
             /* get active L2 tables from cache */
             ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
@@ -1911,12 +1917,6 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             goto fail;
         }
 
-        ret = qcow2_get_refcount(bs, l2_offset >> s->cluster_bits,
-                                 &l2_refcount);
-        if (ret < 0) {
-            goto fail;
-        }
-
         for (j = 0; j < s->l2_size; j++) {
             uint64_t l2_entry = be64_to_cpu(l2_table[j]);
             int64_t offset = l2_entry & L2E_OFFSET_MASK;
-- 
2.13.6
