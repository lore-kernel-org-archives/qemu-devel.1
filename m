Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Ai7-0002BJ-JE
	for qemu-devel@nongnu.org; Thu, 04 May 2017 02:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Ai6-0002a7-JZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 02:57:59 -0400
Date: Thu, 4 May 2017 14:57:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504065748.GC19184@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/17] throttle-groups: protect throttled
 requests with a CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/block-backend.c          |  1 +
>  block/throttle-groups.c        | 11 +++++++++--
>  include/sysemu/block-backend.h |  7 ++-----
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 915ccc5..a37d74d 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -163,6 +163,7 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
>      blk->shared_perm = shared_perm;
>      blk_set_enable_write_cache(blk, true);
>  
> +    qemu_co_mutex_init(&blk->public.reqs_lock);
>      qemu_co_queue_init(&blk->public.throttled_reqs[0]);
>      qemu_co_queue_init(&blk->public.throttled_reqs[1]);
>  
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index d66bf62..695d28d 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -268,8 +268,13 @@ static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
>  static bool throttle_group_co_restart_queue(BlockBackend *blk, bool is_write)
>  {
>      BlockBackendPublic *blkp = blk_get_public(blk);
> +    bool ret;
>  
> -    return qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
> +    qemu_co_mutex_lock(&blkp->reqs_lock);
> +    ret = qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
> +    qemu_co_mutex_unlock(&blkp->reqs_lock);
> +
> +    return ret;
>  }
>  
>  /* Look for the next pending I/O request and schedule it.
> @@ -338,7 +343,9 @@ void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
>      if (must_wait || blkp->pending_reqs[is_write]) {
>          blkp->pending_reqs[is_write]++;
>          qemu_mutex_unlock(&tg->lock);
> -        qemu_co_queue_wait(&blkp->throttled_reqs[is_write], NULL);
> +        qemu_co_mutex_lock(&blkp->reqs_lock);
> +        qemu_co_queue_wait(&blkp->throttled_reqs[is_write], &blkp->reqs_lock);
> +        qemu_co_mutex_unlock(&blkp->reqs_lock);
>          qemu_mutex_lock(&tg->lock);
>          blkp->pending_reqs[is_write]--;
>      }
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> index 87a43b0..e9529fb 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -72,11 +72,8 @@ typedef struct BlockDevOps {
>   * fields that must be public. This is in particular for QLIST_ENTRY() and
>   * friends so that BlockBackends can be kept in lists outside block-backend.c */
>  typedef struct BlockBackendPublic {
> -    /* I/O throttling has its own locking, but also some fields are
> -     * protected by the AioContext lock.
> -     */
> -
> -    /* Protected by AioContext lock.  */
> +    /* reqs_lock protects the CoQueues for throttled requests.  */
> +    CoMutex      reqs_lock;

Bikeshedding: will it be more readable if it's called throttled_reqs_lock or
throttled_lock?

Fam

>      CoQueue      throttled_reqs[2];
>  
>      /* Nonzero if the I/O limits are currently being ignored; generally
> -- 
> 2.9.3
> 
> 
> 
