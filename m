Received: from eggs.gnu.org ([2001:4830:134:3::10]:55294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYx-0005wt-F2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYw-0004OW-Ib
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:11 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:56 -0500
Message-Id: <20170221154057.20313-9-jcody@redhat.com>
In-Reply-To: <20170221154057.20313-1-jcody@redhat.com>
References: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] mirror: do not increase offset during
 initial zero_or_discard phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 1486045515-8009-1-git-send-email-den@openvz.org
CC: Jeff Cody <jcody@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/mirror.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 698a54e..ca8547b 100644
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
 
@@ -572,6 +574,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             return 0;
         }
 
+        s->initial_zeroing_ongoing = true;
         for (sector_num = 0; sector_num < end; ) {
             int nb_sectors = MIN(end - sector_num,
                 QEMU_ALIGN_DOWN(INT_MAX, s->granularity) >> BDRV_SECTOR_BITS);
@@ -579,6 +582,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             mirror_throttle(s);
 
             if (block_job_is_cancelled(&s->common)) {
+                s->initial_zeroing_ongoing = false;
                 return 0;
             }
 
@@ -593,6 +597,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }
 
         mirror_wait_for_all_io(s);
+        s->initial_zeroing_ongoing = false;
     }
 
     /* First part, loop on the sectors and initialize the dirty bitmap.  */
-- 
2.9.3
