Received: from eggs.gnu.org ([2001:4830:134:3::10]:41794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNMQr-00075N-IE
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNMQp-0005ky-MC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:32:01 -0500
Date: Thu, 15 Nov 2018 18:31:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181115183141.GA27179@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
	<20181115020334.1189829-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115020334.1189829-10-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/13] RFC: crypto: Rely on block layer
 for fragmentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Nov 14, 2018 at 08:03:30PM -0600, Eric Blake wrote:
> No need to reimplement fragmentation to BLOCK_CRYPTO_MAX_IO_SIZE
> ourselves when we can ask the block layer to do it for us.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> Question - is this patch for 'crypto' acceptable, or should we stick
> with just the previous one that marks things as 64-bit clean?

Unless I'm missing something, this is functionally equivalent to
the existing code, and is simpler to read, so I don't see any
obvious downside  to this patch.

Assuming that you've run 'qemu-iotests/check -luks' on it to
validate it then ...

   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



> ---
>  block/crypto.c | 80 +++++++++++++++++++-------------------------------
>  1 file changed, 30 insertions(+), 50 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 259ef2649e1..b004cef22c2 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -328,8 +328,6 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64=
_t offset, uint64_t bytes,
>                         QEMUIOVector *qiov, int flags)
>  {
>      BlockCrypto *crypto =3D bs->opaque;
> -    uint64_t cur_bytes; /* number of bytes in current iteration */
> -    uint64_t bytes_done =3D 0;
>      uint8_t *cipher_data =3D NULL;
>      QEMUIOVector hd_qiov;
>      int ret =3D 0;
> @@ -346,38 +344,30 @@ block_crypto_co_preadv(BlockDriverState *bs, uint=
64_t offset, uint64_t bytes,
>      /* Bounce buffer because we don't wish to expose cipher text
>       * in qiov which points to guest memory.
>       */
> -    cipher_data =3D
> -        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_IO_SIZE=
,
> -                                              qiov->size));
> +    assert(qiov->size <=3D BLOCK_CRYPTO_MAX_IO_SIZE);
> +    cipher_data =3D qemu_try_blockalign(bs->file->bs, qiov->size);
>      if (cipher_data =3D=3D NULL) {
>          ret =3D -ENOMEM;
>          goto cleanup;
>      }
>=20
> -    while (bytes) {
> -        cur_bytes =3D MIN(bytes, BLOCK_CRYPTO_MAX_IO_SIZE);
> +    qemu_iovec_reset(&hd_qiov);
> +    qemu_iovec_add(&hd_qiov, cipher_data, bytes);
>=20
> -        qemu_iovec_reset(&hd_qiov);
> -        qemu_iovec_add(&hd_qiov, cipher_data, cur_bytes);
> -
> -        ret =3D bdrv_co_preadv(bs->file, payload_offset + offset + byt=
es_done,
> -                             cur_bytes, &hd_qiov, 0);
> -        if (ret < 0) {
> -            goto cleanup;
> -        }
> -
> -        if (qcrypto_block_decrypt(crypto->block, offset + bytes_done,
> -                                  cipher_data, cur_bytes, NULL) < 0) {
> -            ret =3D -EIO;
> -            goto cleanup;
> -        }
> -
> -        qemu_iovec_from_buf(qiov, bytes_done, cipher_data, cur_bytes);
> +    ret =3D bdrv_co_preadv(bs->file, payload_offset + offset, bytes,
> +                         &hd_qiov, 0);
> +    if (ret < 0) {
> +        goto cleanup;
> +    }
>=20
> -        bytes -=3D cur_bytes;
> -        bytes_done +=3D cur_bytes;
> +    if (qcrypto_block_decrypt(crypto->block, offset,
> +                              cipher_data, bytes, NULL) < 0) {
> +        ret =3D -EIO;
> +        goto cleanup;
>      }
>=20
> +    qemu_iovec_from_buf(qiov, 0, cipher_data, bytes);
> +
>   cleanup:
>      qemu_iovec_destroy(&hd_qiov);
>      qemu_vfree(cipher_data);
> @@ -391,8 +381,6 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint6=
4_t offset, uint64_t bytes,
>                          QEMUIOVector *qiov, int flags)
>  {
>      BlockCrypto *crypto =3D bs->opaque;
> -    uint64_t cur_bytes; /* number of bytes in current iteration */
> -    uint64_t bytes_done =3D 0;
>      uint8_t *cipher_data =3D NULL;
>      QEMUIOVector hd_qiov;
>      int ret =3D 0;
> @@ -409,36 +397,28 @@ block_crypto_co_pwritev(BlockDriverState *bs, uin=
t64_t offset, uint64_t bytes,
>      /* Bounce buffer because we're not permitted to touch
>       * contents of qiov - it points to guest memory.
>       */
> -    cipher_data =3D
> -        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_IO_SIZE=
,
> -                                              qiov->size));
> +    assert(qiov->size <=3D BLOCK_CRYPTO_MAX_IO_SIZE);
> +    cipher_data =3D qemu_try_blockalign(bs->file->bs, qiov->size);
>      if (cipher_data =3D=3D NULL) {
>          ret =3D -ENOMEM;
>          goto cleanup;
>      }
>=20
> -    while (bytes) {
> -        cur_bytes =3D MIN(bytes, BLOCK_CRYPTO_MAX_IO_SIZE);
> +    qemu_iovec_to_buf(qiov, 0, cipher_data, bytes);
>=20
> -        qemu_iovec_to_buf(qiov, bytes_done, cipher_data, cur_bytes);
> +    if (qcrypto_block_encrypt(crypto->block, offset,
> +                              cipher_data, bytes, NULL) < 0) {
> +        ret =3D -EIO;
> +        goto cleanup;
> +    }
>=20
> -        if (qcrypto_block_encrypt(crypto->block, offset + bytes_done,
> -                                  cipher_data, cur_bytes, NULL) < 0) {
> -            ret =3D -EIO;
> -            goto cleanup;
> -        }
> +    qemu_iovec_reset(&hd_qiov);
> +    qemu_iovec_add(&hd_qiov, cipher_data, bytes);
>=20
> -        qemu_iovec_reset(&hd_qiov);
> -        qemu_iovec_add(&hd_qiov, cipher_data, cur_bytes);
> -
> -        ret =3D bdrv_co_pwritev(bs->file, payload_offset + offset + by=
tes_done,
> -                              cur_bytes, &hd_qiov, flags);
> -        if (ret < 0) {
> -            goto cleanup;
> -        }
> -
> -        bytes -=3D cur_bytes;
> -        bytes_done +=3D cur_bytes;
> +    ret =3D bdrv_co_pwritev(bs->file, payload_offset + offset,
> +                          bytes, &hd_qiov, flags);
> +    if (ret < 0) {
> +        goto cleanup;
>      }
>=20
>   cleanup:
> @@ -453,7 +433,7 @@ static void block_crypto_refresh_limits(BlockDriver=
State *bs, Error **errp)
>      BlockCrypto *crypto =3D bs->opaque;
>      uint64_t sector_size =3D qcrypto_block_get_sector_size(crypto->blo=
ck);
>      bs->bl.request_alignment =3D sector_size; /* No sub-sector I/O */
> -    bs->bl.max_transfer =3D INT64_MAX;
> +    bs->bl.max_transfer =3D BLOCK_CRYPTO_MAX_IO_SIZE;
>  }
>=20
>=20
> --=20
> 2.17.2
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
