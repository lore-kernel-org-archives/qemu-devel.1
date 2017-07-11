Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuLG-0000OI-CI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuLC-0000tr-IV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUuLC-0000tV-8j
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:32:34 -0400
Date: Tue, 11 Jul 2017 13:32:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170711123229.GN7116@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
	<1499158630-75260-15-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499158630-75260-15-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v4 14/18] crypto: hash: add afalg-backend
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
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com

On Tue, Jul 04, 2017 at 04:57:06PM +0800, Longpeng(Mike) wrote:
> Adds afalg-backend hash support: introduces some private APIs
> firstly, and then intergrates them into qcrypto_hash_afalg_driver.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/Makefile.objs |   1 +
>  crypto/afalgpriv.h   |   1 +
>  crypto/hash-afalg.c  | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/hash.c        |  17 +++++++
>  crypto/hashpriv.h    |   8 +++
>  5 files changed, 166 insertions(+)
>  create mode 100644 crypto/hash-afalg.c
> 
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index d2e8fa8..2b99e08 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -12,6 +12,7 @@ crypto-obj-y += desrfb.o
>  crypto-obj-y += cipher.o
>  crypto-obj-$(CONFIG_AF_ALG) += afalg.o
>  crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
> +crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
>  crypto-obj-y += tlscreds.o
>  crypto-obj-y += tlscredsanon.o
>  crypto-obj-y += tlscredsx509.o
> diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
> index a4a7b97..9d42ba9 100644
> --- a/crypto/afalgpriv.h
> +++ b/crypto/afalgpriv.h
> @@ -24,6 +24,7 @@
>  #endif
>  
>  #define AFALG_TYPE_CIPHER "skcipher"
> +#define AFALG_TYPE_HASH "hash"
>  
>  #define ALG_OPTYPE_LEN 4
>  #define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
> diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
> new file mode 100644
> index 0000000..a19847e
> --- /dev/null
> +++ b/crypto/hash-afalg.c
> @@ -0,0 +1,139 @@
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
> +    name = g_strdup_printf("%s", alg_name);
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
> +    const int expect_len = qcrypto_hash_digest_len(alg);
> +
> +    if (*resultlen == 0) {
> +        *resultlen = expect_len;
> +        *result = g_new0(uint8_t, *resultlen);
> +    } else if (*resultlen != expect_len) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is not match hash %d",
> +                   *resultlen, expect_len);
> +        return -1;
> +    }
> +
> +    afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
> +    if (!afalg) {
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

Are we guaranteed that short read can't happen ?  If so, then assert
that ret == expect_len, otherwise use iov_send_recv to loop to catch
all output data

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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
