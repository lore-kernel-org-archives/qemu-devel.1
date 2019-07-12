Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABC3C742B9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0943720863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmQ7D2ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0943720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hluMv-0008I6-A0
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 08:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33270)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hluMj-0007ts-IT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hluMi-00006M-02
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:09:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hluMh-00005k-MF
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:09:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so9759853wrs.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3nPNckTOEUVI8tn7Ee3AgGea9nYCKN+5LDF6gPS97Xg=;
 b=QmQ7D2jaX6eYWkeMT35ZEQttvslJHqr5qEKGsvZPAXA6l1BFaAvmwwafG+FaCK3kfR
 gM+5oOjujtndZhEuLiy/AXeYwhKf8z7R9eUCs0ADXFwRoIh+MkiEa9i6VfFY+jcfU3eq
 zuIg/f92Tt+KlImJ35l/iM1nCx13dS3/jOxgvwnzWZS7nL9lpu2C/QDfGvULxfrIA0NV
 FRET+vzQRQbvea3Ear5ynTipPG/f7q793IT7ppmVyzj/pAScFCHOmyTiVTzKk9GTII1A
 0D293sfw+kUV9c1JzAddoGwU6tQbCNVjp+0A3tSzRg8IQHw6aNREKOVDgus8V0DBPouE
 9IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3nPNckTOEUVI8tn7Ee3AgGea9nYCKN+5LDF6gPS97Xg=;
 b=IDWe+xfHG2//VazcHX+mBhCihEpjz1QQiIppZfzE0SxGPJH/HVb/W6BWaQQDrsh6YF
 T5jr7vFutZLzK2MLdWEvM7plTTKg2vbHKlcFoDpOBm/5dHYa20dMrq4CvN5/CgbGJXfv
 QFuwYqKJ0dxrAiofpruJwUkzsw51GN58MeLdd2UPCDWxqE4nkZlSdh6a+s+l3UByyuGK
 nRZlHAmf/XUjHv1/fVyTl+tAGjYmDVWjigVSF/cpy/U4pGUKh9ZxB74n1z8qIqerYFgK
 ScEVUHwIE9+x3qCqoEtgt6jBwDfmLI8NO5I99L8QR3VnZM4A7nDXhxZFKrvKYu8qJusC
 Y53A==
X-Gm-Message-State: APjAAAUmSIpiP4HFZmfb5kblaldbtsOhJGPv9IQuZ/Oi44FILLGvZLyX
 iKILZVlCvjWLSo2XovBYYdrvfA==
X-Google-Smtp-Source: APXvYqzd9BE3LLwIDCzE0ZuwvZcbfSsxuI+c2DQ/SkPo2p7XJklu3ytAoDPXUsEy+FuvE2zFm5LLaw==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr11587478wri.7.1562933366198; 
 Fri, 12 Jul 2019 05:09:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z7sm7062886wrh.67.2019.07.12.05.09.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 05:09:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 137451FF87;
 Fri, 12 Jul 2019 13:09:25 +0100 (BST)
References: <20190712101849.8993-1-berrange@redhat.com>
 <20190712101849.8993-2-berrange@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190712101849.8993-2-berrange@redhat.com>
