Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2686DC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F3921926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRGxNzLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F3921926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqHmK-0005wm-5H
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqHm9-0005YR-Kx
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqHm8-0001ld-DY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:57:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqHm8-0001lF-5N
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:57:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id s15so20373872wmj.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 06:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PYfScfr3f6BZHk3fGIvKBec3+6WFtNBjmH/3C2qd9g4=;
 b=XRGxNzLiuoRYOhF/ChLXMM1SoB1sgWHnwKliprzNqP59x8wOrEu2ZpksaITKlowbrd
 CJ2P2g6F1gnKANwOAnRN42v2UpsR0vgbpeTyGxI2wxiu7E5cNuEc3hRcbvhpkLDwfqnw
 ZOoSDJSoT0wy+KFuMHenfddKpaTkGo1uzfgyK87yfK/HhclYqrMxCT7JgXLOEnkrBem7
 ZSUsUS9wyf2FVf93rOxPVdMXWGW3znvUBMEJ+0R2clPQ+jIQo1aBl8q2DZCSVJWV1NPv
 4gMOIcMWIlknLoPwTZnlacFvkPyBEOw+qxyFAke1kiIsDU/OYsV+0FjwnUx4XISybAcI
 V8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PYfScfr3f6BZHk3fGIvKBec3+6WFtNBjmH/3C2qd9g4=;
 b=A8ADyEZYtqEsZUhn0ouUAjUVaXDtFDz0FkW4SNDP9pwBuFAnZs1JCYCw1zF4KUIrsv
 Mow8Tf80s+US5kpdZepnRyez+Iw2uFOR0UtfPLZ4k3KlL4WSa6zTQgdCgiMEB99QiDgs
 oxfKprtRI9ZH/9quT/LXrkW9b22x0GbEwjUuCWTkgRNePei3/qyxxLIoux8XZyHeH4BB
 DO9tzPzT6adtF0/UhJ79P+DUCFgWjDdtGv8EExahjQiAAHNnMViRRerLiwIe8imO3q4r
 8uhXw+SGThfGkM95L10MGEKyUEKwQRhfaA4NP1wNiUNofCgfkt2bnGyveYugOsiI4v7h
 ndNw==
X-Gm-Message-State: APjAAAVv7is0NhounOYcr3y2GYAeTE9ubkP3hVnW48PHh1aHz8DFhqu2
 NKvv+QxMxvXz+nbuUCdLmjTBsQ==
X-Google-Smtp-Source: APXvYqxLU0oWUFAbzPhKgGQqY24iUqG3vdl7DyfIvP+urikaWz70iOQEG5wrMppkoAJYPPgkEJVh6w==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr73710827wml.157.1563976666609; 
 Wed, 24 Jul 2019 06:57:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o7sm19045884wru.58.2019.07.24.06.57.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 06:57:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86EC61FF87;
 Wed, 24 Jul 2019 14:57:45 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-9-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-9-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2019 14:57:45 +0100
Message-ID: <877e871qna.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for-4.2 08/24] target/arm: Add
 CONTEXTIDR_EL2
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

> Not all of the breakpoint types are supported, but those that
> only examine contextidr are extended to support the new register.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/debug_helper.c | 50 +++++++++++++++++++++++++++++----------
>  target/arm/helper.c       | 11 +++++++++
>  2 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index dde80273ff..2e3e90c6a5 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -20,6 +20,7 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
>      int ctx_cmps =3D extract32(cpu->dbgdidr, 20, 4);
>      int bt;
>      uint32_t contextidr;
> +    uint64_t hcr_el2;
>
>      /*
>       * Links to unimplemented or non-context aware breakpoints are
> @@ -40,24 +41,44 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
>      }
>
>      bt =3D extract64(bcr, 20, 4);
> -
> -    /*
> -     * We match the whole register even if this is AArch32 using the
> -     * short descriptor format (in which case it holds both PROCID and A=
SID),
> -     * since we don't implement the optional v7 context ID masking.
> -     */
> -    contextidr =3D extract64(env->cp15.contextidr_el[1], 0, 32);
> +    hcr_el2 =3D arm_hcr_el2_eff(env);
>
>      switch (bt) {
>      case 3: /* linked context ID match */
> -        if (arm_current_el(env) > 1) {
> -            /* Context matches never fire in EL2 or (AArch64) EL3 */
> +        switch (arm_current_el(env)) {
> +        default:
> +            /* Context matches never fire in AArch64 EL3 */
>              return false;
> +        case 2:
> +            if (!(hcr_el2 & HCR_E2H)) {
> +                /* Context matches never fire in EL2 without E2H enabled=
. */
> +                return false;
> +            }
> +            contextidr =3D env->cp15.contextidr_el[2];
> +            break;
> +        case 1:
> +            contextidr =3D env->cp15.contextidr_el[1];
> +            break;
> +        case 0:
> +            if ((hcr_el2 & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | HCR_TG=
E)) {
> +                contextidr =3D env->cp15.contextidr_el[2];
> +            } else {
> +                contextidr =3D env->cp15.contextidr_el[1];
> +            }
> +            break;
>          }
> -        return (contextidr =3D=3D extract64(env->cp15.dbgbvr[lbn], 0, 32=
));
> -    case 5: /* linked address mismatch (reserved in AArch64) */
> +        break;
> +
> +    case 7:  /* linked contextidr_el1 match */
> +        contextidr =3D env->cp15.contextidr_el[1];
> +        break;
> +    case 13: /* linked contextidr_el2 match */
> +        contextidr =3D env->cp15.contextidr_el[2];
> +        break;
> +
>      case 9: /* linked VMID match (reserved if no EL2) */
>      case 11: /* linked context ID and VMID match (reserved if no EL2) */
> +    case 15: /* linked full context ID match */
>      default:

I'm wondering if a qemu_log(UNIMP) here? I guess not as we check the
value a lot....

>          /*
>           * Links to Unlinked context breakpoints must generate no
> @@ -66,7 +87,12 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
>          return false;
>      }
>
> -    return false;
> +    /*
> +     * We match the whole register even if this is AArch32 using the
> +     * short descriptor format (in which case it holds both PROCID and A=
SID),
> +     * since we don't implement the optional v7 context ID masking.
> +     */
> +    return contextidr =3D=3D (uint32_t)env->cp15.dbgbvr[lbn];
>  }
>
>  static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0a55096770..d1bf31ab74 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6801,6 +6801,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_arm_cp_regs(cpu, lor_reginfo);
>      }
>
> +    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, c=
pu)) {
> +        static const ARMCPRegInfo vhe_reginfo[] =3D {
> +            { .name =3D "CONTEXTIDR_EL2", .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 4, .crn =3D 13, .crm =3D 0, .opc2 =
=3D 1,
> +              .access =3D PL2_RW,
> +              .fieldoffset =3D offsetof(CPUARMState, cp15.contextidr_el[=
2]) },
> +            REGINFO_SENTINEL
> +        };
> +        define_arm_cp_regs(cpu, vhe_reginfo);
> +    }
> +
>      if (cpu_isar_feature(aa64_sve, cpu)) {
>          define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
>          if (arm_feature(env, ARM_FEATURE_EL2)) {

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

