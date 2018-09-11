Received: from eggs.gnu.org ([2001:4830:134:3::10]:37172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzdwU-0007r7-Om
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzdwR-0007My-KA
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:22:38 -0400
Date: Tue, 11 Sep 2018 16:17:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911081723.GE19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] job: Use AIO_WAIT_WHILE() in
 job_finish_sync()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

On Fri, 09/07 18:15, Kevin Wolf wrote:
> job_finish_sync() needs to release the AioContext lock of the job before
> calling aio_poll(). Otherwise, callbacks called by aio_poll() would
> possibly take the lock a second time and run into a deadlock with a
> nested AIO_WAIT_WHILE() call.
> 
> Also, job_drain() without aio_poll() isn't necessarily enough to make
> progress on a job, it could depend on bottom halves to be executed.
> 
> Combine both open-coded while loops into a single AIO_WAIT_WHILE() call
> that solves both of these problems.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  job.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/job.c b/job.c
> index 9ad0b7476a..8480eda188 100644
> --- a/job.c
> +++ b/job.c
> @@ -29,6 +29,7 @@
>  #include "qemu/job.h"
>  #include "qemu/id.h"
>  #include "qemu/main-loop.h"
> +#include "block/aio-wait.h"
>  #include "trace-root.h"
>  #include "qapi/qapi-events-job.h"
>  
> @@ -998,6 +999,7 @@ void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque)
>  int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
>  {
>      Error *local_err = NULL;
> +    AioWait dummy_wait = {};
>      int ret;
>  
>      job_ref(job);
> @@ -1010,14 +1012,10 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
>          job_unref(job);
>          return -EBUSY;
>      }
> -    /* job_drain calls job_enter, and it should be enough to induce progress
> -     * until the job completes or moves to the main thread. */
> -    while (!job->deferred_to_main_loop && !job_is_completed(job)) {
> -        job_drain(job);
> -    }
> -    while (!job_is_completed(job)) {
> -        aio_poll(qemu_get_aio_context(), true);
> -    }
> +
> +    AIO_WAIT_WHILE(&dummy_wait, job->aio_context,
> +                   (job_drain(job), !job_is_completed(job)));

The condition expression would read more elegant if job_drain() returns
progress.

Reviewed-by: Fam Zheng <famz@redhat.com>

> +
>      ret = (job_is_cancelled(job) && job->ret == 0) ? -ECANCELED : job->ret;
>      job_unref(job);
>      return ret;
> -- 
> 2.13.6
> 
