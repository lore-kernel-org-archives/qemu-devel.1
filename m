Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cocsL-0005Ay-HT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cocsK-0002aY-Ir
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:24:01 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 16 Mar 2017 17:23:49 -0400
Message-Id: <20170316212351.13797-2-jsnow@redhat.com>
In-Reply-To: <20170316212351.13797-1-jsnow@redhat.com>
References: <20170316212351.13797-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] blockjob: add block_job_start_shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

The purpose of this shim is to allow us to pause pre-started jobs.
The purpose of *that* is to allow us to buffer a pause request that
will be able to take effect before the job ever does any work, allowing
us to create jobs during a quiescent state (under which they will be
automatically paused), then resuming the jobs after the critical section
in any order, either:

(1) -block_job_start
    -block_job_resume (via e.g. drained_end)

(2) -block_job_resume (via e.g. drained_end)
    -block_job_start

The problem that requires a startup wrapper is the idea that a job must
start in the busy=true state only its first time-- all subsequent entries
require busy to be false, and the toggling of this state is otherwise
handled during existing pause and yield points.

The wrapper simply allows us to mandate that a job can "start," set busy
to true, then immediately pause only if necessary. We could avoid
requiring a wrapper, but all jobs would need to do it, so it's been
factored out here.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 69126af..69b4ec6 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -250,16 +250,28 @@ static bool block_job_started(BlockJob *job)
     return job->co;
 }
 
+/**
+ * All jobs must allow a pause point before entering their job proper. This
+ * ensures that jobs can be paused prior to being started, then resumed later.
+ */
+static void coroutine_fn block_job_co_entry(void *opaque)
+{
+    BlockJob *job = opaque;
+
+    assert(job && job->driver && job->driver->start);
+    block_job_pause_point(job);
+    job->driver->start(job);
+}
+
 void block_job_start(BlockJob *job)
 {
     assert(job && !block_job_started(job) && job->paused &&
-           !job->busy && job->driver->start);
-    job->co = qemu_coroutine_create(job->driver->start, job);
-    if (--job->pause_count == 0) {
-        job->paused = false;
-        job->busy = true;
-        qemu_coroutine_enter(job->co);
-    }
+           job->driver && job->driver->start);
+    job->co = qemu_coroutine_create(block_job_co_entry, job);
+    job->pause_count--;
+    job->busy = true;
+    job->paused = false;
+    qemu_coroutine_enter(job->co);
 }
 
 void block_job_ref(BlockJob *job)
-- 
2.9.3
