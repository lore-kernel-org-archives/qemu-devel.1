Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78090C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDBE20637
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhAOo5uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDBE20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icSwQ-000522-7o
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 06:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icS5a-0008Qi-1X
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icS5X-0002xL-HB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:40:57 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icS5U-0002k0-TF
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:40:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so7972791wrr.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 02:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FrBU2FXqlWFLfUT0qohfTK3FgsyYVnvvKPGQtUpgRFc=;
 b=FhAOo5ucWiFOU6/k9YjcP2WHDVKHF58o7L92/OiHJoExawxyMOc7PfK6eky9liQS//
 LTXeUvZ61WVAMK9ZlNhgJdUzyvg88/HJeQYOeucy+Wkons1JflhbI5hNQiATmXwysDC7
 ujkPbCgFGA0DRHfHH/srS5+ncEIOB11zJsDO7LEMDcqrYqiBomooKdnk9yDGMh7Y6Moq
 uCpoQR/Wh38UVy+3dWOJmHvEEr7Z3G5QDJBrI45awcqXKnfdWYaLtvoh4WQrdBJzTdvj
 hf6N0Gvs1BAAZU2sP08ZIicAqyq6gHCKajboyoQ9n8RHjsvQ+fV2/KVefdBj7rwIiZnF
 /jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FrBU2FXqlWFLfUT0qohfTK3FgsyYVnvvKPGQtUpgRFc=;
 b=uVdCqHQyZ8UPepFYA8SQ7Fvr34pt9SmEoJ5ds3uRSxu21/7yUaRz3FGiGRr3299eTu
 /xs+JLRBsolVc59kppUS3gOIsn3BeIATgsO+xBOHQiU5ukwqkRA7mcqixpbD1hG1fQ0W
 tB1Ogn7mhJ7H1Ay+SdkWQOcqgsQj7wh039nlgIljGt6rPTsNquvQxU0C4jbw8KCmGQek
 LoAUzNO2VnjXNEBvAQWTT4u1zeQ3iviuNOFndTIcxkt4XJzuzE8prXjHRJ2UOBI3kEHd
 fZNyJxVXM89bXlFiB03tjJfTJbvJQZnjrxMP3sBXOvHQjpwXQPDmHb6b2nySN/elPalX
 pD4g==
X-Gm-Message-State: APjAAAXOaiu66+oOUCZ41itQM0o+VOMjdCUfPjQT43TLMrzOw0Gm6sNm
 YRso+yKOymJ4wRs/e7pGFLiys8/H4wY=
X-Google-Smtp-Source: APXvYqxW4mXuACa1h3qIKFO4s8fWL+g66y8pfTLZyGYPgh9aWSyrMCO+HL8x1/g7HjLy+5UKLEQvMA==
X-Received: by 2002:adf:9161:: with SMTP id j88mr3220537wrj.125.1575456043745; 
 Wed, 04 Dec 2019 02:40:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm6340695wme.45.2019.12.04.02.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 02:40:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 97B091FF87;
 Wed,  4 Dec 2019 10:40:41 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-10-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 09/40] target/arm: Rename ARMMMUIdx_S2NS to
 ARMMMUIdx_Stage2
In-reply-to: <20191203022937.1474-10-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 10:40:41 +0000
Message-ID: <87d0d49xw6.fsf@linaro.org>
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

