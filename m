Received: from eggs.gnu.org ([2001:4830:134:3::10]:42475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er4ev-0004iZ-DX
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er4eu-0007R5-GD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:32:49 -0500
Date: Wed, 28 Feb 2018 17:32:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228163222.GH4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-15-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-15-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 14/21] blockjobs: add block_job_txn_apply
 function
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
> Simply apply a function transaction-wide.
> A few more uses of this in forthcoming patches.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockjob.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 431ce9c220..8f02c03880 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -467,6 +467,19 @@ static void block_job_cancel_async(BlockJob *job)
>      job->cancelled = true;
>  }
>  
> +static void block_job_txn_apply(BlockJobTxn *txn, void fn(BlockJob *))
> +{
> +    AioContext *ctx;
> +    BlockJob *job, *next;
> +
> +    QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
> +        ctx = blk_get_aio_context(job->blk);
> +        aio_context_acquire(ctx);
> +        fn(job);
> +        aio_context_release(ctx);
> +    }
> +}
> +
>  static void block_job_do_dismiss(BlockJob *job)
>  {
>      assert(job);
> @@ -552,9 +565,8 @@ static void block_job_completed_txn_abort(BlockJob *job)
>  
>  static void block_job_completed_txn_success(BlockJob *job)
>  {
> -    AioContext *ctx;
>      BlockJobTxn *txn = job->txn;
> -    BlockJob *other_job, *next;
> +    BlockJob *other_job;
>      /*
>       * Successful completion, see if there are other running jobs in this
>       * txn.
> @@ -565,13 +577,7 @@ static void block_job_completed_txn_success(BlockJob *job)
>          }
>      }
>      /* We are the last completed job, commit the transaction. */
> -    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
> -        ctx = blk_get_aio_context(other_job->blk);
> -        aio_context_acquire(ctx);
> -        assert(other_job->ret == 0);

Can we just move the assertion up a few lines (after checking
other_job->completed) instead of removing it?

> -        block_job_completed_single(other_job);
> -        aio_context_release(ctx);
> -    }
> +    block_job_txn_apply(txn, block_job_completed_single);
>  }

Kevin
