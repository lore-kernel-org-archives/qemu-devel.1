Received: from eggs.gnu.org ([2001:4830:134:3::10]:38109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrY5-00058h-4E
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrY4-0002no-5k
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:35 -0500
Message-Id: <20170705210842.960-15-eblake@redhat.com>
In-Reply-To: <20170705210842.960-1-eblake@redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 14/21] block: Drop unused
 bdrv_round_sectors_to_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that the last user [mirror_iteration()] has converted to using
bytes, we no longer need a function to round sectors to clusters.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
v3-v4: no change
v2: hoist to earlier series, no change
---
 include/block/block.h |  4 ----
 block/io.c            | 21 ---------------------
 2 files changed, 25 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f432ea6..a9dc753 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -472,10 +472,6 @@ const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
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
diff --git a/block/io.c b/block/io.c
index 9186c5a..f662c97 100644
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
-- 
2.9.4
