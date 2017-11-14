Received: from eggs.gnu.org ([2001:4830:134:3::10]:58204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcyB-0001xW-Kn
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcyA-00012h-NQ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:17:47 -0500
References: <cover.1510059970.git.jcody@redhat.com>
	<659e4cdba6ef4c651737852777c8c93d27b38040.1510059970.git.jcody@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fe1036ea-5bfe-1c9c-2821-ce62be865a92@redhat.com>
Date: Tue, 14 Nov 2017 16:17:32 +0100
MIME-Version: 1.0
In-Reply-To: <659e4cdba6ef4c651737852777c8c93d27b38040.1510059970.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="avSW4klOWJI9o2LpHgtHOAnLWNcIEFfp9"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block/vhdx.c: Don't blindly update
 the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, den@openvz.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--avSW4klOWJI9o2LpHgtHOAnLWNcIEFfp9
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, den@openvz.org,
 stefanha@redhat.com
Message-ID: <fe1036ea-5bfe-1c9c-2821-ce62be865a92@redhat.com>
Subject: Re: [PATCH v4 1/4] block/vhdx.c: Don't blindly update the header
References: <cover.1510059970.git.jcody@redhat.com>
 <659e4cdba6ef4c651737852777c8c93d27b38040.1510059970.git.jcody@redhat.com>
In-Reply-To: <659e4cdba6ef4c651737852777c8c93d27b38040.1510059970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-07 14:10, Jeff Cody wrote:
> The VHDX specification requires that before user data modification of
> the vhdx image, the VHDX header file and data GUIDs need to be updated.=

> In vhdx_open(), if the image is set to RDWR, we go ahead and update the=

> header.
>=20
> However, just because the image is set to RDWR does not mean we can go
> ahead and write at this point - specifically, if the QEMU run state is
> INMIGRATE, the underlying file BS may be set to inactive via the BDS
> open flag of BDRV_O_INACTIVE.  Attempting to write under this condition=

> will cause an assert in bdrv_co_pwritev().
>=20
> We can alternatively latch the first time the image is written.  And lo=

> and behold, we do just that, via vhdx_user_visible_write() in
> vhdx_co_writev().  This means the call to vhdx_update_headers() in
> vhdx_open() is likely just vestigial, and can be removed.
>=20
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/vhdx.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 7ae4589..9956933 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1008,13 +1008,6 @@ static int vhdx_open(BlockDriverState *bs, QDict=
 *options, int flags,
>          goto fail;
>      }
> =20
> -    if (flags & BDRV_O_RDWR) {
> -        ret =3D vhdx_update_headers(bs, s, false, NULL);

And this doesn't even update the data GUID...

Max

> -        if (ret < 0) {
> -            goto fail;
> -        }
> -    }
> -
>      /* TODO: differencing files */
> =20
>      return 0;
>=20



--avSW4klOWJI9o2LpHgtHOAnLWNcIEFfp9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLCQwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AeaMH/3Toi0euQVe3eYj0KIr1VV2Cyt+9oLWm
q5UxqHqxIuYQ2jrF79JV3sFDnQtbr26UPphfCCqg5k+nmk0f+TgD/E4M2nY5kN83
izdsqy/CUICbDgbd83uUSCZbrUVnUNxLjuSzJwQNpOSkZ3ql79HAp+LfPZo1BRg+
nOKHXM6xAlrALt54fju1JL55phnam8t2brzYlSG/QO2nDoEbFoJ13JJ5Gm+Uf7GB
OdFDH9V+NJqsB0ugf//v0JyCTLu2gRLzrBHuFSYh1w7Hiz8FtKpxp/MSU5Tj6Za9
svMYEWovYxyhDna+BajzFKOx9JPgaP5uMxUMv7kIvNC8tMVan8Grxh0=
=naxq
-----END PGP SIGNATURE-----

--avSW4klOWJI9o2LpHgtHOAnLWNcIEFfp9--
