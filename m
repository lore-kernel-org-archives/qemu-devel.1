Received: from eggs.gnu.org ([2001:4830:134:3::10]:42301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwfFP-0003om-PK
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 21:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwfFM-0006UW-LW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 21:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cwfFM-0006UN-CE
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 21:33:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BC5361D15
	for <qemu-devel@nongnu.org>; Sat,  8 Apr 2017 01:32:59 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-11-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <04b67e67-6b27-e5d0-5fbd-38ec98d57b44@redhat.com>
Date: Fri, 7 Apr 2017 21:32:58 -0400
MIME-Version: 1.0
In-Reply-To: <20170323173928.14439-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] blockjob: use deferred_to_main_loop
 to indicate the coroutine has ended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
> All block jobs are using block_job_defer_to_main_loop as the final
> step just before the coroutine terminates.  At this point,
> block_job_enter should do nothing, but currently it restarts
> the freed coroutine.
> 
> Now, the job->co states should probably be changed to an enum
> (e.g. BEFORE_START, STARTED, YIELDED, COMPLETED) subsuming

Yes, I'd love to formalize the FSM for jobs.

> block_job_started, job->deferred_to_main_loop and job->busy.
> For now, this patch eliminates the problematic reenter by
> removing the reset of job->deferred_to_main_loop (which served
> no purpose, as far as I could see) and checking the flag in
> block_job_enter.

Not sure -- the original commit 794f01414 makes it seem like it should
stay so that the correct AIO context can be acquired. Probably a race as
jobs don't often stay long once they've deferred to the main loop, but I
think the reset is harmless as you say.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 10 ++++++++--
>  include/block/blockjob_int.h |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 3fa2885..2d80dae 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -750,7 +750,14 @@ void block_job_resume_all(void)
>  
>  void block_job_enter(BlockJob *job)
>  {
> -    if (job->co && !job->busy) {
> +    if (!block_job_started(job)) {
> +        return;
> +    }
> +    if (job->deferred_to_main_loop) {
> +        return;
> +    }
> +
> +    if (!job->busy) {
>          qemu_coroutine_enter(job->co);
>      }
>  }
> @@ -874,7 +881,6 @@ static void block_job_defer_to_main_loop_bh(void *opaque)
>          aio_context_acquire(aio_context);
>      }
>  
> -    data->job->deferred_to_main_loop = false;
>      data->fn(data->job, data->opaque);
>  
>      if (aio_context != data->aio_context) {
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 97ffc43..4d287ba 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -227,7 +227,8 @@ typedef void BlockJobDeferToMainLoopFn(BlockJob *job, void *opaque);
>   * @fn: The function to run in the main loop
>   * @opaque: The opaque value that is passed to @fn
>   *
> - * Execute a given function in the main loop with the BlockDriverState
> + * This function must be called by the main job coroutine just before it
> + * returns.  @fn is executed in the main loop with the BlockDriverState
>   * AioContext acquired.  Block jobs must call bdrv_unref(), bdrv_close(), and
>   * anything that uses bdrv_drain_all() in the main loop.
>   *
> 

Reviewed-by: John Snow <jsnow@redhat.com>
