Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4892C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8276E2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzNQKKCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8276E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIMH-0004d3-Mi
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idHBo-0005bI-7M
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idHBk-0000kz-Np
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:14:45 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idHBi-0000gN-6Q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:14:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id d17so6461975otc.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 09:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h4+BATZ1wD7mJYLuwMBs4jDzp6xj/7Ujv/BDZUQa+5A=;
 b=DzNQKKCs62/pThGkw/7r+d+lmc02n5KBqhDIGCk1+BvLvJErJQ8kL/5IVVQpBgEAkU
 evDsOp1JCONYM1sdhAbSx26pZC1Ox2BrXF7IQB5W0OCr5BxciPSsmvw51hSnUlvXk2dQ
 7n/Le9HFlKnvmdDWrLj3flKwukZ/2VmCLgogn1yvHpIdh/AFdSfQSWnc+wLf7DznltsR
 kl0Qx4u5OkXeiOrpDHn4dd+8omjaloQGnvUmzf/hiTcREhxfOMK9jE+4v08pWFM07tTx
 arUNoC/6OMJdbXdD5epUYys2lprQR2efQTyqbBDrqYfRw5ifwAdsOovE1cnHcWgKeQVO
 TRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h4+BATZ1wD7mJYLuwMBs4jDzp6xj/7Ujv/BDZUQa+5A=;
 b=Hn+9U4IjZD4hFYwiA3/XXUcnclQlhpfrANu9qSpqPqq/NYZIR2+RuzimP5VWZ8qcZF
 t/1UHACLLVIf4lJd6+8ZbaYCNC/jMvzPWXc4DwwrQJDFb4ZNkLdgdmGeEmh/SvxVqHpY
 WaiuKRKLxoep/CnbRNT9j6tZaXoy+/46x6K/KW09zzbX9Coe7rgshYyQrP05Hxhs2sN1
 kqLLIWzdCEU4y7aeKBYVSl/fEf6zoFUHKXhHo6aSJpppxR9mdoOUwN4JTrCL9lAYPwtZ
 rYLRgJ//PEuLFgs+SlziHnB83KuPV6BHUHPunsLDaCABNJmoDIM642KHL0RpbAGAo3v7
 nE8Q==
X-Gm-Message-State: APjAAAWCirXXS1x3fxnUjeNEHrCtqfxExYAFTEOCBoWg2yc5BdYOh5Pg
 yGNlM9Ef1y97Kwi4WF9roJZAw5uECSVuladr8pMUxA==
X-Google-Smtp-Source: APXvYqwp2217ZVGscBcuK4VNv/vu0KA7XXpAEOmeRaCfW2Zg22Gg/RG/MtTgD32r1zx1XjDGKol8chsBXNAHiEQDNZc=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr12291698otg.232.1575652480345; 
 Fri, 06 Dec 2019 09:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-31-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 17:14:29 +0000
Message-ID: <CAFEAcA-=s0rd78PUQSLV3j0xM4RdynxGv6jUYaYUqMVExsZb8A@mail.gmail.com>
Subject: Re: [PATCH v4 30/40] target/arm: Flush tlbs for E2&0 translation
 regime
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2a4d4c2c0d..b059d9f81a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4123,8 +4123,12 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
>
>  static int vae1_tlbmask(CPUARMState *env)
>  {
> +    /* Since we exclude secure first, we may read HCR_EL2 directly. */
>      if (arm_is_secure_below_el3(env)) {
>          return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
> +    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
> +               == (HCR_E2H | HCR_TGE)) {
> +        return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
>      } else {
>          return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
>      }
> @@ -4158,9 +4162,14 @@ static int vmalle1_tlbmask(CPUARMState *env)
>       * Note that the 'ALL' scope must invalidate both stage 1 and
>       * stage 2 translations, whereas most other scopes only invalidate
>       * stage 1 translations.
> +     *
> +     * Since we exclude secure first, we may read HCR_EL2 directly.
>       */
>      if (arm_is_secure_below_el3(env)) {
>          return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
> +    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
> +               == (HCR_E2H | HCR_TGE)) {
> +        return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
>      } else if (arm_feature(env, ARM_FEATURE_EL2)) {
>          return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_Stage2;
>      } else {
> @@ -4177,13 +4186,22 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      tlb_flush_by_mmuidx(cs, mask);
>  }
>
> +static int vae2_tlbmask(CPUARMState *env)
> +{
> +    if (arm_hcr_el2_eff(env) & HCR_E2H) {
> +        return ARMMMUIdxBit_EL20_0 | ARMMMUIdxBit_EL20_2;
> +    } else {
> +        return ARMMMUIdxBit_E2;
> +    }
> +}
> +
>  static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                    uint64_t value)
>  {
> -    ARMCPU *cpu = env_archcpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
> +    int mask = vae2_tlbmask(env);

Why do we use the 'v' mask function for a non 'v' TLB op?

>
> -    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
> +    tlb_flush_by_mmuidx(cs, mask);

The spec fror TLBI ALLE2 doesn't say it depends on
what the E2H setting is. It says it flushes all entries
for either NS EL2 or NS EL2&0 translation regimes.
Wouldn't that be
ARMMMUIdxBit_EL20_0 | ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_E2
?

Contrast TLBI VAE2, which does say that the entries it
flushes depend on the current setting of HCR_EL2.E2H.

>  }


thanks
-- PMM

