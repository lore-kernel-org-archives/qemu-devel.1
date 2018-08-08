Received: from eggs.gnu.org ([2001:4830:134:3::10]:39639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fnFgg-00015l-FX
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fnFgf-0002HZ-F5
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:03:06 -0400
Date: Wed, 8 Aug 2018 00:02:53 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180808040253.GE755222@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807043349.27196-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/21] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Aug 07, 2018 at 12:33:30AM -0400, John Snow wrote:
> Most jobs do the same thing when they leave their running loop:
> - Store the return code in a structure
> - wait to receive this structure in the main thread
> - signal job completion via job_completed
> 
> More seriously, when we utilize job_defer_to_main_loop_bh to call
> a function that calls job_completed, job_finalize_single will run
> in a context where it has recursively taken the aio_context lock,
> which can cause hangs if it puts down a reference that causes a flush.
> 
> The job infrastructure is perfectly capable of registering job
> completion itself when we leave the job's entry point. In this
> context, we can signal job completion from outside of the aio_context,
> which should allow for job cleanup code to run with only one lock.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

I like the simplification, both in SLOC and in exit logic (as seen in
patches 3-7).

> ---
>  include/qemu/job.h |  7 +++++++
>  job.c              | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 845ad00c03..0c24e8704f 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -204,6 +204,13 @@ struct JobDriver {
>       */
>      void (*drain)(Job *job);
>  
> +    /**
> +     * If the callback is not NULL, exit will be invoked from the main thread
> +     * when the job's coroutine has finished, but before transactional
> +     * convergence; before @prepare or @abort.
> +     */
> +    void (*exit)(Job *job);
> +
>      /**
>       * If the callback is not NULL, prepare will be invoked when all the jobs
>       * belonging to the same transaction complete; or upon this job's completion
> diff --git a/job.c b/job.c
> index b281f30375..cc5ac9ac30 100644
> --- a/job.c
> +++ b/job.c
> @@ -535,6 +535,19 @@ void job_drain(Job *job)
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
> +
>  /**
>   * All jobs must allow a pause point before entering their job proper. This
>   * ensures that jobs can be paused prior to being started, then resumed later.
> @@ -546,6 +559,12 @@ static void coroutine_fn job_co_entry(void *opaque)
>      assert(job && job->driver && job->driver->start);
>      job_pause_point(job);
>      job->driver->start(job);

One nit-picky observation here, that is unrelated to this patch: reading
through, it may not be so obvious that 'start' is really a 'run' or
'execute', (linguistically, to me 'start' implies a kick-off rather than
ongoing execution).

Just some bike-shedding again, though, and not even for this patch.  So
nothing to do here :)

Reviewed-by: Jeff Cody <jcody@redhat.com>


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
