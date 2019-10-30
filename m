Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A47FCA9EC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB19B20656
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdFq148Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB19B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPos3-00028e-T6
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iPor0-00016y-Np
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iPoqz-0000IV-2C
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:21:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iPoqy-0000H1-Qd
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:21:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id n15so2480095wrw.13
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JDCddm2CvNp/bN3KwiFRsSmZIZ6Nx/daCCj7gXQYlbE=;
 b=BdFq148QCzb7/lL7GwDrhps+sZgYl6flIJl6liOLQsLNMOz4j44BI4VWtDaTT2C8+V
 4gsuZs/DuNKMme39HzTFwXijquY8YH92hf0Lsm6oPow9N2e0U6iSNXYA55Du3FQ979DA
 lSSEzNp51xXNFfXncGXy5WzSAnD9ZikpXeRAmIb9tQctsRjb9UQ7FnEXqLS+NWPYJw5y
 mW9n+7pQoPuM5BvpETMjKfR97uKkgG/QxXvcjx7aWAPGKa16leR5CN79Hwiba+fxsTmW
 NiZ8Nl631C8fG6/eiy52OTKUpp2HM0meuDTZPs693GnwGkx8j1fbhbt4ZgilQ4qUBNME
 93rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JDCddm2CvNp/bN3KwiFRsSmZIZ6Nx/daCCj7gXQYlbE=;
 b=lC2ssjtwE19y9IV5EFer/cUvWUajWwXYqdm3IHfGXGSlSRRskVCwu0kbYhFqFqCfM+
 0gAzTO5aZIEcjNbE1Fk+7lvQAdCwjVMejeI9YflT8st9B2LIs3eSr0P8mDVfm00zO+Z5
 Vqkug77qV32jibpvhMKFJemD32mfNAhxHQOwT9P4fHL8H+9o3b+cLvO4jZiNI6edvYuo
 oGR42e9gJm4zQiMIHICauhqbfTM03PMdbEBpGE1H4j3gjc89xrJaCPSWQKjTZ9Ey58sK
 bVR2AgRLowprfum13Gkc13ZB1gH8dnUH3WmlasIR3WdDaKGusbKRUtqGM/K5ZMlmArzK
 7YOg==
X-Gm-Message-State: APjAAAUX5jPqZaY16NQAaU9Unr1t3NhEwfS5HvkP193kvZm8pJ5hmnHK
 gZwbfjCCzqLJwgUEaqJ04O6Qn4ghB3wD8g==
X-Google-Smtp-Source: APXvYqw3TIud1jpi23Cvg893YMmeukrDlfef59yDeVcRR8v4l4vA48GjOD+IWBQUdtWOwkbnnReeCg==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr98386wro.85.1572445297918;
 Wed, 30 Oct 2019 07:21:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w13sm422632wrm.8.2019.10.30.07.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 07:21:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14C7D1FF87;
 Wed, 30 Oct 2019 14:21:36 +0000 (GMT)
References: <20191028154914.84821-1-berrange@redhat.com>
 <20191028154914.84821-5-berrange@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 4/4] crypto: add support for nettle's native XTS impl
In-reply-to: <20191028154914.84821-5-berrange@redhat.com>
Date: Wed, 30 Oct 2019 14:21:36 +0000
Message-ID: <87pnie8gb3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Nettle 3.5.0 will add support for the XTS mode. Use this because long
> term we wish to delete QEMU's XTS impl to avoid carrying private crypto
> algorithm impls.
>
> Unfortunately this degrades nettle performance from 612 MB/s to 568 MB/s
> as nettle's XTS impl isn't so well optimized yet.

Unfortunately this has broken some of the Travis tests, specifically:

  # QEMU configure log Wed 30 Oct 14:16:57 GMT 2019
  # Configured with: '../../configure' '--disable-tools' '--disable-docs' '=
--static' '--disable-system'

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  configure              | 18 ++++++++++++++++++
>  crypto/cipher-nettle.c | 18 ++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/configure b/configure
> index d1e9e457ce..452c2dfe4e 100755
> --- a/configure
> +++ b/configure
> @@ -472,6 +472,7 @@ gtk_gl=3D"no"
>  tls_priority=3D"NORMAL"
>  gnutls=3D""
>  nettle=3D""
> +nettle_xts=3D"no"
>  gcrypt=3D""
>  gcrypt_hmac=3D"no"
>  gcrypt_xts=3D"no"
> @@ -2871,6 +2872,19 @@ if test "$nettle" !=3D "no"; then
>              pass=3D"yes"
>          fi
>      fi
> +    if test "$pass" =3D "yes"
> +    then
> +        cat > $TMPC << EOF
> +#include <nettle/xts.h>
> +int main(void) {
> +  return 0;
> +}
> +EOF
> +        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
> +            nettle_xts=3Dyes
> +            qemu_private_xts=3Dno
> +        fi
> +    fi
>      if test "$pass" =3D "no" && test "$nettle" =3D "yes"; then
>          feature_not_found "nettle" "Install nettle devel >=3D 2.7.1"
>      else
> @@ -6346,6 +6360,10 @@ then
>     echo "  XTS             $gcrypt_xts"
>  fi
>  echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
> +if test "$nettle" =3D "yes"
> +then
> +   echo "  XTS             $nettle_xts"
> +fi
>  echo "libtasn1          $tasn1"
>  echo "PAM               $auth_pam"
>  echo "iconv support     $iconv"
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index d7411bb8ff..7e9a4cc199 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -19,7 +19,9 @@
>   */
>
>  #include "qemu/osdep.h"
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>  #include "crypto/xts.h"
> +#endif
>  #include "cipherpriv.h"
>
>  #include <nettle/nettle-types.h>
> @@ -30,6 +32,9 @@
>  #include <nettle/serpent.h>
>  #include <nettle/twofish.h>
>  #include <nettle/ctr.h>
> +#ifndef CONFIG_QEMU_PRIVATE_XTS
> +#include <nettle/xts.h>
> +#endif
>
>  typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
>                                                 size_t length,
> @@ -626,9 +631,15 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
>          break;
>
>      case QCRYPTO_CIPHER_MODE_XTS:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>          xts_encrypt(ctx->ctx, ctx->ctx_tweak,
>                      ctx->alg_encrypt_wrapper, ctx->alg_encrypt_wrapper,
>                      ctx->iv, len, out, in);
> +#else
> +        xts_encrypt_message(ctx->ctx, ctx->ctx_tweak,
> +                            ctx->alg_encrypt_native,
> +                            ctx->iv, len, out, in);
> +#endif
>          break;
>
>      case QCRYPTO_CIPHER_MODE_CTR:
> @@ -673,9 +684,16 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
>          break;
>
>      case QCRYPTO_CIPHER_MODE_XTS:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>          xts_decrypt(ctx->ctx, ctx->ctx_tweak,
>                      ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrapper,
>                      ctx->iv, len, out, in);
> +#else
> +        xts_decrypt_message(ctx->ctx, ctx->ctx_tweak,
> +                            ctx->alg_decrypt_native,
> +                            ctx->alg_encrypt_native,
> +                            ctx->iv, len, out, in);
> +#endif
>          break;
>      case QCRYPTO_CIPHER_MODE_CTR:
>          ctr_crypt(ctx->ctx, ctx->alg_encrypt_native,


--
Alex Benn=C3=A9e

