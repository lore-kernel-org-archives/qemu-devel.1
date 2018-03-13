Received: from eggs.gnu.org ([2001:4830:134:3::10]:59262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd7-0001LQ-4A
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd6-0004ZK-4H
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:35 +0100
Message-Id: <20180313161803.1814-14-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/41] blockjobs: add commit, abort,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

The completed_single function is getting a little mucked up with
checking to see which callbacks exist, so let's factor them out.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 61af628376..0c64fadc6d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -415,6 +415,29 @@ static void block_job_update_rc(BlockJob *job)
     }
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
@@ -423,17 +446,11 @@ static void block_job_completed_single(BlockJob *job)
     block_job_update_rc(job);
 
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
2.13.6
