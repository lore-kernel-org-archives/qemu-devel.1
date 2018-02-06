Received: from eggs.gnu.org ([2001:4830:134:3::10]:51342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ej5qs-0005Dd-8O
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ej5qr-0006tQ-Az
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:12:10 -0500
Date: Tue, 6 Feb 2018 16:11:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180206161141.GF13343@stefanha-x1.localdomain>
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 05:16:31PM +0300, Anton Nefedov wrote:
> The normal bdrv_co_pwritev() use is either
>   - BDRV_REQ_ZERO_WRITE reset and iovector provided
>   - BDRV_REQ_ZERO_WRITE set and iovector =3D=3D NULL
>=20
> while
>   - the flag reset and iovector =3D=3D NULL is an assertion failure
>     in bdrv_co_do_zero_pwritev()
>   - the flag set and iovector provided is in fact allowed
>     (the flag prevails and zeroes are written)
>=20
> However the alignment logic does not support the latter case so the paddi=
ng
> areas get overwritten with zeroes.

Please include a test case.  Berto mentioned that bdrv_pwrite_zeroes()
hits this issue, that might be one way to test it.

> Solution could be to forbid such case or just use bdrv_co_do_zero_pwritev=
()
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
> @@ -1701,7 +1701,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>       */
>      tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
> =20
> -    if (!qiov) {
> +    if (flags & BDRV_REQ_ZERO_WRITE) {
>          ret =3D bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &re=
q);
>          goto out;
>      }

Looks good.

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaedO9AAoJEJykq7OBq3PImFgH/j302ZkG20Ufsm+U5EP/nEuj
5kZY2fcSCKqbXaaWcBQ/oXN3xldxNFKo8vVmcZJHacWEZ7b97VlwZrUbgdTFqZoJ
ffAztGBErnXEBQIdUnX0xsmZgpwq90h7L74EczBvp5mwWglymMGgI+k1IEoCT1KR
Z0RvV4gTjOj4KMrcDtuEtqiv5Lj1s0ab9gnQjUqhXd9pSjGxc4yc8nvqVprG0wpo
2wmhJYYe/eiXK3MH3y6b7hyNBp2L1CYHuI1CDFo6eY2ECF3XjH1hqf5SQix6wd67
7foI0KVYFPA/jrPwcaFnMPuG69PKoHQLnOyi+QtdWccJvlKqC8ywUlUmKzUEvdg=
=IKml
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
