Received: from eggs.gnu.org ([2001:4830:134:3::10]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1Xdk-0001FB-MX
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1Xdh-00008Q-GQ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:26:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3451
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1Xdg-00006s-Iu
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:26:17 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 12:25:54 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238AEC@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-12-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-12-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 11/18] crypto: hmac: add hmac
 driver framework
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
> Subject: [PATCH v2 for-2.10 11/18] crypto: hmac: add hmac driver framewor=
k
>=20
> 1) makes the public APIs in hmac-nettle/gcrypt/glib static,
>    and rename them with "nettle/gcrypt/glib" prefix.
>=20
> 2) introduces hmac framework, including QCryptoHmacDriver
>    and new public APIs.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hmac-gcrypt.c  | 51 ++++++++++++-----------------------
>  crypto/hmac-glib.c    | 75 +++++++++++++++++++++------------------------=
------
>  crypto/hmac-nettle.c  | 52 ++++++++++++-----------------------
>  crypto/hmac.c         | 44 ++++++++++++++++++++++++++++++
>  crypto/hmacpriv.h     | 36 +++++++++++++++++++++++++
>  include/crypto/hmac.h |  1 +
>  6 files changed, 145 insertions(+), 114 deletions(-)
>  create mode 100644 crypto/hmacpriv.h
>=20
> diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
> index 42489f3..76ca61b 100644
> --- a/crypto/hmac-gcrypt.c
> +++ b/crypto/hmac-gcrypt.c
> @@ -15,6 +15,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/hmac.h"
> +#include "hmacpriv.h"
>  #include <gcrypt.h>
>=20
>  static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] =3D {
> @@ -42,10 +43,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm
> alg)
>      return false;
>  }
>=20
> -static QCryptoHmacGcrypt *
> -qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> -                     const uint8_t *key, size_t nkey,
> -                     Error **errp)
> +void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> +                           const uint8_t *key, size_t nkey,
> +                           Error **errp)

Why do this change?

