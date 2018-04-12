Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6Ytq-0005PW-NN
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6Ytp-0002aa-RT
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:52:14 -0400
Date: Thu, 12 Apr 2018 11:51:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180412095157.GA5004@localhost.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on
 drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Am 12.04.2018 um 10:37 hat Paolo Bonzini geschrieben:
> On 11/04/2018 18:39, Kevin Wolf wrote:
> > +bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
> >  {
> >      /* Execute pending BHs first and check everything else only afte=
r the BHs
> >       * have executed. */
> > -    while (aio_poll(bs->aio_context, false));
> > +    if (top_level) {
> > +        while (aio_poll(bs->aio_context, false));
> > +    }
> > +
> > +    if (bdrv_parent_drained_poll(bs)) {
> > +        return true;
> > +    }
> > +
> >      return atomic_read(&bs->in_flight);
> >  }
> > =20
>=20
> Up until now I liked very much this series, but I like this patch a bit
> less for two reasons.
>=20
> 1) I think I would prefer to have the !top_level case in a separate
> function---making the API easier to use in the BdrvChildRole callback
> because there is no need to pass false.

Basically just move the aio_poll() out to a different function that
calls bdrv_drain_poll afterwards? Maybe it's a bit cleaner, yes.
However, see below.

> In addition, the callback is not really polling anything, but rather
> returning whether the children are quiescent.  So a better name would
> be bdrv_children_drained and c->role->drained.

Why isn't it polling? We're actively checking the state of the node, and
we keep calling the callback until it has the expected state. Would it
only become polling for you if the loop were in this function rather
than the its caller?

> 2) Worse, the main idea behind the first drain restructuring was that
> draining could proceed in topological order: first drain the roots' I/O=
,
> then call bdrv_drain to send the last requests to their children, then
> recurse.  It is not clear to me why you need to introduce this recursiv=
e
> step, which is also O(n^2) in the worst case.

I need to introduce it because it fixes the bug that we don't wait until
the parents are actually quiesced and don't send new requests any more.
I don't see how this could be fixed without going to the parents.

Is the O(n=B2) that you mean that we recursively iterate all children in
bdrv_do_drained_begin() (or later in the series in bdrv_drain_poll()),
and then come back from the children when they poll their parents?

We could do the same thing as for bdrv_parent_drained_begin(), i.e. pass
the parent that we came from (BdrvChild *parent instead of bool
top_level, NULL instead of top_level=3Dtrue) and then skip that parent
while calling the BdrvChildRole .drain_poll callbacks. Would that
address your concerns?

In that solution, splitting the function by moving aio_poll() out
wouldn't get rid of a parameter and simplify the API any more. It might
still be cleaner, though?

Kevin
