Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft6Jo-00076G-VN
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft6Jn-0000ni-VS
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:15:40 -0400
Date: Fri, 24 Aug 2018 15:15:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180824071529.GC31581@lemon.usersys.redhat.com>
References: <20180817170246.14641-1-kwolf@redhat.com>
	<20180817170246.14641-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817170246.14641-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/5] tests: Acquire AioContext around
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
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On Fri, 08/17 19:02, Kevin Wolf wrote:
> All callers in QEMU proper hold the AioContext lock when calling
> job_finish_sync(). The tests should do the same.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

A similar patch is needed for job_finalize() too, I think.

Fam

> ---
>  include/qemu/job.h      | 6 ++++++
>  tests/test-bdrv-drain.c | 6 ++++++
>  tests/test-blockjob.c   | 6 ++++++
>  3 files changed, 18 insertions(+)
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
> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> index 17bb8508ae..30294038ef 100644
> --- a/tests/test-bdrv-drain.c
> +++ b/tests/test-bdrv-drain.c
> @@ -795,6 +795,7 @@ static void test_blockjob_common(enum drain_type drain_type)
>      BlockBackend *blk_src, *blk_target;
>      BlockDriverState *src, *target;
>      BlockJob *job;
> +    AioContext *ctx;
>      int ret;
>  
>      src = bdrv_new_open_driver(&bdrv_test, "source", BDRV_O_RDWR,
> @@ -807,6 +808,9 @@ static void test_blockjob_common(enum drain_type drain_type)
>      blk_target = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
>      blk_insert_bs(blk_target, target, &error_abort);
>  
> +    ctx = qemu_get_aio_context();
> +    aio_context_acquire(ctx);
> +
>      job = block_job_create("job0", &test_job_driver, NULL, src, 0, BLK_PERM_ALL,
>                             0, 0, NULL, NULL, &error_abort);
>      block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
> @@ -853,6 +857,8 @@ static void test_blockjob_common(enum drain_type drain_type)
>      ret = job_complete_sync(&job->job, &error_abort);
>      g_assert_cmpint(ret, ==, 0);
>  
> +    aio_context_release(ctx);
> +
>      blk_unref(blk_src);
>      blk_unref(blk_target);
>      bdrv_unref(src);
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
