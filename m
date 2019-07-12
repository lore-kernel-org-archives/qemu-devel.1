Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A8DC742BA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DAA21670
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmsWQ3YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DAA21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hluNi-0000oc-UJ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 08:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33440)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hluNY-0000Pb-4T
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hluNX-0000YC-2G
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:10:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hluNW-0000XB-S1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:10:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so9714371wrf.11
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=d4oV1ERdmYqoogupdUvD13AKRDSrwQQtdHp9c68xWXY=;
 b=DmsWQ3YXNM++HGgSPdSKPdHI1/51wTufyliwj2vMnNrdQBGP3VJbJ5Ra9yQ2WseXzD
 gOOyF16nvt/e0eutJ+fDpkATwA8Q6WnkduNTlN4hqvDl1Xbu9o2Bi3+tZEWdUJXwB5A3
 T7IngurYRaXyIdtFYpkG0C/V/4UyO/yrwNi+eDjGpaYT35GX11WBcelwznE4UUupjDfr
 9nSX2VDTNnaP+2kbgtNVNSvyyG4u2IBOq2O+QuRPU7DeCwhCTq5ew+cUBZagQYlvz7lU
 Mo+Mkd5cttOsx4HH3QXXA+eQvAv+m/S/x2tzEhbc1HKEGTXN4cZVvutcP03EGyJTvTpX
 +bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=d4oV1ERdmYqoogupdUvD13AKRDSrwQQtdHp9c68xWXY=;
 b=mYiJcHDE99rXLykXkf7uT3eb74LESpcLxrICBdCrn31Q6UpOdukF0JNNAqK2O6Re1W
 74P12mlkug8LMw0B/gXAxB0D+fyepwgsgMxXS9Gab3r43qsmUMHMILfNcBBVUbwkiGqE
 4dZXeECkqCySu1fscCm4GIbcyr3ed5E3T00bBtUKlJ6XkT/jqYWcoMsUPE5kutcVs11/
 ylocJHDrVsIvx2JlAYtXAQKpf+4LZ4pKwVbTczdbUbyGONOVpbUODeFESbMTtrmLawcN
 3PyJ0/5AQE7U7BvwMNJs+usbM78i7QjVDNk7WkQRjP3exGVQ8NkjeQCAceeyY0s6TeV3
 rOpA==
X-Gm-Message-State: APjAAAUTbaR2HtPOl/3WNa2A3sHMweDwVH5zNlGmyvWin1Je6WXrDU3M
 /h1vSBlK+4vN3JZqCDxe+mr6h+I0Joc=
X-Google-Smtp-Source: APXvYqyCwNlyHj+/rgrZ/fQPqOZL+WIxGnDc54rN0GfcKfQ2v/lRzFHqin1IF5zxD3eOFICSlnL5lw==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr6524199wrj.16.1562933417722;
 Fri, 12 Jul 2019 05:10:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f17sm7770298wmf.27.2019.07.12.05.10.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 05:10:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D50731FF87;
 Fri, 12 Jul 2019 13:10:16 +0100 (BST)
References: <20190712101849.8993-1-berrange@redhat.com>
 <20190712101849.8993-3-berrange@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190712101849.8993-3-berrange@redhat.com>
Date: Fri, 12 Jul 2019 13:10:16 +0100
Message-ID: <8736jbe9nb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] crypto: fix function
 signatures for nettle 2.7 vs 3
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

> Nettle version 2.7.x used 'unsigned int' instead of 'size_t' for length
> parameters in functions. Use a local typedef so that we can build with
> the correct signature depending on nettle version, as we already do in
> the cipher code.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  crypto/hash-nettle.c | 12 +++++++++---
>  crypto/hmac-nettle.c | 17 +++++++++++++----
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> index 96f186f442..6ffb9c3db7 100644
> --- a/crypto/hash-nettle.c
> +++ b/crypto/hash-nettle.c
> @@ -26,12 +26,18 @@
>  #include <nettle/sha.h>
>  #include <nettle/ripemd160.h>
>
> +#if CONFIG_NETTLE_VERSION_MAJOR < 3
> +typedef unsigned int     hash_length_t;
> +#else
> +typedef size_t       hash_length_t;
> +#endif
> +
>  typedef void (*qcrypto_nettle_init)(void *ctx);
>  typedef void (*qcrypto_nettle_write)(void *ctx,
> -                                     unsigned int len,
> +                                     hash_length_t len,
>                                       const uint8_t *buf);
>  typedef void (*qcrypto_nettle_result)(void *ctx,
> -                                      unsigned int len,
> +                                      hash_length_t len,
>                                        uint8_t *buf);
>
>  union qcrypto_hash_ctx {
> @@ -112,7 +118,7 @@ qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
>                             size_t *resultlen,
>                             Error **errp)
>  {
> -    int i;
> +    size_t i;
>      union qcrypto_hash_ctx ctx;
>
>      if (!qcrypto_hash_supports(alg)) {
> diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
> index ec2d61bdde..1152b741fd 100644
> --- a/crypto/hmac-nettle.c
> +++ b/crypto/hmac-nettle.c
> @@ -18,14 +18,23 @@
>  #include "hmacpriv.h"
>  #include <nettle/hmac.h>
>
> +#if CONFIG_NETTLE_VERSION_MAJOR < 3
> +typedef unsigned int hmac_length_t;
> +#else
> +typedef size_t hmac_length_t;
> +#endif
> +
>  typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
> -              size_t key_length, const uint8_t *key);
> +                                           hmac_length_t key_length,
> +                                           const uint8_t *key);
>
>  typedef void (*qcrypto_nettle_hmac_update)(void *ctx,
> -              size_t length, const uint8_t *data);
> +                                           hmac_length_t length,
> +                                           const uint8_t *data);
>
>  typedef void (*qcrypto_nettle_hmac_digest)(void *ctx,
> -              size_t length, uint8_t *digest);
> +                                           hmac_length_t length,
> +                                           uint8_t *digest);
>
>  typedef struct QCryptoHmacNettle QCryptoHmacNettle;
>  struct QCryptoHmacNettle {
> @@ -135,7 +144,7 @@ qcrypto_nettle_hmac_bytesv(QCryptoHmac *hmac,
>                             Error **errp)
>  {
>      QCryptoHmacNettle *ctx;
> -    int i;
> +    size_t i;
>
>      ctx =3D (QCryptoHmacNettle *)hmac->opaque;


--
Alex Benn=C3=A9e

