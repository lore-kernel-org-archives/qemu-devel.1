Received: from eggs.gnu.org ([2001:4830:134:3::10]:60274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2o3-0003MI-E1
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2o2-0004yV-LT
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:51:11 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9d413d87-33ac-7c41-2944-ec9974cd1e44@redhat.com>
Date: Wed, 1 Feb 2017 22:51:01 +0100
MIME-Version: 1.0
In-Reply-To: <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2dVHbbLbE9OpbdjBKxbkgICxeEmF4OTOP"
Subject: Re: [Qemu-devel] [PATCH 2/2] iov: assert that qiov->size doesn't
 exceed INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2dVHbbLbE9OpbdjBKxbkgICxeEmF4OTOP
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9d413d87-33ac-7c41-2944-ec9974cd1e44@redhat.com>
Subject: Re: [PATCH 2/2] iov: assert that qiov->size doesn't exceed INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
In-Reply-To: <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 17:09, Alberto Garcia wrote:
> The type of qiov->size is size_t but the QEMU I/O code uses int all
> over the place to measure request sizes. Overflows are likely going
> to be detected by any of the many assert(qiov->size =3D=3D nbytes), whe=
re
> nbytes is an int, but let's add proper checks in the QEMUIOVector
> initialization, which is where it belongs.

I'm not entirely convinced that's where it belongs. In my opinion, the
BlockBackend functions should all get uint64_t size parameters and let
blk_check_byte_request() do the rest.

I wouldn't mind too much if blk_check_byte_requests() did assertions
instead of returning -EIO.

But the thing with the I/O vector is that it's not exclusively used for
the block layer. I can see at least hw/9pfs/9p.c and hw/usb/core.c using
it internally.

The assertion probably makes sense even for them, considering that
size_t does not have a constant size. But I'm not entirely sold that the
I/O vector creation is actually the place where the assertions belong.

Max

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  util/iov.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/iov.c b/util/iov.c
> index 74e6ca8ed7..6b5cc9203c 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -283,13 +283,18 @@ void qemu_iovec_init_external(QEMUIOVector *qiov,=
 struct iovec *iov, int niov)
>      qiov->niov =3D niov;
>      qiov->nalloc =3D -1;
>      qiov->size =3D 0;
> -    for (i =3D 0; i < niov; i++)
> +    for (i =3D 0; i < niov; i++) {
> +        assert(iov[i].iov_len <=3D INT_MAX);
> +        assert(qiov->size <=3D INT_MAX - iov[i].iov_len);
>          qiov->size +=3D iov[i].iov_len;
> +    }
>  }
> =20
>  void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len)
>  {
>      assert(qiov->nalloc !=3D -1);
> +    assert(len <=3D INT_MAX);
> +    assert(qiov->size <=3D INT_MAX - len);
> =20
>      if (qiov->niov =3D=3D qiov->nalloc) {
>          qiov->nalloc =3D 2 * qiov->nalloc + 1;
>=20



--2dVHbbLbE9OpbdjBKxbkgICxeEmF4OTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSWEYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+3cIAIwwbCq2mrNvx5gpPlNZ/DJxH4wvxQWM
fAUsPfsRiZt6A6qBVEDdOCgrhB7d0s+C1Z5gJjH5oQqOOPGdiSxx0nZ9lTEj7bHp
1cRPXVYLdeE30T2w5VIugWM+PD9nHhoeymVbAs9fWl4YaxJlW7SuWLacHcrZqz5j
JsNWVsas5kTMbD9Jhn3yJ/RXpjoZNxpasUia4WvIrhkhDmIiXExUgIQENVJrY+mp
8uwGv6xBaU4uO5FIyJRyk4Yp/DT2rIdTUQF4zkkA/GE0AofM/soTY1P7R7tRBJQV
6JxwmaS19hagWgABumWDvothk544bl7sNIPt4pqVcDY+8WsxMr2WFXQ=
=wE0W
-----END PGP SIGNATURE-----

--2dVHbbLbE9OpbdjBKxbkgICxeEmF4OTOP--
