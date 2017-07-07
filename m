Received: from eggs.gnu.org ([2001:4830:134:3::10]:41988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlR-0005IK-HC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlM-00088K-Gj
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:57 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:48 +0200
Message-Id: <1499447335-6125-34-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 033/100] block: Drop unused
 bdrv_round_sectors_to_clusters()
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

From: Eric Blake <eblake@redhat.com>

Now that the last user [mirror_iteration()] has converted to using
bytes, we no longer need a function to round sectors to clusters.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c            | 21 ---------------------
 include/block/block.h |  4 ----
 2 files changed, 25 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5c146b5..a0a36df 100644
--- a/block/io.c
+++ b/block/io.c
@@ -419,27 +419,6 @@ static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 }
 
 /**
- * Round a region to cluster boundaries (sector-based)
- */
-void bdrv_round_sectors_to_clusters(BlockDriverState *bs,
-                                    int64_t sector_num, int nb_sectors,
-                                    int64_t *cluster_sector_num,
-                                    int *cluster_nb_sectors)
-{
-    BlockDriverInfo bdi;
-
-    if (bdrv_get_info(bs, &bdi) < 0 || bdi.cluster_size == 0) {
-        *cluster_sector_num = sector_num;
-        *cluster_nb_sectors = nb_sectors;
-    } else {
-        int64_t c = bdi.cluster_size / BDRV_SECTOR_SIZE;
-        *cluster_sector_num = QEMU_ALIGN_DOWN(sector_num, c);
-        *cluster_nb_sectors = QEMU_ALIGN_UP(sector_num - *cluster_sector_num +
-                                            nb_sectors, c);
-    }
-}
-
-/**
  * Round a region to cluster boundaries
  */
 void bdrv_round_to_clusters(BlockDriverState *bs,
diff --git a/include/block/block.h b/include/block/block.h
index afe1b61..121f42b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -475,10 +475,6 @@ const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
 int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
-void bdrv_round_sectors_to_clusters(BlockDriverState *bs,
-                                    int64_t sector_num, int nb_sectors,
-                                    int64_t *cluster_sector_num,
-                                    int *cluster_nb_sectors);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, unsigned int bytes,
                             int64_t *cluster_offset,
-- 
1.8.3.1
