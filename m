Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37823C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CA920674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsAzTYMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CA920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTXG-0004je-5h
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icSQH-0001J4-VA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icSQ2-0003vl-S0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:02:11 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icSPy-0003MV-Tj
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:02:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so8069637wro.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pOuA3FPzA2/6Llx9OE+xVWkGoj985GGh1kyhOv2TaLg=;
 b=WsAzTYMaIAwAtcTgYUTM7+SMq8jYR7MRLd0eK8ZwLcCXq7gFW76U9hGnSu3YW3C4zW
 JrumszSbNwpfrSUBy7qcGaiYz1THqq6H0/1pCUjOjKVl+7Uh+yoqEQbZ1KIQkhvj3YNa
 fmtNvj/8SlPzAVUEQB/Kr/Bu2iTZRapt7xEtesC0S1BIRdHSHoujBCZ0Rdv43yXWhBaq
 OV8K3cfBTdp6rKuwvwYVxIEhY7uA035wxGXQ2mtw2CZckNQrw0vJxeDgpK/s89MChw7Y
 m8oIJAO2yZPRzyo31rfmSG4yhmAts9TWwWJyoeO8oPJ/7XRSDMn2a8UHAT2gXVVLci+w
 hvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pOuA3FPzA2/6Llx9OE+xVWkGoj985GGh1kyhOv2TaLg=;
 b=scLFNUMuDGhWTXLRJCUCQmkHmtSmHHKrfLw0ekbOitdFko3wGTsDSZvCBhYKctFGsL
 roQ75ZQBzRFAbifP9tU6sg+PCi+mujavnSz+ObJ7BRbxQEN4yY52ETo5Y0KsDH40kk7u
 enwAx+t7qub7cW3fZ5V6A9VImws37PeAAsE5p03L2nvu47G4OfCdX/0fWjr74ajnd6Ny
 P13RlS8uMcl5/1qLCDZi44RDVqkowe4+xWwF/ss3NabzAB82wGWAZlL7mO+M5aKqbpis
 oC1gjqepiQ2nrws5+PEJlDdJIlJR6xM9p2nfEG4M2aPtf/OGeefCgUqCcdwZEpz1yX86
 70Mg==
X-Gm-Message-State: APjAAAVNZkbjqZH7Zc5/rAdqAyh5ike3xGnnrWBdtZqI3ScTxiEHfK17
 TAwZ8E9AtqOlEufTUPicUfUuCg==
X-Google-Smtp-Source: APXvYqzvXvyZVfRiEr84q4X7/W5ceunO0r4GS/HovrZNTL6JHCzMAiIawVoOx/vVGunHzIZSB4R5hA==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr3501686wrm.62.1575457313598; 
 Wed, 04 Dec 2019 03:01:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v4sm242898wml.2.2019.12.04.03.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 03:01:52 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D35131FF87;
 Wed,  4 Dec 2019 11:01:51 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-12-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 11/40] target/arm: Rename ARMMMUIdx_S1SE* to
 ARMMMUIdx_SE*
