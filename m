Received: from eggs.gnu.org ([2001:4830:134:3::10]:51156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g02OR-0000iS-Ai
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 06:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g02OP-0004ob-G8
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 06:29:07 -0400
Date: Wed, 12 Sep 2018 12:28:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180912102841.GB5846@localhost.localdomain>
References: <20180905093351.21954-1-slp@redhat.com>
	<20180912074159.GA11164@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912074159.GA11164@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util/async: use qemu_aio_coroutine_enter
 in co_schedule_bh_cb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 12.09.2018 um 09:41 hat Fam Zheng geschrieben:
> On Wed, 09/05 11:33, Sergio Lopez wrote:
> > AIO Coroutines shouldn't by managed by an AioContext different than the
> > one assigned when they are created. aio_co_enter avoids entering a
> > coroutine from a different AioContext, calling aio_co_schedule instead.
> > 
> > Scheduled coroutines are then entered by co_schedule_bh_cb using
> > qemu_coroutine_enter, which just calls qemu_aio_coroutine_enter with the
> > current AioContext obtained with qemu_get_current_aio_context.
> > Eventually, co->ctx will be set to the AioContext passed as an argument
> > to qemu_aio_coroutine_enter.
> > 
> > This means that, if an IO Thread's AioConext is being processed by the
> > Main Thread (due to aio_poll being called with a BDS AioContext, as it
> > happens in AIO_WAIT_WHILE among other places), the AioContext from some
> > coroutines may be wrongly replaced with the one from the Main Thread.
> > 
> > This is the root cause behind some crashes, mainly triggered by the
> > drain code at block/io.c. The most common are these abort and failed
> > assertion:
> > 
> > util/async.c:aio_co_schedule
> > 456     if (scheduled) {
> > 457         fprintf(stderr,
> > 458                 "%s: Co-routine was already scheduled in '%s'\n",
> > 459                 __func__, scheduled);
> > 460         abort();
> > 461     }
> > 
> > util/qemu-coroutine-lock.c:
> > 286     assert(mutex->holder == self);
> > 
> > But it's also known to cause random errors at different locations, and
> > even SIGSEGV with broken coroutine backtraces.
> > 
> > By using qemu_aio_coroutine_enter directly in co_schedule_bh_cb, we can
> > pass the correct AioContext as an argument, making sure co->ctx is not
> > wrongly altered.
> > 
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  util/async.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/util/async.c b/util/async.c
> > index 05979f8014..c10642a385 100644
> > --- a/util/async.c
> > +++ b/util/async.c
> > @@ -400,7 +400,7 @@ static void co_schedule_bh_cb(void *opaque)
> >  
> >          /* Protected by write barrier in qemu_aio_coroutine_enter */
> >          atomic_set(&co->scheduled, NULL);
> > -        qemu_coroutine_enter(co);
> > +        qemu_aio_coroutine_enter(ctx, co);
> >          aio_context_release(ctx);
> >      }
> >  }
> 
> Kevin, could you test this patch together with your next version of the drain
> fix series? Since they are related, it's better if you could include it in your
> series or even apply it yourself. Peter is not processing pull requests, so
> scattering fixes in various trees will do no good.

Apparently I forgot to send an email, but I already applied this to my
block branch.

Kevin
