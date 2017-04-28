Received: from eggs.gnu.org ([2001:4830:134:3::10]:56149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbV-0002HF-BJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbU-0001cC-HX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:35:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:38 +0200
Message-Id: <1493411622-5343-31-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 30/34] qemu-img: improve
 convert_iteration_sectors()
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Do not do extra call to _get_block_status()

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170407113404.9351-1-vsementsov@virtuozzo.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9eb8283..9b6e728 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1554,9 +1554,15 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
     if (s->sector_next_status <= sector_num) {
         BlockDriverState *file;
-        ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
-                                    sector_num - src_cur_offset,
-                                    n, &n, &file);
+        if (s->target_has_backing) {
+            ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
+                                        sector_num - src_cur_offset,
+                                        n, &n, &file);
+        } else {
+            ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
+                                              sector_num - src_cur_offset,
+                                              n, &n, &file);
+        }
         if (ret < 0) {
             return ret;
         }
@@ -1565,26 +1571,8 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
             s->status = BLK_ZERO;
         } else if (ret & BDRV_BLOCK_DATA) {
             s->status = BLK_DATA;
-        } else if (!s->target_has_backing) {
-            /* Without a target backing file we must copy over the contents of
-             * the backing file as well. */
-            /* Check block status of the backing file chain to avoid
-             * needlessly reading zeroes and limiting the iteration to the
-             * buffer size */
-            ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
-                                              sector_num - src_cur_offset,
-                                              n, &n, &file);
-            if (ret < 0) {
-                return ret;
-            }
-
-            if (ret & BDRV_BLOCK_ZERO) {
-                s->status = BLK_ZERO;
-            } else {
-                s->status = BLK_DATA;
-            }
         } else {
-            s->status = BLK_BACKING_FILE;
+            s->status = s->target_has_backing ? BLK_BACKING_FILE : BLK_DATA;
         }
 
         s->sector_next_status = sector_num + n;
-- 
1.8.3.1
