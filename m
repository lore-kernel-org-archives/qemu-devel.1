Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA3C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEF320637
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAaQlRQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEF320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icSlA-0008KU-HR
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 06:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icS3T-0007Id-7x
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icS3Q-0006FQ-BT
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:38:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icS3P-0006Bp-Pi
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:38:44 -0500
Received: by mail-wr1-x441.google.com with SMTP id a15so7907483wrf.9
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xIoqR+lEwHYliMr6zAOom4U0hXtVp/tMWha4w4SUc+Q=;
 b=LAaQlRQVou0ODtdFVX3A6NtyQQn3Lvbsjf/0LX23o3a1BMWu9hik+CKhrpTGzCUXuk
 27x+4i02GVYlkwSeBzV81sZGN56xSWCmT+AbGZyIWHPZwqPH3LWRreVgEQ4CsQz1golY
 NIV9/SsNLY9bntt7RImdKwmEs3EzT5ydLkxMiwppn7uC3NdtPrlSY4J9Uxmph3npKmUM
 elFH9KcDyx6NKgH2b7zHDwID758ohxF99JDCqjjAOYb9YdLJXnXB6TQ5XVqda5LbL5QJ
 jCbKy3JnMNxhDCaqoEKfs1KTcQ84YSngxpU22NLsGhmNt7Cnr86jwEh1pHcdEU8YLSS1
 DpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xIoqR+lEwHYliMr6zAOom4U0hXtVp/tMWha4w4SUc+Q=;
 b=KfbLVaQ3ZLfx6aRjn4KXbs089MLMB/Roby9vBbzmoOPxMpYKaqsSIu5PtBpq8hpMao
 9urgUbIcBP9CVLWmq8jF/0xL027pd4bvO3kqJrGt0tEKLhfCA/sCQc/kgn9A0XuDVowb
 GAtZTA2ZL+wxIYIkuqIJVFniHO0GGt6ZpI3WRITIpnryv5CdNodX0M3qUbbXb3p4rWOP
 voZubm1482Fmcl/fsDNqJfVm/4kj0CQX70kJBNM9tDsfgidrbBl+5J8l1oy7BPQTgu5b
 WLOCGMGHpecaNpKmxYIXMlBwhR2MW+zRGpRRm7P4619R1rRjGBTBG6HApOhdUgym7ID4
 VW5g==
X-Gm-Message-State: APjAAAX87NwuiNcIKUvyFCTbAM1as0gAAJjYmjupMJk6JhmTvIViaVhs
 WXSXtGXFytbaOxVlk47stVKkBg==
X-Google-Smtp-Source: APXvYqykiVjJNlDujv5g1x9L+qPBLz5b9EzLRvoffvaqPx3hkr199A+R4mpFZ9p/HHj+2s0Ox5IP2A==
X-Received: by 2002:adf:de84:: with SMTP id w4mr3030165wrl.97.1575455918619;
 Wed, 04 Dec 2019 02:38:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q144sm519200wme.46.2019.12.04.02.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 02:38:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A6EA71FF87;
 Wed,  4 Dec 2019 10:38:36 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-9-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 08/40] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
