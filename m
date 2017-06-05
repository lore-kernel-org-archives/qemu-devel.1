Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHtB2-0000dk-4e
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHtAx-0008OR-VK
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHtAx-0008My-Mw
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:40:11 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-6-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62ffb8b1-c1d8-309b-1f75-ab7d303d1263@redhat.com>
Date: Mon, 5 Jun 2017 09:40:06 -0500
MIME-Version: 1.0
In-Reply-To: <1496330073-51338-6-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tJm1SWKNXxXkiVx6ar43BKeCfESFaKl1e"
Subject: Re: [Qemu-devel] [PATCH v2 05/15] qcow2: do not COW the empty areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tJm1SWKNXxXkiVx6ar43BKeCfESFaKl1e
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <62ffb8b1-c1d8-309b-1f75-ab7d303d1263@redhat.com>
Subject: Re: [PATCH v2 05/15] qcow2: do not COW the empty areas
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1496330073-51338-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-6-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 10:14 AM, Anton Nefedov wrote:
> If COW area of the newly allocated cluster is zeroes, there is no reaso=
n
> to write zero sectors in perform_cow() again now as whole clusters are
> zeroed out in single chunks by handle_alloc_space().
>=20
> Introduce QCowL2Meta field "reduced", since the existing fields
> (offset and nb_bytes) still has to keep other write requests from
> simultaneous writing in the area
>=20
> iotest 060:
> write to the discarded cluster does not trigger COW anymore.
> so, break on write_aio event instead, will work for the test
> (but write won't fail anymore, so update reference output)
>=20
> iotest 066:
> cluster-alignment areas that were not really COWed are now detected
> as zeroes, hence the initial write has to be exactly the same size for
> the maps to match

> +++ b/block/qcow2.c
> @@ -64,6 +64,9 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
> =20
> +static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
> +                            uint32_t count);
> +

I've already posted patches that redo this function to be byte-based;
I'm not sure which of our series will land first, but it is something to
keep in mind.

I'm also not a big fan of forward declarations of leaf static functions
(they are essential for mutually recursive functions, but when there is
no recursion, the better solution is to just hoist the implementation of
the function to occur where it is first needed, rather than using a
forward declaration).

> @@ -1588,8 +1611,13 @@ static void handle_alloc_space(BlockDriverState =
*bs, QCowL2Meta *l2meta)
>          }
> =20
>          /* try to alloc host space in one chunk for better locality */=

> -        bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset, bytes,
> -                              BDRV_REQ_ALLOCATE);
> +        ret =3D bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset, bytes=
,
> +                                    BDRV_REQ_ALLOCATE);
> +        if (ret !=3D 0) {
> +            continue;
> +        }
> +
> +        handle_cow_reduce(bs, m);

Does this look any better as:

if (bdrv_co_pwrite_zeroes(...) =3D=3D 0) {
    handle_cow_reduce(bs, m);
}

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tJm1SWKNXxXkiVx6ar43BKeCfESFaKl1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNW1GAAoJEKeha0olJ0NqNnUIAIqCBRV4yOiCqhVdgUYt1lmI
10WoXazrCRaFE9y6mibzrH7z/wKjkODkgmSwkPrOFh5DyXe55BwiPJ27Is0p2UeE
ZCfxWvPY71VuY46G07PcoobQw0LcQ3FfvrYrrZhEHGZL20+zxwM9/iI9g4upuqfq
OJi9Uj4zXAic+CcBblpbDvStZwp1fydCdTzJff5zoqwFMDK9ifL44W7iAKa2RkqU
tKH5QLfn5tjw27E2Tgx/2AIU+nkNHobUDD6PWJLLQEIMME5BmyIf3HCX7xr2vaMz
XrNX2OQYSK3f6DRzhDDC2a/Qc79iFQG6m/8iR0qA4rByfjuVqReQt5MiWsJqF9Q=
=cRUc
-----END PGP SIGNATURE-----

--tJm1SWKNXxXkiVx6ar43BKeCfESFaKl1e--
