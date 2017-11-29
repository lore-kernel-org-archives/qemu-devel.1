Received: from eggs.gnu.org ([2001:4830:134:3::10]:34443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK3FI-0003mK-KM
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK3FH-0007T0-NZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:21:52 -0500
Date: Wed, 29 Nov 2017 15:21:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171129142137.GE3753@localhost.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-5-pbonzini@redhat.com>
	<20171129135621.GM25110@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129135621.GM25110@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 4/4] blockjob: reimplement
 block_job_sleep_ns to allow cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

Am 29.11.2017 um 14:56 hat Jeff Cody geschrieben:
> On Wed, Nov 29, 2017 at 11:25:13AM +0100, Paolo Bonzini wrote:
> > This reverts the effects of commit 4afeffc857 ("blockjob: do not allow
> > coroutine double entry or entry-after-completion", 2017-11-21)
> > 
> > This fixed the symptom of a bug rather than the root cause. Canceling the
> > wait on a sleeping blockjob coroutine is generally fine, we just need to
> > make it work correctly across AioContexts.  To do so, use a QEMUTimer
> > that calls block_job_enter.  Use a mutex to ensure that block_job_enter
> > synchronizes correctly with block_job_sleep_ns.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> My only concerns were regarding comments, and Kevin can fix them when
> applying if he wants.

I'm squashing in the following changes.

Kevin


diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 956f0d6819..00403d9482 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -135,7 +135,10 @@ typedef struct BlockJob {
      */
     int ret;
 
-    /** Timer that is used by @block_job_sleep_ns.  */
+    /**
+     * Timer that is used by @block_job_sleep_ns. Accessed under
+     * block_job_mutex (in blockjob.c).
+     */
     QEMUTimer sleep_timer;
 
     /** Non-NULL if this job is part of a transaction */
diff --git a/blockjob.c b/blockjob.c
index 83f5c891be..dd8c685d8a 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -37,9 +37,9 @@
 #include "qemu/timer.h"
 #include "qapi-event.h"
 
-/* Right now, this mutex is only needed to synchronize accesses to job->busy,
- * such as concurrent calls to block_job_do_yield and block_job_enter.
- */
+/* Right now, this mutex is only needed to synchronize accesses to job->busy
+ * and and job->sleep_timer, such as concurrent calls to block_job_do_yield and
+ * block_job_enter. */
 static QemuMutex block_job_mutex;
 
 static void block_job_lock(void)
@@ -760,6 +760,12 @@ static bool block_job_should_pause(BlockJob *job)
     return job->pause_count > 0;
 }
 
+/* Yield, and schedule a timer to reenter the coroutine after @ns nanoseconds.
+ * Reentering the job coroutine with block_job_enter() before the timer has
+ * expired is allowed and cancels the timer.
+ *
+ * If @ns is (uint64_t) -1, no timer is scheduled and block_job_enter() must be
+ * called explicitly. */
 static void block_job_do_yield(BlockJob *job, uint64_t ns)
 {
     block_job_lock();
