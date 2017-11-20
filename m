Received: from eggs.gnu.org ([2001:4830:134:3::10]:47899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGmFc-00071x-5B
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGmFa-00029O-WE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:36:40 -0500
Date: Mon, 20 Nov 2017 08:36:19 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171120133619.GA32161@localhost.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
	<20171120111653.GB4516@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120111653.GB4516@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

On Mon, Nov 20, 2017 at 11:16:53AM +0000, Stefan Hajnoczi wrote:
> On Sun, Nov 19, 2017 at 09:46:42PM -0500, Jeff Cody wrote:
> > --- a/blockjob.c
> > +++ b/blockjob.c
> > @@ -291,10 +291,10 @@ void block_job_start(BlockJob *job)
> >  {
> >      assert(job && !block_job_started(job) && job->paused &&
> >             job->driver && job->driver->start);
> > -    job->co = qemu_coroutine_create(block_job_co_entry, job);
> >      job->pause_count--;
> >      job->busy = true;
> >      job->paused = false;
> > +    job->co = qemu_coroutine_create(block_job_co_entry, job);
> >      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
> >  }
> >  
> 
> This hunk makes no difference.  The coroutine is only entered by
> bdrv_coroutine_enter() so the order of job field initialization doesn't
> matter.
> 

It likely makes no difference with the current code (unless there is a
latent bug). However I made the change to protect against the following
scenario - which, perhaps to your point, would be a bug in any case:

1. job->co = qemu_coroutine_create()

    * Now block_job_started() returns true, as it just checks for job->co

2. Another thread calls block_job_enter(), before we call
   bdrv_coroutine_enter().

    * block_job_enter() checks job->busy and block_job_started() to
      determine if coroutine entry is allowed.  Without this change, these
      checks could pass and coroutine entry could occur.

    * I don't think this can happen in the current code, but the above hunk
      change is still correct, and would protect against such an
      occurrence.


I guess the question is, "is it worth doing?", to try and prevent that sort
of buggy behavior. My thought was "yes" because:

    A) there is no penalty in doing it this way

    B) while a bug, double entry like this can lead to memory and/or
    data corruption, and the checks for co->caller et al. might not
    catch it.  This is particularly true if the coroutine exits
    (COROUTINE_TERMINATE) before the re-entry.

But maybe if we are concerned about that we should figure out a way to
abort() instead.  Of course, that makes allowing recursive coroutines more
difficult in the future.


> > @@ -797,11 +797,14 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
> >          return;
> >      }
> >  
> > -    job->busy = false;
> > +    /* We need to leave job->busy set here, because when we have
> > +     * put a coroutine to 'sleep', we have scheduled it to run in
> > +     * the future.  We cannot enter that same coroutine again before
> > +     * it wakes and runs, otherwise we risk double-entry or entry after
> > +     * completion. */
> >      if (!block_job_should_pause(job)) {
> >          co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
> >      }
> > -    job->busy = true;
> >  
> >      block_job_pause_point(job);
> 
> This leaves a stale doc comment in include/block/blockjob_int.h:
> 
>   /**
>    * block_job_sleep_ns:
>    * @job: The job that calls the function.
>    * @clock: The clock to sleep on.
>    * @ns: How many nanoseconds to stop for.
>    *
>    * Put the job to sleep (assuming that it wasn't canceled) for @ns
>    * nanoseconds.  Canceling the job will interrupt the wait immediately.
>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    */

I didn't catch the doc, that should be changed as well.

>   void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
> 
> This raises questions about the ability to cancel sleep:
> 
> 1. Does something depend on cancelling sleep?
> 

Not that I can tell.  The advantage is that you don't have to wait for the
timer, so something like qmp_block_job_cancel() will cancel sooner.

But it is obviously broken with the current coroutine implementation to try
to do that.

> 2. Did cancellation work properly in commit
>    4513eafe928ff47486f4167c28d364c72b5ff7e3 ("block: add
>    block_job_sleep_ns") and was it broken afterwards?
> 

With iothreads, the answer is complicated.  It was broken for a while for
other reasons.

It broke after using aio_co_wake() in the sleep timer cb (commmit
2f47da5f7f), which added the ability to schedule a coroutine if the timer
callback was called from the wrong AioContext.

Prior to that it "worked" in that the segfault was not present.

But even to bisect back to 2f47da5f7f was not straightforward, because
attempting them stream/cancel with iothreads would not even work until
c324fd0 (so I only bisected back as far as c324fd0 would cleanly apply).

And it is tricky to say if it "works" or not, because it is racy.  What may
have appeared to work may be more attributed to luck and timing.

If the coroutine is going to run at a future time, we cannot enter it
beforehand.  We risk the coroutine not even existing when the timer does run
the sleeping coroutine.  At the very least, early entry with the current
code would require a way to delete the associated timer.

> It is possible to fix the recursive coroutine entry without losing sleep
> cancellation.  Whether it's worth the trouble depends on the answers to
> the above questions.
> 

I contemplated the same thing.

At least for 2.11, fixing recursive coroutine entry is probably more than we
want to do.

Long term, my opinion is that we should fix it, because preventing it
becomes more difficult. It is easy to miss something that might cause a
recursive entry in code reviews, and since it can be racy, casual testing
may often miss it as well.

Jeff
