Received: from eggs.gnu.org ([2001:4830:134:3::10]:57656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwA9k-00075D-HU
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwA9j-0005wL-Ak
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:21:08 -0400
Date: Thu, 6 Apr 2017 18:20:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406162053.GL4341@noname.redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406142527.25835-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] coroutine: Explicitly specify
 AioContext when creating coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 06.04.2017 um 16:25 hat Fam Zheng geschrieben:
> Coroutine in block layer should always be waken up in bs->aio_context
> rather than the "current" context where it is entered. They differ when
> the main loop is doing QMP tasks.

This whole mechanism is complex stuff that I haven't quite caught up on
yet, but this change means that we probably have some code that runs
under one AioContext or the other depending on whether a CoMutex had to
yield. Waking it up in its original AioContext definitely seemed more
straightforward.

> Race conditions happen without this patch, because the wrong context is
> acquired in co_schedule_bh_cb, while the entered coroutine works on a
> different one.

If the code in co_schedule_bh_cb() assumes that coroutines can never
move between AioContexts, then probably this assumption is what really
needs to be fixed.

For example, another case where this happens is that block jobs follow
their nodes if the AioContext changes and even implement
.attached_aio_context callbacks when they need to drag additional nodes
into the new context. With your change, the job coroutine would remember
the old coroutine and move back to the old context in some cases! I
don't want to be the one to debug this kind of problems...

If we really went this way, we'd need at least a way to change the
AioContext of a coroutine after the fact, and be sure that we call it
everywhere where it's needed (it's this last part that I'm highly
doubtful about for 2.9).

In fact, I think even attempting this is insanity and we need to teach
the infrastructure to cope with coroutines that move between
AioContexts. If it's really just about acquiring the wrong context,
shouldn't then using co->ctx instead of ctx solve the problem?

> Make the block layer explicitly specify a desired context for each created
> coroutine. For the rest, always use qemu_get_aio_context().
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -63,7 +63,8 @@ typedef void coroutine_fn CoroutineEntry(void *opaque);
>   * Use qemu_coroutine_enter() to actually transfer control to the coroutine.
>   * The opaque argument is passed as the argument to the entry point.
>   */
> -Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);
> +Coroutine *qemu_coroutine_create(AioContext *ctx,
> +                                 CoroutineEntry *entry, void *opaque);

The new parameter could use some documentation, it's not even obvious
why a coroutine should have an AioContext.

> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -115,7 +118,6 @@ void qemu_coroutine_enter(Coroutine *co)
>      }
>  
>      co->caller = self;
> -    co->ctx = qemu_get_current_aio_context();
>  
>      /* Store co->ctx before anything that stores co.  Matches
>       * barrier in aio_co_wake and qemu_co_mutex_wake.
       */
       smp_wmb();

The comment suggests that the barrier can go away if you don't set
co->ctx any more.

Kevin
