Received: from eggs.gnu.org ([2001:4830:134:3::10]:44917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er6Gv-0005FK-Nx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er6Gu-0006db-9U
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:16:09 -0500
Date: Wed, 28 Feb 2018 19:15:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228181553.GL4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-19-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-19-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 18/21] blockjobs: add block-job-finalize
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

Am 24.02.2018 um 00:51 hat John Snow geschrieben:
> Instead of automatically transitioning from PENDING to CONCLUDED, gate
> the .prepare() and .commit() phases behind an explicit acknowledgement
> provided by the QMP monitor if manual completion mode has been requested.
> 
> This allows us to perform graph changes in prepare and/or commit so that
> graph changes do not occur autonomously without knowledge of the
> controlling management layer.
> 
> Transactions that have reached the "PENDING" state together can all be
> moved to invoke their finalization methods by issuing block_job_finalize
> to any one job in the transaction.
> 
> Jobs in a transaction with mixed job->manual settings will remain stuck
> in the "WAITING" state until block_job_finalize is authored on the job(s)
> that have reached the "PENDING" state.

Why? Removing this inconsistency would make the code slightly simpler.

Is it because you want to avoid that the user picks an automatic job for
completing the mixed transaction?

> These jobs are not allowed to progress because other jobs in the
> transaction may still fail during their preparation phase during
> finalization, so these jobs must remain in the WAITING phase until
> success is guaranteed. These jobs will then automatically dismiss
> themselves, but jobs that had the manual property set will remain
> at CONCLUDED as normal.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/trace-events       |  1 +
>  blockdev.c               | 14 ++++++++++
>  blockjob.c               | 69 +++++++++++++++++++++++++++++++++++++-----------
>  include/block/blockjob.h | 17 ++++++++++++
>  qapi/block-core.json     | 23 +++++++++++++++-
>  5 files changed, 108 insertions(+), 16 deletions(-)
> 
> diff --git a/block/trace-events b/block/trace-events
> index 5e531e0310..a81b66ff36 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -51,6 +51,7 @@ qmp_block_job_cancel(void *job) "job %p"
>  qmp_block_job_pause(void *job) "job %p"
>  qmp_block_job_resume(void *job) "job %p"
>  qmp_block_job_complete(void *job) "job %p"
> +qmp_block_job_finalize(void *job) "job %p"
>  qmp_block_job_dismiss(void *job) "job %p"
>  qmp_block_stream(void *bs, void *job) "bs %p job %p"
>  
> diff --git a/blockdev.c b/blockdev.c
> index 3180130782..05fd421cdc 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3852,6 +3852,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
>      aio_context_release(aio_context);
>  }
>  
> +void qmp_block_job_finalize(const char *id, Error **errp)
> +{
> +    AioContext *aio_context;
> +    BlockJob *job = find_block_job(id, &aio_context, errp);
> +
> +    if (!job) {
> +        return;
> +    }
> +
> +    trace_qmp_block_job_finalize(job);
> +    block_job_finalize(job, errp);
> +    aio_context_release(aio_context);
> +}
> +
>  void qmp_block_job_dismiss(const char *id, Error **errp)
>  {
>      AioContext *aio_context;
> diff --git a/blockjob.c b/blockjob.c
> index 23b4b99fd4..f9e8a64261 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -65,14 +65,15 @@ bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
>      [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
>      [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
>      [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
> +    [BLOCK_JOB_VERB_FINALIZE]             = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
>      [BLOCK_JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
>  };
>  
> -static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
> +static bool block_job_state_transition(BlockJob *job, BlockJobStatus s1)
>  {
>      BlockJobStatus s0 = job->status;
>      if (s0 == s1) {
> -        return;
> +        return false;
>      }
>      assert(s1 >= 0 && s1 <= BLOCK_JOB_STATUS__MAX);
>      trace_block_job_state_transition(job, job->ret, BlockJobSTT[s0][s1] ?
> @@ -83,6 +84,7 @@ static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
>                                                        s1));
>      assert(BlockJobSTT[s0][s1]);
>      job->status = s1;
> +    return true;
>  }
>  
>  static int block_job_apply_verb(BlockJob *job, BlockJobVerb bv, Error **errp)
> @@ -432,7 +434,7 @@ static void block_job_clean(BlockJob *job)
>      }
>  }
>  
> -static int block_job_completed_single(BlockJob *job)
> +static int block_job_finalize_single(BlockJob *job)
>  {
>      assert(job->completed);
>  
> @@ -581,18 +583,44 @@ static void block_job_completed_txn_abort(BlockJob *job)
>              assert(other_job->cancelled);
>              block_job_finish_sync(other_job, NULL, NULL);
>          }
> -        block_job_completed_single(other_job);
> +        block_job_finalize_single(other_job);
>          aio_context_release(ctx);
>      }
>  
>      block_job_txn_unref(txn);
>  }
>  
> +static int block_job_is_manual(BlockJob *job)
> +{
> +    return job->manual;
> +}
> +
> +static void block_job_do_finalize(BlockJob *job)
> +{
> +    int rc;
> +    assert(job && job->txn);
> +
> +    /* For jobs set !job->manual, transition to pending synchronously now */
> +    block_job_txn_apply(job->txn, block_job_event_pending, false);
> +
> +    /* prepare the transaction to complete */
> +    rc = block_job_txn_apply(job->txn, block_job_prepare, true);
> +    if (rc) {
> +        block_job_completed_txn_abort(job);
> +    } else {
> +        block_job_txn_apply(job->txn, block_job_finalize_single, true);
> +    }
> +}
> +
> +static int block_job_pending_conditional(BlockJob *job)
> +{
> +    return job->manual ? block_job_event_pending(job) : 0;
> +}

