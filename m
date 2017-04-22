Received: from eggs.gnu.org ([2001:4830:134:3::10]:59520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jzE-0006TM-Sv
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jzB-0007Ls-Mi
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:37:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3493
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jzA-0007LF-H2
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:37:17 -0400
Message-ID: <58FAB39A.9080400@huawei.com>
Date: Sat, 22 Apr 2017 09:36:26 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-14-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA238C15@DGGEMA505-MBS.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA238C15@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 2017/4/21 20:59, Gonglei (Arei) wrote:

> 
>> -----Original Message-----
>> From: longpeng
>> Sent: Monday, April 17, 2017 9:33 AM
>> To: berrange@redhat.com
>> Cc: Gonglei (Arei); Huangweidong (C); armbru@redhat.com;
>> eblake@redhat.com; mst@redhat.com; qemu-devel@nongnu.org; longpeng
>> Subject: [PATCH v2 for-2.10 13/18] crypto: cipher: add afalg-backend cipher
>> support
>>
>> Adds afalg-backend cipher support: introduces some private APIs
>> firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>>  crypto/Makefile.objs       |   1 +
>>  crypto/afalgpriv.h         |   9 ++
>>  crypto/cipher-afalg.c      | 225
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  crypto/cipher.c            |  28 +++++-
>>  crypto/cipherpriv.h        |  11 +++
>>  include/crypto/cipher.h    |   8 ++
>>  tests/test-crypto-cipher.c |  10 +-
>>  7 files changed, 290 insertions(+), 2 deletions(-)
>>  create mode 100644 crypto/cipher-afalg.c

>> +
>> +static char *
>> +qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
>> +                                 QCryptoCipherMode mode,
>> +                                 Error **errp)
>> +{
>> +    char *name;
>> +    const char *alg_name = NULL;
>> +    const char *mode_name = NULL;
> 
> Superfluous initialization.


Ok.

> 
>> +    int ret;
>> +

>> +
>> +    mode_name = QCryptoCipherMode_lookup[mode];
>> +
>> +    name = (char *)g_new0(int8_t, SALG_NAME_LEN_MAX);
> 
> s/ (char *)g_new0(int8_t, SALG_NAME_LEN_MAX)/g_new0(char, SALG_NAME_LEN_MAX)/
> 


Ok.

> 
>> +    ret = snprintf(name, SALG_NAME_LEN_MAX, "%s(%s)", mode_name,
>> +                   alg_name);
>> +    if (ret < 0 || ret >= SALG_NAME_LEN_MAX) {

>> +
>> +QCryptoAFAlg *
>> +qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>> +                             QCryptoCipherMode mode,
>> +                             const uint8_t *key,
>> +                             size_t nkey, Error **errp)
>> +{
>> +    QCryptoAFAlg *afalg;
>> +    size_t except_niv = 0;
> 
> Doesn't need to initialize it.
> 


Ok.

>> +    char *name;
>> +
>> +    name = qcrypto_afalg_cipher_format_name(alg, mode, errp);
>> +    if (!name) {
>> +        return NULL;
>> +    }
>> +
>> +    afalg = qcrypto_afalg_comm_alloc(AFALG_TYPE_CIPHER, name, errp);
>> +    if (!afalg) {
>> +        goto error;
> 
> Leak memory pointed by name.
> 


It won't.

If failed, the control flow is error->cleanup->return, and 'name' will be freed
in 'cleanup'.

If this method success, then the control flow is cleanup->return, 'name' will
also be freed.

>> +    }
>> +
>> +    /* setkey */
>> +    if (qemu_setsockopt(afalg->tfmfd, SOL_ALG, ALG_SET_KEY, key,
>> +                        nkey) != 0) {
>> +        error_setg_errno(errp, errno, "Set key failed");
>> +        goto error;
> 
> Leak memory pointed by name.
> 


As above.

>> +    }
>> +
>> +    /* prepare msg header */
>> +    afalg->msg = g_new0(struct msghdr, 1);
>> +    afalg->msg->msg_controllen += CMSG_SPACE(ALG_OPTYPE_LEN);
>> +    except_niv = qcrypto_cipher_get_iv_len(alg, mode);
>> +    if (except_niv) {
>> +        afalg->msg->msg_controllen +=
>> CMSG_SPACE(ALG_MSGIV_LEN(except_niv));
>> +    }
>> +    afalg->msg->msg_control = g_new0(uint8_t,
>> afalg->msg->msg_controllen);
>> +
>> +    /* We use 1st msghdr for crypto-info and 2nd msghdr for IV-info */
>> +    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
>> +    afalg->cmsg->cmsg_level = SOL_ALG;
>> +    afalg->cmsg->cmsg_type = ALG_SET_OP;
>> +    afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_OPTYPE_LEN);
>> +
>> +cleanup:
>> +    g_free(name);
>> +    return afalg;
>> +
>> +error:
>> +    qcrypto_afalg_comm_free(afalg);
>> +    afalg = NULL;
>> +    goto cleanup;
>> +}
>> +
>> +static int
>> +qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
>> +                           const uint8_t *iv,
>> +                           size_t niv, Error **errp)
>> +{
>> +    struct af_alg_iv *alg_iv = NULL;
> 
> Superfluous initialization.
> 


Ok.

>> +    QCryptoAFAlg *afalg = cipher->opaque;
>> +
>> +    /* move ->cmsg to next msghdr, for IV-info */
>> +    afalg->cmsg = CMSG_NXTHDR(afalg->msg, afalg->cmsg);
>> +
>> +    /* build setiv msg */
>> +    afalg->cmsg->cmsg_level = SOL_ALG;
>> +    afalg->cmsg->cmsg_type = ALG_SET_IV;
>> +    afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_MSGIV_LEN(niv));
>> +    alg_iv = (struct af_alg_iv *)CMSG_DATA(afalg->cmsg);
>> +    alg_iv->ivlen = niv;
>> +    memcpy(alg_iv->iv, iv, niv);
> 
> Is it possible trigger memory overflow by vicious attacks ?


