Received: from eggs.gnu.org ([2001:4830:134:3::10]:57065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwH4y-000417-Jy
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 19:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwH4x-0006tv-Kz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 19:44:40 -0400
Date: Fri, 7 Apr 2017 07:44:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170406234426.GD4618@lemon>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-4-famz@redhat.com>
	<20170406151733.GJ4341@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406151733.GJ4341@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] block: Quiesce old aio context
 during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 04/06 17:17, Kevin Wolf wrote:
> Am 06.04.2017 um 16:25 hat Fam Zheng geschrieben:
> > The fact that the bs->aio_context is changing can confuse the dataplane
> > iothread, because of the now fine granularity aio context lock.
> > bdrv_drain should rather be a bdrv_drained_begin/end pair, but since
> > bs->aio_context is changing, we can just use aio_disable_external and
> > block_job_pause.
> > 
> > Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block.c b/block.c
> > index 8893ac1..e70684a 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -4395,11 +4395,14 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
> >  
> >  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
> >  {
> > -    AioContext *ctx;
> > +    AioContext *ctx = bdrv_get_aio_context(bs);
> >  
> > +    aio_disable_external(ctx);
> > +    if (bs->job) {
> > +        block_job_pause(bs->job);
> > +    }
> 
> Even more bs->job users... :-(
> 
> But is this one actually necessary? We drain all pending BHs below, so
> the job shouldn't have any requests in flight or be able to submit new
> ones while we switch.

I'm not 100% sure, but I think the aio_poll() loop below can still fire
co_sleep_cb if we don't do block_job_pause()?

> 
> >      bdrv_drain(bs); /* ensure there are no in-flight requests */
> >  
> > -    ctx = bdrv_get_aio_context(bs);
> >      while (aio_poll(ctx, false)) {
> >          /* wait for all bottom halves to execute */
> >      }
> > @@ -4412,6 +4415,10 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
> >      aio_context_acquire(new_context);
> >      bdrv_attach_aio_context(bs, new_context);
> >      aio_context_release(new_context);
> > +    if (bs->job) {
> > +        block_job_resume(bs->job);
> > +    }
> > +    aio_enable_external(ctx);
> >  }
> 
> The aio_disabe/enable_external() pair seems to make sense anyway.
> 
> Kevin
