Received: from eggs.gnu.org ([2001:4830:134:3::10]:53073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJjl9-0003Te-PM
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJjl7-0002Mw-Qa
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:33:27 -0500
Date: Tue, 28 Nov 2017 12:33:10 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171128173310.GI25110@localhost.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-2-kwolf@redhat.com>
	<00b2dbda-e7a1-2fc4-b7ca-e60c0ef08a95@redhat.com>
	<20171128163725.GG3703@localhost.localdomain>
	<cf7eed9c-5047-fce8-f649-f8fb3310546b@redhat.com>
	<20171128171931.GJ3703@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128171931.GJ3703@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/4] Revert "coroutine: abort if
 we try to schedule or enter a pending coroutine"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Tue, Nov 28, 2017 at 06:19:31PM +0100, Kevin Wolf wrote:
> Am 28.11.2017 um 18:01 hat Paolo Bonzini geschrieben:
> > On 28/11/2017 17:37, Kevin Wolf wrote:
> > >>
> > >> It can also conflict badly with another aio_co_schedule().  Your patch
> > >> here removes the assertion in this case, and patch 3 makes it easier to
> > >> get into the situation where two aio_co_schedule()s conflict with each
> > >> other.
> > > I don't see how they conflict. If the second aio_co_schedule() comes
> > > before the coroutine is actually entered, they are effectively simply
> > > merged into a single one. Which is exactly what was intended.
> > 
> > Suppose you have
> > 
> > 	ctx->scheduled_coroutines
> > 	  |
> > 	  '---> co
> >                 |
> >                 '---> NULL
> > 
> > Then aio_co_schedule(ctx, co) does QSLIST_INSERT_HEAD_ATOMIC, which is
> > 
> > 	/* On entry, ctx->scheduled_coroutines == co.  */
> > 	co->next = ctx->scheduled_coroutines
> > 	change ctx->scheduled_coroutines from co->next to co
> > 
> > This results in a loop:
> > 	
> > 	ctx->scheduled_coroutines
> > 	  |
> > 	  '---> co <-.
> >                 |    |
> >                 '----'
> > 
> > This is an obvious hang due to list corruption.  In other more
> > complicated cases it can skip a wakeup, which is a more subtle kind of
> > hang.  You can also get memory corruption if the coroutine terminates
> > (and is freed) before aio_co_schedule executes.
> 
> Okay, I can see that. I thought you were talking about the logic
> introduced by this series, but you're actually talking about preexisting
> behaviour which limits the usefulness of the patches.
> 
> > Basically, once you do aio_co_schedule or aio_co_wake the coroutine is
> > not any more yours.  It's owned by the context that will run it and you
> > should not do anything with it.
> > 
> > The same is true for co_aio_sleep_ns.  Just because in practice it works
> > (and it seemed like a clever idea at the time) it doesn't mean it *is* a
> > good idea...
> 
> Well, but that poses the question how you can implement any coroutine
> that can be reentered from more than one place. Not being able to do
> that would be a severe restriction.
> 
> For example, take quorum, which handles requests by spawning a coroutine
> for every child and then yielding until acb->count == s->num_children.
> This means that the main request coroutine can be reentered from the
> child request coroutines in any order and timing.
> 
> What saves us currently is that they are all in the same AioContext, so
> we won't actually end up in aio_co_schedule(), but I'm sure that sooner
> or later we'll find cases where we're waiting for several workers that
> are spread across different I/O threads.
> 
> I don't think "don't do that" is a good answer to this.
> 
> And yes, reentering co_aio_sleep_ns() early is a real requirement, too.
> The test case that used speed=1 and would have waited a few hours before
> actually cancelling the job is an extreme example, but even just
> delaying cancellation for a second is bad if this is a second of
> migration downtime.
> 

At least this last part should be doable; reentering co_aio_sleep_ns()
really should mean that we want to short-circuit the QEMU timer for the
sleep cb.  Any reason we can't allow a reenter by removing the timer for
that sleep, and then doing an aio_co_wake?
