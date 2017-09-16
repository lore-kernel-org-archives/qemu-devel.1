Received: from eggs.gnu.org ([2001:4830:134:3::10]:47933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFty-0002t4-Em
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFtx-0005jw-CE
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:06 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c2731b1a-419e-d6cf-48a8-97755651bdf2@redhat.com>
Date: Sat, 16 Sep 2017 18:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FVNCHNi7jl1c9Kr1KdeImtMxPHOEG4USj"
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: don't use constant 512 as
 sector size in crypto driver
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
--FVNCHNi7jl1c9Kr1KdeImtMxPHOEG4USj
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <c2731b1a-419e-d6cf-48a8-97755651bdf2@redhat.com>
Subject: Re: [PATCH v3 4/7] block: don't use constant 512 as sector size in
 crypto driver
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-5-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-12 13:28, Daniel P. Berrange wrote:
> Use the qcrypto_block_get_sector_size() value in the block
> crypto driver instead of hardcoding 512 as the sector size.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index d68cbac2ac..49d6d4c058 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -392,8 +392,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t=
 sector_num,
>      uint8_t *cipher_data =3D NULL;
>      QEMUIOVector hd_qiov;
>      int ret =3D 0;
> +    uint64_t sector_size =3D qcrypto_block_get_sector_size(crypto->blo=
ck);
>      uint64_t payload_offset =3D
> -        qcrypto_block_get_payload_offset(crypto->block) / 512;
> +        qcrypto_block_get_payload_offset(crypto->block) / sector_size;=

>      assert(payload_offset < (INT64_MAX / 512));
> =20
>      qemu_iovec_init(&hd_qiov, qiov->niov);
> @@ -401,9 +402,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t=
 sector_num,
>      /* Bounce buffer because we don't wish to expose cipher text
>       * in qiov which points to guest memory.
>       */
> -    cipher_data =3D
> -        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS=
 * 512,
> -                                              qiov->size));
> +    cipher_data =3D qemu_try_blockalign(
> +        bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * sector_size,
> +                          qiov->size));
>      if (cipher_data =3D=3D NULL) {
>          ret =3D -ENOMEM;
>          goto cleanup;
> @@ -417,7 +418,7 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t=
 sector_num,
>          }
> =20
>          qemu_iovec_reset(&hd_qiov);
> -        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
> +        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * sector_=
size);

cur_nr_sectors is based on remaining_sectors; which in turn is a
parameter to this function and comes from the block layer.  Therefore
its unit is BDRV_SECTOR_SIZE and not the crypto driver's sector size.

Same in the hunk below, and in block_crypto_co_writev().

> =20
>          ret =3D bdrv_co_readv(bs->file,
>                              payload_offset + sector_num,

Same thing here, albeit in a different variation: The unit of this
parameter of bdrv_co_readv() (start sector index) is a block layer
sector, whose size is always BDRV_SECTOR_SIZE.

Therefore you cannot divide the result from
qcrypto_block_get_payload_offset() by the crypto driver's sector size
and then use it as a sector index here.

Same in block_crypto_co_writev().


I assume that you fix this in the next patch, but for now it's just wrong=
=2E

Max


--FVNCHNi7jl1c9Kr1KdeImtMxPHOEG4USj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9UFgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ap0UIAKMrQSxNlAADZGdf/kpqV37VnDG7ojf7
t+HLAXSPYUwfAY+POfZ9wJ6zLUmZ/o6I5jImmXfmvEK5bagmYgM0snxf/Zm78sJc
WI5xHn2hbuSMhOC8IySq9tJeiAz8rl2PZE3RmzkYx+VwxPBf8GoQ+T9LJ7Cn/xLn
snQNxOgDdmZC2fYaWNqC8kYkdA4N0cVDY1Zan286Zw3bgrqk8MA3iyGpFVKU6yvx
Gwi3RLWk5oy5c0ti/sgwoi1Dvh+l0Wm7R1sNbeYB6+76tP1emjlzOzjwv7x7NdFx
5BhR8JC04s3BArMjY2OSRtSAT/77bobz2MoPAzfklK+mxhsmi0oKCGE=
=7ed+
-----END PGP SIGNATURE-----

--FVNCHNi7jl1c9Kr1KdeImtMxPHOEG4USj--
