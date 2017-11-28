Received: from eggs.gnu.org ([2001:4830:134:3::10]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eJhHO-0002nA-Ii
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eJhHI-0002Z9-VX
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:54:34 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 28 Nov 2017 16:53:27 +0200
Message-Id: <20171128145327.17248-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-2.11] blockjob: Remove the job from the
 list earlier in block_job_unref()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

When destroying a block job in block_job_unref() we should remove it
from the job list before calling block_job_remove_all_bdrv().

This is because removing the BDSs can trigger an aio_poll() and wake
up other jobs that might attempt to use the block job list. If that
happens the job we're currently destroying should not be in that list
anymore.
---
 blockjob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index ff9a614531..2f0cc1528b 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -152,6 +152,7 @@ void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt == 0) {
         BlockDriverState *bs = blk_bs(job->blk);
+        QLIST_REMOVE(job, job_list);
         bs->job = NULL;
         block_job_remove_all_bdrv(job);
         blk_remove_aio_context_notifier(job->blk,
@@ -160,7 +161,6 @@ void block_job_unref(BlockJob *job)
         blk_unref(job->blk);
         error_free(job->blocker);
         g_free(job->id);
-        QLIST_REMOVE(job, job_list);
         g_free(job);
     }
 }
-- 
2.11.0
