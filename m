Received: from eggs.gnu.org ([2001:4830:134:3::10]:55146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cqNtL-000648-F6
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cqNtI-000246-7K
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:48:19 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Mar 2017 18:48:10 +0100
Message-Id: <1490118490-5597-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] blockjob: avoid recursive AioContext
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, famz@redhat.com, jsnow@redhat.com

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
1.8.3.1
