Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwP3F-0003B4-Vl
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwP3E-0007aL-QE
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:15:25 -0400
Date: Fri, 7 Apr 2017 10:15:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170407081505.GA4716@noname.redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-4-famz@redhat.com>
	<20170406151733.GJ4341@noname.redhat.com>
	<20170406234426.GD4618@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406234426.GD4618@lemon>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 07.04.2017 um 01:44 hat Fam Zheng geschrieben:
> On Thu, 04/06 17:17, Kevin Wolf wrote:
> > Am 06.04.2017 um 16:25 hat Fam Zheng geschrieben:
> > > The fact that the bs->aio_context is changing can confuse the dataplane
> > > iothread, because of the now fine granularity aio context lock.
> > > bdrv_drain should rather be a bdrv_drained_begin/end pair, but since
> > > bs->aio_context is changing, we can just use aio_disable_external and
> > > block_job_pause.
> > > 
> > > Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >  block.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block.c b/block.c
> > > index 8893ac1..e70684a 100644
> > > --- a/block.c
> > > +++ b/block.c
> > > @@ -4395,11 +4395,14 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
> > >  
> > >  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
> > >  {
> > > -    AioContext *ctx;
> > > +    AioContext *ctx = bdrv_get_aio_context(bs);
> > >  
> > > +    aio_disable_external(ctx);
> > > +    if (bs->job) {
> > > +        block_job_pause(bs->job);
> > > +    }
> > 
> > Even more bs->job users... :-(
> > 
> > But is this one actually necessary? We drain all pending BHs below, so
> > the job shouldn't have any requests in flight or be able to submit new
> > ones while we switch.
> 
> I'm not 100% sure, but I think the aio_poll() loop below can still fire
> co_sleep_cb if we don't do block_job_pause()?

Somehow I thought that aio_poll() doesn't run timers, but that seems to
be wrong. I think in the pre-AioContext world it used to be this way.

Okay, let's leave this patch as it is. We can then clean things up in
the 2.10 timeframe and propagate things cleanly upwards through the
BlockBackend to its users. We want to this for drain anyway.

Hm, maybe we should already call bdrv_parent_drained_begin/end? I don't
think that image throttling can submit new requests while we're changing
the AioContext (because it probably doesn't have any at that point), but
I'm not completely sure.

Kevin