> The EL1&0 regime is the only one that uses 2-stage translation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h           |  4 +--
>  target/arm/internals.h     |  2 +-
>  target/arm/helper.c        | 57 ++++++++++++++++++++------------------
>  target/arm/translate-a64.c |  2 +-
>  target/arm/translate.c     |  2 +-
>  5 files changed, 35 insertions(+), 32 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 802cddd2df..fdb868f2e9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2870,7 +2870,7 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_S1E3 =3D 3 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1SE0 =3D 4 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1SE1 =3D 5 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_S2NS =3D 6 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_Stage2 =3D 6 | ARM_MMU_IDX_A,
>      ARMMMUIdx_MUser =3D 0 | ARM_MMU_IDX_M,
>      ARMMMUIdx_MPriv =3D 1 | ARM_MMU_IDX_M,
>      ARMMMUIdx_MUserNegPri =3D 2 | ARM_MMU_IDX_M,
> @@ -2896,7 +2896,7 @@ typedef enum ARMMMUIdxBit {
>      ARMMMUIdxBit_S1E3 =3D 1 << 3,
>      ARMMMUIdxBit_S1SE0 =3D 1 << 4,
>      ARMMMUIdxBit_S1SE1 =3D 1 << 5,
> -    ARMMMUIdxBit_S2NS =3D 1 << 6,
> +    ARMMMUIdxBit_Stage2 =3D 1 << 6,
>      ARMMMUIdxBit_MUser =3D 1 << 0,
>      ARMMMUIdxBit_MPriv =3D 1 << 1,
>      ARMMMUIdxBit_MUserNegPri =3D 1 << 2,
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 54142dd789..ca8be78bbf 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -813,7 +813,7 @@ static inline bool regime_is_secure(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_S1NSE0:
>      case ARMMMUIdx_S1NSE1:
>      case ARMMMUIdx_S1E2:
> -    case ARMMMUIdx_S2NS:
> +    case ARMMMUIdx_Stage2:
>      case ARMMMUIdx_MPrivNegPri:
>      case ARMMMUIdx_MUserNegPri:
>      case ARMMMUIdx_MPriv:
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d2b90763ca..97677f8482 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -672,7 +672,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>      tlb_flush_by_mmuidx(cs,
>                          ARMMMUIdxBit_EL10_1 |
>                          ARMMMUIdxBit_EL10_0 |
> -                        ARMMMUIdxBit_S2NS);
> +                        ARMMMUIdxBit_Stage2);
>  }
>=20=20
>  static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
> @@ -683,7 +683,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, c=
onst ARMCPRegInfo *ri,
>      tlb_flush_by_mmuidx_all_cpus_synced(cs,
>                                          ARMMMUIdxBit_EL10_1 |
>                                          ARMMMUIdxBit_EL10_0 |
> -                                        ARMMMUIdxBit_S2NS);
> +                                        ARMMMUIdxBit_Stage2);
>  }
>=20=20
>  static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -704,7 +704,7 @@ static void tlbiipas2_write(CPUARMState *env, const A=
RMCPRegInfo *ri,
>=20=20
>      pageaddr =3D sextract64(value << 12, 0, 40);
>=20=20
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
>  }
>=20=20
>  static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -720,7 +720,7 @@ static void tlbiipas2_is_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>      pageaddr =3D sextract64(value << 12, 0, 40);
>=20=20
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             ARMMMUIdxBit_S2NS);
> +                                             ARMMMUIdxBit_Stage2);
>  }
>=20=20
>  static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3528,12 +3528,15 @@ static void vttbr_write(CPUARMState *env, const A=
RMCPRegInfo *ri,
>      ARMCPU *cpu =3D env_archcpu(env);
>      CPUState *cs =3D CPU(cpu);
>=20=20
> -    /* Accesses to VTTBR may change the VMID so we must flush the TLB.  =
*/
> +    /*
> +     * A change in VMID to the stage2 page table (Stage2) invalidates
> +     * the combined stage 1&2 tlbs (EL10_1 and EL10_0).
> +     */
>      if (raw_read(env, ri) !=3D value) {
>          tlb_flush_by_mmuidx(cs,
>                              ARMMMUIdxBit_EL10_1 |
>                              ARMMMUIdxBit_EL10_0 |
> -                            ARMMMUIdxBit_S2NS);
> +                            ARMMMUIdxBit_Stage2);
>          raw_write(env, ri, value);
>      }
>  }
> @@ -3929,7 +3932,7 @@ static int vmalle1_tlbmask(CPUARMState *env)
>      if (arm_is_secure_below_el3(env)) {
>          return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
>      } else if (arm_feature(env, ARM_FEATURE_EL2)) {
> -        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_=
S2NS;
> +        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_=
Stage2;
>      } else {
>          return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
>      }
> @@ -4083,7 +4086,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *en=
v, const ARMCPRegInfo *ri,
>=20=20
>      pageaddr =3D sextract64(value << 12, 0, 48);
>=20=20
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
>  }
>=20=20
>  static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegIn=
fo *ri,
> @@ -4099,7 +4102,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *=
env, const ARMCPRegInfo *ri,
>      pageaddr =3D sextract64(value << 12, 0, 48);
>=20=20
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             ARMMMUIdxBit_S2NS);
> +                                             ARMMMUIdxBit_Stage2);
>  }
>=20=20
>  static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegIn=
fo *ri,
> @@ -8560,7 +8563,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>  static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
>      switch (mmu_idx) {
> -    case ARMMMUIdx_S2NS:
> +    case ARMMMUIdx_Stage2:
>      case ARMMMUIdx_S1E2:
>          return 2;
>      case ARMMMUIdx_S1E3:
> @@ -8614,7 +8617,7 @@ static inline bool regime_translation_disabled(CPUA=
RMState *env,
>          }
>      }
>=20=20
> -    if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +    if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>          /* HCR.DC means HCR.VM behaves as 1 */
>          return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) =3D=3D 0;
>      }
> @@ -8645,7 +8648,7 @@ static inline bool regime_translation_big_endian(CP=
UARMState *env,
>  static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
>                                     int ttbrn)
>  {
> -    if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +    if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>          return env->cp15.vttbr_el2;
>      }
>      if (ttbrn =3D=3D 0) {
> @@ -8660,7 +8663,7 @@ static inline uint64_t regime_ttbr(CPUARMState *env=
, ARMMMUIdx mmu_idx,
>  /* Return the TCR controlling this translation regime */
>  static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
> -    if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +    if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>          return &env->cp15.vtcr_el2;
>      }
>      return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
> @@ -8847,7 +8850,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx m=
mu_idx, bool is_aa64,
>      bool have_wxn;
>      int wxn =3D 0;
>=20=20
> -    assert(mmu_idx !=3D ARMMMUIdx_S2NS);
> +    assert(mmu_idx !=3D ARMMMUIdx_Stage2);
>=20=20
>      user_rw =3D simple_ap_to_rw_prot_is_user(ap, true);
>      if (is_user) {
> @@ -8939,7 +8942,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, AR=
MMMUIdx mmu_idx,
>                                 ARMMMUFaultInfo *fi)
>  {
>      if ((mmu_idx =3D=3D ARMMMUIdx_S1NSE0 || mmu_idx =3D=3D ARMMMUIdx_S1N=
SE1) &&
> -        !regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
> +        !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
>          target_ulong s2size;
>          hwaddr s2pa;
>          int s2prot;
> @@ -8956,7 +8959,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, AR=
MMMUIdx mmu_idx,
>              pcacheattrs =3D &cacheattrs;
>          }
>=20=20
> -        ret =3D get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
> +        ret =3D get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_Stage2, &s2pa,
>                                   &txattrs, &s2prot, &s2size, fi, pcachea=
ttrs);
>          if (ret) {
>              assert(fi->type !=3D ARMFault_None);
> @@ -9428,7 +9431,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState=
 *env, uint64_t va,
>          tsz =3D extract32(tcr, 0, 6);
>          using64k =3D extract32(tcr, 14, 1);
>          using16k =3D extract32(tcr, 15, 1);
> -        if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +        if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>              /* VTCR_EL2 */
>              tbi =3D tbid =3D hpd =3D false;
>          } else {
> @@ -9489,7 +9492,7 @@ static ARMVAParameters aa32_va_parameters(CPUARMSta=
te *env, uint32_t va,
>      int select, tsz;
>      bool epd, hpd;
>=20=20
> -    if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +    if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>          /* VTCR */
>          bool sext =3D extract32(tcr, 4, 1);
>          bool sign =3D extract32(tcr, 3, 1);
> @@ -9591,7 +9594,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, ta=
rget_ulong address,
>          level =3D 1;
>          /* There is no TTBR1 for EL2 */
>          ttbr1_valid =3D (el !=3D 2);
> -        addrsize =3D (mmu_idx =3D=3D ARMMMUIdx_S2NS ? 40 : 32);
> +        addrsize =3D (mmu_idx =3D=3D ARMMMUIdx_Stage2 ? 40 : 32);
>          inputsize =3D addrsize - param.tsz;
>      }
>=20=20
> @@ -9642,7 +9645,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, ta=
rget_ulong address,
>          goto do_fault;
>      }
>=20=20
> -    if (mmu_idx !=3D ARMMMUIdx_S2NS) {
> +    if (mmu_idx !=3D ARMMMUIdx_Stage2) {
>          /* The starting level depends on the virtual address size (which=
 can
>           * be up to 48 bits) and the translation granule size. It indica=
tes
>           * the number of strides (stride bits at a time) needed to
> @@ -9742,7 +9745,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, ta=
rget_ulong address,
>          attrs =3D extract64(descriptor, 2, 10)
>              | (extract64(descriptor, 52, 12) << 10);
>=20=20
> -        if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +        if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>              /* Stage 2 table descriptors do not include any attribute fi=
elds */
>              break;
>          }
> @@ -9773,7 +9776,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, ta=
rget_ulong address,
>      ap =3D extract32(attrs, 4, 2);
>      xn =3D extract32(attrs, 12, 1);
>=20=20
> -    if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +    if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>          ns =3D true;
>          *prot =3D get_S2prot(env, ap, xn);
>      } else {
> @@ -9800,7 +9803,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, ta=
rget_ulong address,
>      }
>=20=20
>      if (cacheattrs !=3D NULL) {
> -        if (mmu_idx =3D=3D ARMMMUIdx_S2NS) {
> +        if (mmu_idx =3D=3D ARMMMUIdx_Stage2) {
>              cacheattrs->attrs =3D convert_stage2_attrs(env,
>                                                       extract32(attrs, 0,=
 4));
>          } else {
> @@ -9821,7 +9824,7 @@ do_fault:
>      fi->type =3D fault_type;
>      fi->level =3D level;
>      /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
> -    fi->stage2 =3D fi->s1ptw || (mmu_idx =3D=3D ARMMMUIdx_S2NS);
> +    fi->stage2 =3D fi->s1ptw || (mmu_idx =3D=3D ARMMMUIdx_Stage2);
>      return true;
>  }
>=20=20
> @@ -10635,13 +10638,13 @@ bool get_phys_addr(CPUARMState *env, target_ulo=
ng address,
>                                  prot, page_size, fi, cacheattrs);
>=20=20
>              /* If S1 fails or S2 is disabled, return early.  */
> -            if (ret || regime_translation_disabled(env, ARMMMUIdx_S2NS))=
 {
> +            if (ret || regime_translation_disabled(env, ARMMMUIdx_Stage2=
)) {
>                  *phys_ptr =3D ipa;
>                  return ret;
>              }
>=20=20
>              /* S1 is done. Now do S2 translation.  */
> -            ret =3D get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_=
S2NS,
> +            ret =3D get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_=
Stage2,
>                                       phys_ptr, attrs, &s2_prot,
>                                       page_size, fi,
>                                       cacheattrs !=3D NULL ? &cacheattrs2=
 : NULL);
> @@ -10683,7 +10686,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong=
 address,
>      /* Fast Context Switch Extension. This doesn't exist at all in v8.
>       * In v7 and earlier it affects all stage 1 translations.
>       */
> -    if (address < 0x02000000 && mmu_idx !=3D ARMMMUIdx_S2NS
> +    if (address < 0x02000000 && mmu_idx !=3D ARMMMUIdx_Stage2
>          && !arm_feature(env, ARM_FEATURE_V8)) {
>          if (regime_el(env, mmu_idx) =3D=3D 3) {
>              address +=3D env->cp15.fcseidr_s;
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2703ebf32a..3a39315a6c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -119,7 +119,7 @@ static inline int get_a64_user_mem_index(DisasContext=
 *s)
>      case ARMMMUIdx_S1SE1:
>          useridx =3D ARMMMUIdx_S1SE0;
>          break;
> -    case ARMMMUIdx_S2NS:
> +    case ARMMMUIdx_Stage2:
>          g_assert_not_reached();
>      default:
>          useridx =3D s->mmu_idx;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index e3deea50e0..1716bbb615 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -172,7 +172,7 @@ static inline int get_a32_user_mem_index(DisasContext=
 *s)
>      case ARMMMUIdx_MSUserNegPri:
>      case ARMMMUIdx_MSPrivNegPri:
>          return arm_to_core_mmu_idx(ARMMMUIdx_MSUserNegPri);
> -    case ARMMMUIdx_S2NS:
> +    case ARMMMUIdx_Stage2:
>      default:
>          g_assert_not_reached();
>      }


--=20
Alex Benn=C3=A9e

