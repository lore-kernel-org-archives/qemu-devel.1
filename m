Received: from eggs.gnu.org ([2001:4830:134:3::10]:60837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVFDr-0001pw-Em
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVFDl-0002os-Ii
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:27:11 -0500
Date: Fri, 7 Dec 2018 13:26:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181207122647.GE5119@linux.fritz.box>
References: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] blk: postpone request execution on a
 context protected with "drained section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: keith.busch@intel.com, jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@virtuozzo.com, famz@redhat.com, vsementsov@virtuozzo.com

Am 05.12.2018 um 13:23 hat Denis Plotnikov geschrieben:
> At the time, the "drained section" doesn't protect Block Driver State
> from the requests appearing in the vCPU threads.
> This could lead to the data loss because of request coming to
> an unexpected BDS.
> 
> For example, when a request comes to ide controller from the guest,
> the controller creates a request coroutine and executes the coroutine
> in the vCPU thread. If another thread(iothread) has entered the
> "drained section" on a BDS with bdrv_drained_begin, which protects
> BDS' AioContext from external requests, and released the AioContext
> because of finishing some coroutine by the moment of the request
> appearing at the ide controller, the controller acquires the AioContext
> and executes its request without any respect to the entered
> "drained section" producing any kinds of data inconsistency.
> 
> The patch prevents this case by putting requests from external threads to
> the queue on AioContext while the context is protected for external requests
> and executes those requests later on the external requests protection removing.
> 
> Also, the patch marks requests generated in a vCPU thread as external ones
> to make use of the request postponing.
> 
> How to reproduce:
> 1. start vm with an ide disk and a linux guest
> 2. in the guest run: dd if=... of=... bs=4K count=100000 oflag=direct
> 3. (qemu) drive_mirror "disk-name"
> 4. wait until block job can receive block_job_complete
> 5. (qemu) block_job_complete "disk-name"
> 6. blk_aio_p[read|write]v may appear in vCPU context (here is the race)
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

This is getting closer, but I'd like to see two more major changes:

> diff --git a/include/block/aio.h b/include/block/aio.h
> index 0ca25dfec6..8512bda44e 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -19,6 +19,7 @@
>  #include "qemu/event_notifier.h"
>  #include "qemu/thread.h"
>  #include "qemu/timer.h"
> +#include "qemu/coroutine.h"
>  
>  typedef struct BlockAIOCB BlockAIOCB;
>  typedef void BlockCompletionFunc(void *opaque, int ret);
> @@ -130,6 +131,11 @@ struct AioContext {
>      QEMUTimerListGroup tlg;
>  
>      int external_disable_cnt;
> +    /* Queue to store the requests coming when the context is disabled for
> +     * external requests.
> +     * Don't use a separate lock for protection relying the context lock
> +     */
> +    CoQueue postponed_reqs;

Why involve the AioContext at all? This could all be kept at the
BlockBackend level without extending the layering violation that
aio_disable_external() is.

BlockBackends get notified when their root node is drained, so hooking
things up there should be as easy, if not even easier than in
AioContext.

>      /* Number of AioHandlers without .io_poll() */
>      int poll_disable_cnt;
> @@ -483,6 +489,15 @@ static inline void aio_timer_init(AioContext *ctx,
>   */
>  int64_t aio_compute_timeout(AioContext *ctx);
>  
> +/**
> + * aio_co_enter:
> + * @ctx: the context to run the coroutine
> + * @co: the coroutine to run
> + *
> + * Enter a coroutine in the specified AioContext.
> + */
> +void aio_co_enter(AioContext *ctx, struct Coroutine *co);
> +
>  /**
>   * aio_disable_external:
>   * @ctx: the aio context
> @@ -491,9 +506,17 @@ int64_t aio_compute_timeout(AioContext *ctx);
>   */
>  static inline void aio_disable_external(AioContext *ctx)
>  {
> +    aio_context_acquire(ctx);
>      atomic_inc(&ctx->external_disable_cnt);
> +    aio_context_release(ctx);
>  }

This acquire/release pair looks rather useless?

> +static void run_postponed_co(void *opaque)
> +{
> +    AioContext *ctx = (AioContext *) opaque;
> +
> +    qemu_co_queue_restart_all(&ctx->postponed_reqs);
> +}
>  /**
>   * aio_enable_external:
>   * @ctx: the aio context
> @@ -504,12 +527,17 @@ static inline void aio_enable_external(AioContext *ctx)
>  {
>      int old;
>  
> +    aio_context_acquire(ctx);
>      old = atomic_fetch_dec(&ctx->external_disable_cnt);
>      assert(old > 0);
>      if (old == 1) {
> +        Coroutine *co = qemu_coroutine_create(run_postponed_co, ctx);
> +        aio_co_enter(ctx, co);
> +
>          /* Kick event loop so it re-arms file descriptors */
>          aio_notify(ctx);
>      }
> +    aio_context_release(ctx);
>  }
>  
>  /**
> @@ -564,15 +592,6 @@ void aio_co_schedule(AioContext *ctx, struct Coroutine *co);
>   */
>  void aio_co_wake(struct Coroutine *co);
>  
> -/**
> - * aio_co_enter:
> - * @ctx: the context to run the coroutine
> - * @co: the coroutine to run
> - *
> - * Enter a coroutine in the specified AioContext.
> - */
> -void aio_co_enter(AioContext *ctx, struct Coroutine *co);
> -
>  /**
>   * Return the AioContext whose event loop runs in the current thread.
>   *
> diff --git a/include/block/block.h b/include/block/block.h
> index 7f5453b45b..0685a73975 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -83,8 +83,14 @@ typedef enum {
>       */
>      BDRV_REQ_SERIALISING        = 0x80,
>  
> +    /*
> +     * marks requests comming from external sources,
> +     * e.g block requests from dma running in the vCPU thread
> +     */
> +    BDRV_REQ_EXTERNAL   = 0x100,

I don't like this one because BlockBackends should be used _only_ from
external sources.

I know that this isn't quite true today and there are still block jobs
calling BlockBackend internally while handling a BDS request, but I hope
with Vladimir's backup patches going it, this can go away.

So I suggest that for the time being, we invert the flag and have a
BDRV_REQ_INTERNAL instead, which is only used for BlockBackend requests,
hopefully doesn't have to be used in many places and which can go away
eventually.

>      /* Mask of valid flags */
> -    BDRV_REQ_MASK               = 0xff,
> +    BDRV_REQ_MASK               = 0xfff,
>  } BdrvRequestFlags;
>  
>  typedef struct BlockSizes {

Kevin
