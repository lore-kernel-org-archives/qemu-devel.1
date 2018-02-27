Received: from eggs.gnu.org ([2001:4830:134:3::10]:38896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlJC-0006aD-FH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlJB-0006ti-MX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:53:06 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-15-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24631f89-f682-bee5-2024-77d191a18e43@redhat.com>
Date: Tue, 27 Feb 2018 13:52:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-15-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Simply apply a function transaction-wide.
> A few more uses of this in forthcoming patches.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockjob.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 

> @@ -565,13 +577,7 @@ static void block_job_completed_txn_success(BlockJob *job)
>           }
>       }
>       /* We are the last completed job, commit the transaction. */
> -    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
> -        ctx = blk_get_aio_context(other_job->blk);
> -        aio_context_acquire(ctx);
> -        assert(other_job->ret == 0);

We lost this assertion.  Hopefully that doesn't matter in the long run.

> -        block_job_completed_single(other_job);
> -        aio_context_release(ctx);
> -    }
> +    block_job_txn_apply(txn, block_job_completed_single);
>   }
>   
>   /* Assumes the block_job_mutex is held */
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
