Received: from eggs.gnu.org ([2001:4830:134:3::10]:47543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eK2RY-0004ig-AL
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eK2RS-0007U4-5M
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:30:28 -0500
Date: Wed, 29 Nov 2017 08:30:10 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171129133010.GL25110@localhost.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] blockjob: introduce block_job_do_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

On Wed, Nov 29, 2017 at 11:25:12AM +0100, Paolo Bonzini wrote:
> Hide the clearing of job->busy in a single function, and set it
> in block_job_enter.  This lets block_job_do_yield verify that
> qemu_coroutine_enter is not used while job->busy = false.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  blockjob.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index db9e4fc89a..4d22b7d2fb 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -729,6 +729,15 @@ static bool block_job_should_pause(BlockJob *job)
>      return job->pause_count > 0;
>  }
>  
> +static void block_job_do_yield(BlockJob *job)
> +{
> +    job->busy = false;
> +    qemu_coroutine_yield();
> +
> +    /* Set by block_job_enter before re-entering the coroutine.  */
> +    assert(job->busy);
> +}
> +
>  void coroutine_fn block_job_pause_point(BlockJob *job)
>  {
>      assert(job && block_job_started(job));
> @@ -746,9 +755,7 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
>  
>      if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
>          job->paused = true;
> -        job->busy = false;
> -        qemu_coroutine_yield(); /* wait for block_job_resume() */
> -        job->busy = true;
> +        block_job_do_yield(job);
>          job->paused = false;
>      }
>  
> @@ -778,9 +785,12 @@ void block_job_enter(BlockJob *job)
>          return;
>      }
>  
> -    if (!job->busy) {
> -        bdrv_coroutine_enter(blk_bs(job->blk), job->co);
> +    if (job->busy) {
> +        return;
>      }
> +
> +    job->busy = true;
> +    aio_co_wake(job->co);
>  }
>  
>  bool block_job_is_cancelled(BlockJob *job)
> @@ -819,11 +829,9 @@ void block_job_yield(BlockJob *job)
>          return;
>      }
>  
> -    job->busy = false;
>      if (!block_job_should_pause(job)) {
> -        qemu_coroutine_yield();
> +        block_job_do_yield(job);
>      }
> -    job->busy = true;
>  
>      block_job_pause_point(job);
>  }
> -- 
> 2.14.3
> 
> 
