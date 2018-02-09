Received: from eggs.gnu.org ([2001:4830:134:3::10]:58752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ek9t6-0002W5-2S
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ek9t2-0004wp-2g
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:42:52 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  9 Feb 2018 16:42:22 +0200
Message-Id: <20180209144222.8937-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Use g_try_realloc() in
 qcow2_expand_zero_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

g_realloc() aborts the program if it fails to allocate the required
amount of memory. We want to detect that scenario and return an error
instead, so let's use g_try_realloc().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a3fec27bf9..add6d86052 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2071,7 +2071,15 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
         int l1_sectors = DIV_ROUND_UP(s->snapshots[i].l1_size *
                                       sizeof(uint64_t), BDRV_SECTOR_SIZE);
 
-        l1_table = g_realloc(l1_table, l1_sectors * BDRV_SECTOR_SIZE);
+        uint64_t *new_l1_table =
+            g_try_realloc(l1_table, l1_sectors * BDRV_SECTOR_SIZE);
+
+        if (!new_l1_table) {
+            ret = -ENOMEM;
+            goto fail;
+        }
+
+        l1_table = new_l1_table;
 
         ret = bdrv_read(bs->file,
                         s->snapshots[i].l1_table_offset / BDRV_SECTOR_SIZE,
-- 
2.11.0
