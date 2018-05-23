Received: from eggs.gnu.org ([2001:4830:134:3::10]:35576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLd1W-0000Rd-EX
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLd1V-0001nF-2d
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:18:26 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-22-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
Date: Wed, 23 May 2018 19:18:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-22-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/40] job: Convert
 block_job_cancel_async() to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/18/2018 09:20 AM, Kevin Wolf wrote:
> block_job_cancel_async() did two things that were still block job
> specific:
> 
> * Setting job->force. This field makes sense on the Job level, so we can
>   just move it. While at it, rename it to job->force_cancel to make its
>   purpose more obvious.
> 
> * Resetting the I/O status. This can't be moved because generic Jobs
>   don't have an I/O status. What the function really implements is a
>   user resume, except without entering the coroutine. Consequently, it

You know, I had noticed this before but because this is called from
contexts which are NOT user-initiated, I didn't want to share the callback.

... I guess it's fine because the job is about to not exist anymore, so
it probably won't spook anything.

>   makes sense to call the .user_resume driver callback here which
>   already resets the I/O status.
> 
>   The old block_job_cancel_async() has two separate if statements that
>   check job->iostatus != BLOCK_DEVICE_IO_STATUS_OK and job->user_paused.
>   However, the former condition always implies the latter (as is
>   asserted in block_job_iostatus_reset()), so changing the explicit call
>   of block_job_iostatus_reset() on the former condition with the
>   .user_resume callback on the latter condition is equivalent and
>   doesn't need to access any BlockJob specific state.

Oh, cool! This is nice.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/blockjob.h |  6 ------
>  include/qemu/job.h       |  6 ++++++
>  block/mirror.c           |  4 ++--
>  blockjob.c               | 25 +++++++++++++------------
>  4 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 3f405d1fa7..d975efea20 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -51,12 +51,6 @@ typedef struct BlockJob {
>      BlockBackend *blk;
>  
>      /**
> -     * Set to true if the job should abort immediately without waiting
> -     * for data to be in sync.
> -     */
> -    bool force;
> -
> -    /**
>       * Set to true when the job is ready to be completed.
>       */
>      bool ready;
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 3e817beee9..2648c74281 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -97,6 +97,12 @@ typedef struct Job {
>       */
>      bool cancelled;
>  
> +    /**
> +     * Set to true if the job should abort immediately without waiting
> +     * for data to be in sync.
> +     */
> +    bool force_cancel;
> +

Does this comment need an update now, though?

Actually, in terms of "new jobs" API, it'd be really nice if cancel
*always meant cancel*.

I think "cancel" should never be used to mean "successful completion,
but different from the one we'd get if we used job_complete."

i.e., either we need a job setting:

job-set completion-mode=[pivot|no-pivot]

or optional parameters to pass to job-complete:

job-complete mode=[understood-by-job-type]

or some other mechanism that accomplishes the same type of behavior. It
would be nice if it did not have to be determined at job creation time
but instead could be determined later.


>      /** Set to true when the job has deferred work to the main loop. */
>      bool deferred_to_main_loop;
>  
> diff --git a/block/mirror.c b/block/mirror.c
> index e9a90ea730..c3951d1ca2 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -871,7 +871,7 @@ static void coroutine_fn mirror_run(void *opaque)
>          trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>          job_sleep_ns(&s->common.job, delay_ns);
>          if (job_is_cancelled(&s->common.job) &&
> -            (!s->synced || s->common.force))
> +            (!s->synced || s->common.job.force_cancel))
>          {
>              break;
>          }
> @@ -884,7 +884,7 @@ immediate_exit:
>           * or it was cancelled prematurely so that we do not guarantee that
>           * the target is a copy of the source.
>           */
> -        assert(ret < 0 || ((s->common.force || !s->synced) &&
> +        assert(ret < 0 || ((s->common.job.force_cancel || !s->synced) &&
>                 job_is_cancelled(&s->common.job)));
>          assert(need_drain);
>          mirror_wait_for_all_io(s);
> diff --git a/blockjob.c b/blockjob.c
> index 34c57da304..4cac3670ad 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -270,19 +270,20 @@ static int block_job_prepare(BlockJob *job)
>      return job->job.ret;
>  }
>  
> -static void block_job_cancel_async(BlockJob *job, bool force)
> +static void job_cancel_async(Job *job, bool force)
>  {
> -    if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
> -        block_job_iostatus_reset(job);
> -    }
> -    if (job->job.user_paused) {
> -        /* Do not call block_job_enter here, the caller will handle it.  */
> -        job->job.user_paused = false;
> -        job->job.pause_count--;
> +    if (job->user_paused) {
> +        /* Do not call job_enter here, the caller will handle it.  */
> +        job->user_paused = false;
> +        if (job->driver->user_resume) {
> +            job->driver->user_resume(job);
> +        }
> +        assert(job->pause_count > 0);
> +        job->pause_count--;
>      }
> -    job->job.cancelled = true;
> +    job->cancelled = true;
>      /* To prevent 'force == false' overriding a previous 'force == true' */
> -    job->force |= force;
> +    job->force_cancel |= force;
>  }
>  
>  static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *), bool lock)
> @@ -367,7 +368,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
>       * on the caller, so leave it. */
>      QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
>          if (other_job != job) {
> -            block_job_cancel_async(other_job, false);
> +            job_cancel_async(&other_job->job, false);
>          }
>      }
>      while (!QLIST_EMPTY(&txn->jobs)) {
> @@ -527,7 +528,7 @@ void block_job_cancel(BlockJob *job, bool force)
>          job_do_dismiss(&job->job);
>          return;
>      }
> -    block_job_cancel_async(job, force);
> +    job_cancel_async(&job->job, force);
>      if (!job_started(&job->job)) {
>          block_job_completed(job, -ECANCELED);
>      } else if (job->job.deferred_to_main_loop) {
> 