Date: Fri, 12 Jul 2019 13:09:25 +0100
Message-ID: <874l3re9oq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/2] crypto: switch to modern
 nettle AES APIs
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
Cc: Amol Surati <suratiamol@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The aes_ctx struct and aes_* functions have been deprecated in nettle
> 3.5, in favour of keysize specific functions which were introduced
> first in nettle 3.0.
>
> Switch QEMU code to use the new APIs and add some backcompat defines
> such that it still builds on nettle 2.7
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  crypto/cipher-nettle.c | 218 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 183 insertions(+), 35 deletions(-)
>
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index 3848cb3b3a..115d16dd7b 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -42,29 +42,89 @@ typedef void *       cipher_ctx_t;
>  typedef unsigned     cipher_length_t;
>
>  #define cast5_set_key cast128_set_key
> +
> +#define aes128_ctx aes_ctx
> +#define aes192_ctx aes_ctx
> +#define aes256_ctx aes_ctx
> +#define aes128_set_encrypt_key(c, k) \
> +    aes_set_encrypt_key(c, 16, k)
> +#define aes192_set_encrypt_key(c, k) \
> +    aes_set_encrypt_key(c, 24, k)
> +#define aes256_set_encrypt_key(c, k) \
> +    aes_set_encrypt_key(c, 32, k)
> +#define aes128_set_decrypt_key(c, k) \
> +    aes_set_decrypt_key(c, 16, k)
> +#define aes192_set_decrypt_key(c, k) \
> +    aes_set_decrypt_key(c, 24, k)
> +#define aes256_set_decrypt_key(c, k) \
> +    aes_set_decrypt_key(c, 32, k)
> +#define aes128_encrypt aes_encrypt
> +#define aes192_encrypt aes_encrypt
> +#define aes256_encrypt aes_encrypt
> +#define aes128_decrypt aes_decrypt
> +#define aes192_decrypt aes_decrypt
> +#define aes256_decrypt aes_decrypt
>  #else
>  typedef nettle_cipher_func * QCryptoCipherNettleFuncNative;
>  typedef const void * cipher_ctx_t;
>  typedef size_t       cipher_length_t;
>  #endif
>
> -typedef struct QCryptoNettleAES {
> -    struct aes_ctx enc;
> -    struct aes_ctx dec;
> -} QCryptoNettleAES;
> +typedef struct QCryptoNettleAES128 {
> +    struct aes128_ctx enc;
> +    struct aes128_ctx dec;
> +} QCryptoNettleAES128;
> +
> +typedef struct QCryptoNettleAES192 {
> +    struct aes192_ctx enc;
> +    struct aes192_ctx dec;
> +} QCryptoNettleAES192;
> +
> +typedef struct QCryptoNettleAES256 {
> +    struct aes256_ctx enc;
> +    struct aes256_ctx dec;
> +} QCryptoNettleAES256;
> +
> +static void aes128_encrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
> +                                  uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES128 *aesctx =3D ctx;
> +    aes128_encrypt(&aesctx->enc, length, dst, src);
> +}
> +
> +static void aes128_decrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
> +                                  uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES128 *aesctx =3D ctx;
> +    aes128_decrypt(&aesctx->dec, length, dst, src);
> +}
> +
> +static void aes192_encrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
> +                               uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES192 *aesctx =3D ctx;
> +    aes192_encrypt(&aesctx->enc, length, dst, src);
> +}
> +
> +static void aes192_decrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
> +                               uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES192 *aesctx =3D ctx;
> +    aes192_decrypt(&aesctx->dec, length, dst, src);
> +}
>
> -static void aes_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +static void aes256_encrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
>                                 uint8_t *dst, const uint8_t *src)
>  {
> -    const QCryptoNettleAES *aesctx =3D ctx;
> -    aes_encrypt(&aesctx->enc, length, dst, src);
> +    const QCryptoNettleAES256 *aesctx =3D ctx;
> +    aes256_encrypt(&aesctx->enc, length, dst, src);
>  }
>
> -static void aes_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> +static void aes256_decrypt_native(cipher_ctx_t ctx, cipher_length_t leng=
th,
>                                 uint8_t *dst, const uint8_t *src)
>  {
> -    const QCryptoNettleAES *aesctx =3D ctx;
> -    aes_decrypt(&aesctx->dec, length, dst, src);
> +    const QCryptoNettleAES256 *aesctx =3D ctx;
> +    aes256_decrypt(&aesctx->dec, length, dst, src);
>  }
>
>  static void des_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
> @@ -127,18 +187,46 @@ static void twofish_decrypt_native(cipher_ctx_t ctx=
, cipher_length_t length,
>      twofish_decrypt(ctx, length, dst, src);
>  }
>
> -static void aes_encrypt_wrapper(const void *ctx, size_t length,
> +static void aes128_encrypt_wrapper(const void *ctx, size_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES128 *aesctx =3D ctx;
> +    aes128_encrypt(&aesctx->enc, length, dst, src);
> +}
> +
> +static void aes128_decrypt_wrapper(const void *ctx, size_t length,
>                                  uint8_t *dst, const uint8_t *src)
>  {
> -    const QCryptoNettleAES *aesctx =3D ctx;
> -    aes_encrypt(&aesctx->enc, length, dst, src);
> +    const QCryptoNettleAES128 *aesctx =3D ctx;
> +    aes128_decrypt(&aesctx->dec, length, dst, src);
>  }
>
> -static void aes_decrypt_wrapper(const void *ctx, size_t length,
> +static void aes192_encrypt_wrapper(const void *ctx, size_t length,
>                                  uint8_t *dst, const uint8_t *src)
>  {
> -    const QCryptoNettleAES *aesctx =3D ctx;
> -    aes_decrypt(&aesctx->dec, length, dst, src);
> +    const QCryptoNettleAES192 *aesctx =3D ctx;
> +    aes192_encrypt(&aesctx->enc, length, dst, src);
> +}
> +
> +static void aes192_decrypt_wrapper(const void *ctx, size_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES192 *aesctx =3D ctx;
> +    aes192_decrypt(&aesctx->dec, length, dst, src);
> +}
> +
> +static void aes256_encrypt_wrapper(const void *ctx, size_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES256 *aesctx =3D ctx;
> +    aes256_encrypt(&aesctx->enc, length, dst, src);
> +}
> +
> +static void aes256_decrypt_wrapper(const void *ctx, size_t length,
> +                                uint8_t *dst, const uint8_t *src)
> +{
> +    const QCryptoNettleAES256 *aesctx =3D ctx;
> +    aes256_decrypt(&aesctx->dec, length, dst, src);
>  }
>
>  static void des_encrypt_wrapper(const void *ctx, size_t length,
> @@ -319,34 +407,94 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
>          break;
>
>      case QCRYPTO_CIPHER_ALG_AES_128:
> +        ctx->ctx =3D g_new0(QCryptoNettleAES128, 1);
> +
> +        if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> +            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES128, 1);
> +
> +            nkey /=3D 2;
> +            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->e=
nc,
> +                                   key);
> +            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->d=
ec,
> +                                   key);
> +
> +            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx_twe=
ak)->
> +                                   enc, key + nkey);
> +            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx_twe=
ak)->
> +                                   dec, key + nkey);
> +        } else {
> +            aes128_set_encrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->e=
nc,
> +                                   key);
> +            aes128_set_decrypt_key(&((QCryptoNettleAES128 *)ctx->ctx)->d=
ec,
> +                                   key);
> +        }
> +
> +        ctx->alg_encrypt_native =3D aes128_encrypt_native;
> +        ctx->alg_decrypt_native =3D aes128_decrypt_native;
> +        ctx->alg_encrypt_wrapper =3D aes128_encrypt_wrapper;
> +        ctx->alg_decrypt_wrapper =3D aes128_decrypt_wrapper;
> +
> +        ctx->blocksize =3D AES_BLOCK_SIZE;
> +        break;
> +
>      case QCRYPTO_CIPHER_ALG_AES_192:
> +        ctx->ctx =3D g_new0(QCryptoNettleAES192, 1);
> +
> +        if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> +            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES192, 1);
> +
> +            nkey /=3D 2;
> +            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->e=
nc,
> +                                   key);
> +            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->d=
ec,
> +                                   key);
> +
> +            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx_twe=
ak)->
> +                                   enc, key + nkey);
> +            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx_twe=
ak)->
> +                                   dec, key + nkey);
> +        } else {
> +            aes192_set_encrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->e=
nc,
> +                                   key);
> +            aes192_set_decrypt_key(&((QCryptoNettleAES192 *)ctx->ctx)->d=
ec,
> +                                   key);
> +        }
> +
> +        ctx->alg_encrypt_native =3D aes192_encrypt_native;
> +        ctx->alg_decrypt_native =3D aes192_decrypt_native;
> +        ctx->alg_encrypt_wrapper =3D aes192_encrypt_wrapper;
> +        ctx->alg_decrypt_wrapper =3D aes192_decrypt_wrapper;
> +
> +        ctx->blocksize =3D AES_BLOCK_SIZE;
> +        break;
> +
>      case QCRYPTO_CIPHER_ALG_AES_256:
> -        ctx->ctx =3D g_new0(QCryptoNettleAES, 1);
> +        ctx->ctx =3D g_new0(QCryptoNettleAES256, 1);
>
>          if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> -            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES, 1);
> +            ctx->ctx_tweak =3D g_new0(QCryptoNettleAES256, 1);
>
>              nkey /=3D 2;
> -            aes_set_encrypt_key(&((QCryptoNettleAES *)ctx->ctx)->enc,
> -                                nkey, key);
> -            aes_set_decrypt_key(&((QCryptoNettleAES *)ctx->ctx)->dec,
> -                                nkey, key);
> -
> -            aes_set_encrypt_key(&((QCryptoNettleAES *)ctx->ctx_tweak)->e=
nc,
> -                                nkey, key + nkey);
> -            aes_set_decrypt_key(&((QCryptoNettleAES *)ctx->ctx_tweak)->d=
ec,
> -                                nkey, key + nkey);
> +            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->e=
nc,
> +                                   key);
> +            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->d=
ec,
> +                                   key);
> +
> +            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx_twe=
ak)->
> +                                   enc, key + nkey);
> +            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx_twe=
ak)->
> +                                   dec, key + nkey);
>          } else {
> -            aes_set_encrypt_key(&((QCryptoNettleAES *)ctx->ctx)->enc,
> -                                nkey, key);
> -            aes_set_decrypt_key(&((QCryptoNettleAES *)ctx->ctx)->dec,
> -                                nkey, key);
> +            aes256_set_encrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->e=
nc,
> +                                   key);
> +            aes256_set_decrypt_key(&((QCryptoNettleAES256 *)ctx->ctx)->d=
ec,
> +                                   key);
>          }
>
> -        ctx->alg_encrypt_native =3D aes_encrypt_native;
> -        ctx->alg_decrypt_native =3D aes_decrypt_native;
> -        ctx->alg_encrypt_wrapper =3D aes_encrypt_wrapper;
> -        ctx->alg_decrypt_wrapper =3D aes_decrypt_wrapper;
> +        ctx->alg_encrypt_native =3D aes256_encrypt_native;
> +        ctx->alg_decrypt_native =3D aes256_decrypt_native;
> +        ctx->alg_encrypt_wrapper =3D aes256_encrypt_wrapper;
> +        ctx->alg_decrypt_wrapper =3D aes256_decrypt_wrapper;
>
>          ctx->blocksize =3D AES_BLOCK_SIZE;
>          break;


--
Alex Benn=C3=A9e

