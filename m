Received: from eggs.gnu.org ([2001:4830:134:3::10]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusv-0004DW-Pp
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusu-0003vZ-2Y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxust-0003vR-Sb
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:28 +0800
Message-Id: <20170411122632.14050-8-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] blockjob: Use bdrv_coroutine_enter to
 start coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

Resuming and especially starting of the block job coroutine, could be issued in
the main thread.  However the coroutine's "home" ctx should be set to the same
context as job->blk. Use bdrv_coroutine_enter to ensure that.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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
