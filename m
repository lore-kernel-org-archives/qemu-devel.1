Received: from eggs.gnu.org ([2001:4830:134:3::10]:40861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5VP-0003kv-IY
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5VJ-0005dt-O9
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:01:27 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 16:59:45 +0200
Message-Id: <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 18/39] qcow2: Refactor get_cluster_table()
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

After the previous patch we're now always using l2_load() in
get_cluster_table() regardless of whether a new L2 table has to be
allocated or not.

This patch refactors that part of the code to use one single l2_load()
call.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 2a53c1dc5f..0c0cab85e8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -695,15 +695,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
         return -EIO;
     }
 
-    /* seek the l2 table of the given l2 offset */
-
-    if (s->l1_table[l1_index] & QCOW_OFLAG_COPIED) {
-        /* load the l2 table in memory */
-        ret = l2_load(bs, offset, l2_offset, &l2_table);
-        if (ret < 0) {
-            return ret;
-        }
-    } else {
+    if (!(s->l1_table[l1_index] & QCOW_OFLAG_COPIED)) {
         /* First allocate a new L2 table (and do COW if needed) */
         ret = l2_allocate(bs, l1_index);
         if (ret < 0) {
@@ -719,11 +711,12 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
         /* Get the offset of the newly-allocated l2 table */
         l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
         assert(offset_into_cluster(s, l2_offset) == 0);
-        /* Load the l2 table in memory */
-        ret = l2_load(bs, offset, l2_offset, &l2_table);
-        if (ret < 0) {
-            return ret;
-        }
+    }
+
+    /* load the l2 table in memory */
+    ret = l2_load(bs, offset, l2_offset, &l2_table);
+    if (ret < 0) {
+        return ret;
     }
 
     /* find the cluster offset for the given disk offset */
-- 
2.11.0
