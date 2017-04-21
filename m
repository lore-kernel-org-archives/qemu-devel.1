Received: from eggs.gnu.org ([2001:4830:134:3::10]:44487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XB9-0001Zv-P2
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XB5-0006tR-TU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3489
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XB5-0006rU-AL
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:43 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 11:56:22 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA23898F@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-4-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-4-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 03/18] crypto: cipher:
 introduce qcrypto_cipher_ctx_new for nettle-backend
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
> Subject: [PATCH v2 for-2.10 03/18] crypto: cipher: introduce
> qcrypto_cipher_ctx_new for nettle-backend
>=20
> Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
> nettle-backend impls.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-nettle.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index e04e3a1..e6d6e6c 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -262,12 +262,12 @@ static void
> nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
>  }
>=20
>=20
> -QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> -                                  QCryptoCipherMode mode,
> -                                  const uint8_t *key, size_t nkey,
> -                                  Error **errp)
> +static QCryptoCipherNettle
> *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> +
> QCryptoCipherMode mode,
> +                                                   const uint8_t
> *key,
> +                                                   size_t nkey,
> +                                                   Error **errp)
>  {
> -    QCryptoCipher *cipher;
>      QCryptoCipherNettle *ctx;
>      uint8_t *rfbkey;
>=20
> @@ -287,12 +287,7 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>          return NULL;
>      }
>=20
> -    cipher =3D g_new0(QCryptoCipher, 1);
> -    cipher->alg =3D alg;
> -    cipher->mode =3D mode;
> -
>      ctx =3D g_new0(QCryptoCipherNettle, 1);
> -    cipher->opaque =3D ctx;
>=20
>      switch (alg) {
>      case QCRYPTO_CIPHER_ALG_DES_RFB:
> @@ -436,10 +431,10 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>=20
>      ctx->iv =3D g_new0(uint8_t, ctx->blocksize);
>=20
> -    return cipher;
> +    return ctx;
>=20
>   error:
> -    qcrypto_cipher_free(cipher);
> +    nettle_cipher_free_ctx(ctx);
>      return NULL;
>  }
>=20
> @@ -561,3 +556,25 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>      memcpy(ctx->iv, iv, niv);
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
> +    QCryptoCipherNettle *ctx;
> +
> +    ctx =3D qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
> +    if (!ctx) {
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
