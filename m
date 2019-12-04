Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE6C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87EB20833
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFh0IvCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87EB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTN2-0007uW-My
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icSSZ-0001QK-FH
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icSQO-0005Cr-Ig
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:02:34 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icSQO-0004b5-AL
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:02:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so8016638wrt.6
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZqVHgMcCd7kkDODEXrZrRan1RGtDvVpLSO5ofWs7Ce4=;
 b=LFh0IvCf9UbWo9/QCJQIJlqAaHg1VQlbCetHmiwOI9R/vKJHSUbHWI9nqptGcOrfkl
 +vTtCBoRU4edvH2ljlLM8Xbj+3Jjii23zWStNqOfaCA5IAAdAo2N/T8Fzk6vHs3MKMs2
 5/vbJDe1p9Pw25TpVmhBFOMQ1Ouc4dywA7TJltZeDHECIJ6vlzxtT1q2Arqb8FNZEJ9u
 B08AkgfvGZ53AegPeg3utQ3LIhGWrVcjZxyzPMowZQfD/Y9Q3OUTG/IrgOKlNG7X2ZjB
 PhbZgqF1zlC/Z9j8XPdOub3GT14CQu7+3HWDsVuu07XJ8MN0ugZ0AzL5YY8ot0yh+Lmi
 /AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZqVHgMcCd7kkDODEXrZrRan1RGtDvVpLSO5ofWs7Ce4=;
 b=WbtKgxF+7R1pX/9ITG0CZnVGhYpzBb0Anv/Elv0F3Vlde30I6yFLCjojqoOn1WSNFf
 x/AOjY38+vc71c93vqdD4cO0vDMCGamIumHydIQ4lvifbvs9LCwnRXsfR9e2GvT/sHtj
 eRiZBhyEyTe2mkfUQYpyEvHj9pjdrO5ddoXr7/jMq2ALdqR8luVwdNtESw09UFgX7bAH
 GTp+6KYzxrNNkRuIn+Jn9cXdtG961kmzhMMXCGqht9e2X48C4IzFC0OJlhJBbVzZb4li
 b6kNZxQkCbZuCaL6pDNe1svv9e1EHuVi1yZVwqkEtXemA6IFdOM0ArLujHMgke17nvpm
 gPfQ==
X-Gm-Message-State: APjAAAW1arXG7xY/MNodONUmjuK3FBlGUyaiL+xjn4pA6PV+xAhKYiUN
 +Nlxvt+n/Eu81bfkZX6Rq9mXog==
X-Google-Smtp-Source: APXvYqym+Ul0ih0rXI3BtWG071AkxvOQynVJRmWNWwvtCZ9yKwAimyAXK5RDPAB72yBbPPrxPPAPzg==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr3150303wrr.309.1575457342018; 
 Wed, 04 Dec 2019 03:02:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y139sm6631255wmd.24.2019.12.04.03.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 03:02:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 10B6A1FF87;
 Wed,  4 Dec 2019 11:02:20 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-13-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 12/40] target/arm: Rename ARMMMUIdx*_S1E3 to
 ARMMMUIdx*_SE3
