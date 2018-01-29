Received: from eggs.gnu.org ([2001:4830:134:3::10]:58027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egCrk-0002F4-4u
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egCra-0006Ja-6T
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:05:08 -0500
Date: Mon, 29 Jan 2018 18:04:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129170442.GL6141@localhost.localdomain>
References: <20180127020515.27137-1-jsnow@redhat.com>
	<20180127020515.27137-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127020515.27137-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 02/14] blockjobs: Add status enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 27.01.2018 um 03:05 hat John Snow geschrieben:
> We're about to add several new states, and booleans are becoming
> unwieldly and difficult to reason about. To this end, add a new "status"
> field and add our existing states in a redundant manner alongside the
> bools they are replacing:
> 
> UNDEFINED: Placeholder, default state.
> CREATED:   replaces (paused && !busy)
> RUNNING:   replaces effectively (!paused && busy)
> PAUSED:    Nearly redundant with info->paused, which shows pause_count.
>            This reports the actual status of the job, which almost always
>            matches the paused request status. It differs in that it is
>            strictly only true when the job has actually gone dormant.
> READY:     replaces job->ready.
> 
> New state additions in coming commits will not be quite so redundant:
> 
> WAITING:   Waiting on Transaction. This job has finished all the work
>            it can until the transaction converges, fails, or is canceled.
>            This status does not feature for non-transactional jobs.
> PENDING:   Pending authorization from user. This job has finished all the
>            work it can until the job or transaction is finalized via
>            block_job_finalize. If this job is in a transaction, it has
>            already left the WAITING status.
> CONCLUDED: Job has ceased all operations and has a return code available
>            for query and may be dismissed via block_job_dismiss.
> Signed-off-by: John Snow <jsnow@redhat.com>

Empty line before S-o-b?

>  blockjob.c               | 10 ++++++++++
>  include/block/blockjob.h |  4 ++++
>  qapi/block-core.json     | 17 ++++++++++++++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 9850d70cb0..6eb783a354 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -321,6 +321,7 @@ void block_job_start(BlockJob *job)
>      job->pause_count--;
>      job->busy = true;
>      job->paused = false;
> +    job->status = BLOCK_JOB_STATUS_RUNNING;
>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
>  }
>  
> @@ -601,6 +602,10 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
>      info->speed     = job->speed;
>      info->io_status = job->iostatus;
>      info->ready     = job->ready;
> +    if (job->manual) {
> +        info->has_status = true;
> +        info->status = job->status;
> +    }

Why do we want to hide the status from clients that don't want to
complete the job manually? Isn't this conflating two orthogonal things?

>      return info;
>  }
>  
> @@ -704,6 +709,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>      job->pause_count   = 1;
>      job->refcnt        = 1;
>      job->manual        = manual;
> +    job->status        = BLOCK_JOB_STATUS_CREATED;
>      aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
>                     QEMU_CLOCK_REALTIME, SCALE_NS,
>                     block_job_sleep_timer_cb, job);
> @@ -808,9 +814,12 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
>      }
>  
>      if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
> +        BlockJobStatus status = job->status;
> +        job->status = BLOCK_JOB_STATUS_PAUSED;
>          job->paused = true;
>          block_job_do_yield(job, -1);
>          job->paused = false;
> +        job->status = status;
>      }
>  
>      if (job->driver->resume) {
> @@ -916,6 +925,7 @@ void block_job_iostatus_reset(BlockJob *job)
>  
>  void block_job_event_ready(BlockJob *job)
>  {
> +    job->status = BLOCK_JOB_STATUS_READY;
>      job->ready = true;
>  
>      if (block_job_is_internal(job)) {
> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index b94d0c9fa6..d8e7df7e6e 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -146,6 +146,10 @@ typedef struct BlockJob {
>       */
>      bool manual;
>  
> +    /* Current state, using 2.12+ state names
> +     */
> +    BlockJobStatus status;
> +
>      /** Non-NULL if this job is part of a transaction */
>      BlockJobTxn *txn;
>      QLIST_ENTRY(BlockJob) txn_list;
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8225308904..eac89754c1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -955,6 +955,18 @@
>  { 'enum': 'BlockJobType',
>    'data': ['commit', 'stream', 'mirror', 'backup'] }
>  
> +##
> +# @BlockJobStatus:
> +#
> +# Block Job State
> +#
> +#
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'BlockJobStatus',
> +  'data': ['undefined', 'created', 'running', 'paused', 'ready'] }

I assume these multiple empty lines are left there so you have space to
fill in the information from the commit message?

>  ##
>  # @BlockJobInfo:
>  #
> @@ -981,12 +993,15 @@
>  #
>  # @ready: true if the job may be completed (since 2.2)
>  #
> +# @status: Current job state/status (since 2.12)
> +#
>  # Since: 1.1
>  ##
>  { 'struct': 'BlockJobInfo',
>    'data': {'type': 'str', 'device': 'str', 'len': 'int',
>             'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
> -           'io-status': 'BlockDeviceIoStatus', 'ready': 'bool'} }
> +           'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
> +           '*status': 'BlockJobStatus' } }

If we don't actually have a reason to hide the status above, it can
become a non-opional field here.

Kevin
