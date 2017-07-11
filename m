Received: from eggs.gnu.org ([2001:4830:134:3::10]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuIp-00082D-93
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuIl-000844-GR
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:30:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUuIl-000838-65
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:30:03 -0400
Date: Tue, 11 Jul 2017 13:29:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170711122958.GM7116@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
	<1499158630-75260-14-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499158630-75260-14-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v4 13/18] crypto: cipher: add afalg-backend
 cipher support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com

On Tue, Jul 04, 2017 at 04:57:05PM +0800, Longpeng(Mike) wrote:
> Adds afalg-backend cipher support: introduces some private APIs
> firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/Makefile.objs  |   1 +
>  crypto/afalgpriv.h    |   9 ++
>  crypto/cipher-afalg.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/cipher.c       |  23 +++++-
>  crypto/cipherpriv.h   |  16 ++++
>  5 files changed, 268 insertions(+), 4 deletions(-)
>  create mode 100644 crypto/cipher-afalg.c
> 
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 2be5a3a..d2e8fa8 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -11,6 +11,7 @@ crypto-obj-y += aes.o
>  crypto-obj-y += desrfb.o
>  crypto-obj-y += cipher.o
>  crypto-obj-$(CONFIG_AF_ALG) += afalg.o
> +crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
>  crypto-obj-y += tlscreds.o
>  crypto-obj-y += tlscredsanon.o
>  crypto-obj-y += tlscredsx509.o
> diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
> index d21160c..a4a7b97 100644
> --- a/crypto/afalgpriv.h
> +++ b/crypto/afalgpriv.h
> @@ -19,6 +19,15 @@
>  #define SALG_TYPE_LEN_MAX 14
>  #define SALG_NAME_LEN_MAX 64
>  
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
>  
>  struct QCryptoAFAlg {
> diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
> new file mode 100644
> index 0000000..c5d1d5d
> --- /dev/null
> +++ b/crypto/cipher-afalg.c
> @@ -0,0 +1,223 @@
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
> +    const char *alg_name;
> +    const char *mode_name;
> +
> +    switch (alg) {
> +    case QCRYPTO_CIPHER_ALG_AES_128:
> +    case QCRYPTO_CIPHER_ALG_AES_192:
> +    case QCRYPTO_CIPHER_ALG_AES_256:
> +        alg_name = "aes";
> +        break;
> +    case QCRYPTO_CIPHER_ALG_CAST5_128:
> +        alg_name = "cast5";
> +        break;
> +    case QCRYPTO_CIPHER_ALG_SERPENT_128:
> +    case QCRYPTO_CIPHER_ALG_SERPENT_192:
> +    case QCRYPTO_CIPHER_ALG_SERPENT_256:
> +        alg_name = "serpent";
> +        break;
> +    case QCRYPTO_CIPHER_ALG_TWOFISH_128:
> +    case QCRYPTO_CIPHER_ALG_TWOFISH_192:
> +    case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> +        alg_name = "twofish";
> +        break;
> +
> +    default:
> +        error_setg(errp, "Unsupported cipher algorithm %d", alg);
> +        return NULL;
> +    }
> +
> +    mode_name = QCryptoCipherMode_lookup[mode];
> +    name = g_strdup_printf("%s(%s)", mode_name, alg_name);
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
> +    size_t expect_niv;
> +    char *name;
> +
> +    name = qcrypto_afalg_cipher_format_name(alg, mode, errp);
> +    if (!name) {
> +        return NULL;
> +    }
> +
> +    afalg = qcrypto_afalg_comm_alloc(AFALG_TYPE_CIPHER, name, errp);
> +    if (!afalg) {
> +        g_free(name);
> +        return NULL;
> +    }
> +    afalg->name = name;
> +
> +    /* setkey */
> +    if (qemu_setsockopt(afalg->tfmfd, SOL_ALG, ALG_SET_KEY, key,
> +                        nkey) != 0) {
> +        error_setg_errno(errp, errno, "Set key failed");
> +        qcrypto_afalg_comm_free(afalg);
> +        return NULL;
> +    }
> +
> +    /* prepare msg header */
> +    afalg->msg = g_new0(struct msghdr, 1);
> +    afalg->msg->msg_controllen += CMSG_SPACE(ALG_OPTYPE_LEN);
> +    expect_niv = qcrypto_cipher_get_iv_len(alg, mode);
> +    if (expect_niv) {
> +        afalg->msg->msg_controllen += CMSG_SPACE(ALG_MSGIV_LEN(expect_niv));
> +    }
> +    afalg->msg->msg_control = g_new0(uint8_t, afalg->msg->msg_controllen);
> +
> +    /* We use 1st msghdr for crypto-info and 2nd msghdr for IV-info */
> +    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
> +    afalg->cmsg->cmsg_type = ALG_SET_OP;
> +    afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_OPTYPE_LEN);
> +    if (expect_niv) {
> +        afalg->cmsg = CMSG_NXTHDR(afalg->msg, afalg->cmsg);
> +        afalg->cmsg->cmsg_type = ALG_SET_IV;
> +        afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_MSGIV_LEN(expect_niv));
> +    }
> +    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
> +
> +    return afalg;
> +}
> +
> +static int
> +qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
> +                           const uint8_t *iv,
> +                           size_t niv, Error **errp)
> +{
> +    struct af_alg_iv *alg_iv;
> +    size_t expect_niv;
> +    QCryptoAFAlg *afalg = cipher->opaque;
> +
> +    expect_niv = qcrypto_cipher_get_iv_len(cipher->alg, cipher->mode);
> +    if (niv != expect_niv) {
> +        error_setg(errp, "Set IV len(%zu) not match expected(%zu)",
> +                   niv, expect_niv);
> +        return -1;
> +    }
> +
> +    /* move ->cmsg to next msghdr, for IV-info */
> +    afalg->cmsg = CMSG_NXTHDR(afalg->msg, afalg->cmsg);
> +
> +    /* build setiv msg */
> +    afalg->cmsg->cmsg_level = SOL_ALG;
> +    alg_iv = (struct af_alg_iv *)CMSG_DATA(afalg->cmsg);
> +    alg_iv->ivlen = niv;
> +    memcpy(alg_iv->iv, iv, niv);
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
> +    uint32_t *type = NULL;
> +    struct iovec iov;
> +    size_t ret, done = 0;
> +    uint32_t origin_controllen;
> +
> +    origin_controllen = afalg->msg->msg_controllen;
> +    /* movev ->cmsg to first header, for crypto-info */
> +    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
> +
> +    /* build encrypt msg */
> +    afalg->cmsg->cmsg_level = SOL_ALG;
> +    afalg->msg->msg_iov = &iov;
> +    afalg->msg->msg_iovlen = 1;
> +    type = (uint32_t *)CMSG_DATA(afalg->cmsg);
> +    if (do_encrypt) {
> +        *type = ALG_OP_ENCRYPT;
> +    } else {
> +        *type = ALG_OP_DECRYPT;
> +    }
> +
> +    do {
> +        iov.iov_base = (void *)in + done;
> +        iov.iov_len = len - done;
> +
> +        /* send info to AF_ALG core */
> +        ret = sendmsg(afalg->opfd, afalg->msg, 0);
> +        if (ret == -1) {
> +            error_setg_errno(errp, errno, "Send data to AF_ALG core failed");
> +            return -1;
> +        }
> +
> +        /* encrypto && get result */
> +        if (ret != read(afalg->opfd, out, ret)) {
> +            error_setg_errno(errp, errno, "Get result from AF_ALG core failed");
> +            return -1;
> +        }
> +
> +        /* do not update IV for following chunks */
> +        afalg->msg->msg_controllen = 0;
> +        done += ret;
> +    } while (done < len);

In the next patch you use iov_send_recv() which provides the
while()  loop automatically upon short write. Lets just use
that method here too.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
