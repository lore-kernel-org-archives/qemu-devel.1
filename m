Received: from eggs.gnu.org ([209.51.188.92]:52717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Vkl-00076E-Mk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Vkk-0001FZ-RG
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:34:31 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfc7c39d-78df-b576-6e24-96846bb31193@redhat.com>
Date: Wed, 6 Mar 2019 06:34:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190305234337.18353-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1hbVabPLSGEvOyWjmUCPeEAIIOqcSntZM"
Subject: Re: [Qemu-devel] [PATCH 1/5] block/qcow2-bitmap: Skip length check
 in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1hbVabPLSGEvOyWjmUCPeEAIIOqcSntZM
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <dfc7c39d-78df-b576-6e24-96846bb31193@redhat.com>
Subject: Re: [PATCH 1/5] block/qcow2-bitmap: Skip length check in some cases
References: <20190305234337.18353-1-jsnow@redhat.com>
 <20190305234337.18353-2-jsnow@redhat.com>
In-Reply-To: <20190305234337.18353-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/5/19 5:43 PM, John Snow wrote:
> If we were to allow resizes, the length check that happens when we load=

> bitmap headers from disk when we read or store bitmaps would begin to
> fail:
>=20
> Imagine the circumstance where we've resized bitmaps in memory, but the=
y still
> have the old values on-disk. The lengths will no longer match bdrv_getl=
ength,
> so we must allow this check to be skipped when flushing bitmaps to disk=
=2E
>=20
> Limit this to when we are about to overwrite the headers: we will verif=
y the
> outgoing headers, but we will skip verifying the known stale headers.

No-op until we actually do allow resizes later in the series, but makes
sense.

>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2-bitmap.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index c3b210ede1..d02730004a 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -435,7 +435,8 @@ static inline Qcow2BitmapDirEntry *next_dir_entry(Q=
cow2BitmapDirEntry *entry)
>      return (Qcow2BitmapDirEntry *)((uint8_t *)entry + dir_entry_size(e=
ntry));
>  }
> =20
> -static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *=
entry)
> +static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *=
entry,
> +                           bool allow_resize)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t phys_bitmap_bytes;
> @@ -462,8 +463,14 @@ static int check_dir_entry(BlockDriverState *bs, Q=
cow2BitmapDirEntry *entry)
>          return len;

Someday, it would be nice to plumb Error* through this function, so that
you can give distinct reasons for failure, rather than lumping all
failures into the nebulous "doesn't meet the constraints" because we
lost context when slamming multiple errors into a single -EINVAL. But
that's a separate patch series.

>      }
> =20
> -    fail =3D (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
> -           (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits)=
);
> +    if (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) {
> +        return -EINVAL;
> +    }
> +
> +    if (!allow_resize &&
> +        (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits))) =
{
> +        return -EINVAL;
> +    }
> =20
>      return fail ? -EINVAL : 0;

Dead conditional - with your refactoring, this line is only reached when
fail =3D=3D false.

With it changed to 'return 0',
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--1hbVabPLSGEvOyWjmUCPeEAIIOqcSntZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/vlAACgkQp6FrSiUn
Q2r0nwf9HLHzgfBB9NmZ65vh0jCZarECEmY0XeJ7Q0AabzuGL1d2T2GRXW8k5+zD
/y4jj9ZUqSewQtm80zwK+KactVQDySiave2XOaCXrTjBeuOLW8Gh52gMwsP4L7up
S66s0h3qToxPM5CaEi0+ap4LHPtI6J2bjc/P5b2PhVU3Kz8zVJ0P9pHW4Fxwft79
jDNdfQR2ndy1Q8/G2SnMWhxunWeaa6E9LYetxr6wVG+dfvkOqafpMl66BkCWKshR
bu4ryPIlG8vfVpgwmw1rqzUCZfteNwOYKFDzio7nPl9h1dRVPj6gzRVrk0DqSeqp
G8gWzp9zpeWkp4YOjn2zjsvCgGVjNQ==
=65Dg
-----END PGP SIGNATURE-----

--1hbVabPLSGEvOyWjmUCPeEAIIOqcSntZM--
