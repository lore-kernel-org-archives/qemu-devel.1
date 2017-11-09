Received: from eggs.gnu.org ([2001:4830:134:3::10]:58636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCpdl-0008J1-AK
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCpdj-0005ih-Kr
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:25:17 -0500
Date: Thu, 9 Nov 2017 17:25:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171109162506.GB5260@localhost.localdomain>
References: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
	<20171107142218.GC4706@localhost.localdomain>
	<a527b5a7-9503-8f17-ab81-bb533b30afba@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <a527b5a7-9503-8f17-ab81-bb533b30afba@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Drainage in
 bdrv_replace_child_noperm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Qemu-devel <qemu-devel@nongnu.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.11.2017 um 21:16 hat Max Reitz geschrieben:
> On 2017-11-07 15:22, Kevin Wolf wrote:
> > I think the issue is much simpler, even though it still has two parts.
> > It's the old story of bdrv_drain mixing two separate concepts:
> >=20
> > 1. Wait synchronously for the completion of all my requests to this
> >    node. This needs to be propagated down the graph to the children.
>=20
> So, flush without flushing protocol drivers? :-)

No, flush is a completely different thing. Drain is about completing all
in-flight requests, whereas flush is about writing out all caches. You
can do either one without the other.

In particular, a flush doesn't involve a drain, you can still requests
while a flush request is in flight. The semantics is that a flush makes
sure that all requests which had already completed when the flush
request was started are stable on disk. Later requests may or may not be
stable on disk yet.

> > 2. Make sure that nobody else sends new requests to this node. This
> >    needs to be propagated up the graph to the parents.
> >=20
> > Some callers want only 1. (usually callers of bdrv_drain_all() without a
> > begin/end pair), some callers want both 1. and 2. (that's the begin/end
> > construction for getting exclusive access). Not sure if there are
> > callers that want only 2., but possibly.
> >=20
> > If we actually take this separation serious, the first step to a fix
> > could be that BdrvChildRole.drained_begin shouldn't be propagated to the
> > children.
>=20
> That seems good to me, but considering that the default was to just
> propagate it to every child, I thought that I was missing something.

bdrv_child_cb_drained_begin() calls bdrv_drained_begin() to wait for the
completion of all running requests on its current node. The propagation
to every child is an unwanted side effect, but so far it didn't seem to
hurt anyone, so we didn't care about preventing it.

> >           We may still need to drain the requests at the node itself:
> > > Imagine a drained backing file of qcow2 node. Making sure that the qc=
ow2
> > node doesn't get new requests isn't enough, we also must make sure that
> > in-flight requests don't access the backing file any more. This means
> > draining the qcow2 node, though we don't care whether its child nodes
> > still have requests in flight.
>=20
> If you want to stop the qcow2 node from generating further requests, you
> can either flush them (as you said) or pause them (whatever that means...=
).

Pausing is probably way to complicated. qcow2 never issues requests by
itself. It only has requests running if someone else has a request
running on the qcow2 node. So it's enough to just drain the request
queue of the qcow2 node to get to the state we want.

The only thing we need to make sure is that we drain it _before_ its
child node is replaced with a drained one, so that its requests can
complete.

In fact, I think graph modifications should only be done with drained
nodes anyway. Otherwise you could switch over in the middle of a single
high-level operation and possibly get callbacks from a node that isn't a
child any more. Maybe we should add some assertions to that effect and
clean up whatever code breaks after it.

