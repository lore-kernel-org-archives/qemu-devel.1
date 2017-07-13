Received: from eggs.gnu.org ([2001:4830:134:3::10]:41455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVdNQ-0005sY-JG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVdNP-0001u3-P9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:37:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Jul 2017 14:37:43 +0200
Message-Id: <1499949463-22531-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] vpc: Remove useless parameters in
 get_sector_offset()
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

All callers of get_sector_offset() pass write=false and err=NULL. Remove
the parameters.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
Based on my block branch, specifically Peter's 'block/vpc.c: Handle write
failures in get_image_offset()'

 block/vpc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index bccc981..471f9ab 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -508,10 +508,9 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
 }
 
 static inline int64_t get_sector_offset(BlockDriverState *bs,
-                                        int64_t sector_num, bool write,
-                                        int *err)
+                                        int64_t sector_num)
 {
-    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, write, err);
+    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, false, NULL);
 }
 
 /*
@@ -721,7 +720,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
                (sector_num << BDRV_SECTOR_BITS);
     }
 
-    offset = get_sector_offset(bs, sector_num, false, NULL);
+    offset = get_sector_offset(bs, sector_num);
     start = offset;
     allocated = (offset != -1);
     *pnum = 0;
@@ -744,7 +743,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
         if (nb_sectors == 0) {
             break;
         }
-        offset = get_sector_offset(bs, sector_num, false, NULL);
+        offset = get_sector_offset(bs, sector_num);
     } while (offset == -1);
 
     return 0;
-- 
1.8.3.1
