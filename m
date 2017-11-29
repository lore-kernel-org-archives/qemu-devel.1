Received: from eggs.gnu.org ([2001:4830:134:3::10]:35190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK6by-0002Vy-R0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK6bv-00011U-Oi
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:57:30 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 29 Nov 2017 19:56:34 +0200
Message-Id: <4011ffb0dd7f0a0a3e2cfe28223047c809761c90.1511978000.git.berto@igalia.com>
In-Reply-To: <cover.1511978000.git.berto@igalia.com>
References: <cover.1511978000.git.berto@igalia.com>
In-Reply-To: <cover.1511978000.git.berto@igalia.com>
References: <cover.1511978000.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-2.11 1/1] blockjob: Make
 block_job_pause_all() keep a reference to the jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Starting from commit 40840e419be31e6a32e6ea24511c74b389d5e0e4 we are
pausing all block jobs during bdrv_reopen_multiple() to prevent any of
them from finishing and removing nodes from the graph while they are
being reopened.

It turns out that pausing a block job doesn't necessarily prevent it
from finishing: a paused block job can still run its exit function
from the main loop and call block_job_completed(). The mirror block
job in particular always goes to the main loop while it is paused (by
virtue of the bdrv_drained_begin() call in mirror_run()).

Destroying a paused block job during bdrv_reopen_multiple() has two
consequences:

   1) The references to the nodes involved in the job are released,
      possibly destroying some of them. If those nodes were in the
      reopen queue this would trigger the problem originally described
      in commit 40840e419be, crashing QEMU.

   2) At the end of bdrv_reopen_multiple(), bdrv_drain_all_end() would
      not be doing all necessary bdrv_parent_drained_end() calls.

I can reproduce problem 1) easily with iotest 030 by increasing
STREAM_BUFFER_SIZE from 512KB to 8MB in block/stream.c, or by tweaking
the iotest like in this example:

   https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00934.html

This patch keeps an additional reference to all block jobs between
block_job_pause_all() and block_job_resume_all(), guaranteeing that
they are kept alive.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 blockjob.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 0ed50b953b..715c2c2680 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -730,6 +730,7 @@ void block_job_pause_all(void)
         AioContext *aio_context = blk_get_aio_context(job->blk);
 
         aio_context_acquire(aio_context);
+        block_job_ref(job);
         block_job_pause(job);
         aio_context_release(aio_context);
     }
@@ -808,12 +809,14 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
 
 void block_job_resume_all(void)
 {
-    BlockJob *job = NULL;
-    while ((job = block_job_next(job))) {
+    BlockJob *job, *next;
+
+    QLIST_FOREACH_SAFE(job, &block_jobs, job_list, next) {
         AioContext *aio_context = blk_get_aio_context(job->blk);
 
         aio_context_acquire(aio_context);
         block_job_resume(job);
+        block_job_unref(job);
         aio_context_release(aio_context);
     }
 }
-- 
2.11.0
