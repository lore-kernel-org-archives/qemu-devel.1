Received: from eggs.gnu.org ([2001:4830:134:3::10]:52898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPqEJ-0007lX-7e
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPqEE-0005Nt-91
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:08:31 -0400
Date: Tue, 27 Jun 2017 14:08:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170627130812.GI8555@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-8-el13635@mail.ntua.gr>
	<20170626154444.GH29664@stefanha-x1.localdomain>
	<20170626224507.ep2hqzpxknfimf55@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <20170626224507.ep2hqzpxknfimf55@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 7/8] block: remove
 legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 01:45:07AM +0300, Manos Pitsidianakis wrote:
> On Mon, Jun 26, 2017 at 04:44:44PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jun 23, 2017 at 03:46:59PM +0300, Manos Pitsidianakis wrote:
> > > -void blk_io_limits_disable(BlockBackend *blk)
> > > +void blk_io_limits_disable(BlockBackend *blk, Error **errp)
> > >  {
> > > -    assert(blk->public.throttle_group_member.throttle_state);
> > > -    bdrv_drained_begin(blk_bs(blk));
> > > -    throttle_group_unregister_tgm(&blk->public.throttle_group_member=
);
> > > -    bdrv_drained_end(blk_bs(blk));
> > > +    Error *local_err =3D NULL;
> > > +    BlockDriverState *bs, *throttle_node;
> > > +
> > > +    throttle_node =3D blk_get_public(blk)->throttle_node;
> > > +
> > > +    assert(throttle_node && throttle_node->refcnt =3D=3D 1);
> >=20
> > I'm not sure if we can enforce refcnt =3D=3D 1.  What stops other graph
> > manipulation operations from inserting a node above or a BB that uses
> > throttle_node as the root?
>=20
> Is this possible unless the user explicitly does this? I suppose going do=
wn
> the path and removing it from any place is okay. If the throttle_node has
> more than one parent then the result would be invalid anyway. I don't see
> anything in the code doing this (removing a BDS from a BB->leaf path) or
> wrapping it in some way, is that what should be done?

We cannot assume the user will keep their hands off the graph :).

In general, QEMU cannot assume that external interfaces (e.g.
command-line, monitor, VNC, ...) are only called in convenient and safe
ways.

The code must handle all possible situations.  Usually the simplest
solution is to reject requests that would put QEMU into an invalid
state.

> >=20
> > > +
> > > +    /* ref throttle_node's child bs so that it isn't lost when throt=
tle_node is
> > > +     * destroyed */
> > > +    bdrv_ref(bs);
> > > +
> > > +    /* this destroys throttle_node */
> > > +    blk_remove_bs(blk);
> >=20
> > This assumes that throttle_node is the top node.  How is this constraint
> > enforced?
>=20
>=20
> Kevin had said in a previous discussion:
> > The throttle node affects only the backing file now, but not the new
> > top-level node. With manually created filter nodes we may need to
> > provide a way so that the QMP command tells where in the tree the
> > snapshot is actually taken. With automatically created ones, we need to
> > make sure that they always stay on top.
> >=20
> > Similar problems arise when block jobs manipulate the graph. For
> > example, think of a commit block job, which will remove the topmost node
> > from the backing file chain. We don't want it to remove the throttling
> > filter together with the qcow2 node. (Or do we? It might be something
> > that needs to be configurable.)
> >=20
> > We also have several QMP that currently default to working on the
> > topmost image of the chain. Some of them may actually want to work on
> > the topmost node that isn't an automatically inserted filter.
> >=20
> >=20
> > I hope this helps you understand why I keep saying that automatic
> > insertion/removal of filter nodes is tricky and we should do it as
> > little as we possibly can.
>=20
> Yes, this constraint isn't enforced. The automatically inserted filter is
> not a very clean concept. I'll have to think about it a little more, unle=
ss
> there are some ideas.

The block layer has an "op blockers" and permissions API to reject
operations that would violate the graph constraints.  Kevin has recently
worked on it and I hope he can give you some advice in this area.

Stefan

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUli8AAoJEJykq7OBq3PI+LcIAMTzCOuDdkz7NMCnb00RjWeT
WTfj4G/h5nvmD4rqEVwnnZuSRQGuIekO0FGA2xmbzDqrkjbXJpkfkJmn0zPpnNTf
bup6ouEik9h6nthpV/EO71sl2ldv+/dOFfmsf7NVVtbMmszhXdOVu7vcoPCRzw5p
mst2OufHz1OAC4fMjP1ZaOgoCf1EO3QTNH/sYUYTu5RhI8RFjIzy8MEZ9VN9F6YD
bRdhCoPKIJLylZQIUFtX5QBSEH6JhEY1YpNPMEXc75S4Gf2Sa3zgcjnFMLAdsYdI
Neihq76gs9Bc9BlCPEAwKJN36kRMaQX6vqFWySUYrz8ITaMLm7fBGhsASB9vIC8=
=Fr8P
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
