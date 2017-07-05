Received: from eggs.gnu.org ([2001:4830:134:3::10]:37966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXu-0004xr-GG
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXt-0002ii-Id
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:31 -0500
Message-Id: <20170705210842.960-11-eblake@redhat.com>
In-Reply-To: <20170705210842.960-1-eblake@redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/21] mirror: Update signature of
 mirror_clip_sectors()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Rather than having a void function that modifies its input
in-place as the output, change the signature to reduce a layer
of indirection and return the result.

Suggested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

---
v3-v4: no change
v2: new patch
---
 block/mirror.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2736d0b..70682b6 100644
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
2.9.4
