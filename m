Received: from eggs.gnu.org ([2001:4830:134:3::10]:44385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XAx-0001Rr-Q9
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XAt-0006lm-TH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:35 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3386
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XAt-0006ip-1N
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:31 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 11:56:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238988@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-3-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 02/18] crypto: cipher:
 introduce qcrypto_cipher_ctx_new for gcrypt-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: longpeng
> Sent: Monday, April 17, 2017 9:33 AM
> To: berrange@redhat.com
> Cc: Gonglei (Arei); Huangweidong (C); armbru@redhat.com;
> eblake@redhat.com; mst@redhat.com; qemu-devel@nongnu.org; longpeng
> Subject: [PATCH v2 for-2.10 02/18] crypto: cipher: introduce
> qcrypto_cipher_ctx_new for gcrypt-backend
>=20
> Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
> gcrypt-backend impls.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-gcrypt.c | 50
> +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


> diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
> index 0ecffa2..871730b 100644
> --- a/crypto/cipher-gcrypt.c
> +++ b/crypto/cipher-gcrypt.c
> @@ -80,12 +80,12 @@ static void
> gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
>  }
>=20
>=20
> -QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> -                                  QCryptoCipherMode mode,
> -                                  const uint8_t *key, size_t nkey,
> -                                  Error **errp)
> +static QCryptoCipherGcrypt
> *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> +
> QCryptoCipherMode mode,
> +                                                   const uint8_t
> *key,
> +                                                   size_t nkey,
> +                                                   Error **errp)
>  {
> -    QCryptoCipher *cipher;
>      QCryptoCipherGcrypt *ctx;
>      gcry_error_t err;
>      int gcryalg, gcrymode;
> @@ -162,10 +162,6 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          return NULL;
>      }
>=20
> -    cipher =3D g_new0(QCryptoCipher, 1);
> -    cipher->alg =3D alg;
> -    cipher->mode =3D mode;
> -
>      ctx =3D g_new0(QCryptoCipherGcrypt, 1);
>=20
>      err =3D gcry_cipher_open(&ctx->handle, gcryalg, gcrymode, 0);
> @@ -174,7 +170,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>                     gcry_strerror(err));
>          goto error;
>      }
> -    if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>          err =3D gcry_cipher_open(&ctx->tweakhandle, gcryalg, gcrymode, 0=
);
>          if (err !=3D 0) {
>              error_setg(errp, "Cannot initialize cipher: %s",
> @@ -183,7 +179,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          }
>      }
>=20
> -    if (cipher->alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB) {
> +    if (alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB) {
>          /* We're using standard DES cipher from gcrypt, so we need
>           * to munge the key so that the results are the same as the
>           * bizarre RFB variant of DES :-)
> @@ -193,7 +189,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          g_free(rfbkey);
>          ctx->blocksize =3D 8;
>      } else {
> -        if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> +        if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>              nkey /=3D 2;
>              err =3D gcry_cipher_setkey(ctx->handle, key, nkey);
>              if (err !=3D 0) {
> @@ -210,7 +206,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>                         gcry_strerror(err));
>              goto error;
>          }
> -        switch (cipher->alg) {
> +        switch (alg) {
>          case QCRYPTO_CIPHER_ALG_AES_128:
>          case QCRYPTO_CIPHER_ALG_AES_192:
>          case QCRYPTO_CIPHER_ALG_AES_256:
> @@ -230,7 +226,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          }
>      }
>=20
> -    if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>          if (ctx->blocksize !=3D XTS_BLOCK_SIZE) {
>              error_setg(errp,
>                         "Cipher block size %zu must equal XTS block
> size %d",
> @@ -240,12 +236,10 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          ctx->iv =3D g_new0(uint8_t, ctx->blocksize);
>      }
>=20
> -    cipher->opaque =3D ctx;
> -    return cipher;
> +    return ctx;
>=20
>   error:
>      gcrypt_cipher_free_ctx(ctx, mode);
> -    g_free(cipher);
>      return NULL;
>  }
>=20
> @@ -385,3 +379,25 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>=20
>      return 0;
>  }
> +
> +
> +QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> +                                  QCryptoCipherMode mode,
> +                                  const uint8_t *key, size_t nkey,
> +                                  Error **errp)
> +{
> +    QCryptoCipher *cipher;
> +    QCryptoCipherGcrypt *ctx;
> +
> +    ctx =3D qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
> +    if (ctx =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    cipher =3D g_new0(QCryptoCipher, 1);
> +    cipher->alg =3D alg;
> +    cipher->mode =3D mode;
> +    cipher->opaque =3D ctx;
> +
> +    return cipher;
> +}
> --
> 1.8.3.1
>=20
