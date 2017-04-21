Received: from eggs.gnu.org ([2001:4830:134:3::10]:44213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XAP-000153-PI
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XAL-0006YX-TU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3447
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XAL-0006YN-5I
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:55:57 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 11:55:37 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA23897B@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-2-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 01/18] crypto: cipher:
 introduce context free function
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
> Subject: [PATCH v2 for-2.10 01/18] crypto: cipher: introduce context free
> function
>=20
> Refactors the qcrypto_cipher_free(), splits it into two parts. One
> is gcrypt/nettle__cipher_free_ctx() to free the special context.
>=20
> This makes code more clear, what's more, it would be used by the
> later patch.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-gcrypt.c | 31 ++++++++++++++++++-------------
>  crypto/cipher-nettle.c | 18 ++++++++++++++----
>  2 files changed, 32 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


> diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
> index 6487eca..0ecffa2 100644
> --- a/crypto/cipher-gcrypt.c
> +++ b/crypto/cipher-gcrypt.c
> @@ -64,6 +64,22 @@ struct QCryptoCipherGcrypt {
>      uint8_t *iv;
>  };
>=20
> +static void gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
> +                                   QCryptoCipherMode mode)
> +{
> +    if (!ctx) {
> +        return;
> +    }
> +
> +    gcry_cipher_close(ctx->handle);
> +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> +        gcry_cipher_close(ctx->tweakhandle);
> +    }
> +    g_free(ctx->iv);
> +    g_free(ctx);
> +}
> +
> +
>  QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>                                    QCryptoCipherMode mode,
>                                    const uint8_t *key, size_t nkey,
> @@ -228,11 +244,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>      return cipher;
>=20
>   error:
> -    gcry_cipher_close(ctx->handle);
> -    if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> -        gcry_cipher_close(ctx->tweakhandle);
> -    }
> -    g_free(ctx);
> +    gcrypt_cipher_free_ctx(ctx, mode);
>      g_free(cipher);
>      return NULL;
>  }
> @@ -240,17 +252,10 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>=20
>  void qcrypto_cipher_free(QCryptoCipher *cipher)
>  {
> -    QCryptoCipherGcrypt *ctx;
>      if (!cipher) {
>          return;
>      }
> -    ctx =3D cipher->opaque;
> -    gcry_cipher_close(ctx->handle);
> -    if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> -        gcry_cipher_close(ctx->tweakhandle);
> -    }
> -    g_free(ctx->iv);
> -    g_free(ctx);
> +    gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
>      g_free(cipher);
>  }
>=20
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index dfc9030..e04e3a1 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -249,6 +249,19 @@ bool
> qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>  }
>=20
>=20
> +static void nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
> +{
> +    if (!ctx) {
> +        return;
> +    }
> +
> +    g_free(ctx->iv);
> +    g_free(ctx->ctx);
> +    g_free(ctx->ctx_tweak);
> +    g_free(ctx);
> +}
> +
> +
>  QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>                                    QCryptoCipherMode mode,
>                                    const uint8_t *key, size_t nkey,
> @@ -440,10 +453,7 @@ void qcrypto_cipher_free(QCryptoCipher *cipher)
>      }
>=20
>      ctx =3D cipher->opaque;
> -    g_free(ctx->iv);
> -    g_free(ctx->ctx);
> -    g_free(ctx->ctx_tweak);
> -    g_free(ctx);
> +    nettle_cipher_free_ctx(ctx);
>      g_free(cipher);
>  }
>=20
> --
> 1.8.3.1
>=20
