Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69A6C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF87207DD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rw9ZMuJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF87207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTgc-0002UQ-Hd
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icT4S-0000bA-Ga
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icT4J-0003pE-BG
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:43:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icT4H-000316-NZ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:43:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id g17so8234405wro.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=shV5c1pJwDqi6fi6IyhoCOCFTsTfCukpcPfonQrdOAw=;
 b=rw9ZMuJEuTGSXrs+JwQPLJHWuxZc+dtXPg0HvClZFASbcdzssz3s5ZnKq5q2E0TfPf
 DfyP9RUSj5Ze0umujTeM2+Fc0+2JSF01dq+2dhTD1igCeWQ4OAyGMqzffPxPqG/T1lr2
 wPcxKrXAOy27OD13jQKlnrcdlvjDMMhMYeqvLDn6wh3f+hDkzmkH2Y1lqvUpq4rYwePo
 GguotyfE0iPE+aONcQeBcXS82zOZpiLdf1FJnPj7aMZvDXwGIdmQ7BUbm+8QTubPA/aA
 MIMjkq2dNUDdjhHEfISR/wTZGM9YahjVj6SiaAyvUgpCOr6ihSFUZxVyAHobZA+LZSkZ
 P7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=shV5c1pJwDqi6fi6IyhoCOCFTsTfCukpcPfonQrdOAw=;
 b=Q7t8Thd0Mu+uFoMaOgY7B9TrvIt9frXiVgyu7Q2EgXU4kTnSiVs8qILRcYMTYya7Sr
 cXITh6EeLAnk8HA+pKW/70PIYLmFnRftSX6yLnMKToRqQ6ZisgiLwa0WVB/JBla3538Y
 xgq7/6ifJNxjs+SjESHP5veFn+Bpc5ouBkrQBbTgMaEjCoqPMNPElIHQeW18A76LHBQn
 04pjZjjg4m1nThiMl6dH2ycXJxIcBR65oqnxYhqEMweIcFRt6EXiwsDiJ4FUU8dr+CF9
 5o/UisYQSBQu9ZQ/Tb6/vNVmq4n3/woJcchtUtlU//g4aH7FgzA33o3Kdx0m0CP6lp5H
 V8tw==
X-Gm-Message-State: APjAAAVaQz9+QilOzZ6XyM6J8k91/AXnTIiDn6+343myj4Wq4Lnneelz
 WNH3QSg0gXMNF3phjPT4IpjezA==
X-Google-Smtp-Source: APXvYqxpMuwSzAU1nx1H9Tx03WuG42ZUd+YrV+h9IR4pEdTr6B52NEqK18zldh9D5RQ0sJO4wKmaGg==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr3861143wrr.27.1575459812552;
 Wed, 04 Dec 2019 03:43:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f11sm6502232wmc.25.2019.12.04.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 03:43:31 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 494B91FF87;
 Wed,  4 Dec 2019 11:43:30 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-15-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 14/40] target/arm: Recover 4 bits from TBFLAGs
In-reply-to: <20191203022937.1474-15-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 11:43:30 +0000
Message-ID: <87y2vs8gf1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

> We had completely run out of TBFLAG bits.
> Split A- and M-profile bits into two overlapping buckets.
> This results in 4 free bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h       | 52 ++++++++++++++++++++++++---------------
>  target/arm/helper.c    | 17 ++++++-------
>  target/arm/translate.c | 56 +++++++++++++++++++++++-------------------
>  3 files changed, 70 insertions(+), 55 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 28259be733..ae9fc1ded3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3188,38 +3188,50 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
>   */
>  FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)

I'm not sure if this visual aid helps but here you go:

 *  31                  20 19    16 15         10 9            0
 * +----------------------+--------+-------------+--------------+
 * |                      |        |       TBFLAG_A64           |
 * |                      |     +--+-------------+--------------+
 * |     TBFLAG_ANY       |     |   TBFLAG_A32   |              |
 * |                      |     +-----+----------+  TBFLAG_AM32 |
 * |                      |           |TBFLAG_M32|              |
 * +----------------------+-----------+----------+--------------+

