Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB274C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5783217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPdN8VEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5783217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2XC-0003Tv-Uk
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2Vg-0002MI-PJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2Ve-0006cH-AD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:43:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK2Vc-0006Yv-Py
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:43:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id i16so17779211wmd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uszuYWrcXo5En1JdBB/Ve5JEhTOKuGlSkZjZjpwzCOQ=;
 b=TPdN8VEsF+GFwbXBCFLnIdg3Apx0ZDbrdtYAS4R19k7jHmmuIJdKSrV029hc1jYbeU
 9OYnZ/MIqxdSwFWrpFzqICcoUPMV5Jk+F1oLIwZSnmmGkN3VQDkM8DIdJgryL3STd8QL
 DWrgwckpsiKPrqWYMZOSmY9T8ldTfqWPNgKNMWZtT0brtou0TeS4C23Cle+xUqwpUlUx
 BTkc5+odB5gjLXMngp/5dk1dYQVhhULp3RTLtczBZL58DenNQQHztSVmhfXn5O09pGPx
 3DV0qRczcb6qgvxcY3zEDz4r4cTD6vqcGMdgmBnbyph99aC+NQGA/RvCea5DAddj22Yo
 +ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uszuYWrcXo5En1JdBB/Ve5JEhTOKuGlSkZjZjpwzCOQ=;
 b=gCiXebGOBVB+VbmbW+CYLFOhfWce6r+igxS00chtrDJhJOvKn756UAbp+6all3rxsO
 nwyLS5qsqzphMaL4GayAbUpsUk3mcLGCJMr2vb+vYOTvSMyX6e8Y9vYaooZEs0hubeCG
 s8etbYz3QFuwW8QtMwkSgD3JAo4NgevBxIs+GZrb+amnj70KDteGT2TtBYpn7izoMyDG
 b/hTYySs7ciODp5mWNKq90NlPdkXF749KD640IkdlMiRZAMMdUPxwPDZ0KogWpdL8Pvb
 U0xGp+8rLZskskMgu1e2XVO7gLiAqDaEW9kbFEL8ZgLmRtobfszdv2oPiWhCTr/bL+mz
 MSmQ==
X-Gm-Message-State: APjAAAXJuMyzy8lL/zxR64EZHwQdDEbKIGW4gARABOXRb34vWUeLRVhl
 SGm5wIV1t5qbajcUqxH94huv5A==
X-Google-Smtp-Source: APXvYqz+TmaM9LcPLtUZCrU+fmdyN9WcJvKHPwGOvanAwndt+saLDH9J0jbCr7tbevhjjruW9Nk5cA==
X-Received: by 2002:a05:600c:2291:: with SMTP id
 17mr14539149wmf.171.1571067821987; 
 Mon, 14 Oct 2019 08:43:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x5sm34222663wrg.69.2019.10.14.08.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 08:43:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 773881FF87;
 Mon, 14 Oct 2019 16:43:40 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 02/20] target/arm: Split out rebuild_hflags_a64
