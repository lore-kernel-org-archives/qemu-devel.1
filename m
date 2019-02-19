Received: from eggs.gnu.org ([209.51.188.92]:47633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw2Zl-0007XE-1u
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw2ZV-00025x-K6
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:24:27 -0500
Date: Tue, 19 Feb 2019 11:24:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219102400.GG4727@localhost.localdomain>
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-5-kwolf@redhat.com>
	<0e7acbc6-9e05-abd0-852b-5c76ce084dff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7acbc6-9e05-abd0-852b-5c76ce084dff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/12] io: Make qio_channel_yield()
 interruptible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Am 18.02.2019 um 18:11 hat Paolo Bonzini geschrieben:
> On 18/02/19 17:18, Kevin Wolf wrote:
> > Similar to how qemu_co_sleep_ns() allows to be preempted by an external
> > coroutine entry, allow reentering qio_channel_yield() early.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/io/channel.h |  9 ++++++---
> >  io/channel.c         | 10 ++++++++++
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/io/channel.h b/include/io/channel.h
> > index da2f138200..59460cb1ec 100644
> > --- a/include/io/channel.h
> > +++ b/include/io/channel.h
> > @@ -739,10 +739,13 @@ void qio_channel_detach_aio_context(QIOChannel *ioc);
> >   * addition, no two coroutine can be waiting on the same condition
> >   * and channel at the same time.
> >   *
> > - * This must only be called from coroutine context
> > + * This must only be called from coroutine context. It is safe to
> > + * reenter the coroutine externally while it is waiting; in this
> > + * case the function will return even if @condition is not yet
> > + * available.
> >   */
> > -void qio_channel_yield(QIOChannel *ioc,
> > -                       GIOCondition condition);
> > +void coroutine_fn qio_channel_yield(QIOChannel *ioc,
> > +                                    GIOCondition condition);
> >  
> >  /**
> >   * qio_channel_wait:
> > diff --git a/io/channel.c b/io/channel.c
> > index 8dd0684f5d..303376e08d 100644
> > --- a/io/channel.c
> > +++ b/io/channel.c
> > @@ -469,6 +469,16 @@ void coroutine_fn qio_channel_yield(QIOChannel *ioc,
> >      }
> >      qio_channel_set_aio_fd_handlers(ioc);
> >      qemu_coroutine_yield();
> > +
> > +    /* Allow interrupting the operation by reentering the coroutine other than
> > +     * through the aio_fd_handlers. */
> > +    if (condition == G_IO_IN && ioc->read_coroutine) {
> > +        ioc->read_coroutine = NULL;
> > +        qio_channel_set_aio_fd_handlers(ioc);
> > +    } else if (condition == G_IO_OUT && ioc->write_coroutine) {
> > +        ioc->write_coroutine = NULL;
> > +        qio_channel_set_aio_fd_handlers(ioc);
> > +    }
> >  }
> 
> Perhaps it's a bit cleaner to remove the ioc->..._coroutine assignments,
> and the call to qio_channel_set_aio_fd_handlers, from
> qio_channel_restart_read and qio_channel_restart_write.

I wasn't sure if this was correct because aio_co_wake() doesn't
necessarily enter the coroutine immediately, so the value between there
and actually entering the coroutine would change compared to the old
state.

On closer look, these handlers are never in coroutine context, and
qio_channel_attach_aio_context() asserts that the handlers are inactive,
so I guess we could replace the aio_co_wake() with a direct
qemu_coroutine_enter() and possibly an assertion that we're already in
the right AioContext.

That would make it obvious that removing the assignment and call to
qio_channel_set_aio_fd_handlers() there is safe.

In any case, I think this needs to be a separate patch where the commit
message can explain the above.

Kevin
