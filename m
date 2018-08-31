Received: from eggs.gnu.org ([2001:4830:134:3::10]:35549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fvjn0-0004Ey-FY
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fvjmz-0007eu-4v
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:48:42 -0400
Date: Fri, 31 Aug 2018 09:48:28 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180831134828.GE415265@localhost.localdomain>
References: <20180830015734.19765-1-jsnow@redhat.com>
	<20180830015734.19765-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830015734.19765-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/9] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Aug 29, 2018 at 09:57:28PM -0400, John Snow wrote:
> All jobs do the same thing when they leave their running loop:
> - Store the return code in a structure
> - wait to receive this structure in the main thread
> - signal job completion via job_completed
> 
> Few jobs do anything beyond exactly this. Consolidate this exit
> logic for a net reduction in SLOC.
> 
> More seriously, when we utilize job_defer_to_main_loop_bh to call
> a function that calls job_completed, job_finalize_single will run
> in a context where it has recursively taken the aio_context lock,
> which can cause hangs if it puts down a reference that causes a flush.
> 
> You can observe this in practice by looking at mirror_exit's careful
> placement of job_completed and bdrv_unref calls.
> 
> If we centralize job exiting, we can signal job completion from outside
> of the aio_context, which should allow for job cleanup code to run with
> only one lock, which makes cleanup callbacks less tricky to write.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  include/qemu/job.h | 11 +++++++++++
>  job.c              | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index e0e99870a1..1144d671a1 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -208,6 +208,17 @@ struct JobDriver {
>       */
>      void (*drain)(Job *job);
>  
> +    /**
> +     * If the callback is not NULL, exit will be invoked from the main thread
> +     * when the job's coroutine has finished, but before transactional
> +     * convergence; before @prepare or @abort.
> +     *
> +     * FIXME TODO: This callback is only temporary to transition remaining jobs
> +     * to prepare/commit/abort/clean callbacks and will be removed before 3.1.
> +     * is released.
> +     */
> +    void (*exit)(Job *job);
> +
>      /**
>       * If the callback is not NULL, prepare will be invoked when all the jobs
>       * belonging to the same transaction complete; or upon this job's completion
> diff --git a/job.c b/job.c
> index bc1d970df4..bc8dad4e71 100644
> --- a/job.c
> +++ b/job.c
> @@ -535,6 +535,18 @@ void job_drain(Job *job)
>      }
>  }
>  
> +static void job_exit(void *opaque)
> +{
> +    Job *job = (Job *)opaque;
> +    AioContext *aio_context = job->aio_context;
> +
> +    if (job->driver->exit) {
> +        aio_context_acquire(aio_context);
> +        job->driver->exit(job);
> +        aio_context_release(aio_context);
> +    }
> +    job_completed(job, job->ret);
> +}
>  
>  /**
>   * All jobs must allow a pause point before entering their job proper. This
> @@ -547,6 +559,12 @@ static void coroutine_fn job_co_entry(void *opaque)
>      assert(job && job->driver && job->driver->run);
>      job_pause_point(job);
>      job->ret = job->driver->run(job, &job->err);
> +    if (!job->deferred_to_main_loop) {
> +        job->deferred_to_main_loop = true;
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                job_exit,
> +                                job);
> +    }
>  }
>  
>  
> -- 
> 2.14.4
> 