> However, if you flush them, you also need to flush the children you have
> flushed them to...  So what I wrote was technically wrong ("don't pass
> parent drainage back to the child because the child is already
> drained"), instead it should be "don't pass parent drainage back to the
> child because the child is going to be drained (flushed) anyway".
>=20
> So, pause requests first (either by parking them or flushing them,
> driver's choice), then flush the tree.
>=20
> Of course that's easier said than done...  First, we would need a
> non-recursive flush.  Then, every node that is visited by the drain
> would (*after* recursing to its parents) need to flush itself.
>=20
> (Note that I'm completely disregarding nodes which are below the
> original node that is supposed to be drained, and which therefore do not
> drain their parents (or do they?) because I'd like to retain at least
> some of my sanity for now.)

I don't follow, but I suppose this is related to the flush/drain
confusion.

> Secondly we have exactly the issue you describe below...
>=20
> > The big question is whether bdrv_drain() would still work for a single
> > node without recursing to the children, but as it uses bs->in_flight, I
> > think that should be okay these days.
> >=20
> >> (Most importantly, ideally we'd want to attach the new child to the
> >> parent and then drain the parent: This would give us exactly the state
> >> we want.  However, attaching the child first and then draining the
> >> parent is unsafe, so we cannot do it...)
> >>
> >> [1] Whether the parent (un-)drains the child depends on the
> >> BdrvChildRole.drained_{begin,end}() implementation, strictly speaking.
> >> We cannot say it generally.
> >>
> >> OK, so how to fix it?  I don't know, so I'm asking you. :-)
> >=20
> > The conclusion from what I wrote above would be to add a non-recursive
> > drain function (probably a version of bdrv_drained_begin/end with a bool
> > parameter) and call that from bdrv_child_cb_drained_begin/end.
> >=20
> > This would still only be a partial solution because we still maintain
> > the single interface for two different purposes, but it should be a step
> > in the right direction and fix the problem at hand.
>=20
> Well, except...

Yes, bug 1 would be fixed, but not yet bug 2.

> >> I have two ideas:
> >>
> >> One is to assume that (un-)draining a parent will always (un-)drain all
> >> children, including the one the (un-)drain comes from.  This assumption
> >> seems wrong, see [1], but maybe it isn't.  Anyway, if so, we could just
> >> explicitly drain the new child in bdrv_replace_child_noperm() after
> >> having drained the parent and thus get a consistent state again.
> >=20
> > I agree that this is wrong.
> >=20
> >> The other is to declare (A) wrong.  Maybe when
> >> BdrvChildRole.drained_{begin,end}() is invoked, we should not drain th=
at
> >> child because we can declare it the caller's responsibility to make su=
re
> >> it's drained.  This seems logical to me because usually those methods
> >> are invoked when the child is drained anyway.  But maybe I'm wrong. :-)
> >=20
> > Looks like a similar resolution as I suggest, though I like my reasoning
> > for it better. ;-)
> >=20
> >> So, any ideas?
> >=20
> > Just an additional thought (aka "alles kaputt"): The throttle driver
> > will respond to BlockDriver.bdrv_drained_begin() by completing all of
> > the queued requests (ignoring the I/O limits) before it returns. This is
> > great when the drain request comes from a parent because it just want to
> > get everything completed. It's kind of a problem when the drain request
> > comes from a child which is already drained...
> >=20
> > To be more specific, you pointed at bdrv_replace_child_noperm(). This
> > replaces child->bs first and only then calls the .drained_begin callback
> > of the parent. So if the parent wants to implement draining by just
> > submiting its queue, we're submitting requests to a child where this
> > isn't allowed.
>=20
> ...exactly this. :-/
>=20
> So a non-recursive drain would just fix the assert, but not this issue.
> And I'm not sure whether this is reasonable.  Fixing the assert but
> allowing the driver to submit requests to a drained node is just wrong.

Well, apart from what I described below, I see two more solutions:

1. Just drain before replacing the child node. Then the requests still
   go to the old child, which wasn't drained.

2. Require that the parent node be drained before it can be involved in
   a bdrv_replace_child_noperm() operation. This is what I suggested
   above. Right now it seems like a good idea. Not sure if it still does
   after actually trying it out.

> > If we had separated the two operations, we could have two BlockDriver
> > callbacks, one triggering the queue flush, and the other one requiring
> > that no new requests from the queue be submitted.
>=20
> Yes.  Then we could require that every driver implements a way to park
> requests instead of only pausing request submissions through flushing.

I think in the long run we'll need this, but not in the strict form that
this sounds like. We don't need a function to "park" already running
requests, just one to avoid issuing new requests. So not every driver
must implement this, just every driver that can issue requests by
itself.

Kevin

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaBIFhAAoJEH8JsnLIjy/WM6cP/2fmwMgR+Z4XQk/4+fNe06LQ
6iyDheuBJfooMBAekIfAlTA3fHFHEEeC7HGSsYRfUtNhdOQu00mV6XmdJBSrKj0c
0LjCPWqWK4VHmWLFECu5ozSfsoo0BIFIGXB+jlny3hz2iLpvuXYVm/oYfsIEPYtt
7yx6v2vuMjp4xvl1M/eiuxlblhdEmwZicYkgOjyu7PQwkf6cotIlOLI9b+ghLdB7
lbbcbjNw4R85RxMyExFf7vEVqvZmhP1bGFFLRuunTwjzFkMX7oFfh2blED3wi7+r
IbfUxm837NUB7rYVWAFzcUxm4cvy3bjIQvUhHhiN436DmYN7SE0+q/yfpwJ8N7dX
Q9aQgRBx6krRWiy+Uvln7lb2nvY+xMEXv4QKOeWBNaSQqouVoZGweDV354zMwEAg
0TGtgxOis5exeBElp0cIn0lRCqfHq465f9Tie4ktq03xjGLloR/IORjXoYpi5Xyt
aZLpjFNLrQtfoc5IAoG9aFU8aFL4Dftouhlvn2KOqeubw5ng5m22sQexXNKm3bZl
ymb4HIUOZd0eINH3rpPr0r8YpWw81JccwLQngGyLYPbB3aVKA7fEcygLo9nUcYvS
4xIMwrpEh+sHM5tcaAj+RGMqlpGewRynzMP4bXmsaIu0AH/1TsZqM6yplEwgSYby
3tTQ6uY04sTPdHh/YvvY
=D8vs
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
