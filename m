Received: from eggs.gnu.org ([2001:4830:134:3::10]:51022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XUV-0001hS-Lo
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XUS-00058R-Fm
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:16:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3490
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XUR-00056N-Qz
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:16:44 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 12:16:15 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238A7B@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-10-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-10-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 09/18] crypto: hmac: introduce
 qcrypto_hmac_ctx_new for nettle-backend
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
> Subject: [PATCH v2 for-2.10 09/18] crypto: hmac: introduce
> qcrypto_hmac_ctx_new for nettle-backend
>=20
> Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
> nettle-backend impls.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hmac-nettle.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


> diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
> index 4a9e6b2..19fbb4f 100644
> --- a/crypto/hmac-nettle.c
> +++ b/crypto/hmac-nettle.c
> @@ -97,11 +97,11 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm
> alg)
>      return false;
>  }
>=20
> -QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> -                              const uint8_t *key, size_t nkey,
> -                              Error **errp)
> +static QCryptoHmacNettle *
> +qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> +                     const uint8_t *key, size_t nkey,
> +                     Error **errp)
>  {
> -    QCryptoHmac *hmac;
>      QCryptoHmacNettle *ctx;
>=20
>      if (!qcrypto_hmac_supports(alg)) {
> @@ -110,16 +110,11 @@ QCryptoHmac
> *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
>          return NULL;
>      }
>=20
> -    hmac =3D g_new0(QCryptoHmac, 1);
> -    hmac->alg =3D alg;
> -
>      ctx =3D g_new0(QCryptoHmacNettle, 1);
>=20
>      qcrypto_hmac_alg_map[alg].setkey(&ctx->u, nkey, key);
>=20
> -    hmac->opaque =3D ctx;
> -
> -    return hmac;
> +    return ctx;
>  }
>=20
>  void qcrypto_hmac_free(QCryptoHmac *hmac)
> @@ -173,3 +168,22 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
>=20
>      return 0;
>  }
> +
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> +                              const uint8_t *key, size_t nkey,
> +                              Error **errp)
> +{
> +    QCryptoHmac *hmac;
> +    QCryptoHmacNettle *ctx;
> +
> +    ctx =3D qcrypto_hmac_ctx_new(alg, key, nkey, errp);
> +    if (ctx =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    hmac =3D g_new0(QCryptoHmac, 1);
> +    hmac->alg =3D alg;
> +    hmac->opaque =3D ctx;
> +
> +    return hmac;
> +}
> --
> 1.8.3.1
>=20
