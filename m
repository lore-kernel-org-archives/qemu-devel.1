Received: from eggs.gnu.org ([2001:4830:134:3::10]:47550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvDk9-00072L-K3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvDk7-0002dJ-VK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 22:31:05 -0400
Date: Fri, 22 Sep 2017 10:30:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922023053.GB1397@lemon.lan>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
	<20170921131707.17364-2-el13635@mail.ntua.gr>
	<20170921132943.GE13703@lemon.lan>
	<20170921153935.ffyvqej37qhfkrm5@postretch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921153935.ffyvqej37qhfkrm5@postretch>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: add bdrv_co_drain_end
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 09/21 18:39, Manos Pitsidianakis wrote:
> On Thu, Sep 21, 2017 at 09:29:43PM +0800, Fam Zheng wrote:
> > On Thu, 09/21 16:17, Manos Pitsidianakis wrote:
> > > BlockDriverState has a bdrv_do_drain() callback but no equivalent for the end
> > 
> > s/bdrv_do_drain/bdrv_co_drain/
> > 
> > > of the drain. The throttle driver (block/throttle.c) needs a way to mark the
> > > end of the drain in order to toggle io_limits_disabled correctly, thus
> > > bdrv_co_drain_end is needed.
> > > 
> > > Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> > > ---
> > >  include/block/block_int.h |  6 ++++++
> > >  block/io.c                | 48 +++++++++++++++++++++++++++++++++--------------
> > >  2 files changed, 40 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > > index ba4c383393..21950cfda3 100644
> > > --- a/include/block/block_int.h
> > > +++ b/include/block/block_int.h
> > > @@ -356,8 +356,14 @@ struct BlockDriver {
> > >      /**
> > >       * Drain and stop any internal sources of requests in the driver, and
> > >       * remain so until next I/O callback (e.g. bdrv_co_writev) is called.
> > 
> > This line needs update too, maybe:
> > 
> >       /**
> >        * bdrv_co_drain drains and stops any ... and remain so until
> >        * bdrv_co_drain_end is called.
> > 
> > > +     *
> > > +     * The callbacks are called at the beginning and ending of the drain
> > > +     * respectively. They should be implemented if the driver needs to e.g.
> > 
> > As implied by above change, should we explicitly require "should both be
> > implemented"? It may not be technically required, but I think is cleaner and
> > easier to reason about.
> > 
> 
> It might imply to someone that there's an assert(drv->bdrv_co_drain_begin &&
> drv->bdrv_co_drain_end) somewhere unless you state they don't have to be
> implemented at the same time. How about we be completely explicit:
> 
>  bdrv_co_drain_begin is called if implemented in the beggining of a
>  drain operation to drain and stop any internal sources of requests in
>  the driver.
>  bdrv_co_drain_end is called if implemented at the end of the drain.
> 
>  They should be used by the driver to e.g. manage scheduled I/O
>  requests, or toggle an internal state. After the end of the drain new
>  requests will continue normally.
> 
> I hope this is easier for a reader to understand!

I don't like the inconsistent semantics of when the drained section ends, if we
allow drivers to implement bdrv_co_drain_begin but omit bdrv_co_drained_end.
Currently the point where the section ends is, as said in the comment, when next
I/O callback is invoked. Now we are adding the explicit ".bdrv_co_drain_end"
into the fomular, if we still keep the previous convention, the interface
contract is just mixed of two things for no good reason. I don't think it's
technically necessary.

Let's just add the assert:

    assert(!!drv->bdrv_co_drain_begin == !!bdrv_co_drain_end);

in bdrv_drain_invoke, add a comment here, then add an empty .bdrv_co_drain_end
in qed.

Fam
