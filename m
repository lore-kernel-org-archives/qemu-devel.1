Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D4C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8C520659
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxrH/grT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8C520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUyY-000700-Ol
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icUx8-0006N0-Kd
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icUx6-0008Qm-CK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:44:26 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icUx6-0008Qb-39
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:44:24 -0500
Received: by mail-wm1-x342.google.com with SMTP id y23so4898641wma.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 05:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cM6k7/X7sNVgQT6fE/f8k/KE8ERmWt/4SyDNG81fJGQ=;
 b=bxrH/grTAFDc9Jrs82U/gHXtsfSrohk1/R0JoV9mmeTCt+dIap3nHOWwu+2iWFkd5Z
 /iS7E2droFqJ17yUU6nUpFweh9KqmGLN6IbaswLkB6VO+94cx4yZs8/RcTZLXSVxuiFe
 JAq38eahaffD3Sv192bYNrZ4bxk5CcbDlAALJ549htqfzdYAL4XGA4LziTOGFNTq8mU2
 nZMdUnpR+9AXYsryMk2hPn2Ee9pbaf5jrF9S6iAAClknrx2yUGVnjs5uNhlTrON0V3iX
 AH3EUeq6fsoLnbC4SD00GLlQ1SyTnXTkeb5FFXlfPJiXg6aR2OHzCqGQI1NWfPKaW5dm
 JIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cM6k7/X7sNVgQT6fE/f8k/KE8ERmWt/4SyDNG81fJGQ=;
 b=qJ3xQGfdNoUxEff/d0uTsD0iZzUWgvOzg/rpZKoHgBnYY/z4aNGDkm5aJ5rbZtj2hS
 jkMlnUMyA47BvN82AlaLXUFOZY+PVkDDaC1SSahYaae2OoxPyVFcDy2LgCeuTq0H+mTs
 1ChKwCpOjooyr1nu0Rz5cYWShRVCx1tTPsDZwJogbH/9pjtpjMK5O0NbES/RnMb55/Jq
 8oA+kOJXU1pe0M93B4LeEu5iktpwoGk96EEw2sB4DbF98J6NmilFDLf5j+kjdAnDOxRQ
 Ky8J6yqrEvBhuxd6g1LLzLFa+JEkf+vS0doEQpPWWAjP73CGJINeJNgoJWkHRSgR9Lqw
 X+eg==
X-Gm-Message-State: APjAAAVzP2AD0BVAzVSMssL8G4hGti579pf3uetfH6aBkuBo/UZn35Fy
 aqF/yBgAGEG78xqoYk3koImZLg==
X-Google-Smtp-Source: APXvYqyYsV2Oz8tHd2V0yTjkkiVLHrFPOLx5a21ioK7MSS6DHF6oIUX0VGeF1Q3LsSrXiacWcPi7Jg==
X-Received: by 2002:a1c:6585:: with SMTP id
 z127mr34083178wmb.113.1575467062513; 
 Wed, 04 Dec 2019 05:44:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o15sm8749345wra.83.2019.12.04.05.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 05:44:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 732141FF87;
 Wed,  4 Dec 2019 13:44:20 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-19-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 18/40] target/arm: Reorganize ARMMMUIdx
