Received: from eggs.gnu.org ([2001:4830:134:3::10]:46982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6J-0005rQ-9r
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6I-0003aI-I9
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:11 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 22 Mar 2017 13:30:59 -0400
Message-Id: <20170322173102.18180-2-jcody@redhat.com>
In-Reply-To: <20170322173102.18180-1-jcody@redhat.com>
References: <20170322173102.18180-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/4] blockjob: avoid recursive
 AioContext locking
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

From: Paolo Bonzini <pbonzini@redhat.com>

Streaming or any other block job hangs when performed on a block device
that has a non-default iothread.  This happens because the AioContext
is acquired twice by block_job_defer_to_main_loop_bh and then released
only once by BDRV_POLL_WHILE.  (Insert rants on recursive mutexes, which
unfortunately are a temporary but necessary evil for iothreads at the
moment).

Luckily, the reason for the double acquisition is simple; the function
acquires the AioContext for both the job iothread and the BDS iothread,
in case the BDS iothread was changed while the job was running.  It
is therefore enough to skip the second acquisition when the two
AioContexts are one and the same.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 1490118490-5597-1-git-send-email-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 69126af..2159df7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -755,12 +755,16 @@ static void block_job_defer_to_main_loop_bh(void *opaque)
 
     /* Fetch BDS AioContext again, in case it has changed */
     aio_context = blk_get_aio_context(data->job->blk);
-    aio_context_acquire(aio_context);
+    if (aio_context != data->aio_context) {
+        aio_context_acquire(aio_context);
+    }
 
     data->job->deferred_to_main_loop = false;
     data->fn(data->job, data->opaque);
 
-    aio_context_release(aio_context);
+    if (aio_context != data->aio_context) {
+        aio_context_release(aio_context);
+    }
 
     aio_context_release(data->aio_context);
 
-- 
2.9.3
