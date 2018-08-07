Received: from eggs.gnu.org ([2001:4830:134:3::10]:53911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth3-0004ff-20
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth0-0001Gj-G5
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:01 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:36 -0400
Message-Id: <20180807043349.27196-9-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 08/21] tests/test-blockjob-txn: utilize
 job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is safe to do because job_complete which will get called
implicitly already handles resetting the job error code if the job
gets cancelled, so this stanza was wasted effort.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-blockjob-txn.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index fce836639a..307726d089 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -24,17 +24,11 @@ typedef struct {
     int *result;
 } TestBlockJob;
 
-static void test_block_job_complete(Job *job, void *opaque)
+static void test_block_job_exit(Job *job)
 {
     BlockJob *bjob = container_of(job, BlockJob, job);
     BlockDriverState *bs = blk_bs(bjob->blk);
-    int rc = (intptr_t)opaque;
 
-    if (job_is_cancelled(job)) {
-        rc = -ECANCELED;
-    }
-
-    job_completed(job, rc);
     bdrv_unref(bs);
 }
 
@@ -55,8 +49,7 @@ static void coroutine_fn test_block_job_run(void *opaque)
         }
     }
 
-    job_defer_to_main_loop(&job->job, test_block_job_complete,
-                           (void *)(intptr_t)s->rc);
+    s->common.job.ret = s->rc;
 }
 
 typedef struct {
@@ -81,6 +74,7 @@ static const BlockJobDriver test_block_job_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .start         = test_block_job_run,
+        .exit          = test_block_job_exit,
     },
 };
 
-- 
2.14.4
