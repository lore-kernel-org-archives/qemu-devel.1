Received: from eggs.gnu.org ([2001:4830:134:3::10]:53257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZmh-0000vM-LU
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZmg-0000t4-Oi
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:05:11 -0400
Date: Fri, 3 Nov 2017 11:05:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103110500.GM5078@stefanha-x1.localdomain>
References: <cover.1509368614.git.jcody@redhat.com>
	<e3abcb61ba8cdc2bb236368ab14a9037cbe7729b.1509368614.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DheUW4aQn8WJk6WR"
Content-Disposition: inline
In-Reply-To: <e3abcb61ba8cdc2bb236368ab14a9037cbe7729b.1509368614.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/3] block/parallals: Do
 not update header or truncate image when INMIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org


--DheUW4aQn8WJk6WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 02:10:27PM +0100, Jeff Cody wrote:
> If we write or modify the image file while the QEMU run state is
> INMIGRATE, then the BDRV_O_INACTIVE BDS flag is set.  This will cause
> an assert, since the image is marked inactive.  Make sure we obey this
> flag.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/parallels.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/parallels.c b/block/parallels.c
> index 2b6c6e5709..7b7a3efa1d 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -708,7 +708,7 @@ static int parallels_open(BlockDriverState *bs, QDict=
 *options, int flags,
>          s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
>      }
> =20
> -    if (flags & BDRV_O_RDWR) {
> +    if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
>          s->header->inuse =3D cpu_to_le32(HEADER_INUSE_MAGIC);
>          ret =3D parallels_update_header(bs);
>          if (ret < 0) {

Where do we ensure that HEADER_INUSE_MAGIC is set on the destination?

--DheUW4aQn8WJk6WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/E1cAAoJEJykq7OBq3PIZucH/RBBQfvHe2zdLZhab95n8H1U
5F7BzuaYejFvnedyvCfCDF7tDKnpjERCusvWyPswmNfHpQYS32nGSGuCAheooTsm
LLiJNCKggNgBgCg636wmuYShNUQeHfdhu6Zork0FbJM7iVIgvOT3z/pn4Z+1A1DV
ovXBEB2aZPfoFy3JVC0U+EJ5Hw2E7Diia2C9gt4eOAaQO4LcBlkodbC4Gm3P9fD9
lLb0V2SvmZT0I+uwqk4AL5/pEoE8yKgvkrLR/hRaHBiXVWZXrivNQUKx+hnc2W7Y
RlJz629vn7YiQCrusHA32BHgTl0BdaOiItGPrEaKJcCOgTohRdbvgKcGjFZKNWE=
=1mA4
-----END PGP SIGNATURE-----

--DheUW4aQn8WJk6WR--
