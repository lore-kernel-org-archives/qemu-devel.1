Received: from eggs.gnu.org ([2001:4830:134:3::10]:40668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLldq-0006C8-6p
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLldp-0007A9-0i
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:30:34 -0400
Date: Thu, 24 May 2018 10:30:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180524083020.GD4008@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-32-kwolf@redhat.com>
	<8af81ec5-9a7b-e787-25cd-61deec9a40dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af81ec5-9a7b-e787-25cd-61deec9a40dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 31/40] job: Add job_is_ready()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com

Am 24.05.2018 um 01:42 hat John Snow geschrieben:
> On 05/18/2018 09:21 AM, Kevin Wolf wrote:
> > Instead of having a 'bool ready' in BlockJob, add a function that
> > derives its value from the job status.
> > 
> > At the same time, this fixes the behaviour to match what the QAPI
> > documentation promises for query-block-job: 'true if the job may be
> > completed'. When the ready flag was introduced in commit ef6dbf1e46e,
> > the flag never had to be reset to match the description because after
> > being ready, the jobs would immediately complete and disappear.
> > 
> > Job transactions and manual job finalisation were introduced only later.
> > With these changes, jobs may stay around even after having completed
> > (and they are not ready to be completed a second time), however their
> > patches forgot to reset the ready flag.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  include/block/blockjob.h |  5 -----
> >  include/qemu/job.h       |  3 +++
> >  blockjob.c               |  3 +--
> >  job.c                    | 22 ++++++++++++++++++++++
> >  qemu-img.c               |  2 +-
> >  tests/test-blockjob.c    |  2 +-
> >  6 files changed, 28 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> > index 5a81afc6c3..8e1e1ee0de 100644
> > --- a/include/block/blockjob.h
> > +++ b/include/block/blockjob.h
> > @@ -49,11 +49,6 @@ typedef struct BlockJob {
> >      /** The block device on which the job is operating.  */
> >      BlockBackend *blk;
> >  
> > -    /**
> > -     * Set to true when the job is ready to be completed.
> > -     */
> > -    bool ready;
> > -
> >      /** Status that is published by the query-block-jobs QMP API */
> >      BlockDeviceIoStatus iostatus;
> >  
> > diff --git a/include/qemu/job.h b/include/qemu/job.h
> > index 1e8050c6fb..487f9d9a32 100644
> > --- a/include/qemu/job.h
> > +++ b/include/qemu/job.h
> > @@ -367,6 +367,9 @@ bool job_is_cancelled(Job *job);
> >  /** Returns whether the job is in a completed state. */
> >  bool job_is_completed(Job *job);
> >  
> > +/** Returns whether the job is ready to be completed. */
> > +bool job_is_ready(Job *job);
> > +
> >  /**
> >   * Request @job to pause at the next pause point. Must be paired with
> >   * job_resume(). If the job is supposed to be resumed by user action, call
> > diff --git a/blockjob.c b/blockjob.c
> > index 3ca009bea5..38f18e9ba3 100644
> > --- a/blockjob.c
> > +++ b/blockjob.c
> > @@ -269,7 +269,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
> >      info->offset    = job->offset;
> >      info->speed     = job->speed;
> >      info->io_status = job->iostatus;
> > -    info->ready     = job->ready;
> > +    info->ready     = job_is_ready(&job->job),
> >      info->status    = job->job.status;
> >      info->auto_finalize = job->job.auto_finalize;
> >      info->auto_dismiss  = job->job.auto_dismiss;
> > @@ -436,7 +436,6 @@ void block_job_user_resume(Job *job)
> >  void block_job_event_ready(BlockJob *job)
> >  {
> >      job_state_transition(&job->job, JOB_STATUS_READY);
> > -    job->ready = true;
> >  
> >      if (block_job_is_internal(job)) {
> >          return;
> > diff --git a/job.c b/job.c
> > index af31de4669..66ee26f2a0 100644
> > --- a/job.c
> > +++ b/job.c
> > @@ -199,6 +199,28 @@ bool job_is_cancelled(Job *job)
> >      return job->cancelled;
> >  }
> >  
> > +bool job_is_ready(Job *job)
> > +{
> > +    switch (job->status) {
> > +    case JOB_STATUS_UNDEFINED:
> > +    case JOB_STATUS_CREATED:
> > +    case JOB_STATUS_RUNNING:
> > +    case JOB_STATUS_PAUSED:
> > +    case JOB_STATUS_WAITING:
> > +    case JOB_STATUS_PENDING:
> > +    case JOB_STATUS_ABORTING:
> > +    case JOB_STATUS_CONCLUDED:
> > +    case JOB_STATUS_NULL:
> > +        return false;
> > +    case JOB_STATUS_READY:
> > +    case JOB_STATUS_STANDBY:
> > +        return true;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +    return false;
> > +}
> > +
> 
> What's the benefit to a switch statement with a default clause here,
> over the shorter:
> 
> if (job->status == READY || job->status == STANDBY) {
>   return true;
> }
> return false;
> 
> (Yes, I realize you already merged this code, but I'm still curious and
> I need to read the series anyway to see what's changed...)

That it's easy to copy and paste from job_is_completed()? :-P

I guess you could argue that the switch ensures that we don't forget to
explicitly handle every state if we ever add a new one, but the real
reason is more like, job_is_completed() was already there and I didn't
see a reason to do something different here.

(And actually, I seem to remember that I initially had everything after
READY return true as well, but then I noticed that you can reach those
states through ABORTED as well, which should not result in
job_is_ready() returning true.)

Kevin
