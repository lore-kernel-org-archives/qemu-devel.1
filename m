Received: from eggs.gnu.org ([2001:4830:134:3::10]:54701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJj2Q-0005LX-9n
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJj2P-0008PZ-GT
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:47:14 -0500
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0b6d616-aa98-9269-a36c-33c6fcaa3dd4@redhat.com>
Date: Tue, 28 Nov 2017 10:46:59 -0600
MIME-Version: 1.0
In-Reply-To: <20171128154350.21504-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

On 11/28/2017 09:43 AM, Kevin Wolf wrote:
> If a coroutine can be reentered from multiple possible sources, we need
> to be careful in the case that two sources try to reenter it at the same
> time.
> 

> For this case, we'll cancel any pending aio_co_schedule() when the
> coroutine is actually entered. Reentering it once is enough for all
> cases explained above, and a requirement for part of them.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qemu/coroutine_int.h |  1 +

> +++ b/util/qemu-coroutine.c
> @@ -122,6 +122,23 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
>        */
>       smp_wmb();
>   
> +    /* Make sure that a coroutine that can alternatively reentered from two

s/reentered/be reentered/

> +     * different sources isn't reentered more than once when the first caller
> +     * uses aio_co_schedule() and the other one enters to coroutine directly.

s/enters to/enters the/

> +     * This is achieved by cancelling the pending aio_co_schedule().
> +     *
> +     * The other way round, if aio_co_schedule() would be called after this
> +     * point, this would be a problem, too, but in practice it doesn't happen

s/this //

> +     * because we're holding the AioContext lock here and aio_co_schedule()
> +     * callers must do the same. This means that the coroutine just needs to
> +     * prevent other callers from calling aio_co_schedule() before it yields
> +     * (e.g. block job coroutines by setting job->busy = true).

Is 'block job coroutines' the set of coroutines owned by 'block jobs', 
or is it the verb that we are blocking all 'job coroutines'?  I don't 
know if a wording tweak would help avoid ambiguity here.

> +     *
> +     * We still want to ensure that the second case doesn't happen, so reset
> +     * co->scheduled only after setting co->caller to make the above check
> +     * effective for the co_schedule_bh_cb() case. */
> +    atomic_set(&co->scheduled, NULL);
> +
>       ret = qemu_coroutine_switch(self, co, COROUTINE_ENTER);
>   
>       qemu_co_queue_run_restart(co);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