Oh, it's possible for a virtio-crypto user. I'll check the 'niv' in v3.
Thanks.

>> +
>> +    return 0;
>> +}
>> +
>> +static int
>> +qcrypto_afalg_cipher_op(QCryptoAFAlg *afalg,
>> +                        const void *in, void *out,
>> +                        size_t len, bool do_encrypt,
>> +                        Error **errp)
>> +{
>> +    uint32_t *type = NULL;
>> +    struct iovec iov;
>> +    size_t ret, done = 0;
>> +    uint32_t origin_contorllen;
>> +
>> +    origin_contorllen = afalg->msg->msg_controllen;
>> +    /* movev ->cmsg to first header, for crypto-info */
>> +    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
>> +
>> +    /* build encrypt msg */
>> +    afalg->msg->msg_iov = &iov;
>> +    afalg->msg->msg_iovlen = 1;
>> +    type = (uint32_t *)CMSG_DATA(afalg->cmsg);
>> +    if (do_encrypt) {
>> +        *type = ALG_OP_ENCRYPT;
>> +    } else {
>> +        *type = ALG_OP_DECRYPT;
>> +    }
>> +
>> +    do {
>> +        iov.iov_base = (void *)in + done;
>> +        iov.iov_len = len - done;
>> +
>> +        /* send info to AF_ALG core */
>> +        ret = sendmsg(afalg->opfd, afalg->msg, 0);
>> +        if (ret == -1) {
>> +            error_setg_errno(errp, errno, "Send data to AF_ALG core
>> failed");
>> +            return -1;
>> +        }
>> +
>> +        /* encrypto && get result */
>> +        if (ret != read(afalg->opfd, out, ret)) {
>> +            error_setg_errno(errp, errno, "Get result from AF_ALG core
>> failed");
>> +            return -1;
>> +        }
>> +
>> +        /* do not update IV for following chunks */
>> +        afalg->msg->msg_controllen = 0;
>> +        done += ret;
>> +    } while (done < len);
>> +
>> +    afalg->msg->msg_controllen = origin_contorllen;
>> +
>> +    return 0;
>> +}
>> +
>> +static int
>> +qcrypto_afalg_cipher_encrypt(QCryptoCipher *cipher,
>> +                             const void *in, void *out,
>> +                             size_t len, Error **errp)
>> +{
>> +    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
>> +                                   len, true, errp);
>> +}
>> +
>> +static int
>> +qcrypto_afalg_cipher_decrypt(QCryptoCipher *cipher,
>> +                             const void *in, void *out,
>> +                             size_t len, Error **errp)
>> +{
>> +    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
>> +                                   len, false, errp);
>> +}
>> +
>> +static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
>> +{
>> +    qcrypto_afalg_comm_free(cipher->opaque);
>> +}
>> +
>> +struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
>> +    .cipher_encrypt = qcrypto_afalg_cipher_encrypt,
>> +    .cipher_decrypt = qcrypto_afalg_cipher_decrypt,
>> +    .cipher_setiv = qcrypto_afalg_cipher_setiv,
>> +    .cipher_free = qcrypto_afalg_comm_ctx_free,
>> +};
>> diff --git a/crypto/cipher.c b/crypto/cipher.c
>> index a6e052c..4a6f548 100644
>> --- a/crypto/cipher.c
>> +++ b/crypto/cipher.c
>> @@ -164,17 +164,34 @@ QCryptoCipher
>> *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
>>  {
>>      QCryptoCipher *cipher;
>>      void *ctx;
>> +    Error *err2 = NULL;
>> +    QCryptoCipherDriver *drv;
>> +
>> +#ifdef CONFIG_AF_ALG
>> +    ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, &err2);
>> +    if (ctx) {
>> +        drv = &qcrypto_cipher_afalg_driver;
>> +        goto set_cipher;
>> +    }
>> +#endif
>>
>>      ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
>>      if (ctx == NULL) {
>> +        error_free(err2);
>>          return NULL;
>>      }
>>
>> +    drv = &qcrypto_cipher_lib_driver;
>> +    error_free(err2);
>> +
>> +#ifdef CONFIG_AF_ALG
>> +set_cipher:
>> +#endif
>>      cipher = g_new0(QCryptoCipher, 1);
>>      cipher->alg = alg;
>>      cipher->mode = mode;
>>      cipher->opaque = ctx;
>> -    cipher->driver = (void *)&qcrypto_cipher_lib_driver;
>> +    cipher->driver = (void *)drv;
>>
>>      return cipher;
>>  }
>> @@ -220,3 +237,12 @@ void qcrypto_cipher_free(QCryptoCipher *cipher)
>>          g_free(cipher);
>>      }
>>  }
>> +
>> +bool qcrypto_cipher_using_afalg_drv(QCryptoCipher *cipher)
>> +{
>> +#ifdef CONFIG_AF_ALG
>> +    return cipher->driver == (void *)&qcrypto_cipher_afalg_driver;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
>> index 4af5e85..91c6a7e 100644
>> --- a/crypto/cipherpriv.h
>> +++ b/crypto/cipherpriv.h
>> @@ -15,6 +15,9 @@
>>  #ifndef QCRYPTO_CIPHERPRIV_H
>>  #define QCRYPTO_CIPHERPRIV_H
>>
>> +#include "qapi-types.h"
>> +#include "afalgpriv.h"
>> +
>>  typedef struct QCryptoCipherDriver QCryptoCipherDriver;
>>
>>  struct QCryptoCipherDriver {
>> @@ -37,4 +40,12 @@ struct QCryptoCipherDriver {
>>      void (*cipher_free)(QCryptoCipher *cipher);
>>  };
>>
>> +extern QCryptoAFAlg *
>> +qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>> +                             QCryptoCipherMode mode,
>> +                             const uint8_t *key,
>> +                             size_t nkey, Error **errp);
>> +
>> +extern struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
>> +
>>  #endif
>> diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
>> index 984fb82..037f602 100644
>> --- a/include/crypto/cipher.h
>> +++ b/include/crypto/cipher.h
>> @@ -233,4 +233,12 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
>>                           const uint8_t *iv, size_t niv,
>>                           Error **errp);
>>
>> +/**
>> + * qcrypto_cipher_using_afalg_drv:
>> + * @ the cipher object
>> + *
>> + * Returns: true if @cipher is using afalg driver, otherwise false.
>> + */
>> +bool qcrypto_cipher_using_afalg_drv(QCryptoCipher *cipher);
>> +
>>  #endif /* QCRYPTO_CIPHER_H */
>> diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
>> index 07fa2fa..8bb3308 100644
>> --- a/tests/test-crypto-cipher.c
>> +++ b/tests/test-crypto-cipher.c
>> @@ -715,6 +715,7 @@ static void test_cipher_null_iv(void)
>>      uint8_t key[32] = { 0 };
>>      uint8_t plaintext[32] = { 0 };
>>      uint8_t ciphertext[32] = { 0 };
>> +    Error *err = NULL;
>>
>>      cipher = qcrypto_cipher_new(
>>          QCRYPTO_CIPHER_ALG_AES_256,
>> @@ -729,7 +730,14 @@ static void test_cipher_null_iv(void)
>>                             plaintext,
>>                             ciphertext,
>>                             sizeof(plaintext),
>> -                           &error_abort);
>> +                           &err);
>> +
>> +    if (qcrypto_cipher_using_afalg_drv(cipher)) {
>> +        g_assert(err != NULL);
>> +        error_free_or_abort(&err);
>> +    } else {
>> +        g_assert(err == NULL);
>> +    }
>>
>>      qcrypto_cipher_free(cipher);
>>  }
>> --
>> 1.8.3.1
>>
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
