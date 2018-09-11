Received: from eggs.gnu.org ([2001:4830:134:3::10]:38924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzfoR-0004xC-UN
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzfoR-0005IU-3h
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:22:27 -0400
Date: Tue, 11 Sep 2018 12:22:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180911102210.GD3994@localhost.localdomain>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-7-kwolf@redhat.com>
	<20180911082311.GG19292@lemon.usersys.redhat.com>
	<20180911091720.GB3994@localhost.localdomain>
	<20180911092858.z7ocrtr27ifhqett@dritchie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911092858.z7ocrtr27ifhqett@dritchie>
Subject: Re: [Qemu-devel] [PATCH 06/14] block: Add missing locking in
 bdrv_co_drain_bh_cb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Am 11.09.2018 um 11:28 hat Sergio Lopez geschrieben:
> On Tue, Sep 11, 2018 at 11:17:20AM +0200, Kevin Wolf wrote:
> > Am 11.09.2018 um 10:23 hat Fam Zheng geschrieben:
> > > On Fri, 09/07 18:15, Kevin Wolf wrote:
> > > > bdrv_do_drained_begin/end() assume that they are called with the
> > > > AioContext lock of bs held. If we call drain functions from a coroutine
> > > > with the AioContext lock held, we yield and schedule a BH to move out of
> > > > coroutine context. This means that the lock for the home context of the
> > > > coroutine is released and must be re-acquired in the bottom half.
> > > > 
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > ---
> > > >  include/qemu/coroutine.h |  5 +++++
> > > >  block/io.c               | 15 +++++++++++++++
> > > >  util/qemu-coroutine.c    |  5 +++++
> > > >  3 files changed, 25 insertions(+)
> > > > 
> > > > diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> > > > index 6f8a487041..9801e7f5a4 100644
> > > > --- a/include/qemu/coroutine.h
> > > > +++ b/include/qemu/coroutine.h
> > > > @@ -90,6 +90,11 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co);
> > > >  void coroutine_fn qemu_coroutine_yield(void);
> > > >  
> > > >  /**
> > > > + * Get the AioContext of the given coroutine
> > > > + */
> > > > +AioContext *coroutine_fn qemu_coroutine_get_aio_context(Coroutine *co);
> > > > +
> > > > +/**
> > > >   * Get the currently executing coroutine
> > > >   */
> > > >  Coroutine *coroutine_fn qemu_coroutine_self(void);
> > > > diff --git a/block/io.c b/block/io.c
> > > > index 7100344c7b..914ba78f1a 100644
> > > > --- a/block/io.c
> > > > +++ b/block/io.c
> > > > @@ -288,6 +288,18 @@ static void bdrv_co_drain_bh_cb(void *opaque)
> > > >      BlockDriverState *bs = data->bs;
> > > >  
> > > >      if (bs) {
> > > > +        AioContext *ctx = bdrv_get_aio_context(bs);
> > > > +        AioContext *co_ctx = qemu_coroutine_get_aio_context(co);
> > > > +
> > > > +        /*
> > > > +         * When the coroutine yielded, the lock for its home context was
> > > > +         * released, so we need to re-acquire it here. If it explicitly
> > > > +         * acquired a different context, the lock is still held and we don't
> > > > +         * want to lock it a second time (or AIO_WAIT_WHILE() would hang).
> > > > +         */
> > > 
> > > This condition is rather obscure. When is ctx not equal to co_ctx?
> > 
> > Whenever you drain a BlockDriverState that is in a different AioContext.
> > The common case is a bdrv_drain() from the main loop thread for a BDS in
> > an iothread.
> 
> Isn't this a consequence of using qemu_coroutine_enter in co_schedule_bh
> [1]?
> 
> AFAIK, even if an IOThread's AioContext is being polled by the main loop
> thread, all coroutines should be running with the IOThread/BDS
> AioContext.

You're right, bdrv_co_yield_to_drain() does schedule the BH in the
AioContext of the BDS, so in theory this shouldn't happen. If it was
called from a coroutine with a wrong co->ctx (due to the bug you
mentioned), that would explain the behaviour. Maybe the condition isn't
necessary any more after your fix.

Kevin
