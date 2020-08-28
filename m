Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E724C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4ACD20714
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnerbtXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ACD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBejP-0006A0-Rp
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBeiO-0004ov-4i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:46:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBeiG-0000Hu-Ta
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598622399;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFvIYi927tpnK1lDdfMdTcl3yaRcrf3zZzAeawYi4Hk=;
 b=QnerbtXlyBz5W8QLDlRe7I4LEKBc1tj9JzMGmZe0Db1d2lMKu0w/nae6IJykdkOeC/xwri
 2LipqkQQ2PG6eXbBQYUgzYLY+dI1wgJqDBRqoxGrtpRwfVKAlHwXsPSWxl0zZF1PkOfRu1
 j/EDkszSyjjyhMl3wBIVixvNEFXhHc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-QxvapOAgNKCBtl3KIGUbxQ-1; Fri, 28 Aug 2020 09:46:37 -0400
X-MC-Unique: QxvapOAgNKCBtl3KIGUbxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FAF210ABDCC;
 Fri, 28 Aug 2020 13:46:36 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.ams2.redhat.com [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68FB4672CD;
 Fri, 28 Aug 2020 13:46:35 +0000 (UTC)
Date: Fri, 28 Aug 2020 14:46:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 16/17] crypto/nettle: Split QCryptoCipherNettle into
 subclasses
