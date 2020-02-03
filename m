Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5508DC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127C820721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BW39gL7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127C820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaJr-0001Pz-6f
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyaJ2-0000WV-M2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyaJ0-00006G-Di
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:54:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyaJ0-000054-4L
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:54:18 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so15510813wmb.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LorYo/WqNNfcE4xCRat7t0biUfxlZU+q5QtrzadCf6g=;
 b=BW39gL7PgxeGEKDUjX84m0IT1Fmq5dO/nenVauTW+EroyhTQsju+zEQ5Jhm+vVWgLR
 LJYMnu015SGoE2egQPMKnJsIkOssRaveVu1UzGznY0csT2U72DBDQLbw5EAHwtAR8Zbu
 3KRinUwDasf8ZZufcGx1WEkdxhpaXg6HJTI2e6SR35ew1jAc6aOzdPVF6ZdCZ6p03H9Y
 US3Gh4XziUfXe9wZR6x8HYJG/d5W9BBYclcMNHFGNEivEDjLBLURl94T8zaiPfrDmxcs
 nVbD7fsxKWbjoCKKqNsGzvWvpgYVhIL9Rily8rT296/BZOOQWbCOL032Ip6yD/nyCsCN
 /7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LorYo/WqNNfcE4xCRat7t0biUfxlZU+q5QtrzadCf6g=;
 b=LAEX5ttrygxivNcgT1oJfQRCaatua5RTa1YiVz9cNwCc7DLtMKoadmDBQ4qZJEVESQ
 N0eBIqlVEjwzRswQDrDaNN2OcrVltnp+U5ZBU8LyPNCr9Oj9XPTBo07r32La5sngJr9N
 NM4beCZIhnu/mjGuSGPe9pRlkdl3jLZkdyB1lvtYNS9/i/BYp0wStMlT/RhRRo6e7fvH
 oyDQAztH4lV4fgn++U6r0uvFAanpRiRKe0NPGj4lf9DI9G/I1VoX71+JZfRPLJr6UfWw
 COuO/qvyH3hszxO2/ELuD3ykncAgZdvdREplstZ1ExqDFEx4hTmbIFBjcvCoKofp29jc
 x+Fg==
X-Gm-Message-State: APjAAAWXGIFNGy2toTgLl9L1lysWvxzh60f6eRY5xk9PRtsczyb8BUzL
 ZjBzKKOkhQmySPpp9bNCAa6hoQ==
X-Google-Smtp-Source: APXvYqyZ4BdgBxErWRZfFIoEacbFFXL+XumJjcZqXZJiVlT3lV0owQQJ+Rvex56fmSMf0clKXw797A==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr29335721wmi.107.1580730856443; 
 Mon, 03 Feb 2020 03:54:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm25473270wrs.53.2020.02.03.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:54:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB2B01FF87;
 Mon,  3 Feb 2020 11:54:08 +0000 (GMT)
References: <20200202010439.6410-1-richard.henderson@linaro.org>
 <20200202010439.6410-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 02/14] target/arm: Add mmu_idx for EL1 and EL2 w/ PAN
 enabled
In-reply-to: <20200202010439.6410-3-richard.henderson@linaro.org>
Date: Mon, 03 Feb 2020 11:54:08 +0000
Message-ID: <87sgjrantr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