In-reply-to: <20191203022937.1474-19-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 13:44:20 +0000
Message-ID: <87pnh48atn.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Prepare for, but do not yet implement, the EL2&0 regime.
> This involves adding the new MMUIdx enumerators and adjusting
> some of the MMUIdx related predicates to match.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu-param.h |   2 +-
>  target/arm/cpu.h       | 128 ++++++++++++++++++-----------------------
>  target/arm/internals.h |  37 +++++++++++-
>  target/arm/helper.c    |  66 ++++++++++++++++++---
>  target/arm/translate.c |   1 -
>  5 files changed, 150 insertions(+), 84 deletions(-)
>
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index 6e6948e960..18ac562346 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -29,6 +29,6 @@
>  # define TARGET_PAGE_BITS_MIN  10
>  #endif
>=20=20
> -#define NB_MMU_MODES 8
> +#define NB_MMU_MODES 9
>=20=20
>  #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 015301e93a..bf8eb57e3a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2778,7 +2778,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, =
unsigned int excp_idx,
>   *  + NonSecure EL1 & 0 stage 1
>   *  + NonSecure EL1 & 0 stage 2
>   *  + NonSecure EL2
> - *  + Secure EL1 & EL0
> + *  + NonSecure EL2 & 0   (ARMv8.1-VHE)
> + *  + Secure EL0
> + *  + Secure EL1
>   *  + Secure EL3
>   * If EL3 is 32-bit:
>   *  + NonSecure PL1 & 0 stage 1
> @@ -2788,8 +2790,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, =
unsigned int excp_idx,
>   * (reminder: for 32 bit EL3, Secure PL1 is *EL3*, not EL1.)
>   *
>   * For QEMU, an mmu_idx is not quite the same as a translation regime be=
cause:
> - *  1. we need to split the "EL1 & 0" regimes into two mmu_idxes, becaus=
e they
> - *     may differ in access permissions even if the VA->PA map is the sa=
me
> + *  1. we need to split the "EL1 & 0" and "EL2 & 0" regimes into two mmu=
_idxes,
> + *     because they may differ in access permissions even if the VA->PA =
map is
> + *     the same
>   *  2. we want to cache in our TLB the full VA->IPA->PA lookup for a sta=
ge 1+2
>   *     translation, which means that we have one mmu_idx that deals with=
 two
