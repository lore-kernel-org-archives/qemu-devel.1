Received: from eggs.gnu.org ([2001:4830:134:3::10]:34486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d88eO-00033H-HP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d88eN-0005mN-7i
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:10:16 -0400
Date: Tue, 9 May 2017 13:10:04 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170509171004.GC25411@localhost.localdomain>
References: <20170508141310.8674-1-pbonzini@redhat.com>
	<20170508141310.8674-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508141310.8674-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/11] blockjob: move iostatus reset inside
 block_job_user_resume
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

On Mon, May 08, 2017 at 04:13:05PM +0200, Paolo Bonzini wrote:
> Outside blockjob.c, the block_job_iostatus_reset function is used once
> in the monitor and once in BlockBackend.  When we introduce the block
> job mutex, block_job_iostatus_reset's client is going to be the block
> layer (for which blockjob.c will take the block job mutex) rather than
> the monitor (which will take the block job mutex by itself).
> 
> The monitor's call to block_job_iostatus_reset from the monitor comes
> just before the sole call to block_job_user_resume, so reset the
> iostatus directly from block_job_iostatus_reset.  This will avoid
> the need to introduce separate block_job_iostatus_reset and
> block_job_iostatus_reset_locked APIs.
> 
> After making this change, move the function together with the others
> that were moved in the previous patch.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockdev.c |  1 -
>  blockjob.c | 11 ++++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 64282065d8..cdec4ac82a 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3726,7 +3726,6 @@ void qmp_block_job_resume(const char *device, Error **errp)
>      }
>  
>      trace_qmp_block_job_resume(job);
> -    block_job_iostatus_reset(job);
>      block_job_user_resume(job);
>      aio_context_release(aio_context);
>  }
> diff --git a/blockjob.c b/blockjob.c
> index 41dc2fe9f1..7edf779adc 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -412,6 +412,7 @@ void block_job_user_resume(BlockJob *job)
>  {
>      if (job && job->user_paused && job->pause_count > 0) {
>          job->user_paused = false;
> +        block_job_iostatus_reset(job);
>          block_job_resume(job);
>      }
>  }
> @@ -427,11 +428,6 @@ void block_job_cancel(BlockJob *job)
>      }
>  }
>  
> -void block_job_iostatus_reset(BlockJob *job)
> -{
> -    job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
> -}
> -
>  static int block_job_finish_sync(BlockJob *job,
>                                   void (*finish)(BlockJob *, Error **errp),
>                                   Error **errp)
> @@ -767,6 +763,11 @@ void block_job_yield(BlockJob *job)
>      block_job_pause_point(job);
>  }
>  
> +void block_job_iostatus_reset(BlockJob *job)
> +{
> +    job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
> +}
> +
>  void block_job_event_ready(BlockJob *job)
>  {
>      job->ready = true;
> -- 
> 2.12.2
> 
>
Reviewed-by: Jeff Cody <jcody@redhat.com>
