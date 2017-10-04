Received: from eggs.gnu.org ([2001:4830:134:3::10]:37182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzj7N-0001e0-Fv
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzj7M-0004oB-Lo
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:49:41 -0400
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
Date: Wed, 4 Oct 2017 14:49:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170815074513.9055-1-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q5ABp7xF2jnXDSE31CWl3Mjsvq0uOVceL"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] block: add
 block-insert-node QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q5ABp7xF2jnXDSE31CWl3Mjsvq0uOVceL
From: Max Reitz <mreitz@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
Subject: Re: [Qemu-block] [PATCH RFC] block: add block-insert-node QMP command
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
In-Reply-To: <20170815074513.9055-1-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-15 09:45, Manos Pitsidianakis wrote:
> block-insert-node and its pair command block-remove-node provide runtim=
e
> insertion and removal of filter nodes.
>=20
> block-insert-node takes a (parent, child) and (node, child) pair of
> edges and unrefs the (parent, child) BdrvChild relationship and creates=

> a new (parent, node) child with the same BdrvChildRole.
>=20
> This is a different approach than x-blockdev-change which uses the driv=
er
> methods bdrv_add_child() and bdrv_del_child(),

Why? :-)

Can't we reuse x-blockdev-change? As far as I'm concerned, this was one
of its roles, and at least I don't want to have both x-blockdev-change
and these new commands.

I think it would be a good idea just to change bdrv_add_child() and
bdrv_del_child(): If the driver has a bdrv_{add,del}_child() callback,
invoke that.  If it doesn't, then just attach the child.

Of course, it may turn out that x-blockdev-change is lacking something
(e.g. a way to specify as what kind of child a new node is to be
attached).  Then we should either extend it so that it covers what it's
lacking, or replace it completely by these new commands.  In the latter
case, however, they would need to cover the existing use case which is
reconfiguring the quorum driver.  (And that would mean it would have to
invoke bdrv_add_child()/bdrv_del_child() when the driver has them.)

Max


--q5ABp7xF2jnXDSE31CWl3Mjsvq0uOVceL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnU2NcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+x4H/1r+q/w/j5zdkLJjDOmliWnLBWLOYPB+
G8o4S2CGrmgqBIQAduOuEqIEbUuC//uvFriy/EOhlL/U2sQ+OClJA04lylM10gOK
Wp+VPOYwLP0QOVk4noob8xR1KVMPMMrEtyKLd4KzKhU/tgjSVDOjtRYtnoOAnNLp
naXmqKnstmBhzmpQyZw3yvJse8ZaMCr1PLg27TaTOydi9X18sTx6MitO6UzN2AQd
GwhxTsCKDA1D6ZYfrRb2ZxLRcs2ljJasx4mhaTJN2kyKNFiK+9gE/qW9IXoctd4r
yRn1fFugpt77FFROKvwF+d+tm1Idpx1qXNiJaiiPl7ntRPqDBXcXGwQ=
=dQf0
-----END PGP SIGNATURE-----

--q5ABp7xF2jnXDSE31CWl3Mjsvq0uOVceL--
