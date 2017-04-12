Received: from eggs.gnu.org ([2001:4830:134:3::10]:43033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyS5q-0003sQ-Q9
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyS5p-0004vc-HZ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:54:34 -0400
Date: Thu, 13 Apr 2017 07:54:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170412235420.GB8607@lemon>
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170412222251.GB15762@localhost.localdomain>
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

On Wed, 04/12 18:22, Jeff Cody wrote:
> On Wed, Apr 12, 2017 at 05:38:17PM -0400, John Snow wrote:
> > 
> > 
> > On 04/12/2017 04:46 PM, Jeff Cody wrote:
> > > 
> > > This occurs on v2.9.0-rc4, but not on v2.8.0.
> > > 
> > > When running QEMU with an iothread, and then performing a block-mirror, if
> > > we do a system-reset after the BLOCK_JOB_READY event has emitted, qemu
> > > becomes deadlocked.
> > > 
> > > The block job is not paused, nor cancelled, so we are stuck in the while
> > > loop in block_job_detach_aio_context:
> > > 
> > > static void block_job_detach_aio_context(void *opaque)
> > > {
> > >     BlockJob *job = opaque;
> > > 
> > >     /* In case the job terminates during aio_poll()... */
> > >     block_job_ref(job);
> > > 
> > >     block_job_pause(job);
> > > 
> > >     while (!job->paused && !job->completed) {
> > >         block_job_drain(job);
> > >     }
> > > 
> > 
> > Looks like when block_job_drain calls block_job_enter from this context
> > (the main thread, since we're trying to do a system_reset...), we cannot
> > enter the coroutine because it's the wrong context, so we schedule an
> > entry instead with
> > 
> > aio_co_schedule(ctx, co);
> > 
> > But that entry never happens, so the job never wakes up and we never
> > make enough progress in the coroutine to gracefully pause, so we wedge here.
> > 
> 
> 
> John Snow and I debugged this some over IRC.  Here is a summary:
> 
> Simply put, with iothreads the aio context is different.  When
> block_job_detach_aio_context() is called from the main thread via the system
> reset (from main_loop_should_exit()), it calls block_job_drain() in a while
> loop, with job->busy and job->completed as exit conditions.
> 
> block_job_drain() attempts to enter the coroutine (thus allowing job->busy
> or job->completed to change).  However, since the aio context is different
> with iothreads, we schedule the coroutine entry rather than directly
> entering it.
> 
> This means the job coroutine is never going to be re-entered, because we are
> waiting for it to complete in a while loop from the main thread, which is
> blocking the qemu timers which would run the scheduled coroutine... hence,
> we become stuck.

John and I confirmed that this can be fixed by this pending patch:

[PATCH for-2.9 4/5] block: Drain BH in bdrv_drained_begin

https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01018.html

It didn't make it into 2.9-rc4 because of limited time. :(

Looks like there is no -rc5, we'll have to document this as a known issue.
Users should "block-job-complete/cancel" as soon as possible to avoid such a
hang.

Fam
