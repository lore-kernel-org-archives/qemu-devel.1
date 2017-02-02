Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cZIKL-0008Vh-Et
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cZIKI-0001Qu-A5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:25:33 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:28714 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cZIKH-0001Pr-UO
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:25:30 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu,  2 Feb 2017 17:25:15 +0300
Message-Id: <1486045515-8009-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH v2 1/1] mirror: do not increase offset during
 initial zero_or_discard phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

If explicit zeroing out before mirroring is required for the target image,
it moves the block job offset counter to EOF, then offset and len counters
count the image size twice. There is no harm but stats are confusing,
specifically the progress of the operation is always reported as 99% by
management tools.

The patch skips offset increase for the first "technical" pass over the
image. This should not cause any further harm.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Jeff Cody <jcody@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Eric Blake <eblake@redhat.com>
---
Changes from v1:
- changed the approach - we do not allow to increase the offset rather then
  to move it back
- description rewritten
- kludges to tests are removed as not actually needed with this approach

 block/mirror.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 301ba92..f100f5d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -69,6 +69,7 @@ typedef struct MirrorBlockJob {
     bool waiting_for_io;
     int target_cluster_sectors;
     int max_iov;
+    bool initial_zeroing_ongoing;
 } MirrorBlockJob;
 
 typedef struct MirrorOp {
@@ -117,9 +118,10 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
         if (s->cow_bitmap) {
             bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
         }
-        s->common.offset += (uint64_t)op->nb_sectors * BDRV_SECTOR_SIZE;
+        if (!s->initial_zeroing_ongoing) {
+            s->common.offset += (uint64_t)op->nb_sectors * BDRV_SECTOR_SIZE;
+        }
     }
-
     qemu_iovec_destroy(&op->qiov);
     g_free(op);
 
@@ -566,6 +568,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             return 0;
         }
 
+        s->initial_zeroing_ongoing = true;
         for (sector_num = 0; sector_num < end; ) {
             int nb_sectors = MIN(end - sector_num,
                 QEMU_ALIGN_DOWN(INT_MAX, s->granularity) >> BDRV_SECTOR_BITS);
@@ -573,6 +576,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             mirror_throttle(s);
 
             if (block_job_is_cancelled(&s->common)) {
+                s->initial_zeroing_ongoing = false;
                 return 0;
             }
 
@@ -587,6 +591,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }
 
         mirror_wait_for_all_io(s);
+        s->initial_zeroing_ongoing = false;
     }
 
     /* First part, loop on the sectors and initialize the dirty bitmap.  */
-- 
2.7.4
