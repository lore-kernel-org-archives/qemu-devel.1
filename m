Received: from eggs.gnu.org ([2001:4830:134:3::10]:60834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciKUJ-0004WB-79
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciKUI-0005T9-6o
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:33:11 -0500
Date: Mon, 27 Feb 2017 13:33:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170227123302.GD6356@noname.redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-19-git-send-email-kwolf@redhat.com>
	<3a201ea1-81fe-e4f3-7474-364b7cc8f091@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <3a201ea1-81fe-e4f3-7474-364b7cc8f091@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/54] block: Default .bdrv_child_perm()
 for format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.02.2017 um 12:57 hat Max Reitz geschrieben:
> On 21.02.2017 15:58, Kevin Wolf wrote:
> > Almost all format drivers have the same characteristics as far as
> > permissions are concerned: They have one or more children for storing
> > their own data and, more importantly, metadata (can be written to and
> > grow even without external write requests, must be protected against
> > other writers and present consistent data) and optionally a backing file
> > (this is just data, so like for a filter, it only depends on what the
> > parent nodes need).
> >=20
> > This provides a default implementation that can be shared by most of
> > our format drivers.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c                   | 42 +++++++++++++++++++++++++++++++++++++++=
+++
> >  include/block/block_int.h |  8 ++++++++
> >  2 files changed, 50 insertions(+)
> >=20
> > diff --git a/block.c b/block.c
> > index 523cbd3..f2e7178 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1554,6 +1554,48 @@ void bdrv_filter_default_perms(BlockDriverState =
*bs, BdrvChild *c,
> >                 (c->shared_perm & DEFAULT_PERM_UNCHANGED);
> >  }
> > =20
> > +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> > +                               const BdrvChildRole *role,
> > +                               uint64_t perm, uint64_t shared,
> > +                               uint64_t *nperm, uint64_t *nshared)
> > +{
> > +    bool backing =3D (role =3D=3D &child_backing);
> > +    assert(role =3D=3D &child_backing || role =3D=3D &child_file);
> > +
> > +    if (!backing) {
> > +        /* Apart from the modifications below, the same permissions are
> > +         * forwarded and left alone as for filters */
> > +        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, &s=
hared);
> > +
> > +        /* Format drivers may touch metadata even if the guest doesn't=
 write */
> > +        if (!bdrv_is_read_only(bs)) {
> > +            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
> > +        }
> > +
> > +        /* bs->file always needs to be consistent because of the metad=
ata. We
> > +         * can never allow other users to resize or write to it. */
> > +        perm |=3D BLK_PERM_CONSISTENT_READ;
> > +        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> > +    } else {
> > +        /* We want consistent read from backing files if the parent ne=
eds it.
> > +         * No other operations are performed on backing files. */
> > +        perm &=3D BLK_PERM_CONSISTENT_READ;
> > +
> > +        /* If the parent can deal with changing data, we're okay with a
> > +         * writable and resizable backing file. */
> > +        if (shared & BLK_PERM_WRITE) {
> > +            shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
>=20
> Wouldn't this break CONSISTENT_READ?

WRITE (even for multiple users) and CONSISTENT_READ aren't mutually
exclusive. I was afraid that I didn't define CONSISTENT_READ right, but
it appears that the definition is fine:

 * A user that has the "permission" of consistent reads is guaranteed that
 * their view of the contents of the block device is complete and
 * self-consistent, representing the contents of a disk at a specific
 * point.

Kevin

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYtBx+AAoJEH8JsnLIjy/WCyUQAIutUR4dfPPIbFLVnMYYkSjY
PnpHuEex3B3CfLzspdxAwm596E/0WUKVtqmZ4BOslmTiCsqZShk6kEoIIysvidux
ZljKqiNveokKHsdfl5QklIJqpU45mBwW7Q/hoyZQmF5njc0RqtmyAWbS1PzRSCX/
OLFNZVzW9H+4E0fUUYJ2V2jYg/dBNhpphij0H1dmxh8bw7evzNUIG3tydzkk+H5w
TMyTvFMAiiuLSlqXPeC4ZcpSf/2r1RoBOu3RJmLSoDFByg0S9En1T1SPyFv0xTj3
Z1F8IgXjT+TZiSmkfzBuuqY7k7rsrYx9yvmsNZ638Lg04RLJCI2VBUU5aVc+Lv5d
S+OzbFbbQhnP+btlV/BZpt7LWZ0kfLipjS4XADCSdpm8RHYPk8OdzmVOTmzQPNyl
wUU8/w780UNo6bdSS1IgaWVSNKqzA3K7vuxVq4IOnOOLVHVycI8tzOHWhsBx8X4u
IDbsss2iLimTnHS3rN2byZEV2PBrYN2+ujOqMF3Skzo3rtQ0dO51SwphOKWZDPoC
gGxAgbf9zl9vUJnqS6sLua3Ib+gzyg4alkIXK4QJmIz9isNalGbmXlwPcHCba7Tm
YgSM2ciGQVZb479pnaPh9eZRA0x71MNI5nCxR6Xs4ISFXcJ4oVRS6pWKd5AMiqd3
dxvQz4IV8Wd2xX+8OCZ7
=qnO7
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
