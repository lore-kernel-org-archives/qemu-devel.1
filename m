Received: from eggs.gnu.org ([2001:4830:134:3::10]:46455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkq-0001mA-Uy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkq-00061M-9b
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:17 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:41 -0500
Message-Id: <20180119205847.7141-8-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/13] block/backup: use block_job_relax
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

See two commits back for justification.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/backup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 7b1cdd038a..b4204c0ee4 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -336,6 +336,8 @@ static void backup_complete(BlockJob *job, void *opaque)
 
 static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 {
+    uint64_t delay_ns = 0;
+
     if (block_job_is_cancelled(&job->common)) {
         return true;
     }
@@ -344,14 +346,12 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
      * (without, VM does not reboot)
      */
     if (job->common.speed) {
-        uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
-                                                      job->bytes_read);
+        delay_ns = ratelimit_calculate_delay(&job->limit,
+                                             job->bytes_read);
         job->bytes_read = 0;
-        block_job_sleep_ns(&job->common, delay_ns);
-    } else {
-        block_job_sleep_ns(&job->common, 0);
     }
 
+    block_job_relax(&job->common, delay_ns);
     if (block_job_is_cancelled(&job->common)) {
         return true;
     }
-- 
2.14.3
