Received: from eggs.gnu.org ([2001:4830:134:3::10]:58288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebXNZ-0003K3-2e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebXNY-000403-6J
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:58:41 -0500
Date: Tue, 16 Jan 2018 20:58:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180116195830.GB5719@localhost.localdomain>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-2-kwolf@redhat.com>
	<f55f84bb-2f05-1ef8-8198-42208a927764@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <f55f84bb-2f05-1ef8-8198-42208a927764@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 01/10] block/qapi: Introduce
 BlockdevCreateOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.01.2018 um 19:54 hat Eric Blake geschrieben:
> On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> > This creates a BlockdevCreateOptions union type that will contain all of
> > the options for image creation. We'll start out with an empty struct
> > type BlockdevCreateDummy for all drivers.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json | 64 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 64 insertions(+)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index e94a6881b2..1749376c61 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3320,6 +3320,70 @@
> >  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
> > =20
> >  ##
> > +# @BlockdevCreateDummy:
> > +#
> > +# FIXME To be removed. Only there to make the QAPI generator happy whi=
le we're
> > +# adding driver by driver. Leaving out union branches is not allowed.
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'struct': 'BlockdevCreateDummy', 'data': {}}
>=20
> At one point, I had a patch that let you do:
>=20
> 'data': { 'branch': {},
>           ... }
>=20
> for the branches that didn't need to add any additional types to the
> flat union.  Hmm, looks like it is still sitting in my tree, unapplied;
> would it help if I revived that one?

I actually realised that this type won't go away because we have drivers
that don't support image creation. I'm not sure if I should prefer the
conciseness of this syntax or the documentation that comes with a full
type in this specific case. Though generally, I think allowing inline
definitions would be nice.

The infrastructure that I was actually looking for here was a union type
that doesn't accept all enum values, but only some. Maybe some kind of
sub-enum for the discriminator, so that I still get the usual
BLOCKDEV_DRIVER_* constants, but allow only some of them in the context
of the union.

> > +
> > +##
> > +# @BlockdevCreateOptions:
> > +#
> > +# Options for creating an image format on a given node.
> > +#
> > +# @driver           block driver to create the image format
> > +# @node             node to create the image format on
>=20
> Any restrictions we want to document about the node (for example, it
> must not be in use by any backend device at the moment, particularly
> since creation may change the node's format)?

Hm... As long as we can get BLK_PERM_WRITE, we should be good, right?

By the way, I've moved this to the driver-specific options since because
protocol drivers don't need it.

> > +#
> > +# Since: 2.12
> > +##
> > +{ 'union': 'BlockdevCreateOptions',
> > +  'base': {
> > +      'driver':         'BlockdevDriver',
> > +      'node':           'BlockdevRef' },
> > +  'discriminator': 'driver',
> > +  'data': {
> > +      'blkdebug':       'BlockdevCreateDummy',
>=20
> The QAPI itself looks sane for the future patches.

Kevin

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaXllmAAoJEH8JsnLIjy/WtnoP/0p7nfJP96U9+FI13vgeKLQO
VhSFmVC61UukpSdoKR1IvGSvr66S1govmO1E3I1fQkfNPspOWOWgqdg7sJT//U4i
VT5XxWNXwEW/VEj5vNd9JE11DgdJfUfX0QtMIacsrF66a18dPMMxte/e9Us3RhrH
44dd4CefX1W3RFopNzWYOmHxwgXv8pJW1i6lwZnRzmy59NzIjYQzD+daFuXC4lbD
/LqS/zFD1wXqxUaVRrCO9CUQsTbIWQBz9On+Q+IL69ctsI21MIhF/jPWFyBt6kbf
SrQ/TK/0mgvKb6GyS2qdt+ij9sSm4XBh/TrmDlzjfJMuRTEw3+qhf9jod7LJSN3F
vtdAnlGQNYPFaII73b9C36Q4+oh5a31I1t7hi4HGM9DMPu+99Xbee6cMYKnxnzWQ
UhnNqOSoZTy67i2Si7s/LOOKSZHhij+7B/WiL83YJ2MHT9naHKVvIvxBmfwZpVVZ
HDLeGFzbcPJaedTgt+a9dw+4rh67bnF1gfV0Yueqw2mLlWPA+LQ71mcMxJLrZgk6
Q54P2ZaoLgzqxcLC25F8DnhfhVCF8Np+9bZGoaa1K8YQkC8j3qCDhYqr3qqoopHn
tNH+2xrLgNWR3m9rA01vKfb3ftHtZWfqeAOMeoF6bTcKZ/vppnZ9UUpF/ZQEeY53
M5YtuFOVF7XUVtHLyXeQ
=12ny
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
