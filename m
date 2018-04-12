Received: from eggs.gnu.org ([2001:4830:134:3::10]:42267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6a93-00088t-OJ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6a92-0007dz-EB
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:12:01 -0400
Date: Thu, 12 Apr 2018 13:11:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180412111143.GB5004@localhost.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
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

Am 12.04.2018 um 12:12 hat Paolo Bonzini geschrieben:
> On 12/04/2018 11:51, Kevin Wolf wrote:
> > Am 12.04.2018 um 10:37 hat Paolo Bonzini geschrieben:
> >> On 11/04/2018 18:39, Kevin Wolf wrote:
> >>> +bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
> >>>  {
> >>>      /* Execute pending BHs first and check everything else only af=
ter the BHs
> >>>       * have executed. */
> >>> -    while (aio_poll(bs->aio_context, false));
> >>> +    if (top_level) {
> >>> +        while (aio_poll(bs->aio_context, false));
> >>> +    }
> >>> +
> >>> +    if (bdrv_parent_drained_poll(bs)) {
> >>> +        return true;
> >>> +    }
> >>> +
> >>>      return atomic_read(&bs->in_flight);
> >>>  }
> >>> =20
> >>
> >> Up until now I liked very much this series, but I like this patch a =
bit
> >> less for two reasons.
> >>
> >> 1) I think I would prefer to have the !top_level case in a separate
> >> function---making the API easier to use in the BdrvChildRole callbac=
k
> >> because there is no need to pass false.
> >=20
> > Basically just move the aio_poll() out to a different function that
> > calls bdrv_drain_poll afterwards? Maybe it's a bit cleaner, yes.
> > However, see below.
>=20
> Yes.
>=20
> >> In addition, the callback is not really polling anything, but rather
> >> returning whether the children are quiescent.  So a better name woul=
d
> >> be bdrv_children_drained and c->role->drained.
> >=20
> > Why isn't it polling? We're actively checking the state of the node, =
and
> > we keep calling the callback until it has the expected state. Would i=
t
> > only become polling for you if the loop were in this function rather
> > than the its caller?
>=20
> It's just checking the status, it's not invoking the event loop.  The
> polling (in the sense of aio_poll or AIO_POLL_WHILE) is done elsewhere,
> this function is just the condition.  It's just nomenclature I guess.

Yes, it doesn't poll the AioContext events. I don't think that the name
implies that, though. It does poll the state of the block node and its
users.

> >> 2) Worse, the main idea behind the first drain restructuring was tha=
t
> >> draining could proceed in topological order: first drain the roots' =
I/O,
> >> then call bdrv_drain to send the last requests to their children, th=
en
> >> recurse.  It is not clear to me why you need to introduce this recur=
sive
> >> step, which is also O(n^2) in the worst case.
> >=20
> > I need to introduce it because it fixes the bug that we don't wait un=
til
> > the parents are actually quiesced and don't send new requests any mor=
e.
> > I don't see how this could be fixed without going to the parents.
>=20
> Yes, you do need to go to the parents.  I don't understand however why
> you need more than a walk of the graph in parent-before-child order
> (which is a topological order, so it is reverse depth-first order and
> it's easy to do the walk in a recursive function).  If you're draining =
X
> below:
>=20
>      A
>      |
>      B   C
>       \ /
>        X
>=20
> then you start by draining A/B/C in topological order (so A before B).
> If B happens to be already quiescent, you can skip not only B but A too=
.

Are we talking only about bdrv_drain_poll() here or the complete
bdrv_do_drained_begin() call?

If you don't want to recurse separately for .drain_begin and the polling
phase, but keep everything in one function like it's before this series,
you can't skip anything just because it's already quiescent. You don't
have control over that other drain and it might end too early; also,
.drain_begin/end must come in pairs.

If we're only talking about .drain_poll, then in theory you could skip A
if B knows that it's fully quiesced (i.e. not only .drain_begin was
called, but also .drain_poll has returned false at least once). We don't
store this information anywhere, though, and I'm not sure if the saved
recursion would be worth additional state.

>  If the nodes disappear or move elsewhere in the graph it's okay, you'v=
e
> just done useless work.

Not really. The node is drained now and bdrv_do_drained_end() won't end
the drained section because the moved node isn't reachable any more from
this original node.

> When you're done you ensure that every parent
> is quiescent, and if so you're done.  If it's not, , a new parent
> appeared---drain that too, using the same parent-before-child order, an=
d
> loop.

That might work if we only ever were in a single drained section and
BlockDriverState had a bool quiesced. What we do have is a
quiesce_count, and when you look at the quiesce_count of a node, you
can't tell whether it came from you or someone else. So there is no way
to tell whether a parent was already drained by you or not.

And to be honest, even if it worked, it would still seem kind of
complicated to me. Just calling .drain_begin everywhere first and then
polling until nobody has anything in flight any more feels much simpler
conceptually than keeping track of which nodes we drained and repeating
that until no new nodes appear, and somehow undraining the nodes that
disappeared, but are potentially still referenced from somewhere else.

> Well, there is one gotcha: bdrv_ref protects against disappearance, but
> bdrv_ref/bdrv_unref are not thread-safe.  Am I missing something else?

Apart from the above, if we do an extra bdrv_ref/unref we'd also have
to keep track of all the nodes that we've referenced so that we unref
the same nodes again, even if the graph has changes.

So essentially you'd be introducing a new list of BDSes that we have to
manage and then check for every reachable node whether it's already in
that list or not, and for every node in the list whether it's still
reachable. I don't really see how that's going to reduce the complexity.

> > Is the O(n=B2) that you mean that we recursively iterate all children=
 in
> > bdrv_do_drained_begin() (or later in the series in bdrv_drain_poll())=
,
> > and then come back from the children when they poll their parents?
>=20
> Yes.
>=20
> Paolo
>=20
> > We could do the same thing as for bdrv_parent_drained_begin(), i.e. p=
ass
> > the parent that we came from (BdrvChild *parent instead of bool
> > top_level, NULL instead of top_level=3Dtrue) and then skip that paren=
t
> > while calling the BdrvChildRole .drain_poll callbacks. Would that
> > address your concerns?

Ok, then this should be the solution. I can implement it for v2.

Kevin
