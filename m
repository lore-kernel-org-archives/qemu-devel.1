Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0FC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A4421901
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuzzlE5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A4421901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGtv-0000Rp-6m
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59506)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqGtk-0008Ub-Gl
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqGti-0002N1-3o
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:01:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqGth-0002Lx-RT
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:01:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id f17so41538966wme.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Tv4HXhIRYf8Gj1SWPIDUawXNWVBhncRbI5lmaZxoVsQ=;
 b=zuzzlE5eBDitPMK6O8f5YlhTfiUbF30jOTYJ97r3hcZY5Wj11Tf6ZcoyjDXZ2HYbv4
 pivhKf4qN/b8ikrotrCVFYG9z326aeIO4YcJF8wA4APukTcM/eEeezxeAZuBZ6twUbc6
 JPDPOCEHyJ3kn/Iih+VU1amrjVVGNUbKdz4/XVr2B4LvUEVXR/ujzd1/A1KZB2YoRB9G
 CwuXQxhR3rM4htVdXjVz8iLSwKJTjN6TS1585ZFD6W6Q3lNMFbxq2iHjlko7j8N8PLU1
 7+Xg6PupzE12PXDIU/v1MiPrr6pj/AeDGakfIxfmIJmSL4SB0ABdpQC46SehZl29Z5pb
 FUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Tv4HXhIRYf8Gj1SWPIDUawXNWVBhncRbI5lmaZxoVsQ=;
 b=cSPaNED1HRRLVOinrOqLqJLX9uH7Wh2ArTebvgLt3UYRP1TH+QKVRL+eOQGIH/th/7
 Js9HDf8Z5NJLcDG3W2YSoVIwoSxrxZIjb2wrVI5tLAT6gMs3ZpljitdXRwG15eLBU3o5
 f7qAruz3uBMdYCGLAdTbfEf4Zywl9S6mZfXVFNlQysrxEa2bfmh9JUyHnG43BFRvNqBb
 DJN0hv6mrQrU9Du3pfxHwjI0XhII8Oi72WgRqUSMDfgjNs8A5Ray5Gpt1UT003ReCZ7I
 2f/IrQwNF6T6V4yuukXBsDRUVzFMCG5pruS3zL8zhTlgOdSJ80Dvl7jrkI7SCCvS6XkA
 TpAA==
X-Gm-Message-State: APjAAAXzuJZz7yEvGuoSK45fgBdHpszJjVx6AH/wtpzyeWY4mIddR44B
 SCKaoBQdszo5L+YjMWuahc+wxg==
X-Google-Smtp-Source: APXvYqyJ1aQjdzw70nC6MFeOTV/VWfIoDt3J6TnZLhzAKA74vPhTZVpO0N4+/ZNgrh1bppv3gPJvTA==
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr71216278wmc.161.1563973292780; 
 Wed, 24 Jul 2019 06:01:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t15sm39753093wrx.84.2019.07.24.06.01.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 06:01:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41C5C1FF87;
 Wed, 24 Jul 2019 14:01:31 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-8-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2019 14:01:31 +0100
Message-ID: <878ssn1t90.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.2 07/24] target/arm: Enable HCR_E2H
 for VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h    | 7 -------
>  target/arm/helper.c | 6 +++++-
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e6a76d14c6..e37008a4f7 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1366,13 +1366,6 @@ static inline void xpsr_write(CPUARMState *env, ui=
nt32_t val, uint32_t mask)
>  #define HCR_ATA       (1ULL << 56)
>  #define HCR_DCT       (1ULL << 57)
>
> -/*
> - * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
> - * HCR_MASK and then clear it again if the feature bit is not set in
> - * hcr_write().
> - */
> -#define HCR_MASK      ((1ULL << 34) - 1)
> -
>  #define SCR_NS                (1U << 0)
>  #define SCR_IRQ               (1U << 1)
>  #define SCR_FIQ               (1U << 2)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3a9f35bf4b..0a55096770 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4623,7 +4623,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[=
] =3D {
>  static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t=
 value)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
> -    uint64_t valid_mask =3D HCR_MASK;
> +    /* Begin with bits defined in base ARMv8.0.  */
> +    uint64_t valid_mask =3D MAKE_64BIT_MASK(0, 34);
>
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
>          valid_mask &=3D ~HCR_HCD;
> @@ -4637,6 +4638,9 @@ static void hcr_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
>           */
>          valid_mask &=3D ~HCR_TSC;
>      }
> +    if (cpu_isar_feature(aa64_vh, cpu)) {
> +        valid_mask |=3D HCR_E2H;
> +    }
>      if (cpu_isar_feature(aa64_lor, cpu)) {
>          valid_mask |=3D HCR_TLOR;
>      }


--
Alex Benn=C3=A9e

