Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs8-00014F-Mx
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs7-0008Se-G7
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:36 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:09 -0500
Message-Id: <20180127020515.27137-9-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 08/14] blockjobs: add commit, abort,
 clean helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

The completed_single function is getting a little mucked up with
checking to see which callbacks exist, so let's factor them out.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 3d678d6ce2..1b169a0814 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -376,6 +376,29 @@ void block_job_start(BlockJob *job)
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
+static void block_job_commit(BlockJob *job)
+{
+    assert(!job->ret);
+    if (job->driver->commit) {
+        job->driver->commit(job);
+    }
+}
+
+static void block_job_abort(BlockJob *job)
+{
+    assert(job->ret);
+    if (job->driver->abort) {
+        job->driver->abort(job);
+    }
+}
+
+static void block_job_clean(BlockJob *job)
+{
+    if (job->driver->clean) {
+        job->driver->clean(job);
+    }
+}
+
 static void block_job_completed_single(BlockJob *job)
 {
     assert(job->completed);
@@ -386,17 +409,11 @@ static void block_job_completed_single(BlockJob *job)
     }
 
     if (!job->ret) {
-        if (job->driver->commit) {
-            job->driver->commit(job);
-        }
+        block_job_commit(job);
     } else {
-        if (job->driver->abort) {
-            job->driver->abort(job);
-        }
-    }
-    if (job->driver->clean) {
-        job->driver->clean(job);
+        block_job_abort(job);
     }
+    block_job_clean(job);
 
     if (job->cb) {
         job->cb(job->opaque, job->ret);
-- 
2.14.3
