Received: from eggs.gnu.org ([2001:4830:134:3::10]:56395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtGN4-0006fG-DE
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtGN3-0003op-CB
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:55:10 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-6-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bca76897-ec7d-035e-9473-b304b63f5d7b@redhat.com>
Date: Sat, 16 Sep 2017 18:54:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fOv7uXqRUivpuBJHD4knEv44teVmeNjKt"
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: convert crypto driver to
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fOv7uXqRUivpuBJHD4knEv44teVmeNjKt
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <bca76897-ec7d-035e-9473-b304b63f5d7b@redhat.com>
Subject: Re: [PATCH v3 5/7] block: convert crypto driver to
 bdrv_co_preadv|pwritev
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-6-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-12 13:28, Daniel P. Berrange wrote:
> Make the crypto driver implement the bdrv_co_preadv|pwritev
> callbacks, and also use bdrv_co_preadv|pwritev for I/O
> with the protocol driver beneath.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 104 +++++++++++++++++++++++++++++++------------------=
--------
>  1 file changed, 56 insertions(+), 48 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Some notes below.

> diff --git a/block/crypto.c b/block/crypto.c
> index 49d6d4c058..d004e9cef4 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c

[...]

> @@ -410,37 +414,33 @@ block_crypto_co_readv(BlockDriverState *bs, int64=
_t sector_num,
>          goto cleanup;
>      }
> =20
> -    while (remaining_sectors) {
> -        cur_nr_sectors =3D remaining_sectors;
> +    while (bytes) {
> +        cur_bytes =3D bytes;
> =20
> -        if (cur_nr_sectors > BLOCK_CRYPTO_MAX_SECTORS) {
> -            cur_nr_sectors =3D BLOCK_CRYPTO_MAX_SECTORS;
> +        if (cur_bytes > (BLOCK_CRYPTO_MAX_SECTORS * sector_size)) {
> +            cur_bytes =3D BLOCK_CRYPTO_MAX_SECTORS * sector_size;

It's a bit weird that now the bounce buffer's size is now no longer
fixed at 1 MB but variable depending on the crypto driver's block size.
It also doesn't seem too intentional when looking at the first patch's
commit message...

In any case, that would be an issue in the previous patch, though.  In
general, I'm wondering whether maybe you should squash this patch into
the previous one...  Yes, that would make the for a larger patch, but it
wouldn't leave some not-quite-right state in between where sector_size
is generally assumed to be equal to BDRV_SECTOR_SIZE -- which it is in
practice, but not necessarily in theory.

>          }

Also, just a note: It would be shorter with a MIN(). :-)

(cur_bytes =3D MIN(bytes, BLOCK_CRYPTO_MAX_SECTORS * sector_size))

Max


--fOv7uXqRUivpuBJHD4knEv44teVmeNjKt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9V2ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfAcH/1Dr2MF0AZxSSrDlZ8kb8wMsKTvOwz3A
mLS3knUrW42pPDuFgPU8AGSw913gaXF5WXizTjvgfNM/cKLznlayj8EBWxmBLkdF
T113FIltFhFjj2P3kBn/wYcp8rRVJBUIvxPB5N3jZMApxtFOEd8p/oayd84NJlPx
1jGMdtq8Ev7kwhcJyg2mxv+RXxNm2qqfX8Z1ELSwdt47uwKz35j3b/t16JgpyDdk
pcAynb1R2uhv4laMUue29cihI+8FmCFxc4q85weeok64ZQ7WtTOE+0xe2MBICyHi
ZczVdv2wbyRoAeRW84c+0iUTimYZryWh2jwz7zpDjWTgqWtNDV8cT20=
=3Fi4
-----END PGP SIGNATURE-----

--fOv7uXqRUivpuBJHD4knEv44teVmeNjKt--
