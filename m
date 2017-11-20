Received: from eggs.gnu.org ([2001:4830:134:3::10]:40163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGvBM-0004NU-5E
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 18:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGvBK-000685-No
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 18:08:52 -0500
Date: Mon, 20 Nov 2017 18:08:37 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171120230837.GI5399@localhost.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
	<06d8393e-8422-0576-ad68-f14e49eed1a6@redhat.com>
	<20171120223536.GC32161@localhost.localdomain>
	<82e388ce-cbbf-7e59-6433-6e109e426512@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e388ce-cbbf-7e59-6433-6e109e426512@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com

On Mon, Nov 20, 2017 at 11:47:09PM +0100, Paolo Bonzini wrote:
> On 20/11/2017 23:35, Jeff Cody wrote:
> >> Is this a different "state" (in Stefan's parlance) than scheduled?  In
> >> practice both means that someone may call qemu_(aio_)coroutine_enter
> >> concurrently, so you'd better not do it yourself.
> >>
> > It is slightly different; it is from sleeping with a timer via
> > co_aio_sleep_ns and waking via co_sleep_cb.  Whereas the 'co->scheduled' is
> > specifically from being scheduled for a specific AioContext, via
> > aio_co_schedule().
> 
> Right; however, that would only make a difference if we allowed
> canceling a co_aio_sleep_ns.  Since we don't want that, they have the
> same transitions.
> 
> > In practice, 'co->schedule' and 'co->sleeping' certainly rhyme, at the very
> > least.
> > 
> > But having them separate will put the abort closer to where the problem lies,
> > so it should make debugging a bit easier if we hit it.
> 
> What do you mean by closer?  It would print a slightly more informative
> message, but the message is in qemu_aio_coroutine_for both cases.
> 

Sorry, sloppy wording; I meant what you said above, that the error message
is more informative, so by tracking down where co->sleeping is set the
developer is closer to where the problem lies.

> In fact, unifying co->scheduled and co->sleeping means that you can
> easily abort when co_aio_sleep_ns is called on a scheduled coroutine, like
> 
>     /* This is valid. */
>     aio_co_schedule(qemu_get_current_aio_context(),
>                     qemu_coroutine_self());
> 
>     /* But only if there was a qemu_coroutine_yield here.  */
>     co_aio_sleep_ns(qemu_get_current_aio_context(), 1000);
>

That is true.  But we could also check (co->sleeping || co->scheduled) in
co_aio_sleep_ns() though, as well.

Hmm... not checking co->sleeping in co_aio_sleep_ns() is a bug in my
patch.  We don't want to schedule a coroutine on two different timers,
either.

So what do you think about adding this to the patch:

@@ -34,6 +36,7 @@ void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
     CoSleepCB sleep_cb = {
         .co = qemu_coroutine_self(),
     };
+    if (sleep_cb.co->sleeping == 1 || sleep_cb.co->scheduled == 1) {
+       fprintf(stderr, "Cannot sleep a co-routine that is already sleeping "
+                       " or scheduled\n");
+       abort();
+    }
+    sleep_cb.co->sleeping = 1;
     sleep_cb.ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sleep_cb);
     timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();


Jeff
