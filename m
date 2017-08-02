Received: from eggs.gnu.org ([2001:4830:134:3::10]:52288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcqy2-0004Gq-M2
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcqy1-0003Af-Rz
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:33:30 -0400
Date: Wed, 2 Aug 2017 12:33:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170802103319.GB3649@localhost.localdomain>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-4-el13635@mail.ntua.gr>
	<20170802100724.GD5531@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20170802100724.GD5531@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 02.08.2017 um 12:07 hat Stefan Hajnoczi geschrieben:
> On Tue, Aug 01, 2017 at 04:49:07PM +0300, Manos Pitsidianakis wrote:
> > diff --git a/block.c b/block.c
> > index 9ebdba28b0..c6aad25286 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1975,6 +1975,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverStat=
e *child_bs,
> >      child =3D g_new(BdrvChild, 1);
> >      *child =3D (BdrvChild) {
> >          .bs             =3D NULL,
> > +        .parent_bs      =3D NULL,
> >          .name           =3D g_strdup(child_name),
> >          .role           =3D child_role,
> >          .perm           =3D perm,
> > @@ -2009,6 +2010,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *pa=
rent_bs,
> >      if (child =3D=3D NULL) {
> >          return NULL;
> >      }
> > +    child->parent_bs =3D parent_bs;
> > =20
> >      QLIST_INSERT_HEAD(&parent_bs->children, child, next);
> >      return child;
> > @@ -3729,6 +3731,12 @@ const char *bdrv_get_parent_name(const BlockDriv=
erState *bs)
> >                  return name;
> >              }
> >          }
> > +        if (c->parent_bs && c->parent_bs->implicit) {
> > +            name =3D bdrv_get_parent_name(c->parent_bs);
> > +            if (name && *name) {
> > +                return name;
> > +            }
> > +        }
> >      }
> > =20
> >      return NULL;
>=20
> This should be a separate patch.
>=20
> Who updates parent_bs if the parent is changed (e.g.
> bdrv_replace_node())?
>=20
> We already have bs->parents.  Why is BdrvChild->parent_bs needed?

I haven't look at the whole patch yet, but BdrvChild->parent_bs is a
thing that intentionally doesn't exist. A node simply has no business
knowing its parents - which may or may not be BlockDriverStates (the
obvious example where they aren't BDSes are BlockBackends, but block
jobs own some BdrvChild objects, too).

Usually the replacement is a BdrvChildRole callback.

Kevin

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZgapvAAoJEH8JsnLIjy/WQHEP/RsNJRYAc8Flk1C9G0+9Xgkz
DTmhdO0pI8PUO5oCYGtR9GYtoHoDhNXMDC78Sn8/F/BxXle6Z3+NaIl+O0jE5LJA
8o+ca2AfTnnZlM0QkYyOZFb1GtLjTLXfwjx6r7cwCN+hgNv/i47tsOh4Q7CwJEre
mx9aegM004W691m43H6ldOiBV3XzDamy3r6LA6+tY+nGmvmgL7SB9PUM6zZAaDBn
iCn6IUl46go7Lcyj/3K6PDQHLHU9ugI5PQx3wy8+jinnVAWa6Rf/nc8szgjM0N2F
sPKKJFsNKCTU8qPXe1jqSGVA6W+LXlof2nZGHuIAXTeNcZXN2HrvdtDBcoydE761
3vdTbjRJByARuqplt7b7E3vwHMiVVB0uaIR62mBVPkBK2baOnMddvHZTu/EkbeKb
Bf+NFdRIBeqB+ayPerlOynt/e0pOX+hQIzZjsheJdmNt42odKoZw4o5zOHlMtnJ+
eNxGuqGV/iYCp4rDH+v2SZpGj538/xFzgj+J8mOjZZeKO1HjnCoRvSNT8Nx5HK9z
NT3kF8FROB1/nZsZkXYEON47zZWVi/2aWpcm59qQxhNmnCnu6r6zpOgWLMIMGZ1P
rhqfiG0na+uyDBlAXXUPpRZVldklyQN+AW1MaV349ApRP6dz3xRw9RY5hR4OMnM+
W9iattpeFprOhDMcBxYe
=iafr
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
