Received: from eggs.gnu.org ([2001:4830:134:3::10]:34009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqier-0000pD-Lb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqiep-0005PN-3L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:58:45 -0400
Date: Wed, 22 Mar 2017 11:58:29 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170322155829.GG3411@localhost.localdomain>
References: <20170316212351.13797-1-jsnow@redhat.com>
	<20170316212351.13797-2-jsnow@redhat.com>
	<20170322125751.GA15423@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322125751.GA15423@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] blockjob: add block_job_start_shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Mar 22, 2017 at 08:57:51AM -0400, Jeff Cody wrote:
> On Thu, Mar 16, 2017 at 05:23:49PM -0400, John Snow wrote:
> > The purpose of this shim is to allow us to pause pre-started jobs.
> > The purpose of *that* is to allow us to buffer a pause request that
> > will be able to take effect before the job ever does any work, allowing
> > us to create jobs during a quiescent state (under which they will be
> > automatically paused), then resuming the jobs after the critical section
> > in any order, either:
> > 
> > (1) -block_job_start
> >     -block_job_resume (via e.g. drained_end)
> > 
> > (2) -block_job_resume (via e.g. drained_end)
> >     -block_job_start
> > 
> > The problem that requires a startup wrapper is the idea that a job must
> > start in the busy=true state only its first time-- all subsequent entries
> > require busy to be false, and the toggling of this state is otherwise
> > handled during existing pause and yield points.
> > 
> > The wrapper simply allows us to mandate that a job can "start," set busy
> > to true, then immediately pause only if necessary. We could avoid
> > requiring a wrapper, but all jobs would need to do it, so it's been
> > factored out here.
> 
> I think this makes sense.  So when this happens:
> 
> * block_job_create
> * block_job_pause
> * block_job_resume  <-- only effects pause_count, rest is noop
> * block_job_start
> 
> The block_job_resume is mostly a no-op, only affecting the pause_count but
> since there is no job coroutine created yet, the block_job_enter does
> nothing.
>

I should have added:

Reviewed-by: Jeff Cody <jcody@redhat.com>

> > 
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  blockjob.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/blockjob.c b/blockjob.c
> > index 69126af..69b4ec6 100644
> > --- a/blockjob.c
> > +++ b/blockjob.c
> > @@ -250,16 +250,28 @@ static bool block_job_started(BlockJob *job)
> >      return job->co;
> >  }
> >  
> > +/**
> > + * All jobs must allow a pause point before entering their job proper. This
> > + * ensures that jobs can be paused prior to being started, then resumed later.
> > + */
> > +static void coroutine_fn block_job_co_entry(void *opaque)
> > +{
> > +    BlockJob *job = opaque;
> > +
> > +    assert(job && job->driver && job->driver->start);
> > +    block_job_pause_point(job);
> > +    job->driver->start(job);
> > +}
> > +
> >  void block_job_start(BlockJob *job)
> >  {
> >      assert(job && !block_job_started(job) && job->paused &&
> > -           !job->busy && job->driver->start);
> > -    job->co = qemu_coroutine_create(job->driver->start, job);
> > -    if (--job->pause_count == 0) {
> > -        job->paused = false;
> > -        job->busy = true;
> > -        qemu_coroutine_enter(job->co);
> > -    }
> > +           job->driver && job->driver->start);
> > +    job->co = qemu_coroutine_create(block_job_co_entry, job);
> > +    job->pause_count--;
> > +    job->busy = true;
> > +    job->paused = false;
> > +    qemu_coroutine_enter(job->co);
> >  }
> >  
> >  void block_job_ref(BlockJob *job)
> > -- 
> > 2.9.3
> > 
