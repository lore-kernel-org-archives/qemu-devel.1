Received: from eggs.gnu.org ([2001:4830:134:3::10]:34533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzdlr-0007u0-JV
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzdlq-0006s4-Mz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:11:39 -0400
Date: Tue, 11 Sep 2018 16:11:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911081129.GD19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] test-blockjob: Acquire AioContext
 around job_finish_sync()
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
> All callers in QEMU proper hold the AioContext lock when calling
> job_finish_sync(). test-blockjob should do the same.

I think s/job_finish_sync/job_cancel_sync/ in the subject is more accurate?

Reviewed-by: Fam Zheng <famz@redhat.com>

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h    | 6 ++++++
>  tests/test-blockjob.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 0dae5b8481..8ac48dbd28 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -520,6 +520,8 @@ void job_user_cancel(Job *job, bool force, Error **errp);
>   *
>   * Returns the return value from the job if the job actually completed
>   * during the call, or -ECANCELED if it was canceled.
> + *
> + * Callers must hold the AioContext lock of job->aio_context.
>   */
>  int job_cancel_sync(Job *job);
>  
> @@ -537,6 +539,8 @@ void job_cancel_sync_all(void);
>   * function).
>   *
>   * Returns the return value from the job.
> + *
> + * Callers must hold the AioContext lock of job->aio_context.
>   */
>  int job_complete_sync(Job *job, Error **errp);
>  
> @@ -579,6 +583,8 @@ void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque);
>   *
>   * Returns 0 if the job is successfully completed, -ECANCELED if the job was
>   * cancelled before completing, and -errno in other error cases.
> + *
> + * Callers must hold the AioContext lock of job->aio_context.
>   */
>  int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp);
>  
> diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
> index cb42f06e61..8c2babbe35 100644
> --- a/tests/test-blockjob.c
> +++ b/tests/test-blockjob.c
> @@ -230,6 +230,10 @@ static void cancel_common(CancelJob *s)
>      BlockJob *job = &s->common;
>      BlockBackend *blk = s->blk;
>      JobStatus sts = job->job.status;
> +    AioContext *ctx;
> +
> +    ctx = job->job.aio_context;
> +    aio_context_acquire(ctx);
>  
>      job_cancel_sync(&job->job);
>      if (sts != JOB_STATUS_CREATED && sts != JOB_STATUS_CONCLUDED) {
> @@ -239,6 +243,8 @@ static void cancel_common(CancelJob *s)
>      assert(job->job.status == JOB_STATUS_NULL);
>      job_unref(&job->job);
>      destroy_blk(blk);
> +
> +    aio_context_release(ctx);
>  }
>  
>  static void test_cancel_created(void)
> -- 
> 2.13.6
> 