In-reply-to: <20191203022937.1474-12-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 11:01:51 +0000
Message-ID: <877e3c9www.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This is part of a reorganization to the set of mmu_idx.
> The Secure regimes all have a single stage translation;
> there is no point in pointing out that the idx is for stage1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h           |  8 ++++----
>  target/arm/internals.h     |  4 ++--
>  target/arm/translate.h     |  2 +-
>  target/arm/helper.c        | 26 +++++++++++++-------------
>  target/arm/translate-a64.c |  4 ++--
>  target/arm/translate.c     |  6 +++---
>  6 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0714c52176..e8ee316e05 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2868,8 +2868,8 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_EL10_1 =3D 1 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1E2 =3D 2 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1E3 =3D 3 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_S1SE0 =3D 4 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_S1SE1 =3D 5 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE0 =3D 4 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE1 =3D 5 | ARM_MMU_IDX_A,
>      ARMMMUIdx_Stage2 =3D 6 | ARM_MMU_IDX_A,
>      ARMMMUIdx_MUser =3D 0 | ARM_MMU_IDX_M,
>      ARMMMUIdx_MPriv =3D 1 | ARM_MMU_IDX_M,
> @@ -2894,8 +2894,8 @@ typedef enum ARMMMUIdxBit {
>      ARMMMUIdxBit_EL10_1 =3D 1 << 1,
>      ARMMMUIdxBit_S1E2 =3D 1 << 2,
>      ARMMMUIdxBit_S1E3 =3D 1 << 3,
> -    ARMMMUIdxBit_S1SE0 =3D 1 << 4,
> -    ARMMMUIdxBit_S1SE1 =3D 1 << 5,
> +    ARMMMUIdxBit_SE0 =3D 1 << 4,
> +    ARMMMUIdxBit_SE1 =3D 1 << 5,
>      ARMMMUIdxBit_Stage2 =3D 1 << 6,
>      ARMMMUIdxBit_MUser =3D 1 << 0,
>      ARMMMUIdxBit_MPriv =3D 1 << 1,
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 3fd1518f3b..3600bf9122 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -820,8 +820,8 @@ static inline bool regime_is_secure(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_MUser:
>          return false;
>      case ARMMMUIdx_S1E3:
> -    case ARMMMUIdx_S1SE0:
> -    case ARMMMUIdx_S1SE1:
> +    case ARMMMUIdx_SE0:
> +    case ARMMMUIdx_SE1:
>      case ARMMMUIdx_MSPrivNegPri:
>      case ARMMMUIdx_MSUserNegPri:
>      case ARMMMUIdx_MSPriv:
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index dd24f91f26..3760159661 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -124,7 +124,7 @@ static inline int default_exception_el(DisasContext *=
s)
>       * exceptions can only be routed to ELs above 1, so we target the hi=
gher of
>       * 1 or the current EL.
>       */
> -    return (s->mmu_idx =3D=3D ARMMMUIdx_S1SE0 && s->secure_routed_to_el3)
> +    return (s->mmu_idx =3D=3D ARMMMUIdx_SE0 && s->secure_routed_to_el3)
>              ? 3 : MAX(1, s->current_el);
>  }
>=20=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a34accec20..377825431a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3144,7 +3144,7 @@ static void ats_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
>              mmu_idx =3D ARMMMUIdx_Stage1_E1;
>              break;
>          case 1:
> -            mmu_idx =3D secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
> +            mmu_idx =3D secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
>              break;
>          default:
>              g_assert_not_reached();
> @@ -3154,13 +3154,13 @@ static void ats_write(CPUARMState *env, const ARM=
CPRegInfo *ri, uint64_t value)
>          /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
>          switch (el) {
>          case 3:
> -            mmu_idx =3D ARMMMUIdx_S1SE0;
> +            mmu_idx =3D ARMMMUIdx_SE0;
>              break;
>          case 2:
>              mmu_idx =3D ARMMMUIdx_Stage1_E0;
>              break;
>          case 1:
> -            mmu_idx =3D secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
> +            mmu_idx =3D secure ? ARMMMUIdx_SE0 : ARMMMUIdx_Stage1_E0;
>              break;
>          default:
>              g_assert_not_reached();
> @@ -3214,7 +3214,7 @@ static void ats_write64(CPUARMState *env, const ARM=
CPRegInfo *ri,
>      case 0:
>          switch (ri->opc1) {
>          case 0: /* AT S1E1R, AT S1E1W */
> -            mmu_idx =3D secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
> +            mmu_idx =3D secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
>              break;
>          case 4: /* AT S1E2R, AT S1E2W */
>              mmu_idx =3D ARMMMUIdx_S1E2;
> @@ -3227,13 +3227,13 @@ static void ats_write64(CPUARMState *env, const A=
RMCPRegInfo *ri,
>          }
>          break;
>      case 2: /* AT S1E0R, AT S1E0W */
> -        mmu_idx =3D secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
> +        mmu_idx =3D secure ? ARMMMUIdx_SE0 : ARMMMUIdx_Stage1_E0;
>          break;
>      case 4: /* AT S12E1R, AT S12E1W */
> -        mmu_idx =3D secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_EL10_1;
> +        mmu_idx =3D secure ? ARMMMUIdx_SE1 : ARMMMUIdx_EL10_1;
>          break;
>      case 6: /* AT S12E0R, AT S12E0W */
> -        mmu_idx =3D secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_EL10_0;
> +        mmu_idx =3D secure ? ARMMMUIdx_SE0 : ARMMMUIdx_EL10_0;
>          break;
>      default:
>          g_assert_not_reached();
> @@ -3895,7 +3895,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMSta=
te *env,
>  static int vae1_tlbmask(CPUARMState *env)
>  {
>      if (arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
>      } else {
>          return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
>      }
> @@ -3931,7 +3931,7 @@ static int vmalle1_tlbmask(CPUARMState *env)
>       * stage 1 translations.
>       */
>      if (arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
>      } else if (arm_feature(env, ARM_FEATURE_EL2)) {
>          return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_=
Stage2;
>      } else {
> @@ -8569,9 +8569,9 @@ static inline uint32_t regime_el(CPUARMState *env, =
ARMMMUIdx mmu_idx)
>          return 2;
>      case ARMMMUIdx_S1E3:
>          return 3;
> -    case ARMMMUIdx_S1SE0:
> +    case ARMMMUIdx_SE0:
>          return arm_el_is_aa64(env, 3) ? 1 : 3;
> -    case ARMMMUIdx_S1SE1:
> +    case ARMMMUIdx_SE1:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
>      case ARMMMUIdx_MPrivNegPri:
> @@ -8710,7 +8710,7 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *e=
nv, ARMMMUIdx mmu_idx)
>  static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
>      switch (mmu_idx) {
> -    case ARMMMUIdx_S1SE0:
> +    case ARMMMUIdx_SE0:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_MUser:
>      case ARMMMUIdx_MSUser:
> @@ -11150,7 +11150,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
>      }
>=20=20
>      if (el < 2 && arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdx_S1SE0 + el;
> +        return ARMMMUIdx_SE0 + el;
>      } else {
>          return ARMMMUIdx_EL10_0 + el;
>      }
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 3a39315a6c..885c99f0c9 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -116,8 +116,8 @@ static inline int get_a64_user_mem_index(DisasContext=
 *s)
>      case ARMMMUIdx_EL10_1:
>          useridx =3D ARMMMUIdx_EL10_0;
>          break;
> -    case ARMMMUIdx_S1SE1:
> -        useridx =3D ARMMMUIdx_S1SE0;
> +    case ARMMMUIdx_SE1:
> +        useridx =3D ARMMMUIdx_SE0;
>          break;
>      case ARMMMUIdx_Stage2:
>          g_assert_not_reached();
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 1716bbb615..787e34f258 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -157,9 +157,9 @@ static inline int get_a32_user_mem_index(DisasContext=
 *s)
>      case ARMMMUIdx_EL10_1:
>          return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
>      case ARMMMUIdx_S1E3:
> -    case ARMMMUIdx_S1SE0:
> -    case ARMMMUIdx_S1SE1:
> -        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
> +    case ARMMMUIdx_SE0:
> +    case ARMMMUIdx_SE1:
> +        return arm_to_core_mmu_idx(ARMMMUIdx_SE0);
>      case ARMMMUIdx_MUser:
>      case ARMMMUIdx_MPriv:
>          return arm_to_core_mmu_idx(ARMMMUIdx_MUser);


--=20
Alex Benn=C3=A9e