> To implement PAN, we will want to swap, for short periods
> of time, to a different privileged mmu_idx.  In addition,
> we cannot do this with flushing alone, because the AT*
> instructions have both PAN and PAN-less versions.
>
> Add the ARMMMUIdx*_PAN constants where necessary next to
> the corresponding ARMMMUIdx* constant.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu-param.h     |  2 +-
>  target/arm/cpu.h           | 33 ++++++++++++++-------
>  target/arm/internals.h     |  9 ++++++
>  target/arm/helper.c        | 60 +++++++++++++++++++++++++++++++-------
>  target/arm/translate-a64.c |  3 ++
>  target/arm/translate.c     |  2 ++
>  6 files changed, 87 insertions(+), 22 deletions(-)
>
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index 18ac562346..d593b60b28 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -29,6 +29,6 @@
>  # define TARGET_PAGE_BITS_MIN  10
>  #endif
>=20=20
> -#define NB_MMU_MODES 9
> +#define NB_MMU_MODES 12
>=20=20
>  #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0b3036c484..c63bceaaa5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2751,20 +2751,24 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm=
_sync);
>   *  5. we want to be able to use the TLB for accesses done as part of a
>   *     stage1 page table walk, rather than having to walk the stage2 page
>   *     table over and over.
> + *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Acce=
ss
> + *     Never (PAN) bit within PSTATE.
>   *
>   * This gives us the following list of cases:
>   *
>   * NS EL0 EL1&0 stage 1+2 (aka NS PL0)
>   * NS EL1 EL1&0 stage 1+2 (aka NS PL1)
> + * NS EL1 EL1&0 stage 1+2 +PAN
>   * NS EL0 EL2&0
> - * NS EL2 EL2&0
> + * NS EL2 EL2&0 +PAN
>   * NS EL2 (aka NS PL2)
>   * S EL0 EL1&0 (aka S PL0)
>   * S EL1 EL1&0 (not used if EL3 is 32 bit)
> + * S EL1 EL1&0 +PAN
>   * S EL3 (aka S PL1)
>   * NS EL1&0 stage 2
>   *
> - * for a total of 9 different mmu_idx.
> + * for a total of 12 different mmu_idx.
>   *
>   * R profile CPUs have an MPU, but can use the same set of MMU indexes
>   * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
> @@ -2819,19 +2823,22 @@ typedef enum ARMMMUIdx {
>      /*
>       * A-profile.
>       */
> -    ARMMMUIdx_E10_0 =3D  0 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_E20_0 =3D  1 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E10_0      =3D  0 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E20_0      =3D  1 | ARM_MMU_IDX_A,
>=20=20
> -    ARMMMUIdx_E10_1 =3D  2 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E10_1      =3D  2 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E10_1_PAN  =3D  3 | ARM_MMU_IDX_A,
>=20=20
> -    ARMMMUIdx_E2 =3D     3 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_E20_2 =3D  4 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E2         =3D  4 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E20_2      =3D  5 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E20_2_PAN  =3D  6 | ARM_MMU_IDX_A,
>=20=20
> -    ARMMMUIdx_SE10_0 =3D 5 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE10_1 =3D 6 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE3 =3D    7 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE10_0     =3D 7 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE10_1     =3D 8 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE10_1_PAN =3D 9 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE3        =3D 10 | ARM_MMU_IDX_A,
>=20=20
> -    ARMMMUIdx_Stage2 =3D 8 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_Stage2     =3D 11 | ARM_MMU_IDX_A,
>=20=20
>      /*
>       * These are not allocated TLBs and are used only for AT system
> @@ -2839,6 +2846,7 @@ typedef enum ARMMMUIdx {
>       */
>      ARMMMUIdx_Stage1_E0 =3D 0 | ARM_MMU_IDX_NOTLB,
>      ARMMMUIdx_Stage1_E1 =3D 1 | ARM_MMU_IDX_NOTLB,
> +    ARMMMUIdx_Stage1_E1_PAN =3D 2 | ARM_MMU_IDX_NOTLB,
>=20=20
>      /*
>       * M-profile.
> @@ -2864,10 +2872,13 @@ typedef enum ARMMMUIdxBit {
>      TO_CORE_BIT(E10_0),
>      TO_CORE_BIT(E20_0),
>      TO_CORE_BIT(E10_1),
> +    TO_CORE_BIT(E10_1_PAN),
>      TO_CORE_BIT(E2),
>      TO_CORE_BIT(E20_2),
> +    TO_CORE_BIT(E20_2_PAN),
>      TO_CORE_BIT(SE10_0),
>      TO_CORE_BIT(SE10_1),
> +    TO_CORE_BIT(SE10_1_PAN),
>      TO_CORE_BIT(SE3),
>      TO_CORE_BIT(Stage2),
>=20=20
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1f8ee5f573..6be8b2d1a9 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -843,12 +843,16 @@ static inline bool regime_has_2_ranges(ARMMMUIdx mm=
u_idx)
>      switch (mmu_idx) {
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
> +    case ARMMMUIdx_Stage1_E1_PAN:
>      case ARMMMUIdx_E10_0:
>      case ARMMMUIdx_E10_1:
> +    case ARMMMUIdx_E10_1_PAN:
>      case ARMMMUIdx_E20_0:
>      case ARMMMUIdx_E20_2:
> +    case ARMMMUIdx_E20_2_PAN:
>      case ARMMMUIdx_SE10_0:
>      case ARMMMUIdx_SE10_1:
> +    case ARMMMUIdx_SE10_1_PAN:
>          return true;
>      default:
>          return false;
> @@ -861,10 +865,13 @@ static inline bool regime_is_secure(CPUARMState *en=
v, ARMMMUIdx mmu_idx)
>      switch (mmu_idx) {
>      case ARMMMUIdx_E10_0:
>      case ARMMMUIdx_E10_1:
> +    case ARMMMUIdx_E10_1_PAN:
>      case ARMMMUIdx_E20_0:
>      case ARMMMUIdx_E20_2:
> +    case ARMMMUIdx_E20_2_PAN:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
> +    case ARMMMUIdx_Stage1_E1_PAN:
>      case ARMMMUIdx_E2:
>      case ARMMMUIdx_Stage2:
>      case ARMMMUIdx_MPrivNegPri:
> @@ -875,6 +882,7 @@ static inline bool regime_is_secure(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_SE3:
>      case ARMMMUIdx_SE10_0:
>      case ARMMMUIdx_SE10_1:
> +    case ARMMMUIdx_SE10_1_PAN:
>      case ARMMMUIdx_MSPrivNegPri:
>      case ARMMMUIdx_MSUserNegPri:
>      case ARMMMUIdx_MSPriv:
> @@ -1046,6 +1054,7 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMM=
UIdx mmu_idx)
>      switch (mmu_idx) {
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
> +    case ARMMMUIdx_Stage1_E1_PAN:
>          return true;
>      default:
>          return false;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 852fd71dcc..739d2d4cc5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -671,6 +671,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>=20=20
>      tlb_flush_by_mmuidx(cs,
>                          ARMMMUIdxBit_E10_1 |
> +                        ARMMMUIdxBit_E10_1_PAN |
>                          ARMMMUIdxBit_E10_0 |
>                          ARMMMUIdxBit_Stage2);
>  }
> @@ -682,6 +683,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, c=
onst ARMCPRegInfo *ri,
>=20=20
>      tlb_flush_by_mmuidx_all_cpus_synced(cs,
>                                          ARMMMUIdxBit_E10_1 |
> +                                        ARMMMUIdxBit_E10_1_PAN |
>                                          ARMMMUIdxBit_E10_0 |
>                                          ARMMMUIdxBit_Stage2);
>  }
> @@ -2700,6 +2702,7 @@ static int gt_phys_redir_timeridx(CPUARMState *env)
>      switch (arm_mmu_idx(env)) {
>      case ARMMMUIdx_E20_0:
>      case ARMMMUIdx_E20_2:
> +    case ARMMMUIdx_E20_2_PAN:
>          return GTIMER_HYP;
>      default:
>          return GTIMER_PHYS;
> @@ -2711,6 +2714,7 @@ static int gt_virt_redir_timeridx(CPUARMState *env)
>      switch (arm_mmu_idx(env)) {
>      case ARMMMUIdx_E20_0:
>      case ARMMMUIdx_E20_2:
> +    case ARMMMUIdx_E20_2_PAN:
>          return GTIMER_HYPVIRT;
>      default:
>          return GTIMER_VIRT;
> @@ -3337,7 +3341,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint=
64_t value,
>          format64 =3D arm_s1_regime_using_lpae_format(env, mmu_idx);
>=20=20
>          if (arm_feature(env, ARM_FEATURE_EL2)) {
> -            if (mmu_idx =3D=3D ARMMMUIdx_E10_0 || mmu_idx =3D=3D ARMMMUI=
dx_E10_1) {
> +            if (mmu_idx =3D=3D ARMMMUIdx_E10_0 ||
> +                mmu_idx =3D=3D ARMMMUIdx_E10_1 ||
> +                mmu_idx =3D=3D ARMMMUIdx_E10_1_PAN) {
>                  format64 |=3D env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
>              } else {
>                  format64 |=3D arm_current_el(env) =3D=3D 2;
> @@ -3797,7 +3803,9 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *en=
v, const ARMCPRegInfo *ri,
>      if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
>          (arm_hcr_el2_eff(env) & HCR_E2H)) {
>          tlb_flush_by_mmuidx(env_cpu(env),
> -                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
> +                            ARMMMUIdxBit_E20_2 |
> +                            ARMMMUIdxBit_E20_2_PAN |
> +                            ARMMMUIdxBit_E20_0);
>      }
>      raw_write(env, ri, value);
>  }
> @@ -3815,6 +3823,7 @@ static void vttbr_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
>      if (raw_read(env, ri) !=3D value) {
>          tlb_flush_by_mmuidx(cs,
>                              ARMMMUIdxBit_E10_1 |
> +                            ARMMMUIdxBit_E10_1_PAN |
>                              ARMMMUIdxBit_E10_0 |
>                              ARMMMUIdxBit_Stage2);
>          raw_write(env, ri, value);
> @@ -4175,12 +4184,18 @@ static int vae1_tlbmask(CPUARMState *env)
>  {
>      /* Since we exclude secure first, we may read HCR_EL2 directly. */
>      if (arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
> +        return ARMMMUIdxBit_SE10_1 |
> +               ARMMMUIdxBit_SE10_1_PAN |
> +               ARMMMUIdxBit_SE10_0;
>      } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
>                 =3D=3D (HCR_E2H | HCR_TGE)) {
> -        return ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0;
> +        return ARMMMUIdxBit_E20_2 |
> +               ARMMMUIdxBit_E20_2_PAN |
> +               ARMMMUIdxBit_E20_0;
>      } else {
> -        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
> +        return ARMMMUIdxBit_E10_1 |
> +               ARMMMUIdxBit_E10_1_PAN |
> +               ARMMMUIdxBit_E10_0;
>      }
>  }
>=20=20
> @@ -4214,18 +4229,28 @@ static int alle1_tlbmask(CPUARMState *env)
>       * stage 1 translations.
>       */
>      if (arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
> +        return ARMMMUIdxBit_SE10_1 |
> +               ARMMMUIdxBit_SE10_1_PAN |
> +               ARMMMUIdxBit_SE10_0;
>      } else if (arm_feature(env, ARM_FEATURE_EL2)) {
> -        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_St=
age2;
> +        return ARMMMUIdxBit_E10_1 |
> +               ARMMMUIdxBit_E10_1_PAN |
> +               ARMMMUIdxBit_E10_0 |
> +               ARMMMUIdxBit_Stage2;
>      } else {
> -        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
> +        return ARMMMUIdxBit_E10_1 |
> +               ARMMMUIdxBit_E10_1_PAN |
> +               ARMMMUIdxBit_E10_0;
>      }
>  }
>=20=20
>  static int alle2_tlbmask(CPUARMState *env)
>  {
>      /* TODO: ARMv8.4-SecEL2 */
> -    return ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E2;
> +    return ARMMMUIdxBit_E20_0 |
> +           ARMMMUIdxBit_E20_2 |
> +           ARMMMUIdxBit_E20_2_PAN |
> +           ARMMMUIdxBit_E2;
>  }
>=20=20
>  static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
> @@ -9215,6 +9240,7 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUI=
dx mmu_idx)
>      switch (mmu_idx) {
>      case ARMMMUIdx_E20_0:
>      case ARMMMUIdx_E20_2:
> +    case ARMMMUIdx_E20_2_PAN:
>      case ARMMMUIdx_Stage2:
>      case ARMMMUIdx_E2:
>          return 2;
> @@ -9223,10 +9249,13 @@ static uint32_t regime_el(CPUARMState *env, ARMMM=
UIdx mmu_idx)
>      case ARMMMUIdx_SE10_0:
>          return arm_el_is_aa64(env, 3) ? 1 : 3;
>      case ARMMMUIdx_SE10_1:
> +    case ARMMMUIdx_SE10_1_PAN:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
> +    case ARMMMUIdx_Stage1_E1_PAN:
>      case ARMMMUIdx_E10_0:
>      case ARMMMUIdx_E10_1:
> +    case ARMMMUIdx_E10_1_PAN:
>      case ARMMMUIdx_MPrivNegPri:
>      case ARMMMUIdx_MUserNegPri:
>      case ARMMMUIdx_MPriv:
> @@ -9342,6 +9371,8 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx m=
mu_idx)
>          return ARMMMUIdx_Stage1_E0;
>      case ARMMMUIdx_E10_1:
>          return ARMMMUIdx_Stage1_E1;
> +    case ARMMMUIdx_E10_1_PAN:
> +        return ARMMMUIdx_Stage1_E1_PAN;
>      default:
>          return mmu_idx;
>      }
> @@ -9388,6 +9419,7 @@ static inline bool regime_is_user(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>          return false;
>      case ARMMMUIdx_E10_0:
>      case ARMMMUIdx_E10_1:
> +    case ARMMMUIdx_E10_1_PAN:
>          g_assert_not_reached();
>      }
>  }
> @@ -11280,7 +11312,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong=
 address,
