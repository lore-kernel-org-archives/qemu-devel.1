Received: from eggs.gnu.org ([2001:4830:134:3::10]:53437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d06ou-0001W8-Nf
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 09:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d06or-0002mn-I4
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 09:35:56 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d06or-0002mU-D2
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 09:35:53 -0400
Received: by mail-qt0-x241.google.com with SMTP id y33so4526088qta.1
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 06:35:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-8-git-send-email-longpeng2@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c8591ca3-0f82-161f-e472-5791a12e17a3@amsat.org>
Date: Mon, 17 Apr 2017 10:35:48 -0300
MIME-Version: 1.0
In-Reply-To: <1492392806-53720-8-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 07/18] crypto: hmac: move
 crypto/hmac.h into include/crypto/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com
Cc: weidong.huang@huawei.com, mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, arei.gonglei@huawei.com

On 04/16/2017 10:33 PM, Longpeng(Mike) wrote:
> Moves crypto/hmac.h into include/crypto/, likes cipher.h and hash.h
>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  crypto/hmac.h         | 166 --------------------------------------------------
>  include/crypto/hmac.h | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 166 insertions(+), 166 deletions(-)
>  delete mode 100644 crypto/hmac.h
>  create mode 100644 include/crypto/hmac.h
>
> diff --git a/crypto/hmac.h b/crypto/hmac.h
> deleted file mode 100644
> index 0d3acd7..0000000
> --- a/crypto/hmac.h
> +++ /dev/null
> @@ -1,166 +0,0 @@
> -/*
> - * QEMU Crypto hmac algorithms
> - *
> - * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> - * (at your option) any later version.  See the COPYING file in the
> - * top-level directory.
> - *
> - */
> -
> -#ifndef QCRYPTO_HMAC_H
> -#define QCRYPTO_HMAC_H
> -
> -#include "qapi-types.h"
> -
> -typedef struct QCryptoHmac QCryptoHmac;
> -struct QCryptoHmac {
> -    QCryptoHashAlgorithm alg;
> -    void *opaque;
> -};
> -
> -/**
> - * qcrypto_hmac_supports:
> - * @alg: the hmac algorithm
> - *
> - * Determine if @alg hmac algorithm is supported by
> - * the current configured build
> - *
> - * Returns:
> - *  true if the algorithm is supported, false otherwise
> - */
> -bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg);
> -
> -/**
> - * qcrypto_hmac_new:
> - * @alg: the hmac algorithm
> - * @key: the key bytes
> - * @nkey: the length of @key
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Creates a new hmac object with the algorithm @alg
> - *
> - * The @key parameter provides the bytes representing
> - * the secret key to use. The @nkey parameter specifies
> - * the length of @key in bytes
> - *
> - * Note: must use qcrypto_hmac_free() to release the
> - * returned hmac object when no longer required
> - *
> - * Returns:
> - *  a new hmac object, or NULL on error
> - */
> -QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> -                              const uint8_t *key, size_t nkey,
> -                              Error **errp);
> -
> -/**
> - * qcrypto_hmac_free:
> - * @hmac: the hmac object
> - *
> - * Release the memory associated with @hmac that was
> - * previously allocated by qcrypto_hmac_new()
> - */
> -void qcrypto_hmac_free(QCryptoHmac *hmac);
> -
> -/**
> - * qcrypto_hmac_bytesv:
> - * @hmac: the hmac object
> - * @iov: the array of memory regions to hmac
> - * @niov: the length of @iov
> - * @result: pointer to hold output hmac
> - * @resultlen: pointer to hold length of @result
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory regions
> - * present in @iov. The @result pointer will be
> - * filled with raw bytes representing the computed
> - * hmac, which will have length @resultlen. The
> - * memory pointer in @result must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns:
> - *  0 on success, -1 on error
> - */
> -int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> -                        const struct iovec *iov,
> -                        size_t niov,
> -                        uint8_t **result,
> -                        size_t *resultlen,
> -                        Error **errp);
> -
> -/**
> - * qcrypto_hmac_bytes:
> - * @hmac: the hmac object
> - * @buf: the memory region to hmac
> - * @len: the length of @buf
> - * @result: pointer to hold output hmac
> - * @resultlen: pointer to hold length of @result
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory region
> - * @buf of length @len. The @result pointer will be
> - * filled with raw bytes representing the computed
> - * hmac, which will have length @resultlen. The
> - * memory pointer in @result must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns:
> - *  0 on success, -1 on error
> - */
> -int qcrypto_hmac_bytes(QCryptoHmac *hmac,
> -                       const char *buf,
> -                       size_t len,
> -                       uint8_t **result,
> -                       size_t *resultlen,
> -                       Error **errp);
> -
> -/**
> - * qcrypto_hmac_digestv:
> - * @hmac: the hmac object
> - * @iov: the array of memory regions to hmac
> - * @niov: the length of @iov
> - * @digest: pointer to hold output hmac
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory regions
> - * present in @iov. The @digest pointer will be
> - * filled with the printable hex digest of the computed
> - * hmac, which will be terminated by '\0'. The
> - * memory pointer in @digest must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns:
> - *  0 on success, -1 on error
> - */
> -int qcrypto_hmac_digestv(QCryptoHmac *hmac,
> -                         const struct iovec *iov,
> -                         size_t niov,
> -                         char **digest,
> -                         Error **errp);
> -
> -/**
> - * qcrypto_hmac_digest:
> - * @hmac: the hmac object
> - * @buf: the memory region to hmac
> - * @len: the length of @buf
> - * @digest: pointer to hold output hmac
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Computes the hmac across all the memory region
> - * @buf of length @len. The @digest pointer will be
> - * filled with the printable hex digest of the computed
> - * hmac, which will be terminated by '\0'. The
> - * memory pointer in @digest must be released
> - * with a call to g_free() when no longer required.
> - *
> - * Returns: 0 on success, -1 on error
> - */
> -int qcrypto_hmac_digest(QCryptoHmac *hmac,
> -                        const char *buf,
> -                        size_t len,
> -                        char **digest,
> -                        Error **errp);
> -
> -#endif
> diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
> new file mode 100644
> index 0000000..0d3acd7
> --- /dev/null
> +++ b/include/crypto/hmac.h
> @@ -0,0 +1,166 @@
> +/*
> + * QEMU Crypto hmac algorithms
> + *
> + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + *
> + */
> +
> +#ifndef QCRYPTO_HMAC_H
> +#define QCRYPTO_HMAC_H
> +
> +#include "qapi-types.h"
> +
> +typedef struct QCryptoHmac QCryptoHmac;
> +struct QCryptoHmac {
> +    QCryptoHashAlgorithm alg;
> +    void *opaque;
> +};
> +
> +/**
> + * qcrypto_hmac_supports:
> + * @alg: the hmac algorithm
> + *
> + * Determine if @alg hmac algorithm is supported by
> + * the current configured build
> + *
> + * Returns:
> + *  true if the algorithm is supported, false otherwise
> + */
> +bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg);
> +
> +/**
> + * qcrypto_hmac_new:
> + * @alg: the hmac algorithm
> + * @key: the key bytes
> + * @nkey: the length of @key
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Creates a new hmac object with the algorithm @alg
> + *
> + * The @key parameter provides the bytes representing
> + * the secret key to use. The @nkey parameter specifies
> + * the length of @key in bytes
> + *
> + * Note: must use qcrypto_hmac_free() to release the
> + * returned hmac object when no longer required
> + *
> + * Returns:
> + *  a new hmac object, or NULL on error
> + */
> +QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
> +                              const uint8_t *key, size_t nkey,
> +                              Error **errp);
> +
> +/**
> + * qcrypto_hmac_free:
> + * @hmac: the hmac object
> + *
> + * Release the memory associated with @hmac that was
> + * previously allocated by qcrypto_hmac_new()
> + */
> +void qcrypto_hmac_free(QCryptoHmac *hmac);
> +
> +/**
> + * qcrypto_hmac_bytesv:
> + * @hmac: the hmac object
> + * @iov: the array of memory regions to hmac
> + * @niov: the length of @iov
> + * @result: pointer to hold output hmac
> + * @resultlen: pointer to hold length of @result
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory regions
> + * present in @iov. The @result pointer will be
> + * filled with raw bytes representing the computed
> + * hmac, which will have length @resultlen. The
> + * memory pointer in @result must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns:
> + *  0 on success, -1 on error
> + */
> +int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
> +                        const struct iovec *iov,
> +                        size_t niov,
> +                        uint8_t **result,
> +                        size_t *resultlen,
> +                        Error **errp);
> +
> +/**
> + * qcrypto_hmac_bytes:
> + * @hmac: the hmac object
> + * @buf: the memory region to hmac
> + * @len: the length of @buf
> + * @result: pointer to hold output hmac
> + * @resultlen: pointer to hold length of @result
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory region
> + * @buf of length @len. The @result pointer will be
> + * filled with raw bytes representing the computed
> + * hmac, which will have length @resultlen. The
> + * memory pointer in @result must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns:
> + *  0 on success, -1 on error
> + */
> +int qcrypto_hmac_bytes(QCryptoHmac *hmac,
> +                       const char *buf,
> +                       size_t len,
> +                       uint8_t **result,
> +                       size_t *resultlen,
> +                       Error **errp);
> +
> +/**
> + * qcrypto_hmac_digestv:
> + * @hmac: the hmac object
> + * @iov: the array of memory regions to hmac
> + * @niov: the length of @iov
> + * @digest: pointer to hold output hmac
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory regions
> + * present in @iov. The @digest pointer will be
> + * filled with the printable hex digest of the computed
> + * hmac, which will be terminated by '\0'. The
> + * memory pointer in @digest must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns:
> + *  0 on success, -1 on error
> + */
> +int qcrypto_hmac_digestv(QCryptoHmac *hmac,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         char **digest,
> +                         Error **errp);
> +
> +/**
> + * qcrypto_hmac_digest:
> + * @hmac: the hmac object
> + * @buf: the memory region to hmac
> + * @len: the length of @buf
> + * @digest: pointer to hold output hmac
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hmac across all the memory region
> + * @buf of length @len. The @digest pointer will be
> + * filled with the printable hex digest of the computed
> + * hmac, which will be terminated by '\0'. The
> + * memory pointer in @digest must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hmac_digest(QCryptoHmac *hmac,
> +                        const char *buf,
> +                        size_t len,
> +                        char **digest,
> +                        Error **errp);
> +
> +#endif
>
