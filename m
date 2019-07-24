Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370CC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29D022ADB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhE3Uyof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29D022ADB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqI0h-0005PE-Vu
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqI0X-00050n-A5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqI0V-0001yo-M9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:12:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqI0V-0001yA-Af
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:12:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so42000761wma.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eQ4Rtlqxp8fUiYnB0kzG/Rew/2hFatq4qXcZlzyklac=;
 b=RhE3UyofdL31jsG+4SNbJF3x9QBCVWsz40oFi3KTpdO47WxPBR8gY7WWQN3RrLdJuf
 thoKlMnrT6hwbrzETInntnNrqBPCEOSKn3D0flIScTmVeoiZjHEXo+Oqf6fHvaacHgs6
 3MfqTqffUzC3p3dea8UsROL+0xEv8aJgA8NJsGeU7JhB4hp/YuHxvlLqAoEGvjB30i81
 u2CTudGcWFfvZtv2QE7TXWxsiBuHhYO63O8p6Sl3+Jflm698CDxjDJWRLEw/DDjOUuX8
 RH8uT4MGtw1cf12PPSJ5Eg6cfHmlDeHgjQl1KqCEc3UrbDam+1tjThswgoAeVrKym1Kg
 Zn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eQ4Rtlqxp8fUiYnB0kzG/Rew/2hFatq4qXcZlzyklac=;
 b=HYuoL4ZxNzlNXM4TDiiCKfJh2x369b100pyld2+2D43KMH95WHMzmnyZ1E5KJWNG6M
 celrLk3U5/v8YOPQpw3EAOdHyVbGnR01sgWXAwyRy7lC41EWlaCq0CeW6H5YlK6Ay4kZ
 3BgV4EydQT8F/j7slqobAfDh9+lVH/aG0v8GLeNh24vSE7VwXmK0BtKGibzHbZN8vBMC
 zS0hOJgXNDCHeKPkbExtDslr7PFX0I0UkaKN7940WhNnVJBNU2W+3BHHs5evVzrS7gQl
 NnH4hTNO0/ukwsu4c4Qc2D8o9QAvQ/Qjajs6UF/3MxyfZNVCjI2jTreMUhEbvL24zHes
 lv+Q==
X-Gm-Message-State: APjAAAXRYbBh0+KYuiLdKwyNrZjbrfXBX7lf3F0Ej0Ec199G05awZWLX
 gqk27ovs2oy04ApCyEjnNZtejQ==
X-Google-Smtp-Source: APXvYqw/XcD/MPeE4PsFj117VFsPLK1AmScQ9MClzp7Bj1aG/gdBU8Q+EgiBO9ydGQePlItGXJTzOA==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr78567158wmg.92.1563977557791; 
 Wed, 24 Jul 2019 07:12:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l17sm29383340wrr.94.2019.07.24.07.12.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 07:12:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E08921FF87;
 Wed, 24 Jul 2019 15:12:36 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-10-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-10-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2019 15:12:36 +0100
Message-ID: <875znr1pyj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.2 09/24] target/arm: Add TTBR1_EL2
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

> At the same time, add writefn to TTBR0_EL2 and TCR_EL2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d1bf31ab74..da2e0627b2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3449,6 +3449,15 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, =
const ARMCPRegInfo *ri,
>      }
>  }
>
> +static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> +                                    uint64_t value)
> +{
> +    raw_write(env, ri, value);

I wonder if the bellow would be better merged with:

  target/arm: Install asids for E2&0 translation regime

And the commit message amended to say something like:

  "later patches will potentially update the asid"

> +    if (arm_hcr_el2_eff(env) & HCR_E2H) {
> +        /* The ASID field is active.  */
> +    }
> +}
> +
>  static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> @@ -4844,10 +4853,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .resetvalue =3D 0 },
>      { .name =3D "TCR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 2, .crm =3D 0, .opc2 =3D 2,
> -      .access =3D PL2_RW,
> -      /* no .writefn needed as this can't cause an ASID change;
> -       * no .raw_writefn or .resetfn needed as we never use mask/base_ma=
sk
> -       */
> +      .access =3D PL2_RW, .writefn =3D vmsa_tcr_ttbr_el2_write,
> +      /* no .raw_writefn or .resetfn needed as we never use mask/base_ma=
sk */
>        .fieldoffset =3D offsetof(CPUARMState, cp15.tcr_el[2]) },
>      { .name =3D "VTCR", .state =3D ARM_CP_STATE_AA32,
>        .cp =3D 15, .opc1 =3D 4, .crn =3D 2, .crm =3D 1, .opc2 =3D 2,
> @@ -4881,7 +4888,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .fieldoffset =3D offsetof(CPUARMState, cp15.tpidr_el[2]) },
>      { .name =3D "TTBR0_EL2", .state =3D ARM_CP_STATE_AA64,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 2, .crm =3D 0, .opc2 =3D 0,
> -      .access =3D PL2_RW, .resetvalue =3D 0,
> +      .access =3D PL2_RW, .resetvalue =3D 0, .writefn =3D vmsa_tcr_ttbr_=
el2_write,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.ttbr0_el[2]) },
>      { .name =3D "HTTBR", .cp =3D 15, .opc1 =3D 4, .crm =3D 2,
>        .access =3D PL2_RW, .type =3D ARM_CP_64BIT | ARM_CP_ALIAS,
> @@ -6807,6 +6814,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 =3D 3, .opc1 =3D 4, .crn =3D 13, .crm =3D 0, .opc2 =
=3D 1,
>                .access =3D PL2_RW,
>                .fieldoffset =3D offsetof(CPUARMState, cp15.contextidr_el[=
2]) },
> +            { .name =3D "TTBR1_EL2", .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 4, .crn =3D 2, .crm =3D 0, .opc2 =
=3D 1,
> +              .access =3D PL2_RW, .writefn =3D vmsa_tcr_ttbr_el2_write,
> +              .fieldoffset =3D offsetof(CPUARMState, cp15.ttbr1_el[2]) },
>              REGINFO_SENTINEL
>          };
>          define_arm_cp_regs(cpu, vhe_reginfo);

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

