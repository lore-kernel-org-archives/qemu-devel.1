Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF66C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B13320716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2rJWwr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B13320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMdr-0003rV-Q5
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMcC-0002cw-Cc
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMcA-0000aw-BW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMcA-0000a0-4o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:02 -0500
Received: by mail-wm1-x342.google.com with SMTP id m24so9817025wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bGXH5O4wJiTbbXj1sQPPtvjNIz96lxCA6gdfR74QzpU=;
 b=H2rJWwr/egTJyPRF/f5QnWRCCBu+BcZJ/aw0I/tb9I6k53K6I+1IfhwQyQuWr4u3c1
 eyMqGbSyWgW1pnHojBSGDVtlu2QBQLVr9P5qnKNuMIw5Mu0HD4EI5NGtC4Tb6LAUsoW2
 fcErLtqYskpQixPHDc1ZM4ZuMhiV4ThAoUKzAyfPmbrZfrD2ShshSOrBdOePQDFgD1yj
 Il+NrKyMWuNRMwY7ZEZGvO/hFjW5AtCu+LKxs7ET/yqbYs2ZF73abpIZIKFBLg8Dv7g2
 yTCR0jngAN+QR6ZT5p47PjQxT9AQkZ4JnCTv2UkPkOWNFWYilRNtYRPCkLJjxLs863cG
 fxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bGXH5O4wJiTbbXj1sQPPtvjNIz96lxCA6gdfR74QzpU=;
 b=BdhC7iv9gv0z9BOKYm82EykGrjYQxVREKoCELCkVUR13CHaYhLtuzxyM9G9Ab1gDFe
 vZYJd2D9Bz86W6S5xdyk3PpKP5pLDccFMfr2VDPe5BqFpz2qEUQ2zpVCII7HYJ7qFe76
 pUyfSjo//XhVMGo7xC1R6lfUUdkTbiGYBAJhToJo4sDcPDVgLqyS78gBuqYIovWbDBan
 JIsQwDmkB0o4GjknviYHN17m4k2k9VVQupACpjsx+KYEEIR9tVqkJFNGp2obvCdHbPuS
 zfUqx6ZjobKRK7+QgQ74YC7ykbOunocqdfWF5FpqxnPp/rAx9zdalClxAsgnLUWv4z6P
 es6A==
X-Gm-Message-State: APjAAAXh/gotYnSF6nXBDvz6WQ/pW4w+RDJFDBUeWEY1okAhCKg0LxkB
 ZKRwPS2TOl9r+2nuy0Sl4JJA2zEXKgc=
X-Google-Smtp-Source: APXvYqxVacxkR2XTIpWva9/ahALlYaLHG8I2wwkM8s+RkG6VwxqOSD2Ll6SpK2tBDbpEEGaD8hHhfw==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr18402959wmc.54.1576864980534; 
 Fri, 20 Dec 2019 10:03:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm10415701wrt.37.2019.12.20.10.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:02:59 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A16BC1FF87;
 Fri, 20 Dec 2019 18:02:58 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-19-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 18/28] target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
In-reply-to: <20191216221158.29572-19-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:02:58 +0000
Message-ID: <87y2v6c1t9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/cpu.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index cde2a16b94..6a8228df4f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1949,9 +1949,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>  #define cpu_list x86_cpu_list
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _ksmap
> -#define MMU_MODE1_SUFFIX _user
> -#define MMU_MODE2_SUFFIX _knosmap /* SMAP disabled or CPL<3 && AC=3D1 */
>  #define MMU_KSMAP_IDX   0
>  #define MMU_USER_IDX    1
>  #define MMU_KNOSMAP_IDX 2


--=20
Alex Benn=C3=A9e

