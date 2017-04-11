Received: from eggs.gnu.org ([2001:4830:134:3::10]:50490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxs61-0005yE-Gt
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxs60-00020O-GP
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:28:21 -0400
Date: Tue, 11 Apr 2017 11:28:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411092807.GG4516@noname.str.redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 05/10] async: Introduce
 aio_co_enter and aio_co_enter_if_inactive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.04.2017 um 17:05 hat Fam Zheng geschrieben:
> They start the coroutine on the specified context.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/block/aio.h | 18 ++++++++++++++++++
>  util/async.c        | 14 +++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 677b6ff..b0a6bb3 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -511,6 +511,24 @@ void aio_co_schedule(AioContext *ctx, struct Coroutine *co);
>  void aio_co_wake(struct Coroutine *co);
>  
>  /**
> + * aio_co_enter:
> + * @ctx: the context to run the coroutine
> + * @co: the coroutine to run
> + *
> + * Enter a coroutine in the specified AioContext.
> + */
> +void aio_co_enter(AioContext *ctx, struct Coroutine *co);
> +
> +/**
> + * aio_co_enter_if_inactive:
> + * @ctx: the context to run the coroutine
> + * @co: the coroutine to run
> + *
> + * Enter a coroutine in the specified AioContext, if it's not already entered.
> + */
> +void aio_co_enter_if_inactive(AioContext *ctx, struct Coroutine *co);
> +
> +/**
>   * Return the AioContext whose event loop runs in the current thread.
>   *
>   * If called from an IOThread this will be the IOThread's AioContext.  If
> diff --git a/util/async.c b/util/async.c
> index 663e297..507671a 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -453,6 +453,11 @@ void aio_co_wake(struct Coroutine *co)
>      smp_read_barrier_depends();
>      ctx = atomic_read(&co->ctx);
>  
> +    aio_co_enter(ctx, co);
> +}
> +
> +void aio_co_enter(AioContext *ctx, struct Coroutine *co)
> +{
>      if (ctx != qemu_get_current_aio_context()) {
>          aio_co_schedule(ctx, co);
>          return;
> @@ -464,11 +469,18 @@ void aio_co_wake(struct Coroutine *co)
>          QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
>      } else {
>          aio_context_acquire(ctx);
> -        qemu_coroutine_enter(co);
> +        qemu_aio_coroutine_enter(ctx, co);
>          aio_context_release(ctx);
>      }
>  }
>  
> +void aio_co_enter_if_inactive(AioContext *ctx, struct Coroutine *co)
> +{
> +    if (!qemu_coroutine_entered(co)) {
> +        aio_co_enter(ctx, co);
> +    }
> +}

Is this a useful function, though?

I think the only interesting case is the first qemu_coroutine_enter()
after a coroutine is created, here we may want it to run in a different
AioContext than the caller. However, once this has happened, it is
already running in the right AioContext and we can use the normal
functions without giving an explicit AioContext (except in cases where
we wouldn't reenter from a callback of that AioContext, but do such
cases even exist?)

So I expect that some patches down the series, we get a patch that
converts more than is actually necessary. Let's see.

Kevin
