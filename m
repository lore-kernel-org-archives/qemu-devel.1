Received: from eggs.gnu.org ([2001:4830:134:3::10]:46984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6J-0005rT-AT
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6I-0003aB-Ey
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:11 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 22 Mar 2017 13:31:00 -0400
Message-Id: <20170322173102.18180-3-jcody@redhat.com>
In-Reply-To: <20170322173102.18180-1-jcody@redhat.com>
References: <20170322173102.18180-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 2/4] blockjob: add block_job_start_shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

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
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20170316212351.13797-2-jsnow@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 2159df7..0e9ed03 100644
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
