Received: from eggs.gnu.org ([209.51.188.92]:43639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2FlR-0002iC-I5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2FlQ-0004dx-Me
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:42:17 -0500
Date: Fri, 8 Mar 2019 14:41:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190308134159.GD31583@localhost.localdomain>
References: <20190307185401.41639-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307185401.41639-1-slp@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] mirror: Confirm we're quiesced only if
 the job is paused or cancelled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, eblake@redhat.com

Am 07.03.2019 um 19:54 hat Sergio Lopez geschrieben:
> While child_job_drained_begin() calls to job_pause(), the job doesn't
> actually transition between states until it runs again and reaches a
> pause point. This means bdrv_drained_begin() may return with some jobs
> using the node still having 'busy == true'.
> 
> As a consequence, block_job_detach_aio_context() may get into a
> deadlock, waiting for the job to be actually paused, while the coroutine
> servicing the job is yielding and doesn't get the opportunity to get
> scheduled again. This situation can be reproduced by issuing a
> 'block-commit' immediately followed by a 'device_del'.
> 
> To ensure bdrv_drained_begin() only returns when the jobs have been
> paused, we change mirror_drained_poll() to only confirm it's quiesced
> when job->paused == true and there aren't any in-flight requests, except
> if we reached that point by a drained section initiated by the
> mirror/commit job itself.
> 
> The other block jobs shouldn't need any changes, as the default
> drained_poll() behavior is to only confirm it's quiesced if the job is
> not busy or completed.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> 
> ---
> v2
>   - Fix typo (thanks to Eric Blake)
> ---
>  block/mirror.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 726d3c27fb..1a1fb174b6 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -80,6 +80,7 @@ typedef struct MirrorBlockJob {
>      bool initial_zeroing_ongoing;
>      int in_active_write_counter;
>      bool prepared;
> +    bool in_drain;
>  } MirrorBlockJob;
>  
>  typedef struct MirrorBDSOpaque {
> @@ -679,9 +680,11 @@ static int mirror_exit_common(Job *job)
>  
>          /* The mirror job has no requests in flight any more, but we need to
>           * drain potential other users of the BDS before changing the graph. */
> +        s->in_drain = true;
>          bdrv_drained_begin(target_bs);
>          bdrv_replace_node(to_replace, target_bs, &local_err);
>          bdrv_drained_end(target_bs);
> +        s->in_drain = false;
>          if (local_err) {
>              error_report_err(local_err);
>              ret = -EPERM;

I think this hunk is wrong because this is nested: s->in_drain is
already true before this block, so we're setting it to false too early.
We can either drop is completely or just assert(s->in_drain).

Other than this, the patch looks good to me.

Kevin