In-reply-to: <20191011155546.14342-3-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 16:43:40 +0100
Message-ID: <87v9srmixf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Create a function to compute the values of the TBFLAG_A64 bits
> that will be cached.  For now, the env->hflags variable is not
> used, and the results are fed back to cpu_get_tb_cpu_state.
>
> Note that not all BTI related flags are cached, so we have to
> test the BTI feature twice -- once for those bits moved out to
> rebuild_hflags_a64 and once for those bits that remain in
> cpu_get_tb_cpu_state.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 131 +++++++++++++++++++++++---------------------
>  1 file changed, 69 insertions(+), 62 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8829d91ae1..69da04786e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11070,6 +11070,71 @@ static uint32_t rebuild_hflags_common(CPUARMStat=
e *env, int fp_el,
>      return flags;
>  }
>
> +static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
> +                                   ARMMMUIdx mmu_idx)
> +{
> +    ARMMMUIdx stage1 =3D stage_1_mmu_idx(mmu_idx);
> +    ARMVAParameters p0 =3D aa64_va_parameters_both(env, 0, stage1);
> +    uint32_t flags =3D 0;
> +    uint64_t sctlr;
> +    int tbii, tbid;
> +
> +    flags =3D FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
> +
> +    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> +    if (regime_el(env, stage1) < 2) {
> +        ARMVAParameters p1 =3D aa64_va_parameters_both(env, -1, stage1);
> +        tbid =3D (p1.tbi << 1) | p0.tbi;
> +        tbii =3D tbid & ~((p1.tbid << 1) | p0.tbid);
> +    } else {
> +        tbid =3D p0.tbi;
> +        tbii =3D tbid & !p0.tbid;
> +    }
> +
> +    flags =3D FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
> +    flags =3D FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
> +
> +    if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
> +        int sve_el =3D sve_exception_el(env, el);
> +        uint32_t zcr_len;
> +
> +        /*
> +         * If SVE is disabled, but FP is enabled,
> +         * then the effective len is 0.
> +         */
> +        if (sve_el !=3D 0 && fp_el =3D=3D 0) {
> +            zcr_len =3D 0;
> +        } else {
> +            zcr_len =3D sve_zcr_len_for_el(env, el);
> +        }
> +        flags =3D FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
> +        flags =3D FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
> +    }
> +
> +    sctlr =3D arm_sctlr(env, el);
> +
> +    if (cpu_isar_feature(aa64_pauth, env_archcpu(env))) {
> +        /*
> +         * In order to save space in flags, we record only whether
> +         * pauth is "inactive", meaning all insns are implemented as
> +         * a nop, or "active" when some action must be performed.
> +         * The decision of which action to take is left to a helper.
> +         */
> +        if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB))=
 {
> +            flags =3D FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
> +        }
> +    }
> +
> +    if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
> +        /* Note that SCTLR_EL[23].BT =3D=3D SCTLR_BT1.  */
> +        if (sctlr & (el =3D=3D 0 ? SCTLR_BT0 : SCTLR_BT1)) {
> +            flags =3D FIELD_DP32(flags, TBFLAG_A64, BT, 1);
> +        }
> +    }
> +
> +    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> +}
> +
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> @@ -11079,67 +11144,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>      uint32_t flags =3D 0;
>
>      if (is_a64(env)) {
> -        ARMCPU *cpu =3D env_archcpu(env);
> -        uint64_t sctlr;
> -
>          *pc =3D env->pc;
> -        flags =3D FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
> -
> -        /* Get control bits for tagged addresses.  */
> -        {
> -            ARMMMUIdx stage1 =3D stage_1_mmu_idx(mmu_idx);
> -            ARMVAParameters p0 =3D aa64_va_parameters_both(env, 0, stage=
1);
> -            int tbii, tbid;
> -
> -            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> -            if (regime_el(env, stage1) < 2) {
> -                ARMVAParameters p1 =3D aa64_va_parameters_both(env, -1, =
stage1);
> -                tbid =3D (p1.tbi << 1) | p0.tbi;
> -                tbii =3D tbid & ~((p1.tbid << 1) | p0.tbid);
> -            } else {
> -                tbid =3D p0.tbi;
> -                tbii =3D tbid & !p0.tbid;
> -            }
> -
> -            flags =3D FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
> -            flags =3D FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
> -        }
> -
> -        if (cpu_isar_feature(aa64_sve, cpu)) {
> -            int sve_el =3D sve_exception_el(env, current_el);
> -            uint32_t zcr_len;
> -
> -            /* If SVE is disabled, but FP is enabled,
> -             * then the effective len is 0.
> -             */
> -            if (sve_el !=3D 0 && fp_el =3D=3D 0) {
> -                zcr_len =3D 0;
> -            } else {
> -                zcr_len =3D sve_zcr_len_for_el(env, current_el);
> -            }
> -            flags =3D FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
> -            flags =3D FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
> -        }
> -
> -        sctlr =3D arm_sctlr(env, current_el);
> -
> -        if (cpu_isar_feature(aa64_pauth, cpu)) {
> -            /*
> -             * In order to save space in flags, we record only whether
> -             * pauth is "inactive", meaning all insns are implemented as
> -             * a nop, or "active" when some action must be performed.
> -             * The decision of which action to take is left to a helper.
> -             */
> -            if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_En=
DB)) {
> -                flags =3D FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
> -            }
> -        }
> -
> -        if (cpu_isar_feature(aa64_bti, cpu)) {
> -            /* Note that SCTLR_EL[23].BT =3D=3D SCTLR_BT1.  */
> -            if (sctlr & (current_el =3D=3D 0 ? SCTLR_BT0 : SCTLR_BT1)) {
> -                flags =3D FIELD_DP32(flags, TBFLAG_A64, BT, 1);
> -            }
> +        flags =3D rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
> +        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>          }
>      } else {
> @@ -11159,9 +11166,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>              flags =3D FIELD_DP32(flags, TBFLAG_A32,
>                                 XSCALE_CPAR, env->cp15.c15_cpar);
>          }
> -    }
>
> -    flags =3D rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> +        flags =3D rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> +    }
>
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
>       * states defined in the ARM ARM for software singlestep:


--
Alex Benn=C3=A9e