>=20=20
> -/* Bit usage when in AArch32 state: */
> -FIELD(TBFLAG_A32, THUMB, 0, 1)          /* Not cached. */
> -FIELD(TBFLAG_A32, VECLEN, 1, 3)         /* Not cached. */
> -FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)      /* Not cached. */
> +/*
> + * Bit usage when in AArch32 state, both A- and M-profile.
> + */
> +FIELD(TBFLAG_AM32, CONDEXEC, 0, 8)      /* Not cached. */
> +FIELD(TBFLAG_AM32, THUMB, 8, 1)         /* Not cached. */
> +
> +/*
> + * Bit usage when in AArch32 state, for A-profile only.
> + */
> +FIELD(TBFLAG_A32, VECLEN, 9, 3)         /* Not cached. */
> +FIELD(TBFLAG_A32, VECSTRIDE, 12, 2)     /* Not cached. */
>  /*
>   * We store the bottom two bits of the CPAR as TB flags and handle
>   * checks on the other bits at runtime. This shares the same bits as
>   * VECSTRIDE, which is OK as no XScale CPU has VFP.
>   * Not cached, because VECLEN+VECSTRIDE are not cached.
>   */
> -FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
> +FIELD(TBFLAG_A32, XSCALE_CPAR, 12, 2)
> +FIELD(TBFLAG_A32, VFPEN, 14, 1)         /* Partially cached, minus FPEXC=
. */
> +FIELD(TBFLAG_A32, SCTLR_B, 15, 1)
>  /*
>   * Indicates whether cp register reads and writes by guest code should a=
ccess
>   * the secure or nonsecure bank of banked registers; note that this is n=
ot
>   * the same thing as the current security state of the processor!
>   */
> -FIELD(TBFLAG_A32, NS, 6, 1)
> -FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC=
. */
> -FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
> -FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
> -/* For M profile only, set if FPCCR.LSPACT is set */
> -FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
> -/* For M profile only, set if we must create a new FP context */
> -FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1) /* Not cached. */
> -/* For M profile only, set if FPCCR.S does not match current security st=
ate */
> -FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1) /* Not cached. */
> -/* For M profile only, Handler (ie not Thread) mode */
> -FIELD(TBFLAG_A32, HANDLER, 21, 1)
> -/* For M profile only, whether we should generate stack-limit checks */
> -FIELD(TBFLAG_A32, STACKCHECK, 22, 1)
> +FIELD(TBFLAG_A32, NS, 16, 1)
>=20=20
> -/* Bit usage when in AArch64 state */
> +/*
> + * Bit usage when in AArch32 state, for M-profile only.
> + */
> +/* Handler (ie not Thread) mode */
> +FIELD(TBFLAG_M32, HANDLER, 9, 1)
> +/* Whether we should generate stack-limit checks */
> +FIELD(TBFLAG_M32, STACKCHECK, 10, 1)
> +/* Set if FPCCR.LSPACT is set */
> +FIELD(TBFLAG_M32, LSPACT, 11, 1)                 /* Not cached. */
> +/* Set if we must create a new FP context */
> +FIELD(TBFLAG_M32, NEW_FP_CTXT_NEEDED, 12, 1)     /* Not cached. */
> +/* Set if FPCCR.S does not match current security state */
> +FIELD(TBFLAG_M32, FPCCR_S_WRONG, 13, 1)          /* Not cached. */
> +
> +/*
> + * Bit usage when in AArch64 state
> + */
>  FIELD(TBFLAG_A64, TBII, 0, 2)
>  FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
>  FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5172843667..ec5c7fa325 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11207,11 +11207,8 @@ static uint32_t rebuild_hflags_m32(CPUARMState *=
env, int fp_el,
>  {
>      uint32_t flags =3D 0;
>=20=20
> -    /* v8M always enables the fpu.  */
> -    flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
> -
>      if (arm_v7m_is_handler_mode(env)) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
> +        flags =3D FIELD_DP32(flags, TBFLAG_M32, HANDLER, 1);
>      }
>=20=20
>      /*
> @@ -11222,7 +11219,7 @@ static uint32_t rebuild_hflags_m32(CPUARMState *e=
nv, int fp_el,
>      if (arm_feature(env, ARM_FEATURE_V8) &&
>          !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
>            (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))=
) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
> +        flags =3D FIELD_DP32(flags, TBFLAG_M32, STACKCHECK, 1);
>      }
>=20=20
>      return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
> @@ -11385,7 +11382,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>              if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
>                  FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
>                  !=3D env->v7m.secure) {
> -                flags =3D FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1=
);
> +                flags =3D FIELD_DP32(flags, TBFLAG_M32, FPCCR_S_WRONG, 1=
);
>              }
>=20=20
>              if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MAS=
K) &&
> @@ -11397,12 +11394,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>                   * active FP context; we must create a new FP context be=
fore
>                   * executing any FP insn.
>                   */
> -                flags =3D FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEED=
ED, 1);
> +                flags =3D FIELD_DP32(flags, TBFLAG_M32, NEW_FP_CTXT_NEED=
ED, 1);
>              }
>=20=20
>              bool is_secure =3D env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_M=
ASK;
>              if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
> -                flags =3D FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
> +                flags =3D FIELD_DP32(flags, TBFLAG_M32, LSPACT, 1);
>              }
>          } else {
>              /*
> @@ -11423,8 +11420,8 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>              }
>          }
>=20=20
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
> -        flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
> +        flags =3D FIELD_DP32(flags, TBFLAG_AM32, THUMB, env->thumb);
> +        flags =3D FIELD_DP32(flags, TBFLAG_AM32, CONDEXEC, env->condexec=
_bits);
>          pstate_for_ss =3D env->uncached_cpsr;
>      }
>=20=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 51ea99e6f9..cd757165e1 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10841,37 +10841,46 @@ static void arm_tr_init_disas_context(DisasCont=
extBase *dcbase, CPUState *cs)
>       */
>      dc->secure_routed_to_el3 =3D arm_feature(env, ARM_FEATURE_EL3) &&
>                                 !arm_el_is_aa64(env, 3);
> -    dc->thumb =3D FIELD_EX32(tb_flags, TBFLAG_A32, THUMB);
> -    dc->sctlr_b =3D FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
> -    dc->be_data =3D FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : =
MO_LE;
> -    condexec =3D FIELD_EX32(tb_flags, TBFLAG_A32, CONDEXEC);
> +    dc->thumb =3D FIELD_EX32(tb_flags, TBFLAG_AM32, THUMB);
> +    condexec =3D FIELD_EX32(tb_flags, TBFLAG_AM32, CONDEXEC);
>      dc->condexec_mask =3D (condexec & 0xf) << 1;
>      dc->condexec_cond =3D condexec >> 4;
> +
>      core_mmu_idx =3D FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
>      dc->mmu_idx =3D core_to_arm_mmu_idx(env, core_mmu_idx);
>      dc->current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
>  #if !defined(CONFIG_USER_ONLY)
>      dc->user =3D (dc->current_el =3D=3D 0);
>  #endif
> -    dc->ns =3D FIELD_EX32(tb_flags, TBFLAG_A32, NS);
>      dc->fp_excp_el =3D FIELD_EX32(tb_flags, TBFLAG_ANY, FPEXC_EL);
> -    dc->vfp_enabled =3D FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
> -    dc->vec_len =3D FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
> -    if (arm_feature(env, ARM_FEATURE_XSCALE)) {
> -        dc->c15_cpar =3D FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
> -        dc->vec_stride =3D 0;
> +
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        dc->vfp_enabled =3D 1;
> +        dc->be_data =3D MO_TE;
> +        dc->v7m_handler_mode =3D FIELD_EX32(tb_flags, TBFLAG_M32, HANDLE=
R);
> +        dc->v8m_secure =3D arm_feature(env, ARM_FEATURE_M_SECURITY) &&
> +            regime_is_secure(env, dc->mmu_idx);
> +        dc->v8m_stackcheck =3D FIELD_EX32(tb_flags, TBFLAG_M32, STACKCHE=
CK);
> +        dc->v8m_fpccr_s_wrong =3D
> +            FIELD_EX32(tb_flags, TBFLAG_M32, FPCCR_S_WRONG);
> +        dc->v7m_new_fp_ctxt_needed =3D
> +            FIELD_EX32(tb_flags, TBFLAG_M32, NEW_FP_CTXT_NEEDED);
> +        dc->v7m_lspact =3D FIELD_EX32(tb_flags, TBFLAG_M32, LSPACT);
>      } else {
> -        dc->vec_stride =3D FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
> -        dc->c15_cpar =3D 0;
> +        dc->be_data =3D
> +            FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : MO_LE;
> +        dc->debug_target_el =3D
> +            FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGET_EL);
> +        dc->sctlr_b =3D FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
> +        dc->ns =3D FIELD_EX32(tb_flags, TBFLAG_A32, NS);
> +        dc->vfp_enabled =3D FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
> +        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
> +            dc->c15_cpar =3D FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPA=
R);
> +        } else {
> +            dc->vec_len =3D FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
> +            dc->vec_stride =3D FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRID=
E);
> +        }
>      }
> -    dc->v7m_handler_mode =3D FIELD_EX32(tb_flags, TBFLAG_A32, HANDLER);
> -    dc->v8m_secure =3D arm_feature(env, ARM_FEATURE_M_SECURITY) &&
> -        regime_is_secure(env, dc->mmu_idx);
> -    dc->v8m_stackcheck =3D FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
> -    dc->v8m_fpccr_s_wrong =3D FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_W=
RONG);
> -    dc->v7m_new_fp_ctxt_needed =3D
> -        FIELD_EX32(tb_flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED);
> -    dc->v7m_lspact =3D FIELD_EX32(tb_flags, TBFLAG_A32, LSPACT);
>      dc->cp_regs =3D cpu->cp_regs;
>      dc->features =3D env->features;
>=20=20
> @@ -10893,9 +10902,6 @@ static void arm_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      dc->ss_active =3D FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
>      dc->pstate_ss =3D FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
>      dc->is_ldex =3D false;
> -    if (!arm_feature(env, ARM_FEATURE_M)) {
> -        dc->debug_target_el =3D FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_T=
ARGET_EL);
> -    }
>=20=20
>      dc->page_start =3D dc->base.pc_first & TARGET_PAGE_MASK;
>=20=20
> @@ -11332,10 +11338,10 @@ static const TranslatorOps thumb_translator_ops=
 =3D {
>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_=
insns)
>  {
> -    DisasContext dc;
> +    DisasContext dc =3D { };

We seemed to have dropped an initialise here which seems unrelated.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      const TranslatorOps *ops =3D &arm_translator_ops;
>=20=20
> -    if (FIELD_EX32(tb->flags, TBFLAG_A32, THUMB)) {
> +    if (FIELD_EX32(tb->flags, TBFLAG_AM32, THUMB)) {
>          ops =3D &thumb_translator_ops;
>      }
>  #ifdef TARGET_AARCH64


--=20
Alex Benn=C3=A9e