As I said above, I'd get rid of this function altogether, but if not,
can we have something like this:

    if (job->manual) {
        ret = block_job_event_pending()
        assert(ret == 0);
    }
    return 0;

Because if block_job_event_pending() ever started returning errors, the
abort-on-error semantics of block_job_txn_apply() would break this
function.

>  static void block_job_completed_txn_success(BlockJob *job)
>  {
>      BlockJobTxn *txn = job->txn;
>      BlockJob *other_job;
> -    int rc = 0;
>  
>      block_job_state_transition(job, BLOCK_JOB_STATUS_WAITING);
>  
> @@ -606,16 +634,15 @@ static void block_job_completed_txn_success(BlockJob *job)
>          }
>      }
>  
> -    /* Jobs may require some prep-work to complete without failure */
> -    rc = block_job_txn_apply(txn, block_job_prepare, true);
> -    if (rc) {
> -        block_job_completed_txn_abort(job);
> -        return;
> -    }
> +    /* For jobs with (job->manual), transition to the PENDING state.
> +     * jobs with !job->manual are left WAITING (on their pending comrades). */
> +    block_job_txn_apply(txn, block_job_pending_conditional, false);
>  
> -    /* We are the last completed job, commit the transaction. */
> -    block_job_txn_apply(txn, block_job_event_pending, false);
> -    block_job_txn_apply(txn, block_job_completed_single, true);
> +    /* Transactions with any manual jobs must await finalization.
> +     * do_finalize will handle lingering WAITING->PENDING transitions. */
> +    if (!block_job_txn_apply(txn, block_job_is_manual, false)) {
> +        block_job_do_finalize(job);
> +    }
>  }
>  
>  /* Assumes the block_job_mutex is held */
> @@ -667,6 +694,15 @@ void block_job_complete(BlockJob *job, Error **errp)
>      job->driver->complete(job, errp);
>  }
>  
> +void block_job_finalize(BlockJob *job, Error **errp)
> +{
> +    assert(job && job->id && job->txn);
> +    if (block_job_apply_verb(job, BLOCK_JOB_VERB_FINALIZE, errp)) {
> +        return;
> +    }
> +    block_job_do_finalize(job);
> +}
> +
>  void block_job_dismiss(BlockJob **jobptr, Error **errp)
>  {
>      BlockJob *job = *jobptr;
> @@ -826,7 +862,10 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
>  
>  static int block_job_event_pending(BlockJob *job)
>  {
> -    block_job_state_transition(job, BLOCK_JOB_STATUS_PENDING);
> +    /* If we're already pending, don't re-announce */
> +    if (!block_job_state_transition(job, BLOCK_JOB_STATUS_PENDING)) {
> +        return 0;
> +    }

Without the exception for manual jobs, you wouldn't get double
transitions and could avoid adding a return value to
block_job_state_transition(), where we were considering dropping the
s0 == s1 case anyway.

Kevin
