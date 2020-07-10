Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF9DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A19720772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XntfLDBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A19720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jts5Q-0005wA-TI
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jts4m-0005T8-8l
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:24:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jts4j-0002qC-5l
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:24:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so5977987wmg.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uSXOEOS6EZMDYt7h82+0iXfoDmBRSAwvGW4HfXf3nX8=;
 b=XntfLDBlVsNFnWqzXg/JZUI6axTai1TbFP3wS3vTFWU6PK55nv9GW/HTJSLDz9vEKr
 /hzeDsdHregzgosmc8kxiO3ngTuV+qqRDhV7YKWhQqz6hO1lc6/LYmXx2Mmf0XAWllsH
 aL8qXU4n+smDpYuaYsOGy/O1BRSZNBcU8EDXL0eHJHqHbIPJhOSa0tWWm2fEhXrcLJ7s
 2xH2M2vAcUIwljkUdxnka20tsnWQdV+rjLxKnaWKSWjgCFps/EHsDCyNFSYJAHfu1LcV
 H9CoOePXz9x+/mP/kRAHZjEDqmtg7fKPU5izdD1WEchsaHsURexePrFI05c88LHho36W
 SlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uSXOEOS6EZMDYt7h82+0iXfoDmBRSAwvGW4HfXf3nX8=;
 b=GK5wjuGHQzQkoemd7V2bhr+oFFPoVv5d2JKiYRs0uZsF5Jn5JPVqi1/xNU0c3H5E1m
 hliRjx2Tj8u3ZgPVTnx/NqveWo1M6MI9+XKgcThV+6UOV7EXa9lQndXFC8O2gPIJd8Bw
 ykmv6C32+KyddioJxzMtgTwgYqGiHsk92E313kzkcAaEiE+1oQE1pvYCcdVPrvuTg9sf
 yg8D9x8u+BVFRHC4WLB4rVVwlqxtqgsZOUiYK5CuUFHiP5174FNAsqeQBMXlmHe1xSpL
 xHLFP4WACc24b6pgwdomuDC7YSbO0A+Lf9fIS/iYD7wFaEkwjtvlAzmCN2fPkpETZ0L/
 ebFg==
X-Gm-Message-State: AOAM531m/IC9D/rUXgWnv/eM0sqQUdXSL9yxAnM+NlU+w7o/rDBRTAbZ
 azkcRhWO3v2a0qnAgN9jqAzU1g==
X-Google-Smtp-Source: ABdhPJyJGWEivIIiJ4lIWn/P3OqRJLLI6CtVOFbcqXNuatEKBNSFaQgsL/1EI8SfX2sAa8afqAFbUA==
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr5287218wml.128.1594383859389; 
 Fri, 10 Jul 2020 05:24:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z10sm10295842wrm.21.2020.07.10.05.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 05:24:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D4C71FF7E;
 Fri, 10 Jul 2020 13:24:17 +0100 (BST)
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-64-frank.chang@sifive.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: frank.chang@sifive.com
Subject: Re: [RFC 63/65] fpu: implement full set compare for fp16
In-reply-to: <20200710104920.13550-64-frank.chang@sifive.com>
Date: Fri, 10 Jul 2020 13:24:17 +0100
Message-ID: <87eepjlfri.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Chih-Min Chao <chihmin.chao@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


frank.chang@sifive.com writes:

> From: Kito Cheng <kito.cheng@sifive.com>
>
> Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

NACK I'm afraid. What's wrong with the exiting float_compare support?

Even if you did want to bring in aliases for these functions within
softfloat itself the correct way would be to use the decomposed
float_compare support for a bunch of stubs and not restore the old style
error prone bit masking code.

> ---
>  fpu/softfloat.c         | 240 ++++++++++++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h |   8 ++
>  2 files changed, 248 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 028b857167..8bebea1142 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -401,6 +401,34 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
>      return soft(ua.s, ub.s, s);
>  }
>=20=20
> +/*----------------------------------------------------------------------=
------
> +| Returns the fraction bits of the half-precision floating-point value `=
a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +static inline uint32_t extractFloat16Frac(float16 a)
> +{
> +    return float16_val(a) & 0x3ff;
> +}

For example you'll notice this function was deleted in e6b405fe00

--=20
Alex Benn=C3=A9e

