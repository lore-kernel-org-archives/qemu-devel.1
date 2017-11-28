Received: from eggs.gnu.org ([2001:4830:134:3::10]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJiWl-0004pW-9e
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJiWk-0003SN-Br
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:14:31 -0500
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-4-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bd2921d-64c6-724c-0d80-b43e33f41817@redhat.com>
Date: Tue, 28 Nov 2017 17:14:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171128154350.21504-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
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
Cc: mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On 28/11/2017 16:43, Kevin Wolf wrote:
> +    /* Make sure that a coroutine that can alternatively reentered from two
> +     * different sources isn't reentered more than once when the first caller
> +     * uses aio_co_schedule() and the other one enters to coroutine directly.
> +     * This is achieved by cancelling the pending aio_co_schedule().
> +     *
> +     * The other way round, if aio_co_schedule() would be called after this
> +     * point, this would be a problem, too, but in practice it doesn't happen
> +     * because we're holding the AioContext lock here and aio_co_schedule()
> +     * callers must do the same.

No, this is not true.  aio_co_schedule is thread-safe.

> This means that the coroutine just needs to
> +     * prevent other callers from calling aio_co_schedule() before it yields
> +     * (e.g. block job coroutines by setting job->busy = true).
> +     *
> +     * We still want to ensure that the second case doesn't happen, so reset
> +     * co->scheduled only after setting co->caller to make the above check
> +     * effective for the co_schedule_bh_cb() case. */
> +    atomic_set(&co->scheduled, NULL);

This doesn't work.  The coroutine is still in the list, and if someone
calls aio_co_schedule again now, any coroutines linked from "co" via
co_scheduled_next are lost.

(Also, the AioContext lock is by design not protecting any state in
AioContext itself; the AioContext lock is only protecting things that
run in an AioContext but do not have their own lock).

Paolo

> +
>      ret = qemu_coroutine_switch(self, co, COROUTINE_ENTER);
>  
>      qemu_co_queue_run_restart(co);
> 
