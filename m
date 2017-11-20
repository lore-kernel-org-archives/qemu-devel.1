Received: from eggs.gnu.org ([2001:4830:134:3::10]:56686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGuaf-0002Ew-KF
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGuae-0004P6-Pf
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:30:57 -0500
References: <cover.1511145863.git.jcody@redhat.com>
	<0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06d8393e-8422-0576-ad68-f14e49eed1a6@redhat.com>
Date: Mon, 20 Nov 2017 23:30:39 +0100
MIME-Version: 1.0
In-Reply-To: <0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] coroutines: abort if we try to enter a
 still-sleeping coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com

On 20/11/2017 03:46, Jeff Cody wrote:
> Once a coroutine is "sleeping", the timer callback will either enter the
> coroutine, or schedule it for the next AioContext if using iothreads.
> 
> It is illegal to enter that coroutine while waiting for this timer
> event and subsequent callback.  This patch will catch such an attempt,
> and abort QEMU with an error.
> 
> Like with the previous patch, we cannot rely solely on the co->caller
> check for recursive entry.  The prematurely entered coroutine may exit
> with COROUTINE_TERMINATE before the timer expires, making co->caller no
> longer valid.
> 
> We can clear co->sleeping in in co_sleep_cb(), because any doubly entry
> attempt after point should be caught by either the co->scheduled or
> co->caller checks.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  include/qemu/coroutine_int.h | 2 ++
>  util/qemu-coroutine-sleep.c  | 3 +++
>  util/qemu-coroutine.c        | 5 +++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> index 931cdc9..b071217 100644
> --- a/include/qemu/coroutine_int.h
> +++ b/include/qemu/coroutine_int.h
> @@ -56,6 +56,8 @@ struct Coroutine {
>  
>      int scheduled;
>  
> +    int sleeping;

Is this a different "state" (in Stefan's parlance) than scheduled?  In
practice both means that someone may call qemu_(aio_)coroutine_enter
concurrently, so you'd better not do it yourself.

Paolo

> +
>      QSIMPLEQ_ENTRY(Coroutine) co_queue_next;
>      QSLIST_ENTRY(Coroutine) co_scheduled_next;
>  };
> diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
> index 9c56550..11ae95a 100644
> --- a/util/qemu-coroutine-sleep.c
> +++ b/util/qemu-coroutine-sleep.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/coroutine.h"
> +#include "qemu/coroutine_int.h"
>  #include "qemu/timer.h"
>  #include "block/aio.h"
>  
> @@ -25,6 +26,7 @@ static void co_sleep_cb(void *opaque)
>  {
>      CoSleepCB *sleep_cb = opaque;
>  
> +    sleep_cb->co->sleeping = 0;
>      aio_co_wake(sleep_cb->co);
>  }
>  
> @@ -34,6 +36,7 @@ void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
>      CoSleepCB sleep_cb = {
>          .co = qemu_coroutine_self(),
>      };
> +    sleep_cb.co->sleeping = 1;
>      sleep_cb.ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sleep_cb);
>      timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
>      qemu_coroutine_yield();
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 2edab63..1d9f93d 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -118,6 +118,11 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
>          abort();
>      }
>  
> +    if (co->sleeping == 1) {
> +        fprintf(stderr, "Cannot enter a co-routine that is still sleeping\n");
> +        abort();
> +    }
> +
>      if (co->caller) {
>          fprintf(stderr, "Co-routine re-entered recursively\n");
>          abort();
> 