>   *     concatenated translation regimes [this sort of combined s1+2 TLB =
is
> @@ -2801,19 +2804,23 @@ static inline bool arm_excp_unmasked(CPUState *cs=
, unsigned int excp_idx,
>   *  4. we can also safely fold together the "32 bit EL3" and "64 bit EL3"
>   *     translation regimes, because they map reasonably well to each oth=
er
>   *     and they can't both be active at the same time.
> - * This gives us the following list of mmu_idx values:
> + *  5. we want to be able to use the TLB for accesses done as part of a
> + *     stage1 page table walk, rather than having to walk the stage2 page
> + *     table over and over.
>   *
> - * NS EL0 (aka NS PL0) stage 1+2
> - * NS EL1 (aka NS PL1) stage 1+2
> + * This gives us the following list of cases:
> + *
> + * NS EL0 (aka NS PL0) EL1&0 stage 1+2
> + * NS EL1 (aka NS PL1) EL1&0 stage 1+2
> + * NS EL0 EL2&0
> + * NS EL2 EL2&0
>   * NS EL2 (aka NS PL2)
> - * S EL3 (aka S PL1)
>   * S EL0 (aka S PL0)
>   * S EL1 (not used if EL3 is 32 bit)
> - * NS EL0+1 stage 2
> + * S EL3 (aka S PL1)
> + * NS EL0&1 stage 2
>   *
> - * (The last of these is an mmu_idx because we want to be able to use th=
e TLB
> - * for the accesses done as part of a stage 1 page table walk, rather th=
an
> - * having to walk the stage 2 page table over and over.)
> + * for a total of 9 different mmu_idx.
>   *
>   * R profile CPUs have an MPU, but can use the same set of MMU indexes
>   * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
> @@ -2851,26 +2858,47 @@ static inline bool arm_excp_unmasked(CPUState *cs=
, unsigned int excp_idx,
>   * For M profile we arrange them to have a bit for priv, a bit for negpri
>   * and a bit for secure.
>   */
> -#define ARM_MMU_IDX_A 0x10 /* A profile */
> -#define ARM_MMU_IDX_NOTLB 0x20 /* does not have a TLB */
> -#define ARM_MMU_IDX_M 0x40 /* M profile */
> +#define ARM_MMU_IDX_A     0x10  /* A profile */
> +#define ARM_MMU_IDX_NOTLB 0x20  /* does not have a TLB */
> +#define ARM_MMU_IDX_M     0x40  /* M profile */
>=20=20
> -/* meanings of the bits for M profile mmu idx values */
> -#define ARM_MMU_IDX_M_PRIV 0x1
> +/* Meanings of the bits for M profile mmu idx values */
> +#define ARM_MMU_IDX_M_PRIV   0x1
>  #define ARM_MMU_IDX_M_NEGPRI 0x2
> -#define ARM_MMU_IDX_M_S 0x4
> +#define ARM_MMU_IDX_M_S      0x4  /* Secure */
>=20=20
> -#define ARM_MMU_IDX_TYPE_MASK (~0x7)
> -#define ARM_MMU_IDX_COREIDX_MASK 0x7
> +#define ARM_MMU_IDX_TYPE_MASK \
> +    (ARM_MMU_IDX_A | ARM_MMU_IDX_M | ARM_MMU_IDX_NOTLB)
> +#define ARM_MMU_IDX_COREIDX_MASK 0xf
>=20=20
>  typedef enum ARMMMUIdx {
> +    /*
> +     * A-profile.
> +     */
>      ARMMMUIdx_EL10_0 =3D 0 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_EL10_1 =3D 1 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_E2 =3D 2 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE3 =3D 3 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE0 =3D 4 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE1 =3D 5 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_Stage2 =3D 6 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_EL20_0 =3D 1 | ARM_MMU_IDX_A,
> +
> +    ARMMMUIdx_EL10_1 =3D 2 | ARM_MMU_IDX_A,
> +
> +    ARMMMUIdx_E2 =3D     3 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_EL20_2 =3D 4 | ARM_MMU_IDX_A,
> +
> +    ARMMMUIdx_SE0 =3D    5 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE1 =3D    6 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE3 =3D    7 | ARM_MMU_IDX_A,
> +
> +    ARMMMUIdx_Stage2 =3D 8 | ARM_MMU_IDX_A,
> +
> +    /*
> +     * These are not allocated TLBs and are used only for AT system
> +     * instructions or for the first stage of an S12 page table walk.
> +     */
> +    ARMMMUIdx_Stage1_E0 =3D 0 | ARM_MMU_IDX_NOTLB,
> +    ARMMMUIdx_Stage1_E1 =3D 1 | ARM_MMU_IDX_NOTLB,
> +
> +    /*
> +     * M-profile.
> +     */
>      ARMMMUIdx_MUser =3D ARM_MMU_IDX_M,
>      ARMMMUIdx_MPriv =3D ARM_MMU_IDX_M | ARM_MMU_IDX_M_PRIV,
>      ARMMMUIdx_MUserNegPri =3D ARMMMUIdx_MUser | ARM_MMU_IDX_M_NEGPRI,
> @@ -2879,11 +2907,6 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_MSPriv =3D ARMMMUIdx_MPriv | ARM_MMU_IDX_M_S,
>      ARMMMUIdx_MSUserNegPri =3D ARMMMUIdx_MUserNegPri | ARM_MMU_IDX_M_S,
>      ARMMMUIdx_MSPrivNegPri =3D ARMMMUIdx_MPrivNegPri | ARM_MMU_IDX_M_S,
> -    /* Indexes below here don't have TLBs and are used only for AT system
> -     * instructions or for the first stage of an S12 page table walk.
> -     */
> -    ARMMMUIdx_Stage1_E0 =3D 0 | ARM_MMU_IDX_NOTLB,
> -    ARMMMUIdx_Stage1_E1 =3D 1 | ARM_MMU_IDX_NOTLB,
>  } ARMMMUIdx;
>=20=20
>  /*
> @@ -2895,8 +2918,10 @@ typedef enum ARMMMUIdx {
>=20=20
>  typedef enum ARMMMUIdxBit {
>      TO_CORE_BIT(EL10_0),
> +    TO_CORE_BIT(EL20_0),
>      TO_CORE_BIT(EL10_1),
>      TO_CORE_BIT(E2),
> +    TO_CORE_BIT(EL20_2),
>      TO_CORE_BIT(SE0),
>      TO_CORE_BIT(SE1),
>      TO_CORE_BIT(SE3),
> @@ -2916,49 +2941,6 @@ typedef enum ARMMMUIdxBit {
>=20=20
>  #define MMU_USER_IDX 0
>=20=20
> -static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
> -{
> -    return mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
> -}
> -
> -static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_id=
x)
> -{
> -    if (arm_feature(env, ARM_FEATURE_M)) {
> -        return mmu_idx | ARM_MMU_IDX_M;
> -    } else {
> -        return mmu_idx | ARM_MMU_IDX_A;
> -    }
> -}
> -
> -/* Return the exception level we're running at if this is our mmu_idx */
> -static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
> -{
> -    switch (mmu_idx & ARM_MMU_IDX_TYPE_MASK) {
> -    case ARM_MMU_IDX_A:
> -        return mmu_idx & 3;
> -    case ARM_MMU_IDX_M:
> -        return mmu_idx & ARM_MMU_IDX_M_PRIV;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
> -/*
> - * Return the MMU index for a v7M CPU with all relevant information
> - * manually specified.
> - */
> -ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
> -                              bool secstate, bool priv, bool negpri);
> -
> -/* Return the MMU index for a v7M CPU in the specified security and
> - * privilege state.
> - */
> -ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
> -                                                bool secstate, bool priv=
);
> -
> -/* Return the MMU index for a v7M CPU in the specified security state */
> -ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
> -
>  /**
>   * cpu_mmu_index:
>   * @env: The cpu environment
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index aee54dc105..d73615064c 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -769,6 +769,39 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
>                        MMUAccessType access_type, int mmu_idx,
>                        bool probe, uintptr_t retaddr);
>=20=20
> +static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
> +{
> +    return mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
> +}
> +
> +static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_id=
x)
> +{
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        return mmu_idx | ARM_MMU_IDX_M;
> +    } else {
> +        return mmu_idx | ARM_MMU_IDX_A;
> +    }
> +}
> +
> +int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
> +
> +/*
> + * Return the MMU index for a v7M CPU with all relevant information
> + * manually specified.
> + */
> +ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
> +                              bool secstate, bool priv, bool negpri);
> +
> +/*
> + * Return the MMU index for a v7M CPU in the specified security and
> + * privilege state.
> + */
> +ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
> +                                                bool secstate, bool priv=
);
> +
> +/* Return the MMU index for a v7M CPU in the specified security state */
> +ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
> +
>  /* Return true if the stage 1 translation regime is using LPAE format pa=
ge
>   * tables */
>  bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx=
);
> @@ -810,6 +843,8 @@ static inline bool regime_is_secure(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>      switch (mmu_idx) {
>      case ARMMMUIdx_EL10_0:
>      case ARMMMUIdx_EL10_1:
> +    case ARMMMUIdx_EL20_0:
> +    case ARMMMUIdx_EL20_2:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
>      case ARMMMUIdx_E2:
> @@ -819,9 +854,9 @@ static inline bool regime_is_secure(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_MPriv:
>      case ARMMMUIdx_MUser:
>          return false;
> -    case ARMMMUIdx_SE3:
>      case ARMMMUIdx_SE0:
>      case ARMMMUIdx_SE1:
> +    case ARMMMUIdx_SE3:
>      case ARMMMUIdx_MSPrivNegPri:
>      case ARMMMUIdx_MSUserNegPri:
>      case ARMMMUIdx_MSPriv:
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ec5c7fa325..f86285ffbe 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8561,9 +8561,11 @@ void arm_cpu_do_interrupt(CPUState *cs)
>  #endif /* !CONFIG_USER_ONLY */
>=20=20
>  /* Return the exception level which controls this address translation re=
gime */
> -static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
> +static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
>      switch (mmu_idx) {
> +    case ARMMMUIdx_EL20_0:
> +    case ARMMMUIdx_EL20_2:
>      case ARMMMUIdx_Stage2:
>      case ARMMMUIdx_E2:
>          return 2;
> @@ -8574,6 +8576,8 @@ static inline uint32_t regime_el(CPUARMState *env, =
ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_SE1:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
> +    case ARMMMUIdx_EL10_0:
> +    case ARMMMUIdx_EL10_1:
>      case ARMMMUIdx_MPrivNegPri:
>      case ARMMMUIdx_MUserNegPri:
>      case ARMMMUIdx_MPriv:
> @@ -8675,10 +8679,14 @@ static inline TCR *regime_tcr(CPUARMState *env, A=
RMMMUIdx mmu_idx)
>   */
>  static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
>  {
> -    if (mmu_idx =3D=3D ARMMMUIdx_EL10_0 || mmu_idx =3D=3D ARMMMUIdx_EL10=
_1) {
> -        mmu_idx +=3D (ARMMMUIdx_Stage1_E0 - ARMMMUIdx_EL10_0);
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_EL10_0:
> +        return ARMMMUIdx_Stage1_E0;
> +    case ARMMMUIdx_EL10_1:
> +        return ARMMMUIdx_Stage1_E1;
> +    default:
> +        return mmu_idx;
>      }
> -    return mmu_idx;
>  }
>=20=20
>  /* Return true if the translation regime is using LPAE format page table=
s */
> @@ -8711,6 +8719,7 @@ static inline bool regime_is_user(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>  {
>      switch (mmu_idx) {
>      case ARMMMUIdx_SE0:
> +    case ARMMMUIdx_EL20_0:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_MUser:
>      case ARMMMUIdx_MSUser:
> @@ -11136,6 +11145,31 @@ int fp_exception_el(CPUARMState *env, int cur_el)
>      return 0;
>  }
>=20=20
> +/* Return the exception level we're running at if this is our mmu_idx */
> +int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
> +{
> +    if (mmu_idx & ARM_MMU_IDX_M) {
> +        return mmu_idx & ARM_MMU_IDX_M_PRIV;
> +    }
> +
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_EL10_0:
> +    case ARMMMUIdx_EL20_0:
> +    case ARMMMUIdx_SE0:
> +        return 0;
> +    case ARMMMUIdx_EL10_1:
> +    case ARMMMUIdx_SE1:
> +        return 1;
> +    case ARMMMUIdx_E2:
> +    case ARMMMUIdx_EL20_2:
> +        return 2;
> +    case ARMMMUIdx_SE3:
> +        return 3;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  #ifndef CONFIG_TCG
>  ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
>  {
> @@ -11149,10 +11183,26 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int =
el)
>          return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
>      }
>=20=20
> -    if (el < 2 && arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdx_SE0 + el;
> -    } else {
> -        return ARMMMUIdx_EL10_0 + el;
> +    switch (el) {
> +    case 0:
> +        /* TODO: ARMv8.1-VHE */
> +        if (arm_is_secure_below_el3(env)) {
> +            return ARMMMUIdx_SE0;
> +        }
> +        return ARMMMUIdx_EL10_0;
> +    case 1:
> +        if (arm_is_secure_below_el3(env)) {
> +            return ARMMMUIdx_SE1;
> +        }
> +        return ARMMMUIdx_EL10_1;
> +    case 2:
> +        /* TODO: ARMv8.1-VHE */
> +        /* TODO: ARMv8.4-SecEL2 */
> +        return ARMMMUIdx_E2;
> +    case 3:
> +        return ARMMMUIdx_SE3;
> +    default:
> +        g_assert_not_reached();
>      }
>  }
>=20=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index cd757165e1..b7f726e733 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -172,7 +172,6 @@ static inline int get_a32_user_mem_index(DisasContext=
 *s)
>      case ARMMMUIdx_MSUserNegPri:
>      case ARMMMUIdx_MSPrivNegPri:
>          return arm_to_core_mmu_idx(ARMMMUIdx_MSUserNegPri);
> -    case ARMMMUIdx_Stage2:
>      default:
>          g_assert_not_reached();
>      }


--=20
Alex Benn=C3=A9e

