Received: from eggs.gnu.org ([2001:4830:134:3::10]:43014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiSN-0001U6-Ou
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiSK-0001Kj-FG
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:09:59 -0500
Date: Tue, 28 Nov 2017 11:09:40 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171128160940.GD25110@localhost.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128154350.21504-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/4] coroutine: Cancel
 aio_co_schedule() on direct entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Tue, Nov 28, 2017 at 04:43:49PM +0100, Kevin Wolf wrote:
> If a coroutine can be reentered from multiple possible sources, we need
> to be careful in the case that two sources try to reenter it at the same
> time.
> 
> There are two different cases where this can happen:
> 
> 1. A coroutine spawns multiple asynchronous jobs and waits for all of
>    them to complete. In this case, multiple reentries are expected and
>    the coroutine is probably looping around a yield, so entering it
>    twice is generally fine (but entering it just once after all jobs
>    have completed would be enough, too).
> 
>    Exception: When the loop condition becomes false and the first
>    reenter already leaves the loop, we must not do a second reenter.
> 
> 2. A coroutine yields and provides multiple alternative ways to be
>    reentered. In this case, we must always only process the first
>    reenter.
> 
> Direct entry is not a problem. It requires that the AioContext locks for
> the coroutine context are held, which means that the coroutine has
> enough time to set some state that simply prevents the second caller
> from reentering the coroutine, too.
> 
> Things get more interesting with aio_co_schedule() because the coroutine
> may be scheduled before it is (directly) entered from a second place.
> Then changing some state inside the coroutine doesn't help because it is
> already scheduled and the state won't be checked again.
> 
> For this case, we'll cancel any pending aio_co_schedule() when the
> coroutine is actually entered. Reentering it once is enough for all
> cases explained above, and a requirement for part of them.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/coroutine_int.h |  1 +
>  util/async.c                 | 15 ++++++++++++++-
>  util/qemu-coroutine.c        | 17 +++++++++++++++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> index cb98892bba..73fc35e54b 100644
> --- a/include/qemu/coroutine_int.h
> +++ b/include/qemu/coroutine_int.h
> @@ -40,6 +40,7 @@ struct Coroutine {
>      CoroutineEntry *entry;
>      void *entry_arg;
>      Coroutine *caller;
> +    AioContext *scheduled;
>  
>      /* Only used when the coroutine has terminated.  */
>      QSLIST_ENTRY(Coroutine) pool_next;
> diff --git a/util/async.c b/util/async.c
> index 0e1bd8780a..dc249e9404 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -372,6 +372,7 @@ static bool event_notifier_poll(void *opaque)
>  static void co_schedule_bh_cb(void *opaque)
>  {
>      AioContext *ctx = opaque;
> +    AioContext *scheduled_ctx;
>      QSLIST_HEAD(, Coroutine) straight, reversed;
>  
>      QSLIST_MOVE_ATOMIC(&reversed, &ctx->scheduled_coroutines);
> @@ -388,7 +389,16 @@ static void co_schedule_bh_cb(void *opaque)
>          QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
>          trace_aio_co_schedule_bh_cb(ctx, co);
>          aio_context_acquire(ctx);
> -        qemu_coroutine_enter(co);
> +        scheduled_ctx = atomic_mb_read(&co->scheduled);
> +        if (scheduled_ctx == ctx) {
> +            qemu_coroutine_enter(co);
> +        } else {
> +            /* This must be a cancelled aio_co_schedule() because the coroutine
> +             * was already entered before this BH had a chance to run. If a
> +             * coroutine is scheduled for two different AioContexts, something
> +             * is very wrong. */
> +            assert(scheduled_ctx == NULL);
> +        }
>          aio_context_release(ctx);
>      }
>  }
> @@ -438,6 +448,9 @@ fail:
>  void aio_co_schedule(AioContext *ctx, Coroutine *co)
>  {
>      trace_aio_co_schedule(ctx, co);
> +

Do we want to assert(!co->scheduled || co->scheduled == ctx) here?


> +    /* Set co->scheduled before the coroutine becomes visible in the list */
> +    atomic_mb_set(&co->scheduled, ctx);


>      QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
>                                co, co_scheduled_next);
>      qemu_bh_schedule(ctx->co_schedule_bh);
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index d6095c1d5a..c515b3cb4a 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -122,6 +122,23 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
>       */
>      smp_wmb();
>  
> +    /* Make sure that a coroutine that can alternatively reentered from two
> +     * different sources isn't reentered more than once when the first caller
> +     * uses aio_co_schedule() and the other one enters to coroutine directly.
> +     * This is achieved by cancelling the pending aio_co_schedule().
> +     *
> +     * The other way round, if aio_co_schedule() would be called after this
> +     * point, this would be a problem, too, but in practice it doesn't happen
> +     * because we're holding the AioContext lock here and aio_co_schedule()
> +     * callers must do the same. This means that the coroutine just needs to
> +     * prevent other callers from calling aio_co_schedule() before it yields
> +     * (e.g. block job coroutines by setting job->busy = true).
> +     *
> +     * We still want to ensure that the second case doesn't happen, so reset
> +     * co->scheduled only after setting co->caller to make the above check
> +     * effective for the co_schedule_bh_cb() case. */

Nice comment

> +    atomic_set(&co->scheduled, NULL);
> +
>      ret = qemu_coroutine_switch(self, co, COROUTINE_ENTER);
>  
>      qemu_co_queue_run_restart(co);
> -- 
> 2.13.6
> 
