Received: from eggs.gnu.org ([2001:4830:134:3::10]:49541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiUL-000707-Aa
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiUG-0006Qb-EZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:51:37 -0400
Date: Wed, 17 Oct 2018 10:51:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017095128.GK22755@stefanha-x1.localdomain>
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline
In-Reply-To: <20181016132018.5054-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] migration/block-dirty-bitmap:
 fix Coverity CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peter.maydell@linaro.org, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 04:20:18PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Theoretically possible that we finish the skipping loop with bs =3D NULL
> and the following code will crash trying to dereference it. Fix that.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  migration/block-dirty-bitmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
> index 477826330c..6de808f95f 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -288,6 +288,10 @@ static int init_dirty_bitmap_migration(void)
>              bs =3D backing_bs(bs);
>          }
> =20
> +        if (!bs || bs->implicit) {
> +            continue;
> +        }
> +
>          for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>               bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
>          {

Previous discussion:
http://qemu.11.n7.nabble.com/PATCH-migration-Appease-coverity-skip-empty-bl=
ock-trees-td582504.html

I've CCed John so he can take a look.

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwYgAAoJEJykq7OBq3PIq+0IAKi2oSNnfSzcF2vR4kvhkS1n
mYLhNgamTcnzElrt80Laq4jpj9U5+/+gfp0Dy1JriPkoEMGT6RsifAojb3g4il+H
kOWyoJrDFRorFQlnYjkecMxu1qe0um+XWBQ8F+X4Q5AYqJyUuQ+Tz6nwzFE0D5my
z5ZU+SEQHDBL5M6HDb6H77OYHmjV1F/tnWxWRHvD3TjvoYw2VTZDtZAtxUfjkblh
4tpqPqVPJ45pr0WKjrGxC7X06u7k7+v6jZvbHN9la5OvGKSo5mwHGNmRA3okuKmr
7XvNdTqacaFQ1iBr/o8CUuyp/wuoin6vfLB7E4teoc/jklQtsc3d34+dysiUXFM=
=9RX1
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--
