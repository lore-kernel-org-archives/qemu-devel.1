Received: from eggs.gnu.org ([2001:4830:134:3::10]:50391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehFzH-00063t-LS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehFzB-0007Oi-Nb
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:37:15 -0500
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ad2256a-01cd-6c9b-9a34-663aa077f26f@redhat.com>
Date: Thu, 1 Feb 2018 08:36:48 -0600
MIME-Version: 1.0
In-Reply-To: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CKeCmS2RW2fBVgUf0Z0yKgP0iERDitBbF"
Subject: Re: [Qemu-devel] [PATCH] block: fix write with zero flag set and
 iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CKeCmS2RW2fBVgUf0Z0yKgP0iERDitBbF
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Message-ID: <3ad2256a-01cd-6c9b-9a34-663aa077f26f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: fix write with zero flag set and
 iovector provided
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2018 08:16 AM, Anton Nefedov wrote:
> The normal bdrv_co_pwritev() use is either
>   - BDRV_REQ_ZERO_WRITE reset and iovector provided

s/reset/clear/

>   - BDRV_REQ_ZERO_WRITE set and iovector =3D=3D NULL
>=20
> while
>   - the flag reset and iovector =3D=3D NULL is an assertion failure

again

>     in bdrv_co_do_zero_pwritev()
>   - the flag set and iovector provided is in fact allowed
>     (the flag prevails and zeroes are written)
>=20
> However the alignment logic does not support the latter case so the pad=
ding
> areas get overwritten with zeroes.
>=20
> Solution could be to forbid such case or just use bdrv_co_do_zero_pwrit=
ev()
> alignment for it which also makes the code a bit more obvious anyway.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 7ea4023..cf63fd0 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1701,7 +1701,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child=
,
>       */
>      tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE)=
;
> =20
> -    if (!qiov) {
> +    if (flags & BDRV_REQ_ZERO_WRITE) {
>          ret =3D bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &=
req);

So now, the flag rules, but we assert that !qiov (so it would only break
a caller that passed the flag but used qiov, which you argued shouldn't
exist).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CKeCmS2RW2fBVgUf0Z0yKgP0iERDitBbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpzJgAACgkQp6FrSiUn
Q2pNjAf/eN8J/8Y1W9jSE9d8z+amyStEsABz4NEcIuOpQ+IgJdQGxrF2lY+TF+6l
fvfhwpEw5HXF4M2xG1ykcXt3UxoQoqnFqsElub+/Klp1yxVC+Reuz++Ilu781uJ1
SgND04qbpQ+1Gk+FE66yB3CR3bdztJhg9MIM2GBQEe2BscInM2g4IzWtA0/PHQH/
WUuleFeIyQWL+8PCcwGyHCoRrXZErzedhZZ9rn+3yi3VTzTkkxHOVjLmvN+5mZM/
k1Rz9wlwQQAw8RE5LR2upX3Kw4hesQ9PGRcUopNhRKvV/KnRErxuJfTcXX4sJP4S
Bq6wyjH0STbUd1m1WQTxh8TXCoxykA==
=Q0G6
-----END PGP SIGNATURE-----

--CKeCmS2RW2fBVgUf0Z0yKgP0iERDitBbF--