>                     target_ulong *page_size,
>                     ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
>  {
> -    if (mmu_idx =3D=3D ARMMMUIdx_E10_0 || mmu_idx =3D=3D ARMMMUIdx_E10_1=
) {
> +    if (mmu_idx =3D=3D ARMMMUIdx_E10_0 ||
> +        mmu_idx =3D=3D ARMMMUIdx_E10_1 ||
> +        mmu_idx =3D=3D ARMMMUIdx_E10_1_PAN) {
>          /* Call ourselves recursively to do the stage 1 and then stage 2
>           * translations.
>           */
> @@ -11807,10 +11841,13 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_SE10_0:
>          return 0;
>      case ARMMMUIdx_E10_1:
> +    case ARMMMUIdx_E10_1_PAN:
>      case ARMMMUIdx_SE10_1:
> +    case ARMMMUIdx_SE10_1_PAN:
>          return 1;
>      case ARMMMUIdx_E2:
>      case ARMMMUIdx_E20_2:
> +    case ARMMMUIdx_E20_2_PAN:
>          return 2;
>      case ARMMMUIdx_SE3:
>          return 3;
> @@ -12027,11 +12064,14 @@ static uint32_t rebuild_hflags_a64(CPUARMState =
*env, int el, int fp_el,
>      /* TODO: ARMv8.2-UAO */
>      switch (mmu_idx) {
>      case ARMMMUIdx_E10_1:
> +    case ARMMMUIdx_E10_1_PAN:
>      case ARMMMUIdx_SE10_1:
> +    case ARMMMUIdx_SE10_1_PAN:
>          /* TODO: ARMv8.3-NV */
>          flags =3D FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
>          break;
>      case ARMMMUIdx_E20_2:
> +    case ARMMMUIdx_E20_2_PAN:
>          /* TODO: ARMv8.4-SecEL2 */
>          /*
>           * Note that E20_2 is gated by HCR_EL2.E2H =3D=3D 1, but E20_0 is
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 6e82486884..49631c2340 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -124,12 +124,15 @@ static int get_a64_user_mem_index(DisasContext *s)
>           */
>          switch (useridx) {
>          case ARMMMUIdx_E10_1:
> +        case ARMMMUIdx_E10_1_PAN:
>              useridx =3D ARMMMUIdx_E10_0;
>              break;
>          case ARMMMUIdx_E20_2:
> +        case ARMMMUIdx_E20_2_PAN:
>              useridx =3D ARMMMUIdx_E20_0;
>              break;
>          case ARMMMUIdx_SE10_1:
> +        case ARMMMUIdx_SE10_1_PAN:
>              useridx =3D ARMMMUIdx_SE10_0;
>              break;
>          default:
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index e11a5871d0..d58c328e08 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -155,10 +155,12 @@ static inline int get_a32_user_mem_index(DisasConte=
xt *s)
>      case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
>      case ARMMMUIdx_E10_0:
>      case ARMMMUIdx_E10_1:
> +    case ARMMMUIdx_E10_1_PAN:
>          return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
>      case ARMMMUIdx_SE3:
>      case ARMMMUIdx_SE10_0:
>      case ARMMMUIdx_SE10_1:
> +    case ARMMMUIdx_SE10_1_PAN:
>          return arm_to_core_mmu_idx(ARMMMUIdx_SE10_0);
>      case ARMMMUIdx_MUser:
>      case ARMMMUIdx_MPriv:


--=20
Alex Benn=C3=A9e

