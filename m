Received: from eggs.gnu.org ([2001:4830:134:3::10]:60793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnREA-0003wA-Ku
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnRE9-0005h8-Hn
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:17:54 -0400
References: <20170831110518.10741-1-berrange@redhat.com>
	<20170831110518.10741-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e86a5c7-dc18-ca28-3eed-40fc6221e84d@redhat.com>
Date: Thu, 31 Aug 2017 10:17:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170831110518.10741-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ktfl9FoCt5bqP9UECTdf3WBpEqWS0s0e7"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] block: convert
 qcrypto_block_encrypt|decrypt to take bytes offset
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
--ktfl9FoCt5bqP9UECTdf3WBpEqWS0s0e7
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <3e86a5c7-dc18-ca28-3eed-40fc6221e84d@redhat.com>
Subject: Re: [PATCH v2 4/4] block: convert qcrypto_block_encrypt|decrypt to
 take bytes offset
References: <20170831110518.10741-1-berrange@redhat.com>
 <20170831110518.10741-5-berrange@redhat.com>
In-Reply-To: <20170831110518.10741-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 06:05 AM, Daniel P. Berrange wrote:
> Instead of sector offset, take the bytes offset when encrypting
> or decrypting data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c         |  8 ++++----
>  block/qcow.c           |  7 +++++--
>  block/qcow2-cluster.c  |  8 +++-----
>  block/qcow2.c          |  4 ++--
>  crypto/block-luks.c    | 12 ++++++++----
>  crypto/block-qcow.c    | 12 ++++++++----
>  crypto/block.c         | 14 ++++++++------
>  crypto/blockpriv.h     |  4 ++--
>  include/crypto/block.h | 14 ++++++++------
>  9 files changed, 48 insertions(+), 35 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 40daa77188..6b8d88efbc 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -426,8 +426,8 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64=
_t offset, uint64_t bytes,
>              goto cleanup;
>          }
> =20
> -        if (qcrypto_block_decrypt(crypto->block, sector_num, cipher_da=
ta,
> -                                  cur_bytes, NULL) < 0) {
> +        if (qcrypto_block_decrypt(crypto->block, offset + bytes_done,
> +                                  cipher_data, cur_bytes, NULL) < 0) {=


How close are we to getting rid of even needing 'sector_num' as a variabl=
e?

> +++ b/block/qcow.c
> @@ -456,7 +456,9 @@ static uint64_t get_cluster_offset(BlockDriverState=
 *bs,
>                          if (i < n_start || i >=3D n_end) {
>                              Error *err =3D NULL;
>                              memset(s->cluster_data, 0x00, 512);
> -                            if (qcrypto_block_encrypt(s->crypto, start=
_sect + i,
> +                            if (qcrypto_block_encrypt(s->crypto,
> +                                                      start_sect + i *=

> +                                                      BDRV_SECTOR_SIZE=
,

Umm, not the same.  You want (start_sect + i) * BDRV_SECTOR_SIZE.

> +++ b/block/qcow2-cluster.c
> @@ -396,15 +396,13 @@ static bool coroutine_fn do_perform_cow_encrypt(B=
lockDriverState *bs,
>  {
>      if (bytes && bs->encrypted) {
>          BDRVQcow2State *s =3D bs->opaque;
> -        int64_t sector =3D (s->crypt_physical_offset ?
> +        int64_t offset =3D (s->crypt_physical_offset ?
>                            (cluster_offset + offset_in_cluster) :
> -                          (src_cluster_offset + offset_in_cluster))
> -                         >> BDRV_SECTOR_BITS;
> +                          (src_cluster_offset + offset_in_cluster));
>          assert((offset_in_cluster & ~BDRV_SECTOR_MASK) =3D=3D 0);
>          assert((bytes & ~BDRV_SECTOR_MASK) =3D=3D 0);

Pre-existing, but we could use osdep.h macros here, as in QEMU_IS_ALIGNED=
().

> +++ b/crypto/block-luks.c
> @@ -1403,29 +1403,33 @@ static void qcrypto_block_luks_cleanup(QCryptoB=
lock *block)
> =20
>  static int
>  qcrypto_block_luks_decrypt(QCryptoBlock *block,
> -                           uint64_t startsector,
> +                           uint64_t offset,
>                             uint8_t *buf,
>                             size_t len,
>                             Error **errp)
>  {
> +    assert(!(offset % QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
> +    assert(!(len % QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));

Again, QEMU_IS_ALIGNED() might be easier to read - but this time, it's
in code you're adding.

Looking forward to v3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ktfl9FoCt5bqP9UECTdf3WBpEqWS0s0e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoKJgACgkQp6FrSiUn
Q2rihQf/ZUUvT+vulva2b26YUUrwMPEgMkyqMRmINXoDdItf8O8/ptBYUbwCdm9Q
WQX9uvW4WHthweGQ1vIoz1MxpudSs2oIUsPg9yy2Vgs6rlP+u8E4t8Kf8Y/oH+Lq
JRaBsMc4mWFLHUnAokl+yLyqvWusShEJ68UsLSBq1e+3h0fIL2A+LqgicuUBYcDP
Y1GJz2MFN5UPvNpeFUAeSd3S1BcUF2fhkLOd6kDTKguJWVBySiXlHU073tDX7iVy
/kDZLQ6/2/np05XgoUOTQ23MdTgcRuIG9vnOwuyHXDDSnp0x59p+cjXX8QWPuT42
N3QYrvU/2DqS3hMmBO1I32un8kaPFA==
=VKWJ
-----END PGP SIGNATURE-----

--ktfl9FoCt5bqP9UECTdf3WBpEqWS0s0e7--
