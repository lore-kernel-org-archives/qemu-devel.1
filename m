Received: from eggs.gnu.org ([2001:4830:134:3::10]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XLb-0002EA-5W
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XLX-0002Ht-TQ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:07:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3448
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1XLR-0002Eq-Rv
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:07:31 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 12:06:59 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2389F8@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-6-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-6-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 05/18] crypto: cipher: add
 cipher driver framework
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
> Subject: [PATCH v2 for-2.10 05/18] crypto: cipher: add cipher driver fram=
ework
>=20
> 1) makes the public APIs in cipher-nettle/gcrypt/builtin static,
>    and rename them with "nettle/gcrypt/builtin" prefix.
>=20
> 2) introduces cipher framework, including QCryptoCipherDriver
>    and new public APIs.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-builtin.c | 64 +++++++++++++++++--------------------------
>  crypto/cipher-gcrypt.c  | 72 +++++++++++++++++++++----------------------=
------
>  crypto/cipher-nettle.c  | 71 ++++++++++++++++++++-----------------------=
-----
>  crypto/cipher.c         | 65
> ++++++++++++++++++++++++++++++++++++++++++++
>  crypto/cipherpriv.h     | 40 +++++++++++++++++++++++++++
>  include/crypto/cipher.h |  1 +
>  6 files changed, 190 insertions(+), 123 deletions(-)
>  create mode 100644 crypto/cipherpriv.h
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


> diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
> index 8cf47d1..16a36d4 100644
> --- a/crypto/cipher-builtin.c
> +++ b/crypto/cipher-builtin.c
> @@ -22,6 +22,7 @@
>  #include "crypto/aes.h"
>  #include "crypto/desrfb.h"
>  #include "crypto/xts.h"
> +#include "cipherpriv.h"
>=20
>  typedef struct QCryptoCipherBuiltinAESContext
> QCryptoCipherBuiltinAESContext;
>  struct QCryptoCipherBuiltinAESContext {
> @@ -466,25 +467,22 @@ static QCryptoCipherBuiltin
> *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>      return ctxt;
>  }
>=20
> -void qcrypto_cipher_free(QCryptoCipher *cipher)
> +static void
> +qcrypto_builtin_cipher_ctx_free(QCryptoCipher *cipher)
>  {
>      QCryptoCipherBuiltin *ctxt;
>=20
> -    if (!cipher) {
> -        return;
> -    }
> -
>      ctxt =3D cipher->opaque;
>      ctxt->free(cipher);
> -    g_free(cipher);
>  }
>=20
>=20
> -int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
> -                           const void *in,
> -                           void *out,
> -                           size_t len,
> -                           Error **errp)
> +static int
> +qcrypto_builtin_cipher_encrypt(QCryptoCipher *cipher,
> +                               const void *in,
> +                               void *out,
> +                               size_t len,
> +                               Error **errp)
>  {
>      QCryptoCipherBuiltin *ctxt =3D cipher->opaque;
>=20
> @@ -498,11 +496,12 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
>  }
>=20
>=20
> -int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
> -                           const void *in,
> -                           void *out,
> -                           size_t len,
> -                           Error **errp)
> +static int
> +qcrypto_builtin_cipher_decrypt(QCryptoCipher *cipher,
> +                               const void *in,
> +                               void *out,
> +                               size_t len,
> +                               Error **errp)
>  {
>      QCryptoCipherBuiltin *ctxt =3D cipher->opaque;
>=20
> @@ -516,9 +515,10 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
>  }
>=20
>=20
> -int qcrypto_cipher_setiv(QCryptoCipher *cipher,
> -                         const uint8_t *iv, size_t niv,
> -                         Error **errp)
> +static int
> +qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
> +                             const uint8_t *iv, size_t niv,
> +                             Error **errp)
>  {
>      QCryptoCipherBuiltin *ctxt =3D cipher->opaque;
>=20
> @@ -526,23 +526,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>  }
>=20
>=20
> -QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> -                                  QCryptoCipherMode mode,
> -                                  const uint8_t *key, size_t nkey,
> -                                  Error **errp)
> -{
> -    QCryptoCipher *cipher;
> -    QCryptoCipherBuiltin *ctxt;
> -
> -    ctxt =3D qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
> -    if (ctxt =3D=3D NULL) {
> -        return NULL;
> -    }
> -
> -    cipher =3D g_new0(QCryptoCipher, 1);
> -    cipher->alg =3D alg;
> -    cipher->mode =3D mode;
> -    cipher->opaque =3D ctxt;
> -
> -    return cipher;
> -}
> +static struct QCryptoCipherDriver qcrypto_cipher_lib_driver =3D {
> +    .cipher_encrypt =3D qcrypto_builtin_cipher_encrypt,
> +    .cipher_decrypt =3D qcrypto_builtin_cipher_decrypt,
> +    .cipher_setiv =3D qcrypto_builtin_cipher_setiv,
> +    .cipher_free =3D qcrypto_builtin_cipher_ctx_free,
> +};
> diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
> index 871730b..0489147 100644
> --- a/crypto/cipher-gcrypt.c
> +++ b/crypto/cipher-gcrypt.c
> @@ -20,6 +20,7 @@
>=20
>  #include "qemu/osdep.h"
>  #include "crypto/xts.h"
> +#include "cipherpriv.h"
>=20
>  #include <gcrypt.h>
>=20
> @@ -64,8 +65,9 @@ struct QCryptoCipherGcrypt {
>      uint8_t *iv;
>  };
>=20
> -static void gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
> -                                   QCryptoCipherMode mode)
> +static void
> +qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
> +                               QCryptoCipherMode mode)
>  {
>      if (!ctx) {
>          return;
> @@ -239,18 +241,15 @@ static QCryptoCipherGcrypt
> *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>      return ctx;
>=20
>   error:
> -    gcrypt_cipher_free_ctx(ctx, mode);
> +    qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
>      return NULL;
>  }
>=20
>=20
> -void qcrypto_cipher_free(QCryptoCipher *cipher)
> +static void
> +qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
>  {
> -    if (!cipher) {
> -        return;
> -    }
> -    gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
> -    g_free(cipher);
> +    qcrypto_gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
>  }
>=20
>=20
> @@ -274,11 +273,12 @@ static void qcrypto_gcrypt_xts_decrypt(const void
> *ctx,
>      g_assert(err =3D=3D 0);
>  }
>=20
> -int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
> -                           const void *in,
> -                           void *out,
> -                           size_t len,
> -                           Error **errp)
> +static int
> +qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
> +                              const void *in,
> +                              void *out,
> +                              size_t len,
> +                              Error **errp)
>  {
>      QCryptoCipherGcrypt *ctx =3D cipher->opaque;
>      gcry_error_t err;
> @@ -309,11 +309,12 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
>  }
>=20
>=20
> -int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
> -                           const void *in,
> -                           void *out,
> -                           size_t len,
> -                           Error **errp)
> +static int
> +qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
> +                              const void *in,
> +                              void *out,
> +                              size_t len,
> +                              Error **errp)
>  {
>      QCryptoCipherGcrypt *ctx =3D cipher->opaque;
>      gcry_error_t err;
> @@ -343,9 +344,10 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
>      return 0;
>  }
>=20
> -int qcrypto_cipher_setiv(QCryptoCipher *cipher,
> -                         const uint8_t *iv, size_t niv,
> -                         Error **errp)
> +static int
> +qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
> +                            const uint8_t *iv, size_t niv,
> +                            Error **errp)
>  {
>      QCryptoCipherGcrypt *ctx =3D cipher->opaque;
>      gcry_error_t err;
> @@ -381,23 +383,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>  }
>=20
>=20
> -QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> -                                  QCryptoCipherMode mode,
> -                                  const uint8_t *key, size_t nkey,
> -                                  Error **errp)
> -{
> -    QCryptoCipher *cipher;
> -    QCryptoCipherGcrypt *ctx;
> -
> -    ctx =3D qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
> -    if (ctx =3D=3D NULL) {
> -        return NULL;
> -    }
> -
> -    cipher =3D g_new0(QCryptoCipher, 1);
> -    cipher->alg =3D alg;
> -    cipher->mode =3D mode;
> -    cipher->opaque =3D ctx;
> -
> -    return cipher;
> -}
> +static struct QCryptoCipherDriver qcrypto_cipher_lib_driver =3D {
> +    .cipher_encrypt =3D qcrypto_gcrypt_cipher_encrypt,
> +    .cipher_decrypt =3D qcrypto_gcrypt_cipher_decrypt,
> +    .cipher_setiv =3D qcrypto_gcrypt_cipher_setiv,
> +    .cipher_free =3D qcrypto_gcrypt_cipher_ctx_free,
> +};
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index e6d6e6c..c51f119 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -20,6 +20,7 @@
>=20
>  #include "qemu/osdep.h"
>  #include "crypto/xts.h"
> +#include "cipherpriv.h"
>=20
>  #include <nettle/nettle-types.h>
>  #include <nettle/aes.h>
> @@ -249,7 +250,8 @@ bool
> qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>  }
>=20
>=20
> -static void nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
> +static void
> +qcrypto_nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
>  {
>      if (!ctx) {
>          return;
> @@ -434,30 +436,27 @@ static QCryptoCipherNettle
> *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>      return ctx;
>=20
>   error:
> -    nettle_cipher_free_ctx(ctx);
> +    qcrypto_nettle_cipher_free_ctx(ctx);
>      return NULL;
>  }
>=20
>=20
> -void qcrypto_cipher_free(QCryptoCipher *cipher)
> +static void
> +qcrypto_nettle_cipher_ctx_free(QCryptoCipher *cipher)
>  {
>      QCryptoCipherNettle *ctx;
>=20
> -    if (!cipher) {
> -        return;
> -    }
> -
>      ctx =3D cipher->opaque;
> -    nettle_cipher_free_ctx(ctx);
> -    g_free(cipher);
> +    qcrypto_nettle_cipher_free_ctx(ctx);
>  }
>=20
>=20
> -int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
> -                           const void *in,
> -                           void *out,
> -                           size_t len,
> -                           Error **errp)
> +static int
> +qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
> +                              const void *in,
> +                              void *out,
> +                              size_t len,
> +                              Error **errp)
>  {
>      QCryptoCipherNettle *ctx =3D cipher->opaque;
>=20
> @@ -499,11 +498,12 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
>  }
>=20
>=20
> -int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
> -                           const void *in,
> -                           void *out,
> -                           size_t len,
> -                           Error **errp)
> +static int
> +qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
> +                              const void *in,
> +                              void *out,
> +                              size_t len,
> +                              Error **errp)
>  {
>      QCryptoCipherNettle *ctx =3D cipher->opaque;
>=20
> @@ -543,9 +543,10 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
>      return 0;
>  }
>=20
> -int qcrypto_cipher_setiv(QCryptoCipher *cipher,
> -                         const uint8_t *iv, size_t niv,
> -                         Error **errp)
> +static int
> +qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
> +                            const uint8_t *iv, size_t niv,
> +                            Error **errp)
>  {
>      QCryptoCipherNettle *ctx =3D cipher->opaque;
>      if (niv !=3D ctx->blocksize) {
> @@ -558,23 +559,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>  }
>=20
>=20
> -QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> -                                  QCryptoCipherMode mode,
> -                                  const uint8_t *key, size_t nkey,
> -                                  Error **errp)
> -{
> -    QCryptoCipher *cipher;
> -    QCryptoCipherNettle *ctx;
> -
> -    ctx =3D qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
> -    if (!ctx) {
> -        return NULL;
> -    }
> -
> -    cipher =3D g_new0(QCryptoCipher, 1);
> -    cipher->alg =3D alg;
> -    cipher->mode =3D mode;
> -    cipher->opaque =3D ctx;
> -
> -    return cipher;
> -}
> +static struct QCryptoCipherDriver qcrypto_cipher_lib_driver =3D {
> +    .cipher_encrypt =3D qcrypto_nettle_cipher_encrypt,
> +    .cipher_decrypt =3D qcrypto_nettle_cipher_decrypt,
> +    .cipher_setiv =3D qcrypto_nettle_cipher_setiv,
> +    .cipher_free =3D qcrypto_nettle_cipher_ctx_free,
> +};
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index 5a96489..a6e052c 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/cipher.h"
> +#include "cipherpriv.h"
>=20
>=20
>  static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] =3D {
> @@ -155,3 +156,67 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t
> *key,
>  #else
>  #include "crypto/cipher-builtin.c"
>  #endif
> +
> +QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
> +                                  QCryptoCipherMode mode,
> +                                  const uint8_t *key, size_t nkey,
> +                                  Error **errp)
> +{
> +    QCryptoCipher *cipher;
> +    void *ctx;
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
> +    cipher->driver =3D (void *)&qcrypto_cipher_lib_driver;
> +
> +    return cipher;
> +}
> +
> +
> +int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
> +                           const void *in,
> +                           void *out,
> +                           size_t len,
> +                           Error **errp)
> +{
> +    QCryptoCipherDriver *drv =3D cipher->driver;
> +    return drv->cipher_encrypt(cipher, in, out, len, errp);
> +}
> +
> +
> +int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
> +                           const void *in,
> +                           void *out,
> +                           size_t len,
> +                           Error **errp)
> +{
> +    QCryptoCipherDriver *drv =3D cipher->driver;
> +    return drv->cipher_decrypt(cipher, in, out, len, errp);
> +}
> +
> +
> +int qcrypto_cipher_setiv(QCryptoCipher *cipher,
> +                         const uint8_t *iv, size_t niv,
> +                         Error **errp)
> +{
> +    QCryptoCipherDriver *drv =3D cipher->driver;
> +    return drv->cipher_setiv(cipher, iv, niv, errp);
> +}
> +
> +
> +void qcrypto_cipher_free(QCryptoCipher *cipher)
> +{
> +    QCryptoCipherDriver *drv;
> +    if (cipher) {
> +        drv =3D cipher->driver;
> +        drv->cipher_free(cipher);
> +        g_free(cipher);
> +    }
> +}
> diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
> new file mode 100644
> index 0000000..4af5e85
> --- /dev/null
> +++ b/crypto/cipherpriv.h
> @@ -0,0 +1,40 @@
> +/*
> + * QEMU Crypto cipher driver supports
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
> +#ifndef QCRYPTO_CIPHERPRIV_H
> +#define QCRYPTO_CIPHERPRIV_H
> +
> +typedef struct QCryptoCipherDriver QCryptoCipherDriver;
> +
> +struct QCryptoCipherDriver {
> +    int (*cipher_encrypt)(QCryptoCipher *cipher,
> +                          const void *in,
> +                          void *out,
> +                          size_t len,
> +                          Error **errp);
> +
> +    int (*cipher_decrypt)(QCryptoCipher *cipher,
> +                          const void *in,
> +                          void *out,
> +                          size_t len,
> +                          Error **errp);
> +
> +    int (*cipher_setiv)(QCryptoCipher *cipher,
> +                        const uint8_t *iv, size_t niv,
> +                        Error **errp);
> +
> +    void (*cipher_free)(QCryptoCipher *cipher);
> +};
> +
> +#endif
> diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
> index bec9f41..984fb82 100644
> --- a/include/crypto/cipher.h
> +++ b/include/crypto/cipher.h
> @@ -80,6 +80,7 @@ struct QCryptoCipher {
>      QCryptoCipherAlgorithm alg;
>      QCryptoCipherMode mode;
>      void *opaque;
> +    void *driver;
>  };
>=20
>  /**
> --
> 1.8.3.1
>=20
