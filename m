Received: from eggs.gnu.org ([209.51.188.92]:41448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goK81-0003lE-Vv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goK81-0007RX-4r
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:32:01 -0500
Date: Tue, 29 Jan 2019 11:31:55 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190129033155.GD3264@stefanha-x1.localdomain>
References: <20190125164601.130556-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
In-Reply-To: <20190125164601.130556-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 07:46:01PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all.
>=20
> What about such a simple helper for a very often patter around
> qemu_iovec_init_external ?

Sounds good, qemu_iovec_init() has 55 references vs
qemu_iovec_init_external() with 51.  It's worth making
qemu_iovec_init_external() nicer to use.

> If we like it, I'll update other callers of qemu_iovec_init_external.
>=20
> Possible interface change would be
> LOCAL_QIOV(lc, buf, len);
> instead of=20
> LocalQiov lc =3D LOCAL_QIOV(lc, buf, len);
>=20
> or, may be, someone has a better idea?

Bike-shedding territory, but I prefer LocalQiov lc =3D LOCAL_QIOV(lc, buf,
len) because it reveals the type.  This makes the code easier to read
than just LOCAL_QIOV(lc, buf, len) by itself - the reader is forced to
look up the macro definition to figure out what magic happens.

> diff --git a/block/io.c b/block/io.c
> index bd9d688f8b..c7d7b199c1 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -949,18 +949,13 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, Q=
EMUIOVector *qiov)
> =20
>  int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
>  {
> -    QEMUIOVector qiov;
> -    struct iovec iov =3D {
> -        .iov_base =3D (void *)buf,
> -        .iov_len =3D bytes,
> -    };
> +    LocalQiov lq =3D LOCAL_QIOV(lq, buf, bytes);
> =20
>      if (bytes < 0) {
>          return -EINVAL;
>      }
> =20
> -    qemu_iovec_init_external(&qiov, &iov, 1);
> -    return bdrv_preadv(child, offset, &qiov);
> +    return bdrv_preadv(child, offset, &lq.qiov);

I think it's unfortunate that LocalQiov is necessary since the caller
only needs the qiov.  Can we afford to embed the struct iovec into
QEMUIOVector?

That way callers don't need a separate LocalQiov type:

  QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
  ...
  return bdrv_preadv(child, offset, &qiov);

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT8krAAoJEJykq7OBq3PIcxoIAIph6+Nf+kQcGPco2jCJuRxa
/0u0tJ8fOCBONT72YZSL9+OIE5HttUf/B1HAYixCW9pcQVXOXA69lgw30ZQqmt3s
rF17UoNwNfvFnn+N7+CvKRxiOisj7TGGryfgg1YyAZ2fAobr9AGsO3wWXbaPXY+A
k9WpAe5RcVD0epORJ2hm6BMaLnhG4k46GYDc14KMCOfhPACQxJ1jljkfkabRjP/c
lysLYD6zOlALUiGWZzlxgbmrCGaHOby5RJ1dAocf4KZ/9n/zgdGX2XHo2JtQS7AC
dgN8KpaXLAIkcotxgYXYnunR9iOPdpFYckL7yR9FDFkzkOiSkJQHev/mEh9LT6E=
=qbYg
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
