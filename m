Received: from eggs.gnu.org ([2001:4830:134:3::10]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDNp-0002z1-Bb
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDNo-0000st-2V
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:38:17 -0500
Date: Mon, 29 Jan 2018 18:38:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129173802.GN6141@localhost.localdomain>
References: <20180127020515.27137-1-jsnow@redhat.com>
	<20180127020515.27137-6-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127020515.27137-6-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 05/14] blockjobs: add block_job_dismiss
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
> For jobs that have reached their terminal state, prior to having their
> last reference put down (meaning jobs that have completed successfully,
> unsuccessfully, or have been canceled), allow the user to dismiss the
> job's lingering status report via block-job-dismiss.
> 
> This gives management APIs the chance to conclusively determine if a job
> failed or succeeded, even if the event broadcast was missed.
> 
> Note that jobs do not yet linger in any such state, they are freed
> immediately upon reaching this previously-unnamed state. such a state is
> added immediately in the next commit.
> 
> Valid objects:
> Concluded: (added in a future commit); dismisses the concluded job.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/trace-events       |  1 +
>  blockdev.c               | 14 ++++++++++++++
>  blockjob.c               | 30 ++++++++++++++++++++++++++++++
>  include/block/blockjob.h |  9 +++++++++
>  qapi/block-core.json     | 19 +++++++++++++++++++
>  5 files changed, 73 insertions(+)
> 
> diff --git a/block/trace-events b/block/trace-events
> index 11c8d5f590..8f61566770 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -46,6 +46,7 @@ qmp_block_job_cancel(void *job) "job %p"
>  qmp_block_job_pause(void *job) "job %p"
>  qmp_block_job_resume(void *job) "job %p"
>  qmp_block_job_complete(void *job) "job %p"
> +qmp_block_job_dismiss(void *job) "job %p"
>  qmp_block_stream(void *bs, void *job) "bs %p job %p"
>  
>  # block/file-win32.c
> diff --git a/blockdev.c b/blockdev.c
> index 2c0773bba7..5e8edff322 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3849,6 +3849,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
>      aio_context_release(aio_context);
>  }
>  
> +void qmp_block_job_dismiss(const char *id, Error **errp)
> +{
> +    AioContext *aio_context;
> +    BlockJob *job = find_block_job(id, &aio_context, errp);
> +
> +    if (!job) {
> +        return;
> +    }
> +
> +    trace_qmp_block_job_dismiss(job);
> +    block_job_dismiss(&job, errp);
> +    aio_context_release(aio_context);
> +}
> +
>  void qmp_change_backing_file(const char *device,
>                               const char *image_node_name,
>                               const char *backing_file,
> diff --git a/blockjob.c b/blockjob.c
> index ea216aca5e..5531f5c2ab 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -58,6 +58,7 @@ enum BlockJobVerb {
>      BLOCK_JOB_VERB_RESUME,
>      BLOCK_JOB_VERB_SET_SPEED,
>      BLOCK_JOB_VERB_COMPLETE,
> +    BLOCK_JOB_VERB_DISMISS,
>      BLOCK_JOB_VERB__MAX
>  };
>  
> @@ -68,6 +69,7 @@ bool BlockJobVerb[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
>      [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0},
>      [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1},
>      [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1},
> +    [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0},

This makes it very obvious that the patches should probably be
reordered.

>  };
>  
>  static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
> @@ -426,6 +428,13 @@ static void block_job_cancel_async(BlockJob *job)
>      job->cancelled = true;
>  }
>  
> +static void block_job_do_dismiss(BlockJob *job)
> +{
> +    assert(job && job->manual == true);
> +    block_job_state_transition(job, BLOCK_JOB_STATUS_UNDEFINED);

I don't think you made that an allowed transition from anywhere?

> +    block_job_unref(job);
> +}
> +
>  static int block_job_finish_sync(BlockJob *job,
>                                   void (*finish)(BlockJob *, Error **errp),
>                                   Error **errp)
> @@ -455,6 +464,9 @@ static int block_job_finish_sync(BlockJob *job,
>          aio_poll(qemu_get_aio_context(), true);
>      }
>      ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
> +    if (job->manual) {
> +        block_job_do_dismiss(job);
> +    }
>      block_job_unref(job);
>      return ret;
>  }
> @@ -570,6 +582,24 @@ void block_job_complete(BlockJob *job, Error **errp)
>      job->driver->complete(job, errp);
>  }
>  
> +void block_job_dismiss(BlockJob **jobptr, Error **errp)
> +{
> +    BlockJob *job = *jobptr;
> +    /* similarly to _complete, this is QMP-interface only. */
> +    assert(job->id);
> +    if (!job->manual) {
> +        error_setg(errp, "The active block job '%s' was not started with "
> +                   "\'manual\': true, and so cannot be dismissed as it will "
> +                   "clean up after itself automatically", job->id);
> +        return;
> +    }

If you check instead that the job is in the right state to be dismissed
(CONCLUDED), the job->manual check wouldn't be needed any more because
the user can never catch an automatically completed job in CONCLUDED.

> +    error_setg(errp, "unimplemented");

This should hopefully go away when you reorder the patches.

> +    block_job_do_dismiss(job);
> +    *jobptr = NULL;
> +}

Kevin
