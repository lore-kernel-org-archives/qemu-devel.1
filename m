Received: from eggs.gnu.org ([2001:4830:134:3::10]:39747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlN0-0000On-Qb
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlMz-0008Nz-Va
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:57:02 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-16-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb23348b-977c-db0c-1d45-1d4904247413@redhat.com>
Date: Tue, 27 Feb 2018 13:56:50 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-16-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 15/21] blockjobs: add prepare callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Some jobs upon finalization may need to perform some work that can
> still fail. If these jobs are part of a transaction, it's important
> that these callbacks fail the entire transaction.
> 
> We allow for a new callback in addition to commit/abort/clean that
> allows us the opportunity to have fairly late-breaking failures
> in the transactional process.
> 
> The expected flow is:
> 
> - All jobs in a transaction converge to the WAITING state
>    (added in a forthcoming commit)
> - All jobs prepare to call either commit/abort
> - If any job fails, is canceled, or fails preparation, all jobs
>    call their .abort callback.
> - All jobs enter the PENDING state, awaiting manual intervention
>    (also added in a forthcoming commit)
> - block-job-finalize is issued by the user/management layer
> - All jobs call their commit callbacks.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockjob.c                   | 34 +++++++++++++++++++++++++++++++---
>   include/block/blockjob_int.h | 10 ++++++++++
>   2 files changed, 41 insertions(+), 3 deletions(-)
> 

> @@ -467,17 +480,22 @@ static void block_job_cancel_async(BlockJob *job)
>       job->cancelled = true;
>   }
>   
> -static void block_job_txn_apply(BlockJobTxn *txn, void fn(BlockJob *))
> +static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *))
>   {
>       AioContext *ctx;
>       BlockJob *job, *next;
> +    int rc;
>   
>       QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
>           ctx = blk_get_aio_context(job->blk);
>           aio_context_acquire(ctx);
> -        fn(job);
> +        rc = fn(job);
>           aio_context_release(ctx);
> +        if (rc) {
> +            break;
> +        }

This short-circuits the application of the function to the rest of the 
group.  Is that ever going to be a problem?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
