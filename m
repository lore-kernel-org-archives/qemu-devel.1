Received: from eggs.gnu.org ([2001:4830:134:3::10]:35433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1YAT-0004ir-16
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1YAM-0002tO-6e
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:00:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3389
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1YAL-0002st-4k
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:00:02 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 12:59:21 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238C15@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-14-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-14-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 13/18] crypto: cipher: add
 afalg-backend cipher support
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
> Subject: [PATCH v2 for-2.10 13/18] crypto: cipher: add afalg-backend ciph=
er
> support
>=20
> Adds afalg-backend cipher support: introduces some private APIs
> firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/Makefile.objs       |   1 +
>  crypto/afalgpriv.h         |   9 ++
>  crypto/cipher-afalg.c      | 225
> +++++++++++++++++++++++++++++++++++++++++++++
>  crypto/cipher.c            |  28 +++++-
>  crypto/cipherpriv.h        |  11 +++
>  include/crypto/cipher.h    |   8 ++
>  tests/test-crypto-cipher.c |  10 +-
>  7 files changed, 290 insertions(+), 2 deletions(-)
>  create mode 100644 crypto/cipher-afalg.c
>=20
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 2be5a3a..d2e8fa8 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -11,6 +11,7 @@ crypto-obj-y +=3D aes.o
>  crypto-obj-y +=3D desrfb.o
>  crypto-obj-y +=3D cipher.o
>  crypto-obj-$(CONFIG_AF_ALG) +=3D afalg.o
> +crypto-obj-$(CONFIG_AF_ALG) +=3D cipher-afalg.o
>  crypto-obj-y +=3D tlscreds.o
>  crypto-obj-y +=3D tlscredsanon.o
>  crypto-obj-y +=3D tlscredsx509.o
> diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
> index 155130b..7db0597 100644
> --- a/crypto/afalgpriv.h
> +++ b/crypto/afalgpriv.h
> @@ -19,6 +19,15 @@
>  #define SALG_TYPE_LEN_MAX 14
>  #define SALG_NAME_LEN_MAX 64
>=20
> +#ifndef SOL_ALG
> +#define SOL_ALG 279
> +#endif
> +
> +#define AFALG_TYPE_CIPHER "skcipher"
> +
> +#define ALG_OPTYPE_LEN 4
> +#define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
> +
>  typedef struct QCryptoAFAlg QCryptoAFAlg;
>=20
>  struct QCryptoAFAlg {
> diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
> new file mode 100644
> index 0000000..a2b2f53
> --- /dev/null
> +++ b/crypto/cipher-afalg.c
> @@ -0,0 +1,225 @@
> +/*
> + * QEMU Crypto af_alg-backend cipher support
> + *
> + * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Longpeng(Mike) <longpeng2@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/sockets.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "crypto/cipher.h"
> +#include "cipherpriv.h"
> +
> +
> +static char *
> +qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
> +                                 QCryptoCipherMode mode,
> +                                 Error **errp)
> +{
> +    char *name;
> +    const char *alg_name =3D NULL;
> +    const char *mode_name =3D NULL;

Superfluous initialization.

> +    int ret;
> +
> +    switch (alg) {
> +    case QCRYPTO_CIPHER_ALG_AES_128:
> +    case QCRYPTO_CIPHER_ALG_AES_192:
> +    case QCRYPTO_CIPHER_ALG_AES_256:
> +        alg_name =3D "aes";
> +        break;
> +    case QCRYPTO_CIPHER_ALG_CAST5_128:
> +        alg_name =3D "cast5";
> +        break;
> +    case QCRYPTO_CIPHER_ALG_SERPENT_128:
> +    case QCRYPTO_CIPHER_ALG_SERPENT_192:
> +    case QCRYPTO_CIPHER_ALG_SERPENT_256:
> +        alg_name =3D "serpent";
> +        break;
> +    case QCRYPTO_CIPHER_ALG_TWOFISH_128:
> +    case QCRYPTO_CIPHER_ALG_TWOFISH_192:
> +    case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> +        alg_name =3D "twofish";
> +        break;
> +
> +    default:
> +        error_setg(errp, "Unsupported cipher algorithm %d", alg);
> +        return NULL;
> +    }
> +
> +    mode_name =3D QCryptoCipherMode_lookup[mode];
> +
> +    name =3D (char *)g_new0(int8_t, SALG_NAME_LEN_MAX);

s/ (char *)g_new0(int8_t, SALG_NAME_LEN_MAX)/g_new0(char, SALG_NAME_LEN_MAX=
)/


> +    ret =3D snprintf(name, SALG_NAME_LEN_MAX, "%s(%s)", mode_name,
> +                   alg_name);
> +    if (ret < 0 || ret >=3D SALG_NAME_LEN_MAX) {
> +        error_setg(errp, "Build ciphername(name=3D'%s',mode=3D'%s') fail=
ed",
> +                   alg_name, mode_name);
> +        g_free(name);
> +        return NULL;
> +    }
> +
> +    return name;
> +}
> +
> +QCryptoAFAlg *
> +qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> +                             QCryptoCipherMode mode,
> +                             const uint8_t *key,
> +                             size_t nkey, Error **errp)
> +{
> +    QCryptoAFAlg *afalg;
> +    size_t except_niv =3D 0;

Doesn't need to initialize it.

> +    char *name;
> +
> +    name =3D qcrypto_afalg_cipher_format_name(alg, mode, errp);
> +    if (!name) {
> +        return NULL;
> +    }
> +
> +    afalg =3D qcrypto_afalg_comm_alloc(AFALG_TYPE_CIPHER, name, errp);
> +    if (!afalg) {
> +        goto error;

Leak memory pointed by name.

> +    }
> +
> +    /* setkey */
> +    if (qemu_setsockopt(afalg->tfmfd, SOL_ALG, ALG_SET_KEY, key,
> +                        nkey) !=3D 0) {
> +        error_setg_errno(errp, errno, "Set key failed");
> +        goto error;

Leak memory pointed by name.

> +    }
> +
> +    /* prepare msg header */
> +    afalg->msg =3D g_new0(struct msghdr, 1);
> +    afalg->msg->msg_controllen +=3D CMSG_SPACE(ALG_OPTYPE_LEN);
> +    except_niv =3D qcrypto_cipher_get_iv_len(alg, mode);
> +    if (except_niv) {
> +        afalg->msg->msg_controllen +=3D
> CMSG_SPACE(ALG_MSGIV_LEN(except_niv));
> +    }
> +    afalg->msg->msg_control =3D g_new0(uint8_t,
> afalg->msg->msg_controllen);
> +
> +    /* We use 1st msghdr for crypto-info and 2nd msghdr for IV-info */
> +    afalg->cmsg =3D CMSG_FIRSTHDR(afalg->msg);
> +    afalg->cmsg->cmsg_level =3D SOL_ALG;
> +    afalg->cmsg->cmsg_type =3D ALG_SET_OP;
> +    afalg->cmsg->cmsg_len =3D CMSG_SPACE(ALG_OPTYPE_LEN);
> +
> +cleanup:
> +    g_free(name);
> +    return afalg;
> +
> +error:
> +    qcrypto_afalg_comm_free(afalg);
> +    afalg =3D NULL;
> +    goto cleanup;
> +}
> +
> +static int
> +qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
> +                           const uint8_t *iv,
> +                           size_t niv, Error **errp)
> +{
> +    struct af_alg_iv *alg_iv =3D NULL;

Superfluous initialization.

> +    QCryptoAFAlg *afalg =3D cipher->opaque;
> +
> +    /* move ->cmsg to next msghdr, for IV-info */
> +    afalg->cmsg =3D CMSG_NXTHDR(afalg->msg, afalg->cmsg);
> +
> +    /* build setiv msg */
> +    afalg->cmsg->cmsg_level =3D SOL_ALG;
> +    afalg->cmsg->cmsg_type =3D ALG_SET_IV;
> +    afalg->cmsg->cmsg_len =3D CMSG_SPACE(ALG_MSGIV_LEN(niv));
> +    alg_iv =3D (struct af_alg_iv *)CMSG_DATA(afalg->cmsg);
> +    alg_iv->ivlen =3D niv;
> +    memcpy(alg_iv->iv, iv, niv);

Is it possible trigger memory overflow by vicious attacks ?
> +
> +    return 0;
> +}
> +
> +static int
> +qcrypto_afalg_cipher_op(QCryptoAFAlg *afalg,
> +                        const void *in, void *out,
> +                        size_t len, bool do_encrypt,
> +                        Error **errp)
> +{
> +    uint32_t *type =3D NULL;
> +    struct iovec iov;
> +    size_t ret, done =3D 0;
> +    uint32_t origin_contorllen;
> +
> +    origin_contorllen =3D afalg->msg->msg_controllen;
> +    /* movev ->cmsg to first header, for crypto-info */
> +    afalg->cmsg =3D CMSG_FIRSTHDR(afalg->msg);
> +
> +    /* build encrypt msg */
> +    afalg->msg->msg_iov =3D &iov;
> +    afalg->msg->msg_iovlen =3D 1;
> +    type =3D (uint32_t *)CMSG_DATA(afalg->cmsg);
> +    if (do_encrypt) {
> +        *type =3D ALG_OP_ENCRYPT;
> +    } else {
> +        *type =3D ALG_OP_DECRYPT;
> +    }
> +
> +    do {
> +        iov.iov_base =3D (void *)in + done;
> +        iov.iov_len =3D len - done;
> +
> +        /* send info to AF_ALG core */
> +        ret =3D sendmsg(afalg->opfd, afalg->msg, 0);
> +        if (ret =3D=3D -1) {
> +            error_setg_errno(errp, errno, "Send data to AF_ALG core
> failed");
> +            return -1;
> +        }
> +
> +        /* encrypto && get result */
> +        if (ret !=3D read(afalg->opfd, out, ret)) {
> +            error_setg_errno(errp, errno, "Get result from AF_ALG core
> failed");
> +            return -1;
> +        }
> +
> +        /* do not update IV for following chunks */
> +        afalg->msg->msg_controllen =3D 0;
> +        done +=3D ret;
> +    } while (done < len);
> +
> +    afalg->msg->msg_controllen =3D origin_contorllen;
> +
> +    return 0;
> +}
> +
> +static int
> +qcrypto_afalg_cipher_encrypt(QCryptoCipher *cipher,
> +                             const void *in, void *out,
> +                             size_t len, Error **errp)
> +{
> +    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
> +                                   len, true, errp);
> +}
> +
> +static int
> +qcrypto_afalg_cipher_decrypt(QCryptoCipher *cipher,
> +                             const void *in, void *out,
> +                             size_t len, Error **errp)
> +{
> +    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
> +                                   len, false, errp);
> +}
> +
> +static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
> +{
> +    qcrypto_afalg_comm_free(cipher->opaque);
> +}
> +
> +struct QCryptoCipherDriver qcrypto_cipher_afalg_driver =3D {
> +    .cipher_encrypt =3D qcrypto_afalg_cipher_encrypt,
> +    .cipher_decrypt =3D qcrypto_afalg_cipher_decrypt,
> +    .cipher_setiv =3D qcrypto_afalg_cipher_setiv,
> +    .cipher_free =3D qcrypto_afalg_comm_ctx_free,
> +};
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index a6e052c..4a6f548 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -164,17 +164,34 @@ QCryptoCipher
> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>  {
>      QCryptoCipher *cipher;
>      void *ctx;
> +    Error *err2 =3D NULL;
> +    QCryptoCipherDriver *drv;
> +
> +#ifdef CONFIG_AF_ALG
> +    ctx =3D qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, &err2);
> +    if (ctx) {
> +        drv =3D &qcrypto_cipher_afalg_driver;
> +        goto set_cipher;
> +    }
> +#endif
>=20
>      ctx =3D qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
>      if (ctx =3D=3D NULL) {
> +        error_free(err2);
>          return NULL;
>      }
>=20
> +    drv =3D &qcrypto_cipher_lib_driver;
> +    error_free(err2);
> +
> +#ifdef CONFIG_AF_ALG
> +set_cipher:
> +#endif
>      cipher =3D g_new0(QCryptoCipher, 1);
>      cipher->alg =3D alg;
>      cipher->mode =3D mode;
>      cipher->opaque =3D ctx;
> -    cipher->driver =3D (void *)&qcrypto_cipher_lib_driver;
> +    cipher->driver =3D (void *)drv;
>=20
>      return cipher;
>  }
> @@ -220,3 +237,12 @@ void qcrypto_cipher_free(QCryptoCipher *cipher)
>          g_free(cipher);
>      }
>  }
> +
> +bool qcrypto_cipher_using_afalg_drv(QCryptoCipher *cipher)
> +{
> +#ifdef CONFIG_AF_ALG
> +    return cipher->driver =3D=3D (void *)&qcrypto_cipher_afalg_driver;
> +#else
> +    return false;
> +#endif
> +}
> diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
> index 4af5e85..91c6a7e 100644
> --- a/crypto/cipherpriv.h
> +++ b/crypto/cipherpriv.h
> @@ -15,6 +15,9 @@
>  #ifndef QCRYPTO_CIPHERPRIV_H
>  #define QCRYPTO_CIPHERPRIV_H
>=20
> +#include "qapi-types.h"
> +#include "afalgpriv.h"
> +
>  typedef struct QCryptoCipherDriver QCryptoCipherDriver;
>=20
>  struct QCryptoCipherDriver {
> @@ -37,4 +40,12 @@ struct QCryptoCipherDriver {
>      void (*cipher_free)(QCryptoCipher *cipher);
>  };
>=20
> +extern QCryptoAFAlg *
> +qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> +                             QCryptoCipherMode mode,
> +                             const uint8_t *key,
> +                             size_t nkey, Error **errp);
> +
> +extern struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
> +
>  #endif
> diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
> index 984fb82..037f602 100644
> --- a/include/crypto/cipher.h
> +++ b/include/crypto/cipher.h
> @@ -233,4 +233,12 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>                           const uint8_t *iv, size_t niv,
>                           Error **errp);
>=20
> +/**
> + * qcrypto_cipher_using_afalg_drv:
> + * @ the cipher object
> + *
> + * Returns: true if @cipher is using afalg driver, otherwise false.
> + */
> +bool qcrypto_cipher_using_afalg_drv(QCryptoCipher *cipher);
> +
>  #endif /* QCRYPTO_CIPHER_H */
> diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
> index 07fa2fa..8bb3308 100644
> --- a/tests/test-crypto-cipher.c
> +++ b/tests/test-crypto-cipher.c
> @@ -715,6 +715,7 @@ static void test_cipher_null_iv(void)
>      uint8_t key[32] =3D { 0 };
>      uint8_t plaintext[32] =3D { 0 };
>      uint8_t ciphertext[32] =3D { 0 };
> +    Error *err =3D NULL;
>=20
>      cipher =3D qcrypto_cipher_new(
>          QCRYPTO_CIPHER_ALG_AES_256,
> @@ -729,7 +730,14 @@ static void test_cipher_null_iv(void)
>                             plaintext,
>                             ciphertext,
>                             sizeof(plaintext),
> -                           &error_abort);
> +                           &err);
> +
> +    if (qcrypto_cipher_using_afalg_drv(cipher)) {
> +        g_assert(err !=3D NULL);
> +        error_free_or_abort(&err);
> +    } else {
> +        g_assert(err =3D=3D NULL);
> +    }
>=20
>      qcrypto_cipher_free(cipher);
>  }
> --
> 1.8.3.1
>=20
