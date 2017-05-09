Received: from eggs.gnu.org ([2001:4830:134:3::10]:33126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d88at-0000Uy-B7
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d88ar-0004iC-CF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:06:39 -0400
Date: Tue, 9 May 2017 13:06:25 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170509170625.GB25411@localhost.localdomain>
References: <20170508141310.8674-1-pbonzini@redhat.com>
	<20170508141310.8674-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508141310.8674-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

On Mon, May 08, 2017 at 04:13:04PM +0200, Paolo Bonzini wrote:
> We have two different headers for block job operations, blockjob.h
> and blockjob_int.h.  The former contains APIs called by the monitor,
> the latter contains APIs called by the block job drivers and the
> block layer itself.
> 
> Keep the two APIs separate in the blockjob.c file too.  This will
> be useful when transitioning away from the AioContext lock, because
> there will be locking policies for the two categories, too---the
> monitor will have to call new block_job_lock/unlock APIs, while blockjob
> APIs will take care of this for the users.
> 

Would it make sense to split this out into separate files, rather than
delineating it by placement in a single .c file?


> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 390 ++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 205 insertions(+), 185 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 85ad610cae..41dc2fe9f1 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -55,6 +55,21 @@ struct BlockJobTxn {
>  
>  static QLIST_HEAD(, BlockJob) block_jobs = QLIST_HEAD_INITIALIZER(block_jobs);
>  
> +/*
> + * The block job API is composed of two categories of functions.
> + *
> + * The first includes functions used by the monitor.  The monitor is
> + * peculiar in that it accesses the block job list with block_job_get, and
> + * therefore needs consistency across block_job_get and the actual operation
> + * (e.g. block_job_set_speed).  The consistency is achieved with
> + * aio_context_acquire/release.  These functions are declared in blockjob.h.
> + *
> + * The second includes functions used by the block job drivers and sometimes
> + * by the core block layer.  These do not care about locking, because the
> + * whole coroutine runs under the AioContext lock, and are declared in
> + * blockjob_int.h.
> + */
> +
>  BlockJob *block_job_next(BlockJob *job)
>  {
>      if (!job) {
> @@ -216,90 +231,6 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
>      return 0;
>  }
>  
> -void *block_job_create(const char *job_id, const BlockJobDriver *driver,
> -                       BlockDriverState *bs, uint64_t perm,
> -                       uint64_t shared_perm, int64_t speed, int flags,
> -                       BlockCompletionFunc *cb, void *opaque, Error **errp)
> -{
> -    BlockBackend *blk;
> -    BlockJob *job;
> -    int ret;
> -
> -    if (bs->job) {
> -        error_setg(errp, QERR_DEVICE_IN_USE, bdrv_get_device_name(bs));
> -        return NULL;
> -    }
> -
> -    if (job_id == NULL && !(flags & BLOCK_JOB_INTERNAL)) {
> -        job_id = bdrv_get_device_name(bs);
> -        if (!*job_id) {
> -            error_setg(errp, "An explicit job ID is required for this node");
> -            return NULL;
> -        }
> -    }
> -
> -    if (job_id) {
> -        if (flags & BLOCK_JOB_INTERNAL) {
> -            error_setg(errp, "Cannot specify job ID for internal block job");
> -            return NULL;
> -        }
> -
> -        if (!id_wellformed(job_id)) {
> -            error_setg(errp, "Invalid job ID '%s'", job_id);
> -            return NULL;
> -        }
> -
> -        if (block_job_get(job_id)) {
> -            error_setg(errp, "Job ID '%s' already in use", job_id);
> -            return NULL;
> -        }
> -    }
> -
> -    blk = blk_new(perm, shared_perm);
> -    ret = blk_insert_bs(blk, bs, errp);
> -    if (ret < 0) {
> -        blk_unref(blk);
> -        return NULL;
> -    }
> -
> -    job = g_malloc0(driver->instance_size);
> -    job->driver        = driver;
> -    job->id            = g_strdup(job_id);
> -    job->blk           = blk;
> -    job->cb            = cb;
> -    job->opaque        = opaque;
> -    job->busy          = false;
> -    job->paused        = true;
> -    job->pause_count   = 1;
> -    job->refcnt        = 1;
> -
> -    error_setg(&job->blocker, "block device is in use by block job: %s",
> -               BlockJobType_lookup[driver->job_type]);
> -    block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
> -    bs->job = job;
> -
> -    blk_set_dev_ops(blk, &block_job_dev_ops, job);
> -    bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
> -
> -    QLIST_INSERT_HEAD(&block_jobs, job, job_list);
> -
> -    blk_add_aio_context_notifier(blk, block_job_attached_aio_context,
> -                                 block_job_detach_aio_context, job);
> -
> -    /* Only set speed when necessary to avoid NotSupported error */
> -    if (speed != 0) {
> -        Error *local_err = NULL;
> -
> -        block_job_set_speed(job, speed, &local_err);
> -        if (local_err) {
> -            block_job_unref(job);
> -            error_propagate(errp, local_err);
> -            return NULL;
> -        }
> -    }
> -    return job;
> -}
> -
>  bool block_job_is_internal(BlockJob *job)
>  {
>      return (job->id == NULL);
> @@ -334,11 +265,6 @@ void block_job_start(BlockJob *job)
>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
>  }
>  
> -void block_job_early_fail(BlockJob *job)
> -{
> -    block_job_unref(job);
> -}
> -
>  static void block_job_completed_single(BlockJob *job)
>  {
>      if (!job->ret) {
> @@ -440,21 +366,6 @@ static void block_job_completed_txn_success(BlockJob *job)
>      }
>  }
>  
> -void block_job_completed(BlockJob *job, int ret)
> -{
> -    assert(blk_bs(job->blk)->job == job);
> -    assert(!job->completed);
> -    job->completed = true;
> -    job->ret = ret;
> -    if (!job->txn) {
> -        block_job_completed_single(job);
> -    } else if (ret < 0 || block_job_is_cancelled(job)) {
> -        block_job_completed_txn_abort(job);
> -    } else {
> -        block_job_completed_txn_success(job);
> -    }
> -}
> -
>  void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>  {
>      Error *local_err = NULL;
> @@ -492,44 +403,11 @@ void block_job_user_pause(BlockJob *job)
>      block_job_pause(job);
>  }
>  
> -static bool block_job_should_pause(BlockJob *job)
> -{
> -    return job->pause_count > 0;
> -}
> -
>  bool block_job_user_paused(BlockJob *job)
>  {
>      return job->user_paused;
>  }
>  
> -void coroutine_fn block_job_pause_point(BlockJob *job)
> -{
> -    assert(job && block_job_started(job));
> -
> -    if (!block_job_should_pause(job)) {
> -        return;
> -    }
> -    if (block_job_is_cancelled(job)) {
> -        return;
> -    }
> -
> -    if (job->driver->pause) {
> -        job->driver->pause(job);
> -    }
> -
> -    if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
> -        job->paused = true;
> -        job->busy = false;
> -        qemu_coroutine_yield(); /* wait for block_job_resume() */
> -        job->busy = true;
> -        job->paused = false;
> -    }
> -
> -    if (job->driver->resume) {
> -        job->driver->resume(job);
> -    }
> -}
> -
>  void block_job_user_resume(BlockJob *job)
>  {
>      if (job && job->user_paused && job->pause_count > 0) {
> @@ -538,13 +416,6 @@ void block_job_user_resume(BlockJob *job)
>      }
>  }
>  
> -void block_job_enter(BlockJob *job)
> -{
> -    if (job->co && !job->busy) {
> -        bdrv_coroutine_enter(blk_bs(job->blk), job->co);
> -    }
> -}
> -
>  void block_job_cancel(BlockJob *job)
>  {
>      if (block_job_started(job)) {
> @@ -556,11 +427,6 @@ void block_job_cancel(BlockJob *job)
>      }
>  }
>  
> -bool block_job_is_cancelled(BlockJob *job)
> -{
> -    return job->cancelled;
> -}
> -
>  void block_job_iostatus_reset(BlockJob *job)
>  {
>      job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
> @@ -628,42 +494,6 @@ int block_job_complete_sync(BlockJob *job, Error **errp)
>      return block_job_finish_sync(job, &block_job_complete, errp);
>  }
>  
> -void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
> -{
> -    assert(job->busy);
> -
> -    /* Check cancellation *before* setting busy = false, too!  */
> -    if (block_job_is_cancelled(job)) {
> -        return;
> -    }
> -
> -    job->busy = false;
> -    if (!block_job_should_pause(job)) {
> -        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
> -    }
> -    job->busy = true;
> -
> -    block_job_pause_point(job);
> -}
> -
> -void block_job_yield(BlockJob *job)
> -{
> -    assert(job->busy);
> -
> -    /* Check cancellation *before* setting busy = false, too!  */
> -    if (block_job_is_cancelled(job)) {
> -        return;
> -    }
> -
> -    job->busy = false;
> -    if (!block_job_should_pause(job)) {
> -        qemu_coroutine_yield();
> -    }
> -    job->busy = true;
> -
> -    block_job_pause_point(job);
> -}
> -
>  BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
>  {
>      BlockJobInfo *info;
> @@ -723,6 +553,95 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
>                                          &error_abort);
>  }
>  
> +/*
> + * API for block job drivers and the block layer.  These functions are
> + * declared in blockjob_int.h.
> + */
> +
> +void *block_job_create(const char *job_id, const BlockJobDriver *driver,
> +                       BlockDriverState *bs, uint64_t perm,
> +                       uint64_t shared_perm, int64_t speed, int flags,
> +                       BlockCompletionFunc *cb, void *opaque, Error **errp)
> +{
> +    BlockBackend *blk;
> +    BlockJob *job;
> +    int ret;
> +
> +    if (bs->job) {
> +        error_setg(errp, QERR_DEVICE_IN_USE, bdrv_get_device_name(bs));
> +        return NULL;
> +    }
> +
> +    if (job_id == NULL && !(flags & BLOCK_JOB_INTERNAL)) {
> +        job_id = bdrv_get_device_name(bs);
> +        if (!*job_id) {
> +            error_setg(errp, "An explicit job ID is required for this node");
> +            return NULL;
> +        }
> +    }
> +
> +    if (job_id) {
> +        if (flags & BLOCK_JOB_INTERNAL) {
> +            error_setg(errp, "Cannot specify job ID for internal block job");
> +            return NULL;
> +        }
> +
> +        if (!id_wellformed(job_id)) {
> +            error_setg(errp, "Invalid job ID '%s'", job_id);
> +            return NULL;
> +        }
> +
> +        if (block_job_get(job_id)) {
> +            error_setg(errp, "Job ID '%s' already in use", job_id);
> +            return NULL;
> +        }
> +    }
> +
> +    blk = blk_new(perm, shared_perm);
> +    ret = blk_insert_bs(blk, bs, errp);
> +    if (ret < 0) {
> +        blk_unref(blk);
> +        return NULL;
> +    }
> +
> +    job = g_malloc0(driver->instance_size);
> +    job->driver        = driver;
> +    job->id            = g_strdup(job_id);
> +    job->blk           = blk;
> +    job->cb            = cb;
> +    job->opaque        = opaque;
> +    job->busy          = false;
> +    job->paused        = true;
> +    job->pause_count   = 1;
> +    job->refcnt        = 1;
> +
> +    error_setg(&job->blocker, "block device is in use by block job: %s",
> +               BlockJobType_lookup[driver->job_type]);
> +    block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
> +    bs->job = job;
> +
> +    blk_set_dev_ops(blk, &block_job_dev_ops, job);
> +    bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
> +
> +    QLIST_INSERT_HEAD(&block_jobs, job, job_list);
> +
> +    blk_add_aio_context_notifier(blk, block_job_attached_aio_context,
> +                                 block_job_detach_aio_context, job);
> +
> +    /* Only set speed when necessary to avoid NotSupported error */
> +    if (speed != 0) {
> +        Error *local_err = NULL;
> +
> +        block_job_set_speed(job, speed, &local_err);
> +        if (local_err) {
> +            block_job_unref(job);
> +            error_propagate(errp, local_err);
> +            return NULL;
> +        }
> +    }
> +    return job;
> +}
> +
>  void block_job_pause_all(void)
>  {
>      BlockJob *job = NULL;
> @@ -735,6 +654,59 @@ void block_job_pause_all(void)
>      }
>  }
>  
> +void block_job_early_fail(BlockJob *job)
> +{
> +    block_job_unref(job);
> +}
> +
> +void block_job_completed(BlockJob *job, int ret)
> +{
> +    assert(blk_bs(job->blk)->job == job);
> +    assert(!job->completed);
> +    job->completed = true;
> +    job->ret = ret;
> +    if (!job->txn) {
> +        block_job_completed_single(job);
> +    } else if (ret < 0 || block_job_is_cancelled(job)) {
> +        block_job_completed_txn_abort(job);
> +    } else {
> +        block_job_completed_txn_success(job);
> +    }
> +}
> +
> +static bool block_job_should_pause(BlockJob *job)
> +{
> +    return job->pause_count > 0;
> +}
> +
> +void coroutine_fn block_job_pause_point(BlockJob *job)
> +{
> +    assert(job && block_job_started(job));
> +
> +    if (!block_job_should_pause(job)) {
> +        return;
> +    }
> +    if (block_job_is_cancelled(job)) {
> +        return;
> +    }
> +
> +    if (job->driver->pause) {
> +        job->driver->pause(job);
> +    }
> +
> +    if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
> +        job->paused = true;
> +        job->busy = false;
> +        qemu_coroutine_yield(); /* wait for block_job_resume() */
> +        job->busy = true;
> +        job->paused = false;
> +    }
> +
> +    if (job->driver->resume) {
> +        job->driver->resume(job);
> +    }
> +}
> +
>  void block_job_resume_all(void)
>  {
>      BlockJob *job = NULL;
> @@ -747,6 +719,54 @@ void block_job_resume_all(void)
>      }
>  }
>  
> +void block_job_enter(BlockJob *job)
> +{
> +    if (job->co && !job->busy) {
> +        bdrv_coroutine_enter(blk_bs(job->blk), job->co);
> +    }
> +}
> +
> +bool block_job_is_cancelled(BlockJob *job)
> +{
> +    return job->cancelled;
> +}
> +
> +void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
> +{
> +    assert(job->busy);
> +
> +    /* Check cancellation *before* setting busy = false, too!  */
> +    if (block_job_is_cancelled(job)) {
> +        return;
> +    }
> +
> +    job->busy = false;
> +    if (!block_job_should_pause(job)) {
> +        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
> +    }
> +    job->busy = true;
> +
> +    block_job_pause_point(job);
> +}
> +
> +void block_job_yield(BlockJob *job)
> +{
> +    assert(job->busy);
> +
> +    /* Check cancellation *before* setting busy = false, too!  */
> +    if (block_job_is_cancelled(job)) {
> +        return;
> +    }
> +
> +    job->busy = false;
> +    if (!block_job_should_pause(job)) {
> +        qemu_coroutine_yield();
> +    }
> +    job->busy = true;
> +
> +    block_job_pause_point(job);
> +}
> +
>  void block_job_event_ready(BlockJob *job)
>  {
>      job->ready = true;
> -- 
> 2.12.2
> 
> 
