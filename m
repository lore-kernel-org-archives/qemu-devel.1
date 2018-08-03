Received: from eggs.gnu.org ([2001:4830:134:3::10]:59632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fldZE-0005TJ-8x
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fldZD-0007CP-6J
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:08:44 -0400
References: <20180803154955.25251-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48beaf6f-55a0-7ae4-d020-a0a6072181a4@redhat.com>
Date: Fri, 3 Aug 2018 19:08:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180803154955.25251-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] async: Fix aio_notify_accept
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 03/08/2018 17:49, Fam Zheng wrote:
>  void aio_notify_accept(AioContext *ctx)
>  {
> -    if (atomic_xchg(&ctx->notified, false)) {
> +    /* If ctx->notify_me >=3D 2, another aio_poll() is waiting which m=
ay need the
> +     * ctx->notifier event to wake up, so don't already clear it just =
because "we" are
> +     * done iterating. */
> +    if (atomic_read(&ctx->notify_me) < 2
> +        && atomic_xchg(&ctx->notified, false)) {
>          event_notifier_test_and_clear(&ctx->notifier);
>      }
>  }

Ok, it's somewhat reassuring to see from the BZ that the aio_poll in the
main thread (in bdrv_set_aio_context) is non-blocking, and that it isn't
about nested aio_poll.

Then it's not possible to have a busy wait there, because sooner or
later the bottom halves will be exhausted and aio_wait will return false
(no progress).

I'm convinced that the idea in your patch---skipping
aio_notify_accept---is correct, it's the ctx->notify_me test that I
cannot understand.  I'm not saying it's wrong, but it's tricky.  So we
need to improve the comments, the commit message, the way we achieve the
fix, or all three.

As to the comments and commit message: the BZ is a very good source of
information.  The comment on the main thread stealing the aio_notify was
very clear.

As to how to fix it, first of all, we should be clear on the invariants.
 It would be nice to assert that, if not
in_aio_context_home_thread(ctx), blocking must be false.  Two concurrent
blocking aio_polls will steal aio_notify from one another, so
intuitively that assertion should be true, and using AIO_WAIT_WHILE
takes care of it.

Second, if blocking is false, do we need to call aio_notify_accept at
all?  If not, and if we combine this with the assertion above, only the
I/O thread will call aio_notify_accept, and the main loop will never
steal the notification.  So that should fix the bug.

Thanks,

Paolo
