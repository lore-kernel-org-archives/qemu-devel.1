Received: from eggs.gnu.org ([2001:4830:134:3::10]:53288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQV-0006AL-Dg
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQT-00047I-V0
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Sep 2018 18:15:13 +0200
Message-Id: <20180907161520.26349-8-kwolf@redhat.com>
In-Reply-To: <20180907161520.26349-1-kwolf@redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] aio-wait: Increase num_waiters even in
 home thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

Even if AIO_WAIT_WHILE() is called in the home context of the
AioContext, we still want to allow the condition to change depending on
other threads as long as they kick the AioWait. Specfically block jobs
can be running in an I/O thread and should then be able to kick a drain
in the main loop context.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio-wait.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index c85a62f798..46ba7f9111 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -77,10 +77,12 @@ typedef struct {
     AioWait *wait_ = (wait);                                       \
     AioContext *ctx_ = (ctx);                                      \
     if (ctx_ && in_aio_context_home_thread(ctx_)) {                \
+        atomic_inc(&wait_->num_waiters);                           \
         while ((cond)) {                                           \
             aio_poll(ctx_, true);                                  \
             waited_ = true;                                        \
         }                                                          \
+        atomic_dec(&wait_->num_waiters);                           \
     } else {                                                       \
         assert(qemu_get_current_aio_context() ==                   \
                qemu_get_aio_context());                            \
-- 
2.13.6
