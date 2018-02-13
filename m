Received: from eggs.gnu.org ([2001:4830:134:3::10]:52128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1d-0002no-GR
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1c-0005Fn-Iu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:39 +0100
Message-Id: <20180213170529.10858-6-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/55] qcow2: Use g_try_realloc() in
 qcow2_expand_zero_clusters()
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

g_realloc() aborts the program if it fails to allocate the required
amount of memory. We want to detect that scenario and return an error
instead, so let's use g_try_realloc().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3a979bcd82..f077cd3ac5 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2070,7 +2070,15 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
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
2.13.6
