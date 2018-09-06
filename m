Received: from eggs.gnu.org ([2001:4830:134:3::10]:56800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxdG-0000tH-Dn
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxdF-0001Hz-C2
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:59:50 -0400
Date: Thu, 6 Sep 2018 12:59:44 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180906165944.GI22117@localhost.localdomain>
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-12-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906130225.5118-12-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/16] jobs: remove .exit callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Sep 06, 2018 at 09:02:20AM -0400, John Snow wrote:
> Now that all of the jobs use the component finalization callbacks,
> there's no use for the heavy-hammer .exit callback anymore.
> 
> job_exit becomes a glorified type shim so that we can call
> job_completed from aio_bh_schedule_oneshot.
> 
> Move these three functions down into job.c to eliminate a
> forward reference.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  include/qemu/job.h | 11 --------
>  job.c              | 77 ++++++++++++++++++++++++------------------------------
>  2 files changed, 34 insertions(+), 54 deletions(-)
> 
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index e0cff702b7..5cb0681834 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -221,17 +221,6 @@ struct JobDriver {
>       */
>      void (*drain)(Job *job);
>  
> -    /**
> -     * If the callback is not NULL, exit will be invoked from the main thread
> -     * when the job's coroutine has finished, but before transactional
> -     * convergence; before @prepare or @abort.
> -     *
> -     * FIXME TODO: This callback is only temporary to transition remaining jobs
> -     * to prepare/commit/abort/clean callbacks and will be removed before 3.1.
> -     * is released.
> -     */
> -    void (*exit)(Job *job);
> -
>      /**
>       * If the callback is not NULL, prepare will be invoked when all the jobs
>       * belonging to the same transaction complete; or upon this job's completion
> diff --git a/job.c b/job.c
> index 01dd97fee3..72f7de1f36 100644
> --- a/job.c
> +++ b/job.c
> @@ -535,49 +535,6 @@ void job_drain(Job *job)
>      }
>  }
>  
> -static void job_completed(Job *job);
> -
> -static void job_exit(void *opaque)
> -{
> -    Job *job = (Job *)opaque;
> -    AioContext *aio_context = job->aio_context;
> -
> -    if (job->driver->exit) {
> -        aio_context_acquire(aio_context);
> -        job->driver->exit(job);
> -        aio_context_release(aio_context);
> -    }
> -    job_completed(job);
> -}
> -
> -/**
> - * All jobs must allow a pause point before entering their job proper. This
> - * ensures that jobs can be paused prior to being started, then resumed later.
> - */
> -static void coroutine_fn job_co_entry(void *opaque)
> -{
> -    Job *job = opaque;
> -
> -    assert(job && job->driver && job->driver->run);
> -    job_pause_point(job);
> -    job->ret = job->driver->run(job, &job->err);
> -    job->deferred_to_main_loop = true;
> -    aio_bh_schedule_oneshot(qemu_get_aio_context(), job_exit, job);
> -}
> -
> -
> -void job_start(Job *job)
> -{
> -    assert(job && !job_started(job) && job->paused &&
> -           job->driver && job->driver->run);
> -    job->co = qemu_coroutine_create(job_co_entry, job);
> -    job->pause_count--;
> -    job->busy = true;
> -    job->paused = false;
> -    job_state_transition(job, JOB_STATUS_RUNNING);
> -    aio_co_enter(job->aio_context, job->co);
> -}
> -
>  /* Assumes the block_job_mutex is held */
>  static bool job_timer_not_pending(Job *job)
>  {
> @@ -894,6 +851,40 @@ static void job_completed(Job *job)
>      }
>  }
>  
> +/** Useful only as a type shim for aio_bh_schedule_oneshot. */
> +static void job_exit(void *opaque)
> +{
> +    Job *job = (Job *)opaque;
> +    job_completed(job);
> +}
> +
> +/**
> + * All jobs must allow a pause point before entering their job proper. This
> + * ensures that jobs can be paused prior to being started, then resumed later.
> + */
> +static void coroutine_fn job_co_entry(void *opaque)
> +{
> +    Job *job = opaque;
> +
> +    assert(job && job->driver && job->driver->run);
> +    job_pause_point(job);
> +    job->ret = job->driver->run(job, &job->err);
> +    job->deferred_to_main_loop = true;
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(), job_exit, job);
> +}
> +
> +void job_start(Job *job)
> +{
> +    assert(job && !job_started(job) && job->paused &&
> +           job->driver && job->driver->run);
> +    job->co = qemu_coroutine_create(job_co_entry, job);
> +    job->pause_count--;
> +    job->busy = true;
> +    job->paused = false;
> +    job_state_transition(job, JOB_STATUS_RUNNING);
> +    aio_co_enter(job->aio_context, job->co);
> +}
> +
>  void job_cancel(Job *job, bool force)
>  {
>      if (job->status == JOB_STATUS_CONCLUDED) {
> -- 
> 2.14.4
> 