>  {
>      QCryptoHmacGcrypt *ctx;
>      gcry_error_t err;
> @@ -81,27 +81,24 @@ error:
>      return NULL;
>  }
>=20
> -void qcrypto_hmac_free(QCryptoHmac *hmac)
> +static void
> +qcrypto_gcrypt_hmac_ctx_free(QCryptoHmac *hmac)
>  {
>      QCryptoHmacGcrypt *ctx;
>=20
> -    if (!hmac) {
> -        return;
> -    }
> -
>      ctx =3D hmac->opaque;
>      gcry_mac_close(ctx->handle);
>=20
>      g_free(ctx);
> -    g_free(hmac);
>  }
>=20
> -int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> -                        const struct iovec *iov,
> -                        size_t niov,
> -                        uint8_t **result,
> -                        size_t *resultlen,
> -                        Error **errp)
> +static int
> +qcrypto_gcrypt_hmac_bytesv(QCryptoHmac *hmac,
> +                           const struct iovec *iov,
> +                           size_t niov,
> +                           uint8_t **result,
> +                           size_t *resultlen,
> +                           Error **errp)
>  {
>      QCryptoHmacGcrypt *ctx;
>      gcry_error_t err;
> @@ -147,21 +144,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
>      return 0;
>  }
>=20
> -QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> -                              const uint8_t *key, size_t nkey,
> -                              Error **errp)
> -{
> -    QCryptoHmac *hmac;
> -    QCryptoHmacGcrypt *ctx;
> -
> -    ctx =3D qcrypto_hmac_ctx_new(alg, key, nkey, errp);
> -    if (ctx =3D=3D NULL) {
> -        return NULL;
> -    }
> -
> -    hmac =3D g_new0(QCryptoHmac, 1);
> -    hmac->alg =3D alg;
> -    hmac->opaque =3D ctx;
> -
> -    return hmac;
> -}
> +QCryptoHmacDriver qcrypto_hmac_lib_driver =3D {
> +    .hmac_bytesv =3D qcrypto_gcrypt_hmac_bytesv,
> +    .hmac_free =3D qcrypto_gcrypt_hmac_ctx_free,
> +};
> diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
> index d9f88d8..8cf6b22 100644
> --- a/crypto/hmac-glib.c
> +++ b/crypto/hmac-glib.c
> @@ -15,6 +15,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/hmac.h"
> +#include "hmacpriv.h"
>=20
>  /* Support for HMAC Algos has been added in GLib 2.30 */
>  #if GLIB_CHECK_VERSION(2, 30, 0)
> @@ -49,10 +50,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm
> alg)
>      return false;
>  }
>=20
> -static QCryptoHmacGlib *
> -qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> -                     const uint8_t *key, size_t nkey,
> -                     Error **errp)
> +void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> +                           const uint8_t *key, size_t nkey,
> +                           Error **errp)
>  {
>      QCryptoHmacGlib *ctx;
>=20
> @@ -78,27 +78,24 @@ error:
>      return NULL;
>  }
>=20
> -void qcrypto_hmac_free(QCryptoHmac *hmac)
> +static void
> +qcrypto_glib_hmac_ctx_free(QCryptoHmac *hmac)
>  {
>      QCryptoHmacGlib *ctx;
>=20
> -    if (!hmac) {
> -        return;
> -    }
> -
>      ctx =3D hmac->opaque;
>      g_hmac_unref(ctx->ghmac);
>=20
>      g_free(ctx);
> -    g_free(hmac);
>  }
>=20
> -int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> -                        const struct iovec *iov,
> -                        size_t niov,
> -                        uint8_t **result,
> -                        size_t *resultlen,
> -                        Error **errp)
> +static int
> +qcrypto_glib_hmac_bytesv(QCryptoHmac *hmac,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         uint8_t **result,
> +                         size_t *resultlen,
> +                         Error **errp)
>  {
>      QCryptoHmacGlib *ctx;
>      int i, ret;
> @@ -129,25 +126,6 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
>      return 0;
>  }
>=20
> -QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> -                              const uint8_t *key, size_t nkey,
> -                              Error **errp)
> -{
> -    QCryptoHmac *hmac;
> -    QCryptoHmacGlib *ctx;
> -
> -    ctx =3D qcrypto_hmac_ctx_new(alg, key, nkey, errp);
> -    if (ctx =3D=3D NULL) {
> -        return NULL;
> -    }
> -
> -    hmac =3D g_new0(QCryptoHmac, 1);
> -    hmac->alg =3D alg;
> -    hmac->opaque =3D ctx;
> -
> -    return hmac;
> -}
> -
>  #else
>=20
>  bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
> @@ -155,26 +133,33 @@ bool
> qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
>      return false;
>  }
>=20
> -QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> -                              const uint8_t *key, size_t nkey,
> -                              Error **errp)
> +void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> +                           const uint8_t *key, size_t nkey,
> +                           Error **errp)
>  {
>      return NULL;
>  }
>=20
> -void qcrypto_hmac_free(QCryptoHmac *hmac)
> +static void
> +qcrypto_glib_hmac_ctx_free(QCryptoHmac *hmac)
>  {
>      return;
>  }
>=20
> -int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> -                        const struct iovec *iov,
> -                        size_t niov,
> -                        uint8_t **result,
> -                        size_t *resultlen,
> -                        Error **errp)
> +static int
> +qcrypto_glib_hmac_bytesv(QCryptoHmac *hmac,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         uint8_t **result,
> +                         size_t *resultlen,
> +                         Error **errp)
>  {
>      return -1;
>  }
>=20
>  #endif
> +
> +QCryptoHmacDriver qcrypto_hmac_lib_driver =3D {
> +    .hmac_bytesv =3D qcrypto_glib_hmac_bytesv,
> +    .hmac_free =3D qcrypto_glib_hmac_ctx_free,
> +};
> diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
> index 19fbb4f..1d5a915 100644
> --- a/crypto/hmac-nettle.c
> +++ b/crypto/hmac-nettle.c
> @@ -15,6 +15,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/hmac.h"
> +#include "hmacpriv.h"
>  #include <nettle/hmac.h>
>=20
>  typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
> @@ -97,10 +98,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm
> alg)
>      return false;
>  }
>=20
> -static QCryptoHmacNettle *
> -qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> -                     const uint8_t *key, size_t nkey,
> -                     Error **errp)
> +void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> +                           const uint8_t *key, size_t nkey,
> +                           Error **errp)
>  {
>      QCryptoHmacNettle *ctx;
>=20
> @@ -117,26 +117,22 @@ qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
>      return ctx;
>  }
>=20
> -void qcrypto_hmac_free(QCryptoHmac *hmac)
> +static void
> +qcrypto_nettle_hmac_ctx_free(QCryptoHmac *hmac)
>  {
>      QCryptoHmacNettle *ctx;
>=20
> -    if (!hmac) {
> -        return;
> -    }
> -
>      ctx =3D hmac->opaque;
> -
>      g_free(ctx);
> -    g_free(hmac);
>  }
>=20
> -int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> -                        const struct iovec *iov,
> -                        size_t niov,
> -                        uint8_t **result,
> -                        size_t *resultlen,
> -                        Error **errp)
> +static int
> +qcrypto_nettle_hmac_bytesv(QCryptoHmac *hmac,
> +                           const struct iovec *iov,
> +                           size_t niov,
> +                           uint8_t **result,
> +                           size_t *resultlen,
> +                           Error **errp)
>  {
>      QCryptoHmacNettle *ctx;
>      int i;
> @@ -169,21 +165,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
>      return 0;
>  }
>=20
> -QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> -                              const uint8_t *key, size_t nkey,
> -                              Error **errp)
> -{
> -    QCryptoHmac *hmac;
> -    QCryptoHmacNettle *ctx;
> -
> -    ctx =3D qcrypto_hmac_ctx_new(alg, key, nkey, errp);
> -    if (ctx =3D=3D NULL) {
> -        return NULL;
> -    }
> -
> -    hmac =3D g_new0(QCryptoHmac, 1);
> -    hmac->alg =3D alg;
> -    hmac->opaque =3D ctx;
> -
> -    return hmac;
> -}
> +QCryptoHmacDriver qcrypto_hmac_lib_driver =3D {
> +    .hmac_bytesv =3D qcrypto_nettle_hmac_bytesv,
> +    .hmac_free =3D qcrypto_nettle_hmac_ctx_free,
> +};
> diff --git a/crypto/hmac.c b/crypto/hmac.c
> index 5750405..d040fbb 100644
> --- a/crypto/hmac.c
> +++ b/crypto/hmac.c
> @@ -12,9 +12,22 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/hmac.h"
> +#include "hmacpriv.h"
>=20
>  static const char hex[] =3D "0123456789abcdef";
>=20
> +int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> +                        const struct iovec *iov,
> +                        size_t niov,
> +                        uint8_t **result,
> +                        size_t *resultlen,
> +                        Error **errp)
> +{
> +    QCryptoHmacDriver *drv =3D hmac->driver;
> +
> +    return drv->hmac_bytesv(hmac, iov, niov, result, resultlen, errp);
> +}
> +
>  int qcrypto_hmac_bytes(QCryptoHmac *hmac,
>                         const char *buf,
>                         size_t len,
> @@ -70,3 +83,34 @@ int qcrypto_hmac_digest(QCryptoHmac *hmac,
>=20
>      return qcrypto_hmac_digestv(hmac, &iov, 1, digest, errp);
>  }
> +
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> +                              const uint8_t *key, size_t nkey,
> +                              Error **errp)
> +{
> +    QCryptoHmac *hmac;
> +    void *ctx;
> +
> +    ctx =3D qcrypto_hmac_ctx_new(alg, key, nkey, errp);
> +    if (ctx =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    hmac =3D g_new0(QCryptoHmac, 1);
> +    hmac->alg =3D alg;
> +    hmac->opaque =3D ctx;
> +    hmac->driver =3D (void *)&qcrypto_hmac_lib_driver;
> +
> +    return hmac;
> +}
> +
> +void qcrypto_hmac_free(QCryptoHmac *hmac)
> +{
> +    QCryptoHmacDriver *drv;
> +
> +    if (hmac) {
> +        drv =3D hmac->driver;
> +        drv->hmac_free(hmac);
> +        g_free(hmac);
> +    }
> +}
> diff --git a/crypto/hmacpriv.h b/crypto/hmacpriv.h
> new file mode 100644
> index 0000000..2be389a
> --- /dev/null
> +++ b/crypto/hmacpriv.h
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU Crypto hmac driver supports
> + *
> + * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Longpeng(Mike) <longpeng2@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + *
> + */
> +
> +#ifndef QCRYPTO_HMACPRIV_H
> +#define QCRYPTO_HMACPRIV_H
> +
> +typedef struct QCryptoHmacDriver QCryptoHmacDriver;
> +
> +struct QCryptoHmacDriver {
> +    int (*hmac_bytesv)(QCryptoHmac *hmac,
> +                       const struct iovec *iov,
> +                       size_t niov,
> +                       uint8_t **result,
> +                       size_t *resultlen,
> +                       Error **errp);
> +
> +    void (*hmac_free)(QCryptoHmac *hmac);
> +};
> +
> +extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
> +                                  const uint8_t *key, size_t nkey,
> +                                  Error **errp);

I think the method of cipher is fine.


> +extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
> +
> +#endif
> diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
> index 0d3acd7..5e88905 100644
> --- a/include/crypto/hmac.h
> +++ b/include/crypto/hmac.h
> @@ -18,6 +18,7 @@ typedef struct QCryptoHmac QCryptoHmac;
>  struct QCryptoHmac {
>      QCryptoHashAlgorithm alg;
>      void *opaque;
> +    void *driver;
>  };
>=20
>  /**
> --
> 1.8.3.1
>=20
