Received: from eggs.gnu.org ([2001:4830:134:3::10]:57740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d2nh3-0004bI-F1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d2ngz-0005Ei-Hu
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d2ngz-0005E5-7g
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:46:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 284B23D95F
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 23:46:52 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-9-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <080b1b18-1173-3200-c655-5a760830f238@redhat.com>
Date: Mon, 24 Apr 2017 19:46:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170419144219.20371-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] blockjob: group BlockJob transaction
 functions together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org



On 04/19/2017 10:42 AM, Paolo Bonzini wrote:
> Yet another pure code movement patch, preparing for the next change.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>         v1->v2: split out of block_job_completed_txn_abort patch [John]
> 
>  blockjob.c | 128 ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 1756153..5d70d25 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -91,6 +91,39 @@ BlockJob *block_job_get(const char *id)
>      return NULL;
>  }
>  
> +BlockJobTxn *block_job_txn_new(void)
> +{
> +    BlockJobTxn *txn = g_new0(BlockJobTxn, 1);
> +    QLIST_INIT(&txn->jobs);
> +    txn->refcnt = 1;
> +    return txn;
> +}
> +
> +static void block_job_txn_ref(BlockJobTxn *txn)
> +{
> +    txn->refcnt++;
> +}
> +
> +void block_job_txn_unref(BlockJobTxn *txn)
> +{
> +    if (txn && --txn->refcnt == 0) {
> +        g_free(txn);
> +    }
> +}
> +
> +void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
> +{
> +    if (!txn) {
> +        return;
> +    }
> +
> +    assert(!job->txn);
> +    job->txn = txn;
> +
> +    QLIST_INSERT_HEAD(&txn->jobs, job, txn_list);
> +    block_job_txn_ref(txn);
> +}
> +
>  static void block_job_pause(BlockJob *job)
>  {
>      job->pause_count++;
> @@ -317,6 +350,37 @@ static void block_job_cancel_async(BlockJob *job)
>      job->cancelled = true;
>  }
>  
> +static int block_job_finish_sync(BlockJob *job,
> +                                 void (*finish)(BlockJob *, Error **errp),
> +                                 Error **errp)
> +{
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    assert(blk_bs(job->blk)->job == job);
> +
> +    block_job_ref(job);
> +
> +    finish(job, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        block_job_unref(job);
> +        return -EBUSY;
> +    }
> +    /* block_job_drain calls block_job_enter, and it should be enough to
> +     * induce progress until the job completes or moves to the main thread.
> +    */
> +    while (!job->deferred_to_main_loop && !job->completed) {
> +        block_job_drain(job);
> +    }
> +    while (!job->completed) {
> +        aio_poll(qemu_get_aio_context(), true);
> +    }
> +    ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
> +    block_job_unref(job);
> +    return ret;
> +}
> +
>  static void block_job_completed_txn_abort(BlockJob *job)
>  {
>      AioContext *ctx;
> @@ -440,37 +504,6 @@ void block_job_cancel(BlockJob *job)
>      }
>  }
>  
> -static int block_job_finish_sync(BlockJob *job,
> -                                 void (*finish)(BlockJob *, Error **errp),
> -                                 Error **errp)
> -{
> -    Error *local_err = NULL;
> -    int ret;
> -
> -    assert(blk_bs(job->blk)->job == job);
> -
> -    block_job_ref(job);
> -
> -    finish(job, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        block_job_unref(job);
> -        return -EBUSY;
> -    }
> -    /* block_job_drain calls block_job_enter, and it should be enough to
> -     * induce progress until the job completes or moves to the main thread.
> -    */
> -    while (!job->deferred_to_main_loop && !job->completed) {
> -        block_job_drain(job);
> -    }
> -    while (!job->completed) {
> -        aio_poll(qemu_get_aio_context(), true);
> -    }
> -    ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
> -    block_job_unref(job);
> -    return ret;
> -}
> -
>  /* A wrapper around block_job_cancel() taking an Error ** parameter so it may be
>   * used with block_job_finish_sync() without the need for (rather nasty)
>   * function pointer casts there. */
> @@ -883,36 +916,3 @@ void block_job_defer_to_main_loop(BlockJob *job,
>      aio_bh_schedule_oneshot(qemu_get_aio_context(),
>                              block_job_defer_to_main_loop_bh, data);
>  }
> -
> -BlockJobTxn *block_job_txn_new(void)
> -{
> -    BlockJobTxn *txn = g_new0(BlockJobTxn, 1);
> -    QLIST_INIT(&txn->jobs);
> -    txn->refcnt = 1;
> -    return txn;
> -}
> -
> -static void block_job_txn_ref(BlockJobTxn *txn)
> -{
> -    txn->refcnt++;
> -}
> -
> -void block_job_txn_unref(BlockJobTxn *txn)
> -{
> -    if (txn && --txn->refcnt == 0) {
> -        g_free(txn);
> -    }
> -}
> -
> -void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
> -{
> -    if (!txn) {
> -        return;
> -    }
> -
> -    assert(!job->txn);
> -    job->txn = txn;
> -
> -    QLIST_INSERT_HEAD(&txn->jobs, job, txn_list);
> -    block_job_txn_ref(txn);
> -}
> 
