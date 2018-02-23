Received: from eggs.gnu.org ([2001:4830:134:3::10]:55172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8H-0005mD-W1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8F-0005m9-Rr
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:05 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:34 -0500
Message-Id: <20180223235142.21501-14-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 13/21] blockjobs: add commit, abort,
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
index ef17dea004..431ce9c220 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -394,6 +394,29 @@ static void block_job_update_rc(BlockJob *job)
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
@@ -402,17 +425,11 @@ static void block_job_completed_single(BlockJob *job)
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
2.14.3
