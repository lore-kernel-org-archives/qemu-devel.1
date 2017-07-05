Received: from eggs.gnu.org ([2001:4830:134:3::10]:37792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXk-0004oO-49
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXi-0002cj-Pc
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:22 -0500
Message-Id: <20170705210842.960-2-eblake@redhat.com>
In-Reply-To: <20170705210842.960-1-eblake@redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/21] blockjob: Track job ratelimits via
 bytes, not sectors
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

The user interface specifies job rate limits in bytes/second.
It's pointless to have our internal representation track things
in sectors/second, particularly since we want to move away from
sector-based interfaces.

Fix up a doc typo found while verifying that the ratelimit
code handles the scaling difference.

Repetition of expressions like 'n * BDRV_SECTOR_SIZE' will be
cleaned up later when functions are converted to iterate over
images by bytes rather than by sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
v2: adjust commit message based on review; no code change
---
 include/qemu/ratelimit.h |  3 ++-
 block/backup.c           |  5 +++--
 block/commit.c           |  5 +++--
 block/mirror.c           | 13 +++++++------
 block/stream.c           |  5 +++--
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index 8da1232..8dece48 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -24,7 +24,8 @@ typedef struct {

 /** Calculate and return delay for next request in ns
  *
- * Record that we sent @p n data units. If we may send more data units
+ * Record that we sent @n data units (where @n matches the scale chosen
+ * during ratelimit_set_speed). If we may send more data units
  * in the current time slice, return 0 (i.e. no delay). Otherwise
  * return the amount of time (in ns) until the start of the next time
  * slice that will permit sending the next chunk of data.
diff --git a/block/backup.c b/block/backup.c
index 5387fbd..9ca1d8e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -208,7 +208,7 @@ static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
+    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }

 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
@@ -359,7 +359,8 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
      */
     if (job->common.speed) {
         uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
-                                                      job->sectors_read);
+                                                      job->sectors_read *
+                                                      BDRV_SECTOR_SIZE);
         job->sectors_read = 0;
         block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
     } else {
diff --git a/block/commit.c b/block/commit.c
index 524bd54..6993994 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -209,7 +209,8 @@ static void coroutine_fn commit_run(void *opaque)
         s->common.offset += n * BDRV_SECTOR_SIZE;

         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit, n);
+            delay_ns = ratelimit_calculate_delay(&s->limit,
+                                                 n * BDRV_SECTOR_SIZE);
         }
     }

@@ -231,7 +232,7 @@ static void commit_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
+    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }

 static const BlockJobDriver commit_job_driver = {
diff --git a/block/mirror.c b/block/mirror.c
index 61a862d..eb27efc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -396,7 +396,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     bitmap_set(s->in_flight_bitmap, sector_num / sectors_per_chunk, nb_chunks);
     while (nb_chunks > 0 && sector_num < end) {
         int64_t ret;
-        int io_sectors, io_sectors_acct;
+        int io_sectors;
+        int64_t io_bytes_acct;
         BlockDriverState *file;
         enum MirrorMethod {
             MIRROR_METHOD_COPY,
@@ -444,16 +445,16 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         switch (mirror_method) {
         case MIRROR_METHOD_COPY:
             io_sectors = mirror_do_read(s, sector_num, io_sectors);
-            io_sectors_acct = io_sectors;
+            io_bytes_acct = io_sectors * BDRV_SECTOR_SIZE;
             break;
         case MIRROR_METHOD_ZERO:
         case MIRROR_METHOD_DISCARD:
             mirror_do_zero_or_discard(s, sector_num, io_sectors,
                                       mirror_method == MIRROR_METHOD_DISCARD);
             if (write_zeroes_ok) {
-                io_sectors_acct = 0;
+                io_bytes_acct = 0;
             } else {
-                io_sectors_acct = io_sectors;
+                io_bytes_acct = io_sectors * BDRV_SECTOR_SIZE;
             }
             break;
         default:
@@ -463,7 +464,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         sector_num += io_sectors;
         nb_chunks -= DIV_ROUND_UP(io_sectors, sectors_per_chunk);
         if (s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit, io_sectors_acct);
+            delay_ns = ratelimit_calculate_delay(&s->limit, io_bytes_acct);
         }
     }
     return delay_ns;
@@ -929,7 +930,7 @@ static void mirror_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
+    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }

 static void mirror_complete(BlockJob *job, Error **errp)
diff --git a/block/stream.c b/block/stream.c
index 52d329f..29273a5 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -191,7 +191,8 @@ static void coroutine_fn stream_run(void *opaque)
         /* Publish progress */
         s->common.offset += n * BDRV_SECTOR_SIZE;
         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit, n);
+            delay_ns = ratelimit_calculate_delay(&s->limit,
+                                                 n * BDRV_SECTOR_SIZE);
         }
     }

@@ -220,7 +221,7 @@ static void stream_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed / BDRV_SECTOR_SIZE, SLICE_TIME);
+    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
 }

 static const BlockJobDriver stream_job_driver = {
-- 
2.9.4
