Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EA0C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10D02186A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYLgeuOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10D02186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Kl3-0002eY-WF
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2KcR-0001YJ-Er
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2KcQ-00012D-37
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:25:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2KcP-0000yE-TQ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:25:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id a127so13037157oii.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0zxdry1BkfHAqau/H/9feepTNjFxh/DYdr86EaL4hL4=;
 b=wYLgeuOgNwUBEs80yhYdzEJlrAL0AFCvpWHnH440DavpwdpKxO7IKTJIlYaW6MV2Co
 pz+wm1y58HJ8mgKirsG1PiRNMYEu/9Dx7HhrE+ucAPJoGg+eaM2mks8eq9bWxs1ybhAf
 sZNwUInTwIQvk9CZIveMxovLHQN7i7518R9fCUoIa+6KUAZYrhmbf4HXiv0SoTPptG6K
 JtK1NHyqT+qffiXZXZSyWoAztAoEvhWlybY1USgg8s2BxJml8r/Pp+krbOENKpNeNvjA
 mYo08V/eYQFhkSt9h16Ucn7m9D1UXmfYfd46GvOVRPrNcGhlv0B38Wd8IbvfNBEFIiLs
 eKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0zxdry1BkfHAqau/H/9feepTNjFxh/DYdr86EaL4hL4=;
 b=XxX23lcPt0S+9YErQr5uWjZizwWVi+lYFKoZpLApvUbQtAqtNjo7CuFh0P30ln74gi
 Hd2b6TsvaoAKI0zmo9SG/rCUBUrY/xvdaZYiin3viheNdqctXKpjF/9TVPdCLtiH7Jf6
 o2zXLbQAAm1sHY/sILPz6pmUPgH5icuJOqFIX2bC4G/oGS3h9VJ0wklHm+OIor1DgOoT
 l6LHjdg+1A4m1Tq6XiMxnB10lctCiSlVDnLs86i/DTdgRfKo4+H6pzxmIGcYMdhVQTd5
 eWdfAnA+Lo9VxKyu90s59x7fGoC6YjYA6MtTRUHo9jraAI3nLqjRlelWiHbgqYbBosSS
 wSQQ==
X-Gm-Message-State: APjAAAWbAtOH6sT+yN/B8dODbcdU5z6O9AVk/+3iqy1jnA2MnoSs5pwM
 nVq41ye2YzgPl3tGvayGevX0BINVj4/bTBzwoYKlvQ==
X-Google-Smtp-Source: APXvYqxumVfsK7IqF94lFLxgQInGFf07s7VCLVGocRf6Lb53XQrGDCw+jRfFGhmrGyxs/LCncojifX3f/JGMJE9FGog=
X-Received: by 2002:a54:4718:: with SMTP id k24mr13106294oik.146.1566847532685; 
 Mon, 26 Aug 2019 12:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-57-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-57-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Aug 2019 20:25:21 +0100
Message-ID: <CAFEAcA-9JAhPA44_PuoOgNFfhHZHTSxkCLbizN00GtaDKt=sxQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 56/68] target/arm: Convert T16,
 Change processor state
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 85 ++++++++++++++++++++----------------------
>  target/arm/t16.decode  | 12 ++++++
>  2 files changed, 52 insertions(+), 45 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 414c562fb3..368f0ab147 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7474,6 +7474,11 @@ static int negate(DisasContext *s, int x)
>      return -x;
>  }
>
> +static int plus_2(DisasContext *s, int x)
> +{
> +    return x + 2;
> +}
> +
>  static int times_2(DisasContext *s, int x)
>  {
>      return x * 2;
> @@ -10152,6 +10157,9 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
>  {
>      uint32_t mask, val;
>
> +    if (ENABLE_ARCH_6 && arm_dc_feature(s, ARM_FEATURE_M)) {
> +        return false;
> +    }

I don't think this condition is quite right. We want to
do two things:
 (1) this is the A/R-profile CPS, so it shouldn't
be decoded for any ARM_FEATURE_M CPU
 (2) for A/R-profile, all the CPS instructions are v6-or-better

(All M-profile CPUs are at v6-or-better, which is why the
legacy decoder gets away with doing its ARCH(6) check
up front rather than only in the A/R-profile arm of its
if statement.)

>      if (IS_USER(s)) {>          /* Implemented as NOP in user mode.  */
>          return true;
> @@ -10182,6 +10190,36 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
>      return true;
>  }
>
> +static bool trans_CPS_v6m(DisasContext *s, arg_CPS_v6m *a)
> +{
> +    TCGv_i32 tmp, addr;
> +
> +    if (!(ENABLE_ARCH_6 && arm_dc_feature(s, ARM_FEATURE_M))) {
> +        return false;
> +    }

Similarly, this one need not check ENABLE_ARCH_6.
That is, this is the generic M-profile CPS, it's
not specific to v6M, and FEATURE_M always implies
ARCH_6 anyway. Usually we name M-profile specific
functions _v7m, not _v6m, for mostly historical
reasons relating to our having implemented v7m first,
so maybe we should follow that here. I have made
a bit of an inconsistent hash of this with the v8M
support, where sometimes I use _v8m because the
function is only in v8M and not v7M, and sometimes
_v7m because it's an M-profile function even if it
happens that it only kicks in or is called for
v8M CPUs. But we do not curretly have any functions
with a _v6m suffix so we should probably go with _v7m here.

> +    if (IS_USER(s)) {
> +        /* Implemented as NOP in user mode.  */
> +        return true;
> +    }
> +
> +    tmp = tcg_const_i32(a->im);
> +    /* FAULTMASK */
> +    if (a->F) {
> +        addr = tcg_const_i32(19);
> +        gen_helper_v7m_msr(cpu_env, addr, tmp);
> +        tcg_temp_free_i32(addr);
> +    }
> +    /* PRIMASK */
> +    if (a->I) {
> +        addr = tcg_const_i32(16);
> +        gen_helper_v7m_msr(cpu_env, addr, tmp);
> +        tcg_temp_free_i32(addr);
> +    }
> +    tcg_temp_free_i32(tmp);
> +    gen_lookup_tb(s);
> +    return true;
> +}

thanks
-- PMM