In-reply-to: <20191203022937.1474-13-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 11:02:20 +0000
Message-ID: <874kyg9ww3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
> The EL3 regime only has a single stage translation, and
> is always secure.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h       |  4 ++--
>  target/arm/internals.h |  2 +-
>  target/arm/helper.c    | 14 +++++++-------
>  target/arm/translate.c |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e8ee316e05..f307de561a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2867,7 +2867,7 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_EL10_0 =3D 0 | ARM_MMU_IDX_A,
>      ARMMMUIdx_EL10_1 =3D 1 | ARM_MMU_IDX_A,
>      ARMMMUIdx_S1E2 =3D 2 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_S1E3 =3D 3 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE3 =3D 3 | ARM_MMU_IDX_A,
>      ARMMMUIdx_SE0 =3D 4 | ARM_MMU_IDX_A,
>      ARMMMUIdx_SE1 =3D 5 | ARM_MMU_IDX_A,
>      ARMMMUIdx_Stage2 =3D 6 | ARM_MMU_IDX_A,
> @@ -2893,7 +2893,7 @@ typedef enum ARMMMUIdxBit {
>      ARMMMUIdxBit_EL10_0 =3D 1 << 0,
>      ARMMMUIdxBit_EL10_1 =3D 1 << 1,
>      ARMMMUIdxBit_S1E2 =3D 1 << 2,
> -    ARMMMUIdxBit_S1E3 =3D 1 << 3,
> +    ARMMMUIdxBit_SE3 =3D 1 << 3,
>      ARMMMUIdxBit_SE0 =3D 1 << 4,
>      ARMMMUIdxBit_SE1 =3D 1 << 5,
>      ARMMMUIdxBit_Stage2 =3D 1 << 6,
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 3600bf9122..50d258b0e1 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -819,7 +819,7 @@ static inline bool regime_is_secure(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_MPriv:
>      case ARMMMUIdx_MUser:
>          return false;
> -    case ARMMMUIdx_S1E3:
> +    case ARMMMUIdx_SE3:
>      case ARMMMUIdx_SE0:
>      case ARMMMUIdx_SE1:
>      case ARMMMUIdx_MSPrivNegPri:
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 377825431a..98d00b4549 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3138,7 +3138,7 @@ static void ats_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
>          /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
>          switch (el) {
>          case 3:
> -            mmu_idx =3D ARMMMUIdx_S1E3;
> +            mmu_idx =3D ARMMMUIdx_SE3;
>              break;
>          case 2:
>              mmu_idx =3D ARMMMUIdx_Stage1_E1;
> @@ -3220,7 +3220,7 @@ static void ats_write64(CPUARMState *env, const ARM=
CPRegInfo *ri,
>              mmu_idx =3D ARMMMUIdx_S1E2;
>              break;
>          case 6: /* AT S1E3R, AT S1E3W */
> -            mmu_idx =3D ARMMMUIdx_S1E3;
> +            mmu_idx =3D ARMMMUIdx_SE3;
>              break;
>          default:
>              g_assert_not_reached();
> @@ -3963,7 +3963,7 @@ static void tlbi_aa64_alle3_write(CPUARMState *env,=
 const ARMCPRegInfo *ri,
>      ARMCPU *cpu =3D env_archcpu(env);
>      CPUState *cs =3D CPU(cpu);
>=20=20
> -    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E3);
> +    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_SE3);
>  }
>=20=20
>  static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> @@ -3988,7 +3988,7 @@ static void tlbi_aa64_alle3is_write(CPUARMState *en=
v, const ARMCPRegInfo *ri,
>  {
>      CPUState *cs =3D env_cpu(env);
>=20=20
> -    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E3);
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_SE3);
>  }
>=20=20
>  static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *r=
i,
> @@ -4016,7 +4016,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, =
const ARMCPRegInfo *ri,
>      CPUState *cs =3D CPU(cpu);
>      uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>=20=20
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E3);
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_SE3);
>  }
>=20=20
>  static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
> @@ -4065,7 +4065,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env=
, const ARMCPRegInfo *ri,
>      uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>=20=20
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             ARMMMUIdxBit_S1E3);
> +                                             ARMMMUIdxBit_SE3);
>  }
>=20=20
>  static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> @@ -8567,7 +8567,7 @@ static inline uint32_t regime_el(CPUARMState *env, =
ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_Stage2:
>      case ARMMMUIdx_S1E2:
>          return 2;
> -    case ARMMMUIdx_S1E3:
> +    case ARMMMUIdx_SE3:
>          return 3;
>      case ARMMMUIdx_SE0:
>          return arm_el_is_aa64(env, 3) ? 1 : 3;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 787e34f258..6cf2fe2806 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -156,7 +156,7 @@ static inline int get_a32_user_mem_index(DisasContext=
 *s)
>      case ARMMMUIdx_EL10_0:
>      case ARMMMUIdx_EL10_1:
>          return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
> -    case ARMMMUIdx_S1E3:
> +    case ARMMMUIdx_SE3:
>      case ARMMMUIdx_SE0:
>      case ARMMMUIdx_SE1:
>          return arm_to_core_mmu_idx(ARMMMUIdx_SE0);


--=20
Alex Benn=C3=A9e

