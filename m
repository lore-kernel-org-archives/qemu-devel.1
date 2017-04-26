Received: from eggs.gnu.org ([2001:4830:134:3::10]:55620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lw4-0000iP-UG
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lw1-0006ug-27
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:20:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3Lw0-0006tv-Ox
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:20:40 -0400
Date: Wed, 26 Apr 2017 13:20:34 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426122034.GT18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-15-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-15-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 14/18] crypto: hash: add afalg-backend
 hash support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

On Sat, Apr 22, 2017 at 03:20:23PM +0800, Longpeng(Mike) wrote:
> Adds afalg-backend hash support: introduces some private APIs
> firstly, and then intergrates them into qcrypto_hash_afalg_driver.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/Makefile.objs |   1 +
>  crypto/afalgpriv.h   |   1 +
>  crypto/hash-afalg.c  | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/hash.c        |  11 ++++
>  crypto/hashpriv.h    |   4 ++
>  5 files changed, 164 insertions(+)
>  create mode 100644 crypto/hash-afalg.c
> 

> diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
> new file mode 100644
> index 0000000..f577c83
> --- /dev/null
> +++ b/crypto/hash-afalg.c
> @@ -0,0 +1,147 @@
> +/*
> + * QEMU Crypto af_alg-backend hash support
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
> +#include "qemu/iov.h"
> +#include "qemu/sockets.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "crypto/hash.h"
> +#include "hashpriv.h"
> +
> +static char *
> +qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
> +                               Error **errp)
> +{
> +    char *name;
> +    const char *alg_name;
> +    int ret;
> +
> +    switch (alg) {
> +    case QCRYPTO_HASH_ALG_MD5:
> +        alg_name = "md5";
> +        break;
> +    case QCRYPTO_HASH_ALG_SHA1:
> +        alg_name = "sha1";
> +        break;
> +    case QCRYPTO_HASH_ALG_SHA224:
> +        alg_name = "sha224";
> +        break;
> +    case QCRYPTO_HASH_ALG_SHA256:
> +        alg_name = "sha256";
> +        break;
> +    case QCRYPTO_HASH_ALG_SHA384:
> +        alg_name = "sha384";
> +        break;
> +    case QCRYPTO_HASH_ALG_SHA512:
> +        alg_name = "sha512";
> +        break;
> +    case QCRYPTO_HASH_ALG_RIPEMD160:
> +        alg_name = "rmd160";
> +        break;
> +
> +    default:
> +        error_setg(errp, "Unsupported hash algorithm %d", alg);
> +        return NULL;
> +    }
> +
> +    name = g_new0(char, SALG_NAME_LEN_MAX);
> +    ret = snprintf(name, SALG_NAME_LEN_MAX, "%s", alg_name);
> +    if (ret < 0 || ret >= SALG_NAME_LEN_MAX) {
> +        error_setg(errp, "Build hash name(name='%s') failed",
> +                   alg_name);
> +        g_free(name);
> +        return NULL;
> +    }

Again use g_strdup_printf() and don't check length here.

> +
> +    return name;
> +}
> +
> +static QCryptoAFAlg *
> +qcrypto_afalg_hash_ctx_new(QCryptoHashAlgorithm alg, Error **errp)
> +{
> +    QCryptoAFAlg *afalg;
> +    char *name;
> +
> +    name = qcrypto_afalg_hash_format_name(alg, errp);
> +    if (!name) {
> +        return NULL;
> +    }
> +
> +    afalg = qcrypto_afalg_comm_alloc(AFALG_TYPE_HASH, name, errp);
> +    if (!afalg) {
> +        g_free(name);
> +        return NULL;
> +    }
> +    afalg->name = name;
> +
> +    /* prepare msg header */
> +    afalg->msg = g_new0(struct msghdr, 1);
> +
> +    return afalg;
> +}
> +
> +static int
> +qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
> +                          const struct iovec *iov,
> +                          size_t niov, uint8_t **result,
> +                          size_t *resultlen,
> +                          Error **errp)
> +{
> +    QCryptoAFAlg *afalg;
> +    struct iovec outv;
> +    int ret = 0;
> +    const int except_len = qcrypto_hash_digest_len(alg);

Should be 'expect_len'

> +
> +    if (*resultlen == 0) {
> +        *resultlen = except_len;
> +        *result = g_new0(uint8_t, *resultlen);
> +    } else if (*resultlen != except_len) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is not match hash %d",
> +                   *resultlen, except_len);
> +        return -1;
> +    }
> +
> +    afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
> +    if (afalg == NULL) {
> +        return -1;
> +    }
> +
> +    /* send data to kernel's crypto core */
> +    ret = iov_send_recv(afalg->opfd, iov, niov,
> +                        0, iov_size(iov, niov), true);
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno, "Send data to afalg-core failed");
> +        goto out;
> +    }
> +
> +    /* hash && get result */
> +    outv.iov_base = *result;
> +    outv.iov_len = *resultlen;
> +    afalg->msg->msg_iov = &outv;
> +    afalg->msg->msg_iovlen = 1;
> +    ret = recvmsg(afalg->opfd, afalg->msg, 0);
> +    if (ret != -1) {
> +        ret = 0;
> +    } else {
> +        error_setg_errno(errp, errno, "Recv result from afalg-core failed");
> +    }
> +
> +out:
> +    qcrypto_afalg_comm_free(afalg);
> +    return ret;
> +}
> +
> +QCryptoHashDriver qcrypto_hash_afalg_driver = {
> +    .hash_bytesv = qcrypto_afalg_hash_bytesv,
> +};
> diff --git a/crypto/hash.c b/crypto/hash.c
> index c43fd87..ba30c9b 100644
> --- a/crypto/hash.c
> +++ b/crypto/hash.c
> @@ -46,6 +46,17 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
>                          size_t *resultlen,
>                          Error **errp)
>  {
> +#ifdef CONFIG_AF_ALG
> +    int ret;
> +
> +    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
> +                                                result, resultlen,
> +                                                errp);
> +    if (ret == 0) {
> +        return ret;
> +    }

If ret != 0, then 'errp' would have been set to an error. At
least we needs to be free'd before we call into the next driver.

I also wonder if we should treat some afalg errors as fatal

> +#endif
> +
>      return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
>                                                 result, resultlen,
>                                                 errp);
> diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
> index 5e505e0..d23662f 100644
> --- a/crypto/hashpriv.h
> +++ b/crypto/hashpriv.h
> @@ -15,6 +15,8 @@
>  #ifndef QCRYPTO_HASHPRIV_H
>  #define QCRYPTO_HASHPRIV_H
>  
> +#include "afalgpriv.h"
> +
>  typedef struct QCryptoHashDriver QCryptoHashDriver;
>  
>  struct QCryptoHashDriver {
> @@ -28,4 +30,6 @@ struct QCryptoHashDriver {
>  
>  extern QCryptoHashDriver qcrypto_hash_lib_driver;
>  
> +extern QCryptoHashDriver qcrypto_hash_afalg_driver;
> +
>  #endif
> -- 
> 1.8.3.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
