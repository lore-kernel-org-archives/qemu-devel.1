Received: from eggs.gnu.org ([209.51.188.92]:47271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlLu-00053e-04
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlLs-0003uP-Rn
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:12:33 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd1e8062-ca36-36b9-7bfd-008ae3e01b00@redhat.com>
Date: Thu, 7 Feb 2019 09:11:50 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JL7z47Nv01L4jJKTUFYxn9ENYX72JKBqh"
Subject: Re: [Qemu-devel] [PATCH v3 07/17] block/parallels: use
 QEMU_IOVEC_INIT_BUF
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
--JL7z47Nv01L4jJKTUFYxn9ENYX72JKBqh
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <dd1e8062-ca36-36b9-7bfd-008ae3e01b00@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/17] block/parallels: use
 QEMU_IOVEC_INIT_BUF
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new QEMU_IOVEC_INIT_BUF() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/parallels.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/block/parallels.c b/block/parallels.c
> index cc9445879d..6d24ee6d8e 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -220,23 +220,20 @@ static int64_t allocate_clusters(BlockDriverState=
 *bs, int64_t sector_num,
>      if (bs->backing) {
>          int64_t nb_cow_sectors =3D to_allocate * s->tracks;
>          int64_t nb_cow_bytes =3D nb_cow_sectors << BDRV_SECTOR_BITS;
> -        QEMUIOVector qiov;
> -        struct iovec iov =3D {
> -            .iov_len =3D nb_cow_bytes,
> -            .iov_base =3D qemu_blockalign(bs, nb_cow_bytes)
> -        };
> -        qemu_iovec_init_external(&qiov, &iov, 1);
> +        QEMUIOVector qiov =3D
> +            QEMU_IOVEC_INIT_BUF(qiov, qemu_blockalign(bs, nb_cow_bytes=
),
> +                                nb_cow_bytes);

I might have done:

char *buf =3D qemu_blockalign(bs, nb_cow_bytes);
QEMUIOVector qiov =3D QEME_IOVEC_INIT_BUF(qiov, buf, nb_cow_bytes);

> =20
>          ret =3D bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SEC=
TOR_SIZE,
>                               nb_cow_bytes, &qiov, 0);
>          if (ret < 0) {
> -            qemu_vfree(iov.iov_base);
> +            qemu_vfree(qemu_iovec_get_buf(&qiov));

and then qemu_vfree(buf);

Depending on how much else in the series needs qemu_iovec_get_buf(),
that function may not actually be needed in patch 1.

But since my proposed changes are aesthetic rather than semantic, and
yours works as written, I'm also okay giving:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JL7z47Nv01L4jJKTUFYxn9ENYX72JKBqh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcSrYACgkQp6FrSiUn
Q2ov0ggAmjpDIc6+W+VOj6QAdLxYkER5X02k7AF3F4b86L7xkO3SkvMhpXqb2RKc
nr3luloWBxYh5Pm5EjhO4b9IV20YN/2I6SCsWfLYaITCh6KG9Yf+OVrVrFJnd2DS
9PKrhFuZkoUTHCYKYFkDbMUGAmzfANj7fveEKebLCCQc2awHFPh5o7VieGbtH2KL
UGsG6ogeEY9sa5S8k8cHwvg1MZNV8pZXSQsdhEJdPLujjqwZlgmQSm2P+KDnSyUS
bFVdZebE0Pa2ptMnTpWR3julTrP1TtC7YHAyBP7VJBApO0u9uGu1kyvgF/V8Bt9q
U6wP/HRuARVoaDyKkZQCJiATSTqp6g==
=u/r2
-----END PGP SIGNATURE-----

--JL7z47Nv01L4jJKTUFYxn9ENYX72JKBqh--
