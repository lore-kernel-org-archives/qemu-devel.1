Received: from eggs.gnu.org ([2001:4830:134:3::10]:48848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWSX-0002sl-9B
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWSU-0008K4-31
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxWST-0008Jk-Qh
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:22:06 -0400
Date: Mon, 10 Apr 2017 11:21:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410102159.GJ3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491814865-62912-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491814865-62912-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 16/19] crypto: hash: add af_alg
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
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Apr 10, 2017 at 05:01:05PM +0800, Longpeng(Mike) wrote:
> Adds afalg-backend hash support: introduces some private APIs
> firstly, and then intergrates them into qcrypto_hash_afalg_driver.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/Makefile.objs        |   1 +
>  crypto/hash-afalg.c         | 150 ++++++++++++++++++++++++++++++++++++++++++++
>  crypto/hash.c               |  16 ++++-
>  include/crypto/afalg-comm.h |   1 +
>  include/crypto/hash.h       |   1 +
>  5 files changed, 166 insertions(+), 3 deletions(-)
>  create mode 100644 crypto/hash-afalg.c
> 

> +static int afalg_hash_format_name(QCryptoHashAlgorithm alg,
> +                                  AfalgSocketAddress *afalg)
> +{
> +    const char *alg_name = NULL;
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
> +        return -1;
> +    }
> +
> +    afalg->name = (char *)g_new0(int8_t, SALG_NAME_LEN_MAX);
> +    sprintf(afalg->name, "%s", alg_name);

Another printf without any bounds checking.


> +
> +    return 0;
> +}
> +
> +static QCryptoAfalg *afalg_hash_ctx_new(QCryptoHashAlgorithm alg)
> +{
> +    SocketAddress *saddr = NULL;
> +    QCryptoAfalg *afalg = NULL;
> +    int ret = 0;
> +
> +    saddr = g_new0(SocketAddress, 1);
> +    saddr->u.afalg.data = g_new0(AfalgSocketAddress, 1);
> +    saddr->type = SOCKET_ADDRESS_KIND_AFALG;
> +    ret = afalg_hash_format_name(alg, saddr->u.afalg.data);
> +    if (ret != 0) {
> +        goto error;
> +    }
> +    afalg_comm_format_type(saddr->u.afalg.data, ALG_TYPE_HASH);
> +
> +    afalg = afalg_comm_alloc(saddr);
> +    if (!afalg) {
> +        goto error;
> +    }
> +
> +    /* prepare msg header */
> +    afalg->msg = g_new0(struct msghdr, 1);
> +
> +cleanup:
> +    g_free(saddr->u.afalg.data->type);
> +    g_free(saddr->u.afalg.data->name);
> +    g_free(saddr->u.afalg.data);
> +    g_free(saddr);
> +    return afalg;
> +
> +error:
> +    afalg_comm_free(afalg);
> +    afalg = NULL;
> +    goto cleanup;
> +}
> +
> +static int afalg_hash_bytesv(QCryptoHashAlgorithm alg,
> +                             const struct iovec *iov,
> +                             size_t niov, uint8_t **result,
> +                             size_t *resultlen,
> +                             Error **errp)
> +{
> +    QCryptoAfalg *afalg = NULL;
> +    struct iovec outv;
> +    int ret = 0;
> +    const int except_len = qcrypto_hash_digest_len(alg);
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
> +    afalg = afalg_hash_ctx_new(alg);
> +    if (afalg == NULL) {
> +        error_setg(errp, "Alloc QCryptoAfalg object failed");

Make afalg_hash_ctx_new() report the error

> +        return -1;
> +    }
> +
> +    /* send data to kernel's crypto core */
> +    ret = iov_send_recv(afalg->opfd, iov, niov,
> +                        0, iov_size(iov, niov), true);
> +    if (ret < 0) {
> +        error_setg(errp, "Send data to afalg-core failed");

error_setg_errno()

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
> +        error_setg(errp, "Recv result from afalg-core failed");
> +    }
> +
> +out:
> +    afalg_comm_free(afalg);
> +    return ret;
> +}
> +
> +QCryptoHashDriver qcrypto_hash_afalg_driver = {
> +    .hash_bytesv = afalg_hash_bytesv,
> +};

All methods should have a qcrypto_afalg_ name prefix.

> diff --git a/crypto/hash.c b/crypto/hash.c
> index 0b0d479..002622c 100644
> --- a/crypto/hash.c
> +++ b/crypto/hash.c
> @@ -45,9 +45,19 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
>                          size_t *resultlen,
>                          Error **errp)
>  {
> -    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
> -                                               result, resultlen,
> -                                               errp);
> +    int ret;
> +
> +    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
> +                                                result, resultlen,
> +                                                errp);
> +    if (ret == 0) {
> +        return ret;
> +    }
> +
> +    ret = qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
> +                                              result, resultlen,
> +                                              errp);
> +    return ret;
>  }
>  
>  
> diff --git a/include/crypto/afalg-comm.h b/include/crypto/afalg-comm.h
> index 34f30dc..3293949 100644
> --- a/include/crypto/afalg-comm.h
> +++ b/include/crypto/afalg-comm.h
> @@ -20,6 +20,7 @@
>  #endif
>  
>  #define ALG_TYPE_CIPHER "skcipher"
> +#define ALG_TYPE_HASH   "hash"
>  
>  #define ALG_OPTYPE_LEN 4
>  #define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 00b764e..eeb17a8 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -36,6 +36,7 @@ struct QCryptoHashDriver {
>  };
>  
>  extern QCryptoHashDriver qcrypto_hash_lib_driver;
> +extern QCryptoHashDriver qcrypto_hash_afalg_driver;
>  
>  /**
>   * qcrypto_hash_supports:
> -- 
> 1.8.3.1
> 
> 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
