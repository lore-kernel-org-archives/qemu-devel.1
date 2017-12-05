Received: from eggs.gnu.org ([2001:4830:134:3::10]:32903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMF3F-0005xi-Or
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMF3E-0006qq-Vp
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:22:29 -0500
Date: Tue, 5 Dec 2017 16:22:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171205152216.GA4096@localhost.localdomain>
References: <20171205145424.24598-1-kwolf@redhat.com>
	<20171205145424.24598-2-kwolf@redhat.com>
	<7ef6de08-0fe1-99e4-1620-ae9a92b6017d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef6de08-0fe1-99e4-1620-ae9a92b6017d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Make bdrv_drain_invoke()
 recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Am 05.12.2017 um 16:02 hat Paolo Bonzini geschrieben:
> On 05/12/2017 15:54, Kevin Wolf wrote:
> >      }
> >  
> > +    bdrv_drain_invoke(bs, true);
> >      bdrv_drain_recurse(bs, true);
> >  }
> >  
> > @@ -294,6 +298,7 @@ void bdrv_drained_end(BlockDriverState *bs)
> >      }
> >  
> >      bdrv_parent_drained_end(bs);
> > +    bdrv_drain_invoke(bs, false);
> >      bdrv_drain_recurse(bs, false);
> >      aio_enable_external(bdrv_get_aio_context(bs));
> 
> I think invoke should be done after recurse from bdrv_drain*end.  In the
> end aio_enable_external is a special kind of drain_end callback, so
> bdrv_drain_invoke should go together with it.

Yes and no.

Calling them together makes sense to me. Not for this patch, though,
which is just mechanical refactoring. bdrv_drain_invoke() was at the
beginning of bdrv_drain_recurse(), so it ends up before it after the
refactoring.

But there is really no reason at all to call bdrv_drain_recurse() in
bdrv_drained_end(). We only called it because it happened to involve
bdrv_drain_invoke(). After this patch, the call can be removed. I can do
that in a v2 (in a separate patch).

What we probably also should do is move bdrv_parent_drained_end() after
bdrv_drain_invoke() so that children are ready to accept new requests
when the parent callback is called. There is also some inconsistency
between bdrv_drain() and bdrv_drain_all() about the order of these
operations. I hope that in the end they would just call the same helper
and only the actual polling loop stays separate (as long as needed).

Kevin
