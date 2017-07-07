Received: from eggs.gnu.org ([2001:4830:134:3::10]:41817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlJ-00058l-Ej
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlI-00082c-2V
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:49 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:44 +0200
Message-Id: <1499447335-6125-30-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 029/100] mirror: Update signature of
 mirror_clip_sectors()
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

Rather than having a void function that modifies its input
in-place as the output, change the signature to reduce a layer
of indirection and return the result.

Suggested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 60eefbd..a41ef25 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -176,12 +176,12 @@ static void mirror_read_complete(void *opaque, int ret)
     aio_context_release(blk_get_aio_context(s->common.blk));
 }
 
-static inline void mirror_clip_sectors(MirrorBlockJob *s,
-                                       int64_t sector_num,
-                                       int *nb_sectors)
+static inline int mirror_clip_sectors(MirrorBlockJob *s,
+                                      int64_t sector_num,
+                                      int nb_sectors)
 {
-    *nb_sectors = MIN(*nb_sectors,
-                      s->bdev_length / BDRV_SECTOR_SIZE - sector_num);
+    return MIN(nb_sectors,
+               s->bdev_length / BDRV_SECTOR_SIZE - sector_num);
 }
 
 /* Round sector_num and/or nb_sectors to target cluster if COW is needed, and
@@ -216,7 +216,8 @@ static int mirror_cow_align(MirrorBlockJob *s,
     }
     /* Clipping may result in align_nb_sectors unaligned to chunk boundary, but
      * that doesn't matter because it's already the end of source image. */
-    mirror_clip_sectors(s, align_sector_num, &align_nb_sectors);
+    align_nb_sectors = mirror_clip_sectors(s, align_sector_num,
+                                           align_nb_sectors);
 
     ret = align_sector_num + align_nb_sectors - (*sector_num + *nb_sectors);
     *sector_num = align_sector_num;
@@ -445,7 +446,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
             return 0;
         }
 
-        mirror_clip_sectors(s, sector_num, &io_sectors);
+        io_sectors = mirror_clip_sectors(s, sector_num, io_sectors);
         switch (mirror_method) {
         case MIRROR_METHOD_COPY:
             io_sectors = mirror_do_read(s, sector_num, io_sectors);
-- 
1.8.3.1
