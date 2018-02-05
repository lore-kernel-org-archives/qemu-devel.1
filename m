Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5W-0007tZ-K7
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5V-000142-KB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:42 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:28 +0200
Message-Id: <947a91d934053a2dbfef979aeb9568f57ef57c5d.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 28/39] qcow2: Read refcount before L2 table
 in expand_zero_clusters_in_l1()
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

At the moment it doesn't really make a difference whether we call
qcow2_get_refcount() before of after reading the L2 table, but if we
want to support L2 slices we'll need to read the refcount first.

This patch simply changes the order of those two operations to prepare
for that. The patch with the actual semantic changes will be easier to
read because of this.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 068d1ee0a0..ecfd4e7019 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1899,6 +1899,12 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
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
@@ -1912,12 +1918,6 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
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
2.11.0
