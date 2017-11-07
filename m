Received: from eggs.gnu.org ([2001:4830:134:3::10]:50461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eC4m2-0006nD-CO
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eC4lu-0004vH-5P
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:22:42 -0500
Date: Tue, 7 Nov 2017 15:22:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171107142218.GC4706@localhost.localdomain>
References: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.11.2017 um 19:49 hat Max Reitz geschrieben:
> Hi everyone,
>=20
> On my quest to fix some flaky iotests, I came to a bit of a halt on 129.
>  (Details: Its issue is that block jobs now generally ignore throttling
> in a BB (because they use their own), so we have to add a throttle node
> instead.  However, when I added it, I got an abort.)
>=20
> My issue can be reproduced as follows:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 \
>     -qmp stdio \
>     -object throttle-group,id=3Dtg0 \
>     -blockdev "{'driver':'throttle','node-name':'drive0',
>                 'throttle-group':'tg0','file':{'driver':'null-co'}}" \
>     -blockdev node-name=3Dtarget,driver=3Dnull-co
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 10, "major": 2},
> "package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'blockdev-mirror','arguments':{
>     'device':'drive0','job-id':'job0','target':'target','sync':'full',
>     'filter-node-name':'mirror-node' }}
> qemu-system-x86_64: block/throttle.c:213: throttle_co_drain_end:
> Assertion `tgm->io_limits_disabled' failed.
> [1]    3524 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
> stdio -object throttle-group,id=3Dtg0
>=20
> Here's what happens:
>=20
> (1) bdrv_drained_begin(bs) in mirror_start_job() starts draining drive0.
>=20
> (2) bdrv_append(...) puts mirror-node above drive0.  Through
> bdrv_replace_child_noperm(), this will invoke
> bdrv_child_cb_drained_begin() on mirror-node.  This is necessary because
> drive0 is drained, so the new parent needs to be drained as well.
> However, note that drive0 is not yet attached to mirror-node.
> Therefore, mirror-node cannot drain drive0 recursively.

Important context: We're talking about bdrv_set_backing_hd() here.

It's also not quite correct to say that drive0 is not yet attached, but
we're in a weird half-attached state. The BdrvChild is already
initialised and in the parent list of drive0, but it's not yet assigned
to mirror_node->backing nor in mirror_node's child list.

For this specific case it looks like this is indeed the same as not
being attached, but I wouldn't be surprised if we saw stranger effects
at some point.

> This is seemingly fine because drive0 is drained anyway.  However, this
> is different from what would happen if we would have drained drive0 with
> mirror-node already attached to it as its parent: Then, we would have
> drained drive0 twice; once by itself, and another time recursively
> through mirror-node.
>=20
> This will be important in a second...
>=20
> (3) ...and this second is now: We invoke bdrv_drained_end() on drive0.
> Now, through bdrv_parent_drained_end() and bdrv_child_cb_drained_end()
> that goes up to mirror-node which recursively un-drains drive0.  Fine so
> far.  But once that parent un-drain is done, we un-drain drive0 by
> itself: And this fails the assertion in the throttle driver because we
> attempt to un-drain it twice, although we've drained it only once.
>=20
>=20
> So the issue has two parts:
>=20
> (A) (Un-)Draining a parent from a child will always (?[1]) (un-)drain
> that child, too.  This seems a bit superfluous to me and I would guess
> that it results in worst-case O(n^2) function calls to drain a block
> graph consisting of n nodes.
>=20
> (B) In bdrv_replace_child_noperm() we try to drain the parent if the new
> child is drained; specifically, we want it to be in a state as if it had
> been a parent when the child was originally drained.  However, we fail
> at this because we drain the parent without the child attached, so we
> don't drain the child twice.  This bites us when we undrain everything.

I think the issue is much simpler, even though it still has two parts.
It's the old story of bdrv_drain mixing two separate concepts:

1. Wait synchronously for the completion of all my requests to this
   node. This needs to be propagated down the graph to the children.

2. Make sure that nobody else sends new requests to this node. This
   needs to be propagated up the graph to the parents.

Some callers want only 1. (usually callers of bdrv_drain_all() without a
begin/end pair), some callers want both 1. and 2. (that's the begin/end
construction for getting exclusive access). Not sure if there are
callers that want only 2., but possibly.

If we actually take this separation serious, the first step to a fix
could be that BdrvChildRole.drained_begin shouldn't be propagated to the
children. We may still need to drain the requests at the node itself:

Imagine a drained backing file of qcow2 node. Making sure that the qcow2
node doesn't get new requests isn't enough, we also must make sure that
in-flight requests don't access the backing file any more. This means
draining the qcow2 node, though we don't care whether its child nodes
still have requests in flight.

The big question is whether bdrv_drain() would still work for a single
node without recursing to the children, but as it uses bs->in_flight, I
think that should be okay these days.

> (Most importantly, ideally we'd want to attach the new child to the
> parent and then drain the parent: This would give us exactly the state
> we want.  However, attaching the child first and then draining the
> parent is unsafe, so we cannot do it...)
>=20
> [1] Whether the parent (un-)drains the child depends on the
> BdrvChildRole.drained_{begin,end}() implementation, strictly speaking.
> We cannot say it generally.
>=20
> OK, so how to fix it?  I don't know, so I'm asking you. :-)

The conclusion from what I wrote above would be to add a non-recursive
drain function (probably a version of bdrv_drained_begin/end with a bool
parameter) and call that from bdrv_child_cb_drained_begin/end.

This would still only be a partial solution because we still maintain
the single interface for two different purposes, but it should be a step
in the right direction and fix the problem at hand.

> I have two ideas:
>=20
> One is to assume that (un-)draining a parent will always (un-)drain all
> children, including the one the (un-)drain comes from.  This assumption
> seems wrong, see [1], but maybe it isn't.  Anyway, if so, we could just
> explicitly drain the new child in bdrv_replace_child_noperm() after
> having drained the parent and thus get a consistent state again.

I agree that this is wrong.

> The other is to declare (A) wrong.  Maybe when
> BdrvChildRole.drained_{begin,end}() is invoked, we should not drain that
> child because we can declare it the caller's responsibility to make sure
> it's drained.  This seems logical to me because usually those methods
> are invoked when the child is drained anyway.  But maybe I'm wrong. :-)

Looks like a similar resolution as I suggest, though I like my reasoning
for it better. ;-)

> So, any ideas?

Just an additional thought (aka "alles kaputt"): The throttle driver
will respond to BlockDriver.bdrv_drained_begin() by completing all of
the queued requests (ignoring the I/O limits) before it returns. This is
great when the drain request comes from a parent because it just want to
get everything completed. It's kind of a problem when the drain request
comes from a child which is already drained...

To be more specific, you pointed at bdrv_replace_child_noperm(). This
replaces child->bs first and only then calls the .drained_begin callback
of the parent. So if the parent wants to implement draining by just
submiting its queue, we're submitting requests to a child where this
isn't allowed.

If we had separated the two operations, we could have two BlockDriver
callbacks, one triggering the queue flush, and the other one requiring
that no new requests from the queue be submitted.

Kevin

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaAcGZAAoJEH8JsnLIjy/WzgQP/3qeB6HZDCnzjBv1T64EX9n9
5I/ryHR06ZuFfgRULHjXJzr75SV5H5lGvMBhJQjFg8PtyFvjwXD+WwwDj5Y2mUBt
aiWg6Xdd8IL2s2CS+5ApybbMi8cIOeIi0Q5A8LphhAb6zQEIRlQt0Q6neNMlKyi6
lj+jlsNt47ASyUHM40HdrHXZEIB/areJwoAHr9TWWdIE3t4uC98cLr3l6HyhE4VU
EUN2os1tNGHY8za34TvhOdd//Uyc7yZWdgZEhcBzpw9KWRJKaVRpDCGIYi2+ZIER
zCUcnqXScskveKGuVZovB5TeDPVwiwoPdye8M0I5JrihA1Y/lTsoyqOJ9WS0Y7/c
K+euIAwUmis7XDc6VG8up4VmUF82agW3UDit247jT7lesEzntkWxbyXcg+PQrLH1
0P/YI6JbN+Lk0oDxnvwKmM1BBK0IwVGwP+FXOsFNDodUo47R5SG4ZWMHC6wtO/Ga
umxuuhYfefdCbsGSRsFiiw1pmp/1Rh7fxAAMNie7IXccZNduBXvckbRqQWpDlf0P
dXFzXgpj5NjBlt63lWViVOAJOVQHE6Tx0nxZszEFiDpYaGtnfy5HLOPr7py6jM3R
dSAsImrsQH4UnsKX4KqLmYDFCattKG9Npn5DNuk+1lKVmzbuhLXN/HjcgW8zFEge
TeZU6f/eu3Qpm9Qk1FHC
=Bf0t
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
