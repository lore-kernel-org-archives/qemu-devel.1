Received: from eggs.gnu.org ([2001:4830:134:3::10]:54307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFQ8-0005Js-CG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFQ7-0004r5-GZ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:48:48 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6a78f65-3be4-9c14-401c-ea7f1fd5fb9c@redhat.com>
Date: Mon, 29 Jan 2018 20:48:38 +0100
MIME-Version: 1.0
In-Reply-To: <1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qQb1fKhxZ9kt1Dixf6euw24fYzrxyUKiV"
Subject: Re: [Qemu-devel] [PATCH v7 4/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qQb1fKhxZ9kt1Dixf6euw24fYzrxyUKiV
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <e6a78f65-3be4-9c14-401c-ea7f1fd5fb9c@redhat.com>
Subject: Re: [PATCH v7 4/9] block: treat BDRV_REQ_ALLOCATE as serialising
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 18:49, Anton Nefedov wrote:
> The idea is that ALLOCATE requests may overlap with other requests.
> Reuse the existing block layer infrastructure for serialising requests.=

> Use the following approach:
>   - mark ALLOCATE serialising, so subsequent requests to the area wait
>   - ALLOCATE request itself must never wait if another request is in fl=
ight
>     already. Return EAGAIN, let the caller reconsider.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)

The basic principle looks good to me.

> diff --git a/block/io.c b/block/io.c
> index cf2f84c..4b0d34f 100644
> --- a/block/io.c
> +++ b/block/io.c

[...]

> @@ -1717,7 +1728,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child=
,
>          struct iovec head_iov;
> =20
>          mark_request_serialising(&req, align);
> -        wait_serialising_requests(&req);
> +        wait_serialising_requests(&req, false);

What if someone calls bdrv_co_pwritev() with BDRV_REQ_ZERO_WRITE |
BDRV_REQ_ALLOCATE?  Then this should do exactly the same as
bdrv_co_do_zero_pwritev(), which it currently does not -- besides this
serialization, this includes returning -ENOTSUP if there is a head or
tail to write.

Max

> =20
>          head_buf =3D qemu_blockalign(bs, align);
>          head_iov =3D (struct iovec) {
> @@ -1758,7 +1769,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child=
,
>          bool waited;
> =20
>          mark_request_serialising(&req, align);
> -        waited =3D wait_serialising_requests(&req);
> +        waited =3D wait_serialising_requests(&req, false);
>          assert(!waited || !use_local_qiov);
> =20
>          tail_buf =3D qemu_blockalign(bs, align);
>=20



--qQb1fKhxZ9kt1Dixf6euw24fYzrxyUKiV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvepYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABXUIAIJfVtOC7bRtNoKXVyP6QZucwR20WV94
uhRLCRtebXTb/icsAiQcLYNx62MAdn/UE8CzgzSVSSUHxiedQs5otT0w49J2E127
2sfJA2o0bRCovIyICkcHlCtHYYPKDKOITFsIj7VGgf5+SJeWBsYiniVVMHo7NSYb
uEKRK972Juhbxn40Sn34uMxP8ota1Wdft9txkOaEIxliMAr+mMLS5HZ/ekZNQHla
tUF3Ob05Yx8N3W4oR+kQliJ2auClKGKkvkaG3gT5VTi5OednECBdUyRiCdrT6K89
iTS/DKhlTeefG0TFxhz5jziRMcEnyIJsKOhGlzcu98NOP1nlC0OI/20=
=Dbxs
-----END PGP SIGNATURE-----

--qQb1fKhxZ9kt1Dixf6euw24fYzrxyUKiV--
