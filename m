Received: from eggs.gnu.org ([2001:4830:134:3::10]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkv-0001rM-L9
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdku-00063l-SQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:21 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:43 -0500
Message-Id: <20180119205847.7141-10-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/13] block/backup: remove yield_and_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

This is a respin of the same functionality as mirror_throttle,
so trash this and replace it with the generic version.

yield_and_check returned true if canceled, false otherwise.
block_job_relax returns -ECANCELED if canceled, 0 otherwise.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index b4204c0ee4..0624c3b322 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -334,29 +334,17 @@ static void backup_complete(BlockJob *job, void *opaque)
     g_free(data);
 }
 
-static bool coroutine_fn yield_and_check(BackupBlockJob *job)
+static uint64_t get_delay_ns(BackupBlockJob *job)
 {
     uint64_t delay_ns = 0;
 
-    if (block_job_is_cancelled(&job->common)) {
-        return true;
-    }
-
-    /* we need to yield so that bdrv_drain_all() returns.
-     * (without, VM does not reboot)
-     */
     if (job->common.speed) {
         delay_ns = ratelimit_calculate_delay(&job->limit,
                                              job->bytes_read);
         job->bytes_read = 0;
     }
 
-    block_job_relax(&job->common, delay_ns);
-    if (block_job_is_cancelled(&job->common)) {
-        return true;
-    }
-
-    return false;
+    return delay_ns;
 }
 
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
@@ -369,7 +357,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
     while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
         do {
-            if (yield_and_check(job)) {
+            if (block_job_relax(&job->common, get_delay_ns(job))) {
                 return 0;
             }
             ret = backup_do_cow(job, cluster * job->cluster_size,
@@ -465,7 +453,7 @@ static void coroutine_fn backup_run(void *opaque)
             bool error_is_read;
             int alloced = 0;
 
-            if (yield_and_check(job)) {
+            if (block_job_relax(&job->common, get_delay_ns(job))) {
                 break;
             }
 
-- 
2.14.3