Message-ID: <20200828134632.GJ224144@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-17-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200813032537.2888593-17-richard.henderson@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 08:25:36PM -0700, Richard Henderson wrote:
> Use separate classes for each cipher entry point: des_rfb, des3,
> aes128, aes192, aes256, cast128, serpent, and twofish.
> 
> Generate wrappers for XTS only for CONFIG_QEMU_PRIVATE_XTS.
> This eliminates unreachable wrappers for DES_RFB, DES3 and
> CAST128, which have blocksizes that do not allow XTS mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  crypto/cipher-nettle.inc.c | 987 +++++++++++++++++++------------------
>  1 file changed, 503 insertions(+), 484 deletions(-)
> 
> diff --git a/crypto/cipher-nettle.inc.c b/crypto/cipher-nettle.inc.c
> index 36d57ef430..a1f4f6eac6 100644
> --- a/crypto/cipher-nettle.inc.c
> +++ b/crypto/cipher-nettle.inc.c
> @@ -34,8 +34,6 @@
>  #include <nettle/xts.h>
>  #endif
>  
> -static const struct QCryptoCipherDriver qcrypto_cipher_lib_driver;
> -
>  typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
>                                                 size_t length,
>                                                 uint8_t *dst,
> @@ -75,62 +73,212 @@ typedef const void * cipher_ctx_t;
>  typedef size_t       cipher_length_t;
>  #endif
>  
> -typedef struct QCryptoNettleAES128 {
> -    struct aes128_ctx enc;
> -    struct aes128_ctx dec;
> -} QCryptoNettleAES128;
> -
> -typedef struct QCryptoNettleAES192 {
> -    struct aes192_ctx enc;
> -    struct aes192_ctx dec;
> -} QCryptoNettleAES192;
> -
> -typedef struct QCryptoNettleAES256 {
> -    struct aes256_ctx enc;
> -    struct aes256_ctx dec;
> -} QCryptoNettleAES256;
> -
> -static void aes128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> -                                  uint8_t *dst, const uint8_t *src)
> +static inline bool qcrypto_length_check(size_t len, size_t blocksize,
> +                                        Error **errp)
>  {
> -    const QCryptoNettleAES128 *aesctx = ctx;
> -    aes128_encrypt(&aesctx->enc, length, dst, src);
> +    if (unlikely(len & (blocksize - 1))) {
> +        error_setg(errp, "Length %zu must be a multiple of block size %zu",
> +                   len, blocksize);
> +        return false;
> +    }
> +    return true;
>  }
>  
> -static void aes128_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> -                                  uint8_t *dst, const uint8_t *src)
> +
> +static void qcrypto_cipher_ctx_free(QCryptoCipher *ctx)
>  {
> -    const QCryptoNettleAES128 *aesctx = ctx;
> -    aes128_decrypt(&aesctx->dec, length, dst, src);
> +    g_free(ctx);
>  }
>  
> -static void aes192_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> -                               uint8_t *dst, const uint8_t *src)
> +static int qcrypto_cipher_no_setiv(QCryptoCipher *cipher,
> +                                   const uint8_t *iv, size_t niv,
> +                                   Error **errp)
>  {
> -    const QCryptoNettleAES192 *aesctx = ctx;
> -    aes192_encrypt(&aesctx->enc, length, dst, src);
> +    error_setg(errp, "Setting IV is not supported");
> +    return -1;
>  }
>  
> -static void aes192_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> -                               uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES192 *aesctx = ctx;
> -    aes192_decrypt(&aesctx->dec, length, dst, src);
> +
> +#define DEFINE_SETIV(NAME, TYPE, BLEN)                                  \
> +static int NAME##_setiv(QCryptoCipher *cipher, const uint8_t *iv,       \
> +                        size_t niv, Error **errp)                       \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (niv != BLEN) {                                                  \
> +        error_setg(errp, "Expected IV size %d not %zu", BLEN, niv);     \
> +        return -1;                                                      \
> +    }                                                                   \
> +    memcpy(ctx->iv, iv, niv);                                           \
> +    return 0;                                                           \
>  }
>  
> -static void aes256_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> -                               uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES256 *aesctx = ctx;
> -    aes256_encrypt(&aesctx->enc, length, dst, src);
> -}
>  
> -static void aes256_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> -                               uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES256 *aesctx = ctx;
> -    aes256_decrypt(&aesctx->dec, length, dst, src);
> +#define DEFINE_ECB(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                  \
> +static int NAME##_encrypt_ecb(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    ENCRYPT(&ctx->key, len, out, in);                                   \
> +    return 0;                                                           \
> +}                                                                       \
> +static int NAME##_decrypt_ecb(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    DECRYPT(&ctx->key, len, out, in);                                   \
> +    return 0;                                                           \
> +}                                                                       \
> +static const struct QCryptoCipherDriver NAME##_driver_ecb = {           \
> +    .cipher_encrypt = NAME##_encrypt_ecb,                               \
> +    .cipher_decrypt = NAME##_decrypt_ecb,                               \
> +    .cipher_setiv = qcrypto_cipher_no_setiv,                            \
> +    .cipher_free = qcrypto_cipher_ctx_free,                             \
> +};
> +
> +
> +#define DEFINE_CBC(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                  \
> +static int NAME##_encrypt_cbc(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    cbc_encrypt(&ctx->key, ENCRYPT, BLEN, ctx->iv, len, out, in);       \
> +    return 0;                                                           \
> +}                                                                       \
> +static int NAME##_decrypt_cbc(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    cbc_decrypt(&ctx->key, DECRYPT, BLEN, ctx->iv, len, out, in);       \
> +    return 0;                                                           \
> +}                                                                       \
> +static const struct QCryptoCipherDriver NAME##_driver_cbc = {           \
> +    .cipher_encrypt = NAME##_encrypt_cbc,                               \
> +    .cipher_decrypt = NAME##_decrypt_cbc,                               \
> +    .cipher_setiv = NAME##_setiv,                                       \
> +    .cipher_free = qcrypto_cipher_ctx_free,                             \
> +};
> +
> +
> +#define DEFINE_CTR(NAME, TYPE, BLEN, ENCRYPT)                           \
> +static int NAME##_encrypt_ctr(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    ctr_crypt(&ctx->key, ENCRYPT, BLEN, ctx->iv, len, out, in);         \
> +    return 0;                                                           \
> +}                                                                       \
> +static const struct QCryptoCipherDriver NAME##_driver_ctr = {           \
> +    .cipher_encrypt = NAME##_encrypt_ctr,                               \
> +    .cipher_decrypt = NAME##_encrypt_ctr,                               \
> +    .cipher_setiv = NAME##_setiv,                                       \
> +    .cipher_free = qcrypto_cipher_ctx_free,                             \
> +};
> +
> +
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
> +#define DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                 \
> +static void NAME##_xts_wrape(const void *ctx, size_t length,            \
> +                             uint8_t *dst, const uint8_t *src)          \
> +{                                                                       \
> +    ENCRYPT(ctx, length, dst, src);                                     \
> +}                                                                       \
> +static void NAME##_xts_wrapd(const void *ctx, size_t length,            \
> +                             uint8_t *dst, const uint8_t *src)          \
> +{                                                                       \
> +    DECRYPT(ctx, length, dst, src);                                     \
> +}                                                                       \
> +static int NAME##_encrypt_xts(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    xts_encrypt(&ctx->key, &ctx->key_xts,                               \
> +                NAME##_xts_wrape, NAME##_xts_wrapd,                     \
> +                ctx->iv, len, out, in);                                 \
> +    return 0;                                                           \
> +}                                                                       \
> +static int NAME##_decrypt_xts(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    xts_decrypt(&ctx->key, &ctx->key_xts,                               \
> +                NAME##_xts_wrape, NAME##_xts_wrapd,                     \
> +                ctx->iv, len, out, in);                                 \
> +    return 0;                                                           \
>  }
> +#else
> +#define DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                 \
> +static int NAME##_encrypt_xts(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    xts_encrypt_message(&ctx->key, &ctx->key_xts, ENCRYPT,              \
> +                        ctx->iv, len, out, in);                         \
> +    return 0;                                                           \
> +}                                                                       \
> +static int NAME##_decrypt_xts(QCryptoCipher *cipher, const void *in,    \
> +                              void *out, size_t len, Error **errp)      \
> +{                                                                       \
> +    TYPE *ctx = container_of(cipher, TYPE, base);                       \
> +    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
> +        return -1;                                                      \
> +    }                                                                   \
> +    xts_decrypt_message(&ctx->key, &ctx->key_xts, DECRYPT, ENCRYPT,     \
> +                        ctx->iv, len, out, in);                         \
> +    return 0;                                                           \
> +}
> +#endif
> +
> +#define DEFINE_XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)          \
> +    QEMU_BUILD_BUG_ON(BLEN != XTS_BLOCK_SIZE);                  \
> +    DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)             \
> +static const struct QCryptoCipherDriver NAME##_driver_xts = {   \
> +    .cipher_encrypt = NAME##_encrypt_xts,                       \
> +    .cipher_decrypt = NAME##_decrypt_xts,                       \
> +    .cipher_setiv = NAME##_setiv,                               \
> +    .cipher_free = qcrypto_cipher_ctx_free,                     \
> +};
> +
> +
> +#define DEFINE_ECB_CBC_CTR(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)  \
> +    DEFINE_SETIV(NAME, TYPE, BLEN)                              \
> +    DEFINE_ECB(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)              \
> +    DEFINE_CBC(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)              \
> +    DEFINE_CTR(NAME, TYPE, BLEN, ENCRYPT)
> +
> +#define DEFINE_ECB_CBC_CTR_XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)      \
> +    DEFINE_ECB_CBC_CTR(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)              \
> +    DEFINE_XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)
> +
> +
> +typedef struct QCryptoNettleDESRFB {
> +    QCryptoCipher base;
> +    struct des_ctx key;
> +    uint8_t iv[DES_BLOCK_SIZE];
> +} QCryptoNettleDESRFB;
>  
>  static void des_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>                                 uint8_t *dst, const uint8_t *src)
> @@ -144,6 +292,16 @@ static void des_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>      des_decrypt(ctx, length, dst, src);
>  }
>  
> +DEFINE_ECB_CBC_CTR(qcrypto_nettle_des_rfb, QCryptoNettleDESRFB,
> +                   DES_BLOCK_SIZE, des_encrypt_native, des_decrypt_native)
> +
> +
> +typedef struct QCryptoNettleDES3 {
> +    QCryptoCipher base;
> +    struct des3_ctx key;
> +    uint8_t iv[DES3_BLOCK_SIZE];
> +} QCryptoNettleDES3;
> +
>  static void des3_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>                                  uint8_t *dst, const uint8_t *src)
>  {
> @@ -156,6 +314,94 @@ static void des3_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>      des3_decrypt(ctx, length, dst, src);
>  }
>  
> +DEFINE_ECB_CBC_CTR(qcrypto_nettle_des3, QCryptoNettleDES3, DES3_BLOCK_SIZE,
> +                   des3_encrypt_native, des3_decrypt_native)
> +
> +
> +typedef struct QCryptoNettleAES128 {
> +    QCryptoCipher base;
> +    uint8_t iv[AES_BLOCK_SIZE];
> +    /* First key from pair is encode, second key is decode. */
> +    struct aes128_ctx key[2], key_xts[2];
> +} QCryptoNettleAES128;
> +
> +static void aes128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                                  uint8_t *dst, const uint8_t *src)
> +{
> +    const struct aes128_ctx *keys = ctx;
> +    aes128_encrypt(&keys[0], length, dst, src);
> +}
> +
> +static void aes128_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                                  uint8_t *dst, const uint8_t *src)
> +{
> +    const struct aes128_ctx *keys = ctx;
> +    aes128_decrypt(&keys[1], length, dst, src);
> +}
> +
> +DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_aes128,
> +                       QCryptoNettleAES128, AES_BLOCK_SIZE,
> +                       aes128_encrypt_native, aes128_decrypt_native)
> +
> +
> +typedef struct QCryptoNettleAES192 {
> +    QCryptoCipher base;
> +    uint8_t iv[AES_BLOCK_SIZE];
> +    /* First key from pair is encode, second key is decode. */
> +    struct aes192_ctx key[2], key_xts[2];
> +} QCryptoNettleAES192;
> +
> +static void aes192_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                                  uint8_t *dst, const uint8_t *src)
> +{
> +    const struct aes192_ctx *keys = ctx;
> +    aes192_encrypt(&keys[0], length, dst, src);
> +}
> +
> +static void aes192_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                                  uint8_t *dst, const uint8_t *src)
> +{
> +    const struct aes192_ctx *keys = ctx;
> +    aes192_decrypt(&keys[1], length, dst, src);
> +}
> +
> +DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_aes192,
> +                       QCryptoNettleAES192, AES_BLOCK_SIZE,
> +                       aes192_encrypt_native, aes192_decrypt_native)
> +
> +
> +typedef struct QCryptoNettleAES256 {
> +    QCryptoCipher base;
> +    uint8_t iv[AES_BLOCK_SIZE];
> +    /* First key from pair is encode, second key is decode. */
> +    struct aes256_ctx key[2], key_xts[2];
> +} QCryptoNettleAES256;
> +
> +static void aes256_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                                  uint8_t *dst, const uint8_t *src)
> +{
> +    const struct aes256_ctx *keys = ctx;
> +    aes256_encrypt(&keys[0], length, dst, src);
> +}
> +
> +static void aes256_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +                               uint8_t *dst, const uint8_t *src)
> +{
> +    const struct aes256_ctx *keys = ctx;
> +    aes256_decrypt(&keys[1], length, dst, src);
> +}
> +
> +DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_aes256,
> +                       QCryptoNettleAES256, AES_BLOCK_SIZE,
> +                       aes256_encrypt_native, aes256_decrypt_native)
> +
> +
> +typedef struct QCryptoNettleCAST128 {
> +    QCryptoCipher base;
> +    uint8_t iv[CAST128_BLOCK_SIZE];
> +    struct cast128_ctx key, key_xts;
> +} QCryptoNettleCAST128;
> +
>  static void cast128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>                                     uint8_t *dst, const uint8_t *src)
>  {
> @@ -168,6 +414,18 @@ static void cast128_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>      cast128_decrypt(ctx, length, dst, src);
>  }
>  
> +DEFINE_ECB_CBC_CTR(qcrypto_nettle_cast128,
> +                   QCryptoNettleCAST128, CAST128_BLOCK_SIZE,
> +                   cast128_encrypt_native, cast128_decrypt_native)
> +
> +
> +typedef struct QCryptoNettleSerpent {
> +    QCryptoCipher base;
> +    uint8_t iv[SERPENT_BLOCK_SIZE];
> +    struct serpent_ctx key, key_xts;
> +} QCryptoNettleSerpent;
> +
> +
>  static void serpent_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>                                     uint8_t *dst, const uint8_t *src)
>  {
> @@ -180,6 +438,17 @@ static void serpent_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>      serpent_decrypt(ctx, length, dst, src);
>  }
>  
> +DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_serpent,
> +                       QCryptoNettleSerpent, SERPENT_BLOCK_SIZE,
> +                       serpent_encrypt_native, serpent_decrypt_native)
> +
> +
> +typedef struct QCryptoNettleTwofish {
> +    QCryptoCipher base;
> +    uint8_t iv[TWOFISH_BLOCK_SIZE];
> +    struct twofish_ctx key, key_xts;
> +} QCryptoNettleTwofish;
> +
>  static void twofish_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>                                     uint8_t *dst, const uint8_t *src)
>  {
> @@ -192,125 +461,10 @@ static void twofish_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
>      twofish_decrypt(ctx, length, dst, src);
>  }
>  
> -static void aes128_encrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES128 *aesctx = ctx;
> -    aes128_encrypt(&aesctx->enc, length, dst, src);
> -}
> +DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_twofish,
> +                       QCryptoNettleTwofish, TWOFISH_BLOCK_SIZE,
> +                       twofish_encrypt_native, twofish_decrypt_native)
>  
> -static void aes128_decrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES128 *aesctx = ctx;
> -    aes128_decrypt(&aesctx->dec, length, dst, src);
> -}
> -
> -static void aes192_encrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES192 *aesctx = ctx;
> -    aes192_encrypt(&aesctx->enc, length, dst, src);
> -}
> -
> -static void aes192_decrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES192 *aesctx = ctx;
> -    aes192_decrypt(&aesctx->dec, length, dst, src);
> -}
> -
> -static void aes256_encrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES256 *aesctx = ctx;
> -    aes256_encrypt(&aesctx->enc, length, dst, src);
> -}
> -
> -static void aes256_decrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    const QCryptoNettleAES256 *aesctx = ctx;
> -    aes256_decrypt(&aesctx->dec, length, dst, src);
> -}
> -
> -static void des_encrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    des_encrypt(ctx, length, dst, src);
> -}
> -
> -static void des_decrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    des_decrypt(ctx, length, dst, src);
> -}
> -
> -static void des3_encrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    des3_encrypt(ctx, length, dst, src);
> -}
> -
> -static void des3_decrypt_wrapper(const void *ctx, size_t length,
> -                                uint8_t *dst, const uint8_t *src)
> -{
> -    des3_decrypt(ctx, length, dst, src);
> -}
> -
> -static void cast128_encrypt_wrapper(const void *ctx, size_t length,
> -                                    uint8_t *dst, const uint8_t *src)
> -{
> -    cast128_encrypt(ctx, length, dst, src);
> -}
> -
> -static void cast128_decrypt_wrapper(const void *ctx, size_t length,
> -                                    uint8_t *dst, const uint8_t *src)
> -{
> -    cast128_decrypt(ctx, length, dst, src);
> -}
> -
> -static void serpent_encrypt_wrapper(const void *ctx, size_t length,
> -                                    uint8_t *dst, const uint8_t *src)
> -{
> -    serpent_encrypt(ctx, length, dst, src);
> -}
> -
> -static void serpent_decrypt_wrapper(const void *ctx, size_t length,
> -                                    uint8_t *dst, const uint8_t *src)
> -{
> -    serpent_decrypt(ctx, length, dst, src);
> -}
> -
> -static void twofish_encrypt_wrapper(const void *ctx, size_t length,
> -                                    uint8_t *dst, const uint8_t *src)
> -{
> -    twofish_encrypt(ctx, length, dst, src);
> -}
> -
> -static void twofish_decrypt_wrapper(const void *ctx, size_t length,
> -                                    uint8_t *dst, const uint8_t *src)
> -{
> -    twofish_decrypt(ctx, length, dst, src);
> -}
> -
> -typedef struct QCryptoCipherNettle QCryptoCipherNettle;
> -struct QCryptoCipherNettle {
> -    QCryptoCipher base;
> -
> -    /* Primary cipher context for all modes */
> -    void *ctx;
> -    /* Second cipher context for XTS mode only */
> -    void *ctx_tweak;
> -    /* Cipher callbacks for both contexts */
> -    QCryptoCipherNettleFuncNative alg_encrypt_native;
> -    QCryptoCipherNettleFuncNative alg_decrypt_native;
> -    QCryptoCipherNettleFuncWrapper alg_encrypt_wrapper;
> -    QCryptoCipherNettleFuncWrapper alg_decrypt_wrapper;
> -    /* Initialization vector or Counter */
> -    uint8_t *iv;
> -    size_t blocksize;
> -};
>  
>  bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>                               QCryptoCipherMode mode)
> @@ -344,30 +498,12 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>      }
>  }
>  
> -
> -static void
> -qcrypto_nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
> -{
> -    if (!ctx) {
> -        return;
> -    }
> -
> -    g_free(ctx->iv);
> -    g_free(ctx->ctx);
> -    g_free(ctx->ctx_tweak);
> -    g_free(ctx);
> -}
> -
> -
>  static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>                                               QCryptoCipherMode mode,
>                                               const uint8_t *key,
>                                               size_t nkey,
>                                               Error **errp)
>  {
> -    QCryptoCipherNettle *ctx;
> -    uint8_t *rfbkey;
> -
>      switch (mode) {
>      case QCRYPTO_CIPHER_MODE_ECB:
>      case QCRYPTO_CIPHER_MODE_CBC:
> @@ -375,6 +511,7 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>      case QCRYPTO_CIPHER_MODE_CTR:
>          break;
>      default:
> +    bad_cipher_mode:
>          error_setg(errp, "Unsupported cipher mode %s",
>                     QCryptoCipherMode_str(mode));

Lets put this jump target at the end of the method, so we avoid having
to jump backwards in the code.


Aside from that

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


