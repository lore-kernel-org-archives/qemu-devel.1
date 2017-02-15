Received: from eggs.gnu.org ([2001:4830:134:3::10]:34931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce3bW-0000Hi-Ua
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce3bW-0006vA-0F
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:42:59 -0500
Date: Wed, 15 Feb 2017 18:42:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215174250.GL4935@noname.redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-12-git-send-email-kwolf@redhat.com>
	<df098565-f960-4941-d1d6-46f542f813d3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <df098565-f960-4941-d1d6-46f542f813d3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 11/41] vvfat: Implement
 .bdrv_child_perm()
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


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.02.2017 um 18:30 hat Max Reitz geschrieben:
> On 13.02.2017 18:22, Kevin Wolf wrote:
> > vvfat is the last remaining driver that can have children, but doesn't
> > implement .bdrv_child_perm() yet. The default handlers aren't suitable
> > here, so let's implement a very simple driver-specific one that protects
> > the internal child from being used by other users as good as our
> > permissions permit.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/vvfat.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/block/vvfat.c b/block/vvfat.c
> > index c6bf67e..7246432 100644
> > --- a/block/vvfat.c
> > +++ b/block/vvfat.c
> > @@ -3052,6 +3052,18 @@ err:
> >      return ret;
> >  }
> > =20
> > +static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
> > +                             const BdrvChildRole *role,
> > +                             uint64_t perm, uint64_t shared,
> > +                             uint64_t *nperm, uint64_t *nshared)
> > +{
> > +    assert(role =3D=3D &child_vvfat_qcow);
> > +
> > +    /* This is a private node, nobody should try to attach to it */
> > +    *nperm =3D BLK_PERM_WRITE;
> > +    *nshared =3D 0;
>=20
> 0 for shared is probably enough to ward every other access off, but
> maybe we should still pro forma request consistent read access...?

Makes sense, yes.

But you missed the real bug I hid there for you:

qemu-system-x86_64: block.c:1530: bdrv_check_update_perm: Assertion
`new_shared_perm & BLK_PERM_WRITE_UNCHANGED' failed.

Kevin

> Max
>=20
> > +}
> > +
> >  static void vvfat_close(BlockDriverState *bs)
> >  {
> >      BDRVVVFATState *s =3D bs->opaque;
> > @@ -3077,6 +3089,7 @@ static BlockDriver bdrv_vvfat =3D {
> >      .bdrv_file_open         =3D vvfat_open,
> >      .bdrv_refresh_limits    =3D vvfat_refresh_limits,
> >      .bdrv_close             =3D vvfat_close,
> > +    .bdrv_child_perm        =3D vvfat_child_perm,
> > =20
> >      .bdrv_co_preadv         =3D vvfat_co_preadv,
> >      .bdrv_co_pwritev        =3D vvfat_co_pwritev,
> >=20
>=20
>=20




--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYpJMaAAoJEH8JsnLIjy/WnawP/RDpwlXvn1Lpn42zPqmiomko
tiRXEN92LYzEWcvV618kuWmxy9oZx9NgQKuNFGg2e2ra8EPhpZQ9v9dzi7KT17NW
ccynmegm6q03CmbdKBf3Ih+SXWJ77vvemd8WoFr+NTvydFlnCUJOFCGLq5SOgB6s
NXZx/RuUHxp7vlzS8fUZdB48Iyk9/8utJshOI22cyi/pupoCEf8UFBH22+ajxYs7
PTPCLzuafkaeVjOyVQ+cKc5/Uc8NbgZ3ITMbt03UpAlk3BV5+Llwl4V8F18NPBNc
Ahgi4i3epF5NRcZJ3lccqci15WwQJbteDLsO2H4bke1Cx33i3cuOfq8xqz1WXvuR
tJ38Kl4sGoZCFnkQRyrIgFVBEW0vzdUnELaHIxsnxxUj82exetEIqd4HMDDSKHd7
nbgBa2avrj/RDyJq0mxIVQDYJHoBh+SGIJTFy2mQiEVeD8piN+Njrsw594p8ATEx
JOmRLoSjTjkccil+5f+xHKSH918P/3yQ05/Kfc2EuyWwz+CuOZO3GrcspqlLITns
Eqm/gu3EQQP0g2Br/hTwYzrlr0lgzpPlXANVcNkvbpHKY9qFq8SEJD5u0xrcor3A
iU40Qot7d9lXuPb4enwWhMfQghRd27TztXL923LhBSj9NWH97Gdi2UNytIHcbtuE
fZbrXXVtSeNBU7hw9oSY
=U7Ea
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
