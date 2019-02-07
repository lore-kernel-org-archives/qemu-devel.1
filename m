Received: from eggs.gnu.org ([209.51.188.92]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl1C-000694-5n
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl1B-0004rc-Cq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:51:10 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e9027ad-88ee-ff11-876e-59f2e932ce78@redhat.com>
Date: Thu, 7 Feb 2019 08:50:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zvjFs1gN9npUSvIYKwLAbEI2zcByoNKu3"
Subject: Re: [Qemu-devel] [PATCH v3 01/17] block: enhance QEMUIOVector
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zvjFs1gN9npUSvIYKwLAbEI2zcByoNKu3
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <8e9027ad-88ee-ff11-876e-59f2e932ce78@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/17] block: enhance QEMUIOVector
 structure
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add a possibility of embedded iovec, for cases when we need only one
> local iov.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/iov.h | 64 ++++++++++++++++++++++++++++++++++++++++++++--=

>  1 file changed, 62 insertions(+), 2 deletions(-)
>=20

> +/*
> + * qemu_iovec_init_buf
> + *
> + * Initialize embedded QEMUIOVector.
> + *
> + * Note: "const" is used over @buf pointer to make it simple to pass
> + * const pointers, appearing in read functions. Then this "const" is
> + * casted away by QEMU_IOVEC_INIT_BUF().

s/casted/cast/ (one of those funny irregular English verbs)

> + */
> +static inline void qemu_iovec_init_buf(QEMUIOVector *qiov,
> +                                       const void *buf, size_t len)
> +{
> +    *qiov =3D (QEMUIOVector) QEMU_IOVEC_INIT_BUF(*qiov, buf, len);
> +}
> +
> +static inline void *qemu_iovec_get_buf(QEMUIOVector *qiov)
> +{
> +    /* Only supports embedded iov */
> +    assert(qiov->niov =3D=3D -1 && qiov->iov =3D=3D &(qiov->local_iov)=
);

The inner () aren't needed here.

> +
> +    return qiov->local_iov.iov_base;
> +}
> +

Both minor, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zvjFs1gN9npUSvIYKwLAbEI2zcByoNKu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcRc0ACgkQp6FrSiUn
Q2rNrQf/Qz67Uf26rEIVDc6heUnw5//he9U1wEfgRqVeU6W+J+rv5XVq6kXUtMXG
UFkXjvfrBXUoUcZ2+bH7DaLe/5wIeKLu2fmNtGJ3AUw8+hxYnS9+K2QpTe3+LWIh
J6tqHX4VpMpgM1h+S0QrMlPtshAUxV1zG3LzAb9Dq4mWqVEgCQTk5+Xu7ZQJlZbF
HYCa8RH2gW6SqmDHEbKvJfZiFXiwP+PDFjJ1w7YOgLAmK7XGewQ4rl2pgr6TM/Yn
6+2xTC+yOrRLfmLmG4767dHr2tks49X8jTkVzg1kwBIVT/FDNxtmnfuC7EJWxtd7
kVsf/5R+t1L+Qn7lz2mO5BtFfMhSGg==
=aQkn
-----END PGP SIGNATURE-----

--zvjFs1gN9npUSvIYKwLAbEI2zcByoNKu3--