In-reply-to: <20191203022937.1474-9-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 10:38:36 +0000
Message-ID: <87fti09xzn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
> This emphasizes that they apply to the EL1&0 regime.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h           |  8 ++++----
>  target/arm/internals.h     |  4 ++--
>  target/arm/helper.c        | 40 +++++++++++++++++++-------------------
>  target/arm/translate-a64.c |  4 ++--
>  target/arm/translate.c     |  6 +++---
>  5 files changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9729e62d2c..802cddd2df 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2864,8 +2864,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, =
unsigned int excp_idx,
>  #define ARM_MMU_IDX_COREIDX_MASK 0x7
>=20=20
>  typedef enum ARMMMUIdx {
> -    ARMMMUIdx_S12NSE0 =3D 0 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_S12NSE1 =3D 1 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_EL10_0 =3D 0 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_EL10_1 =3D 1 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1E2 =3D 2 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1E3 =3D 3 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1SE0 =3D 4 | ARM_MMU_IDX_A,
> @@ -2890,8 +2890,8 @@ typedef enum ARMMMUIdx {
>   * for use when calling tlb_flush_by_mmuidx() and friends.
>   */
>  typedef enum ARMMMUIdxBit {
> -    ARMMMUIdxBit_S12NSE0 =3D 1 << 0,
> -    ARMMMUIdxBit_S12NSE1 =3D 1 << 1,
> +    ARMMMUIdxBit_EL10_0 =3D 1 << 0,
> +    ARMMMUIdxBit_EL10_1 =3D 1 << 1,
>      ARMMMUIdxBit_S1E2 =3D 1 << 2,
>      ARMMMUIdxBit_S1E3 =3D 1 << 3,
>      ARMMMUIdxBit_S1SE0 =3D 1 << 4,
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index f5313dd3d4..54142dd789 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -808,8 +808,8 @@ static inline void arm_call_el_change_hook(ARMCPU *cp=
u)
>  static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
>      switch (mmu_idx) {
> -    case ARMMMUIdx_S12NSE0:
> -    case ARMMMUIdx_S12NSE1:
> +    case ARMMMUIdx_EL10_0:
> +    case ARMMMUIdx_EL10_1:
>      case ARMMMUIdx_S1NSE0:
>      case ARMMMUIdx_S1NSE1:
>      case ARMMMUIdx_S1E2:
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6c09cda4ea..d2b90763ca 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -670,8 +670,8 @@ static void tlbiall_nsnh_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>      CPUState *cs =3D env_cpu(env);
>=20=20
>      tlb_flush_by_mmuidx(cs,
> -                        ARMMMUIdxBit_S12NSE1 |
> -                        ARMMMUIdxBit_S12NSE0 |
> +                        ARMMMUIdxBit_EL10_1 |
> +                        ARMMMUIdxBit_EL10_0 |
>                          ARMMMUIdxBit_S2NS);
>  }
>=20=20
> @@ -681,8 +681,8 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, c=
onst ARMCPRegInfo *ri,
>      CPUState *cs =3D env_cpu(env);
>=20=20
>      tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                        ARMMMUIdxBit_S12NSE1 |
> -                                        ARMMMUIdxBit_S12NSE0 |
> +                                        ARMMMUIdxBit_EL10_1 |
> +                                        ARMMMUIdxBit_EL10_0 |
>                                          ARMMMUIdxBit_S2NS);
>  }
>=20=20
> @@ -3068,7 +3068,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint=
64_t value,
>          format64 =3D arm_s1_regime_using_lpae_format(env, mmu_idx);
>=20=20
>          if (arm_feature(env, ARM_FEATURE_EL2)) {
> -            if (mmu_idx =3D=3D ARMMMUIdx_S12NSE0 || mmu_idx =3D=3D ARMMM=
UIdx_S12NSE1) {
> +            if (mmu_idx =3D=3D ARMMMUIdx_EL10_0 || mmu_idx =3D=3D ARMMMU=
Idx_EL10_1) {
>                  format64 |=3D env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
>              } else {
>                  format64 |=3D arm_current_el(env) =3D=3D 2;
> @@ -3167,11 +3167,11 @@ static void ats_write(CPUARMState *env, const ARM=
CPRegInfo *ri, uint64_t value)
>          break;
>      case 4:
>          /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
> -        mmu_idx =3D ARMMMUIdx_S12NSE1;
> +        mmu_idx =3D ARMMMUIdx_EL10_1;
>          break;
>      case 6:
>          /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
> -        mmu_idx =3D ARMMMUIdx_S12NSE0;
> +        mmu_idx =3D ARMMMUIdx_EL10_0;
>          break;
>      default:
>          g_assert_not_reached();
> @@ -3229,10 +3229,10 @@ static void ats_write64(CPUARMState *env, const A=
RMCPRegInfo *ri,
>          mmu_idx =3D secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
>          break;
>      case 4: /* AT S12E1R, AT S12E1W */
> -        mmu_idx =3D secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
> +        mmu_idx =3D secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_EL10_1;
>          break;
>      case 6: /* AT S12E0R, AT S12E0W */
> -        mmu_idx =3D secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
> +        mmu_idx =3D secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_EL10_0;
>          break;
>      default:
>          g_assert_not_reached();
> @@ -3531,8 +3531,8 @@ static void vttbr_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
>      /* Accesses to VTTBR may change the VMID so we must flush the TLB.  =
*/
>      if (raw_read(env, ri) !=3D value) {
>          tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S12NSE1 |
> -                            ARMMMUIdxBit_S12NSE0 |
> +                            ARMMMUIdxBit_EL10_1 |
> +                            ARMMMUIdxBit_EL10_0 |
>                              ARMMMUIdxBit_S2NS);
>          raw_write(env, ri, value);
>      }
> @@ -3893,7 +3893,7 @@ static int vae1_tlbmask(CPUARMState *env)
>      if (arm_is_secure_below_el3(env)) {
>          return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
>      } else {
> -        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
> +        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
>      }
>  }
>=20=20
> @@ -3929,9 +3929,9 @@ static int vmalle1_tlbmask(CPUARMState *env)
>      if (arm_is_secure_below_el3(env)) {
>          return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
>      } else if (arm_feature(env, ARM_FEATURE_EL2)) {
> -        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBi=
t_S2NS;
> +        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_=
S2NS;
>      } else {
> -        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
> +        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
>      }
>  }
>=20=20
> @@ -8671,8 +8671,8 @@ static inline TCR *regime_tcr(CPUARMState *env, ARM=
MMUIdx mmu_idx)
>   */
>  static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
>  {
> -    if (mmu_idx =3D=3D ARMMMUIdx_S12NSE0 || mmu_idx =3D=3D ARMMMUIdx_S12=
NSE1) {
> -        mmu_idx +=3D (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
> +    if (mmu_idx =3D=3D ARMMMUIdx_EL10_0 || mmu_idx =3D=3D ARMMMUIdx_EL10=
_1) {
> +        mmu_idx +=3D (ARMMMUIdx_S1NSE0 - ARMMMUIdx_EL10_0);
>      }
>      return mmu_idx;
>  }
> @@ -8715,8 +8715,8 @@ static inline bool regime_is_user(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>          return true;
>      default:
>          return false;
> -    case ARMMMUIdx_S12NSE0:
> -    case ARMMMUIdx_S12NSE1:
> +    case ARMMMUIdx_EL10_0:
> +    case ARMMMUIdx_EL10_1:
>          g_assert_not_reached();
>      }
>  }
> @@ -10620,7 +10620,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong=
 address,
>                     target_ulong *page_size,
>                     ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
>  {
> -    if (mmu_idx =3D=3D ARMMMUIdx_S12NSE0 || mmu_idx =3D=3D ARMMMUIdx_S12=
NSE1) {
> +    if (mmu_idx =3D=3D ARMMMUIdx_EL10_0 || mmu_idx =3D=3D ARMMMUIdx_EL10=
_1) {
>          /* Call ourselves recursively to do the stage 1 and then stage 2
>           * translations.
>           */
> @@ -11148,7 +11148,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
>      if (el < 2 && arm_is_secure_below_el3(env)) {
>          return ARMMMUIdx_S1SE0 + el;
>      } else {
> -        return ARMMMUIdx_S12NSE0 + el;
> +        return ARMMMUIdx_EL10_0 + el;
>      }
>  }
>=20=20
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d4bebbe629..2703ebf32a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -113,8 +113,8 @@ static inline int get_a64_user_mem_index(DisasContext=
 *s)
>      ARMMMUIdx useridx;
>=20=20
>      switch (s->mmu_idx) {
> -    case ARMMMUIdx_S12NSE1:
> -        useridx =3D ARMMMUIdx_S12NSE0;
> +    case ARMMMUIdx_EL10_1:
> +        useridx =3D ARMMMUIdx_EL10_0;
>          break;
>      case ARMMMUIdx_S1SE1:
>          useridx =3D ARMMMUIdx_S1SE0;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4d5d4bd888..e3deea50e0 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -153,9 +153,9 @@ static inline int get_a32_user_mem_index(DisasContext=
 *s)
>       */
>      switch (s->mmu_idx) {
>      case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
> -    case ARMMMUIdx_S12NSE0:
> -    case ARMMMUIdx_S12NSE1:
> -        return arm_to_core_mmu_idx(ARMMMUIdx_S12NSE0);
> +    case ARMMMUIdx_EL10_0:
> +    case ARMMMUIdx_EL10_1:
> +        return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
>      case ARMMMUIdx_S1E3:
>      case ARMMMUIdx_S1SE0:
>      case ARMMMUIdx_S1SE1:


--=20
Alex Benn=C3=A9e

