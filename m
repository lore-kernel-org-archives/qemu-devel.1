Received: from eggs.gnu.org ([2001:4830:134:3::10]:52486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEcyc-0004VP-7g
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEcyb-0002P5-Bc
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:50:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  4 May 2018 16:50:14 +0100
Message-Id: <20180504155014.10311-3-stefanha@redhat.com>
In-Reply-To: <20180504155014.10311-1-stefanha@redhat.com>
References: <20180504155014.10311-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] blockjob: do not cancel timer in resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>

Currently the timer is cancelled and the block job is entered by
block_job_resume().  This behavior causes drain to run extra blockjob
iterations when the job was sleeping due to the ratelimit.

This patch leaves the job asleep when block_job_resume() is called.
Jobs can still be forcibly woken up using block_job_enter(), which is
used to cancel jobs.

After this patch drain no longer runs extra blockjob iterations.  This
is the expected behavior that qemu-iotests 185 used to rely on.  We
temporarily changed the 185 test output to make it pass for the QEMU
2.12 release but now it's time to address this issue.

Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockjob.c                 | 22 +++++++++++++++-------
 tests/qemu-iotests/185.out |  6 +++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 27f957e571..70643890be 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -209,6 +209,18 @@ static void block_job_txn_del_job(BlockJob *job)
     }
 }
 
+/* Assumes the block_job_mutex is held */
+static bool block_job_timer_pending(BlockJob *job)
+{
+    return timer_pending(&job->sleep_timer);
+}
+
+/* Assumes the block_job_mutex is held */
+static bool block_job_timer_not_pending(BlockJob *job)
+{
+    return !block_job_timer_pending(job);
+}
+
 static void block_job_pause(BlockJob *job)
 {
     job->pause_count++;
@@ -221,7 +233,9 @@ static void block_job_resume(BlockJob *job)
     if (job->pause_count) {
         return;
     }
-    block_job_enter(job);
+
+    /* kick only if no timer is pending */
+    block_job_enter_cond(job, block_job_timer_not_pending);
 }
 
 void block_job_ref(BlockJob *job)
@@ -651,12 +665,6 @@ static void block_job_completed_txn_success(BlockJob *job)
     }
 }
 
-/* Assumes the block_job_mutex is held */
-static bool block_job_timer_pending(BlockJob *job)
-{
-    return timer_pending(&job->sleep_timer);
-}
-
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
     Error *local_err = NULL;
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 1f21e79c13..e0b34d1725 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -20,7 +20,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 1048576, "speed": 65536, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "commit"}}
 
 === Start active commit job and exit qemu ===
 
@@ -48,7 +48,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 131072, "speed": 65536, "type": "backup"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 65536, "speed": 65536, "type": "backup"}}
 
 === Start streaming job and exit qemu ===
 
@@ -56,6 +56,6 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 1048576, "speed": 65536, "type": "stream"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "stream"}}
 No errors were found on the image.
 *** done
-- 
2.14.3
