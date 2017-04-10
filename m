Received: from eggs.gnu.org ([2001:4830:134:3::10]:34620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxauB-0003yD-K3
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxauA-0002K9-J6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 23:05:39 +0800
Message-Id: <20170410150542.30376-8-famz@redhat.com>
In-Reply-To: <20170410150542.30376-1-famz@redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9 v3 07/10] blockjob: Use
 bdrv_coroutine_enter to start coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Resuming and especially starting of the block job coroutine, could be issued in
the main thread.  However the coroutine's "home" ctx should be set to the same
context as job->blk. Use bdrv_coroutine_enter to ensure that.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 blockjob.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 9b619f385..6e48932 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -290,7 +290,7 @@ void block_job_start(BlockJob *job)
     job->pause_count--;
     job->busy = true;
     job->paused = false;
-    qemu_coroutine_enter(job->co);
+    bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
 void block_job_ref(BlockJob *job)
@@ -532,7 +532,7 @@ void block_job_user_resume(BlockJob *job)
 void block_job_enter(BlockJob *job)
 {
     if (job->co && !job->busy) {
-        qemu_coroutine_enter(job->co);
+        bdrv_coroutine_enter(blk_bs(job->blk), job->co);
     }
 }
 
-- 
2.9.3
