Received: from eggs.gnu.org ([2001:4830:134:3::10]:36487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddidM-0003qY-H7
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddidL-0006iY-BU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:51:44 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-4-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e47643b2-ff2e-ca38-e666-d89a28f0c46f@redhat.com>
Date: Fri, 4 Aug 2017 14:51:34 -0500
MIME-Version: 1.0
In-Reply-To: <1501597152-25342-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IcpS0gnEwlnTdm8DR2l5WltaX0JS0rHxT"
Subject: Re: [Qemu-devel] [PATCH v4 03/15] block: introduce
 BDRV_REQ_ALLOCATE flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IcpS0gnEwlnTdm8DR2l5WltaX0JS0rHxT
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <e47643b2-ff2e-ca38-e666-d89a28f0c46f@redhat.com>
Subject: Re: [PATCH v4 03/15] block: introduce BDRV_REQ_ALLOCATE flag
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1501597152-25342-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 09:19 AM, Anton Nefedov wrote:
> The flag is supposed to indicate that the region of the disk image has
> to be sufficiently allocated so it reads as zeroes. The call with the f=
lag
> set has to return -ENOTSUP if allocation cannot be done efficiently
> (i.e. without falling back to writing actual buffers)
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  include/block/block.h     |  6 +++++-
>  include/block/block_int.h |  2 +-
>  block/io.c                | 20 +++++++++++++++++---
>  3 files changed, 23 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

You might want the commit message to be a bit more verbose...

>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 7fe0125..828da67 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -65,9 +65,13 @@ typedef enum {
>      BDRV_REQ_NO_SERIALISING     =3D 0x8,
>      BDRV_REQ_FUA                =3D 0x10,
>      BDRV_REQ_WRITE_COMPRESSED   =3D 0x20,
> +    /* The BDRV_REQ_ALLOCATE flag is used to indicate that the driver =
has to
> +     * efficiently allocate the space so it reads as zeroes, or return=
 an error.
> +     */
> +    BDRV_REQ_ALLOCATE           =3D 0x40,
> =20
>      /* Mask of valid flags */
> -    BDRV_REQ_MASK               =3D 0x3f,
> +    BDRV_REQ_MASK               =3D 0x7f,
>  } BdrvRequestFlags;
> =20
>  typedef struct BlockSizes {
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 9b94b32..9b64411 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -585,7 +585,7 @@ struct BlockDriverState {
>      /* Flags honored during pwrite (so far: BDRV_REQ_FUA) */
>      unsigned int supported_write_flags;
>      /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
> -     * BDRV_REQ_MAY_UNMAP) */
> +     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_ALLOCATE) */
>      unsigned int supported_zero_flags;

=2E..in addition to adding the new flag here and documenting its semantic=
s
for drivers...

> =20
>      /* the following member gives a name to every node on the bs graph=
=2E */
> diff --git a/block/io.c b/block/io.c
> index 375fc66..04d495e 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1245,7 +1245,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
>              assert(!bs->supported_zero_flags);
>          }
> =20
> -        if (ret =3D=3D -ENOTSUP) {
> +        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
>              /* Fall back to bounce buffer if write zeroes is unsupport=
ed */
>              BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_ZERO_WR=
ITE;

=2E..you also made sure that anywhere the flag is in use you avoid a slow=

fallback...

> @@ -1639,6 +1645,14 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild=
 *child, int64_t offset,
>  {
>      trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
> =20
> +    assert(!(flags & BDRV_REQ_MAY_UNMAP && flags & BDRV_REQ_ALLOCATE))=
;
> +
> +    if (flags & BDRV_REQ_ALLOCATE &&
> +        !(child->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))
> +    {
> +        return -ENOTSUP;

=2E..as well as providing a sane default to make the flag always trigger
-ENOTSUP until individual drivers implement something in later patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IcpS0gnEwlnTdm8DR2l5WltaX0JS0rHxT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmE0EYACgkQp6FrSiUn
Q2r3vwf/dGOvKDV1/TSc+Xg+XaFUJewBecPlwjmCXGJxFmSIiSQP+hCjFUMRO1S6
Q+m2Pexr/8R75Ts0+uzv0YyeoND6MYXg9ABHvQH1Al2ylrzBwOJTSP5A0Xs/E7nB
efMyXBU1D8mfOk0qIa5vbnID1QUeAN3QAmQ/P0w6vUBoNFD+ZFSkc/m+/kZ2t3U1
88OZW8dJEz1TQZcxxEuSxYfPSWP/935CqckjFwmJyoAj86z6lsfFtVLy2dWCIHR2
WdIeL693E8aTgawQBsGgTQ6M5ZGy8VhLqjHxvumZ2M0CWCGo6QTwbN+N4yx6u8od
f+296sWxH76RVW13u9Rwynm7Uo7AeQ==
=vowC
-----END PGP SIGNATURE-----

--IcpS0gnEwlnTdm8DR2l5WltaX0JS0rHxT--
