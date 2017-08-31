Received: from eggs.gnu.org ([2001:4830:134:3::10]:58267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnR4s-0000r3-7z
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnR4k-0000u6-4c
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:08:18 -0400
References: <20170831110518.10741-1-berrange@redhat.com>
	<20170831110518.10741-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3867f025-5d0b-5bed-d47f-a91c706cd3aa@redhat.com>
Date: Thu, 31 Aug 2017 10:08:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170831110518.10741-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xpqp92n8x5qhVSfq10iU4eOEO8w2jsoPu"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block: convert crypto driver to
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xpqp92n8x5qhVSfq10iU4eOEO8w2jsoPu
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <3867f025-5d0b-5bed-d47f-a91c706cd3aa@redhat.com>
Subject: Re: [PATCH v2 3/4] block: convert crypto driver to
 bdrv_co_preadv|pwritev
References: <20170831110518.10741-1-berrange@redhat.com>
 <20170831110518.10741-4-berrange@redhat.com>
In-Reply-To: <20170831110518.10741-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 06:05 AM, Daniel P. Berrange wrote:
> Make the crypto driver implement the bdrv_co_preadv|pwritev
> callbacks,  and also use bdrv_co_preadv|pwritev for I/O
> with the protocol driver beneath.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 103 +++++++++++++++++++++++++++++--------------------=
--------
>  1 file changed, 53 insertions(+), 50 deletions(-)
>=20

>  static coroutine_fn int
> -block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> -                      int remaining_sectors, QEMUIOVector *qiov)
> +block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t=
 bytes,
> +                       QEMUIOVector *qiov, int flags)

>  {
>      BlockCrypto *crypto =3D bs->opaque;
> -    int cur_nr_sectors; /* number of sectors in current iteration */
> +    uint64_t cur_bytes; /* number of bytes in current iteration */
>      uint64_t bytes_done =3D 0;
>      uint8_t *cipher_data =3D NULL;
>      QEMUIOVector hd_qiov;
>      int ret =3D 0;
> -    size_t payload_offset =3D
> -        qcrypto_block_get_payload_offset(crypto->block) / BDRV_SECTOR_=
SIZE;
> +    size_t payload_offset =3D qcrypto_block_get_payload_offset(crypto-=
>block);

Pre-existing: is size_t the right type, or can we overflow a 64-bit
offset on a 32-bit host?

> +    uint64_t sector_num =3D offset / BDRV_SECTOR_SIZE;
> +
> +    assert((offset % BDRV_SECTOR_SIZE) =3D=3D 0);
> +    assert((bytes % BDRV_SECTOR_SIZE) =3D=3D 0);

The osdep.h macros might be nicer than open-coding; furthermore, if
desired, you could shorten to:

assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));


> =20
>  static coroutine_fn int
> -block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
> -                       int remaining_sectors, QEMUIOVector *qiov)
> +block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_=
t bytes,
> +                        QEMUIOVector *qiov, int flags)
>  {

Hmm - you don't set supported_write_flags.  But presumably, if the
underlying BDS supports BDRV_REQUEST_FUA, then crypto can likewise
support that flag by passing it through to the underlying device after
encryption.

>      BlockCrypto *crypto =3D bs->opaque;
> -    int cur_nr_sectors; /* number of sectors in current iteration */
> +    uint64_t cur_bytes; /* number of bytes in current iteration */
>      uint64_t bytes_done =3D 0;
>      uint8_t *cipher_data =3D NULL;
>      QEMUIOVector hd_qiov;
>      int ret =3D 0;
> -    size_t payload_offset =3D
> -        qcrypto_block_get_payload_offset(crypto->block) / BDRV_SECTOR_=
SIZE;
> +    size_t payload_offset =3D qcrypto_block_get_payload_offset(crypto-=
>block);
> +    uint64_t sector_num =3D offset / BDRV_SECTOR_SIZE;
> +
> +    assert((offset % BDRV_SECTOR_SIZE) =3D=3D 0);
> +    assert((bytes % BDRV_SECTOR_SIZE) =3D=3D 0);

Same comment as for read.

> @@ -611,8 +613,9 @@ BlockDriver bdrv_crypto_luks =3D {
>      .bdrv_truncate      =3D block_crypto_truncate,
>      .create_opts        =3D &block_crypto_create_opts_luks,
> =20
> -    .bdrv_co_readv      =3D block_crypto_co_readv,
> -    .bdrv_co_writev     =3D block_crypto_co_writev,
> +    .bdrv_refresh_limits =3D block_crypto_refresh_limits,
> +    .bdrv_co_preadv      =3D block_crypto_co_preadv,
> +    .bdrv_co_pwritev     =3D block_crypto_co_pwritev,
>      .bdrv_getlength     =3D block_crypto_getlength,
>      .bdrv_get_info      =3D block_crypto_get_info_luks,
>      .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,

Looks weird when =3D isn't consistently aligned, but we use more than one=

space.  My preference is to just use one space everywhere, as adding a
longer name to the list doesn't require a mass re-format of all other
entries; but I'm not opposed when people like the aligned =3D for
legibility.  So up to you if you do anything in response to my nit.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xpqp92n8x5qhVSfq10iU4eOEO8w2jsoPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoJlAACgkQp6FrSiUn
Q2qfdgf/WwpIqbAPVhRl1qpmVsW3fmtSdhOWD+DY9AyRO9em7TWofEJGL9oIaaNQ
WuDLhge93ZFETTMdCgnE2NH2mZAN9qDjvydKDictWxGpdm5JXbRl5zNouN1UAid2
fzdRu9M1JTWMh2yKcxfOHPu0v2uWBRHJ0XmChXwQ+LE8w/UWReeGfQz8jE87iMbp
E6w23EIzZFz4PmZBXqLG3Dgp6d2Bg9cxcoRHba2nMqj9x0HKhh/X1Nq4FvTyrSnU
Y21sM2oAveG7PK4/kVzfzDg0dhnt7GUUy4ca9FbwLBF83lCiNsn4JrU3x/MOvk6X
4Sbgt/dX51JHauS4VX6ZUYSh7obNHA==
=oro+
-----END PGP SIGNATURE-----

--xpqp92n8x5qhVSfq10iU4eOEO8w2jsoPu--
