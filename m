Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C7C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E41A217F9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwIbZCDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E41A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5OY-0007aq-EK
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5NF-0006wX-9N
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5NE-0006Wa-5l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:47:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5ND-0006WO-VG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:47:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id p7so18311293wmp.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2Pk2PaoCA2FAOy0UkNnpDqQxfLHeo0dEKF6M1GkPot0=;
 b=IwIbZCDCKOL0JWsP872lSMDeDJUIr5TbsBnwgHNKNQQem8F3ibNAquxdOSWiacp8gE
 /l5LraWjltokqYnPVTd4bs8/KwOivW7N1FTTN4noY5Ncaiw3peWcQVMjGgAYg6Hi8XBU
 w8UBqVDhyu20lB/qcWPcVpzS9JLi//NhL31afarzdDHelIlCgw6udNhED6hZK/RglKw8
 9iqcLiTndwwiKlON6ifoGczZyIWc8zy+zlD8Hy8x0s4n9RhOXwUATBHof+IQIfcuHj//
 6HJDP4eORK1IXqfHfNzHlcNdJNJgus1REfvo3J9ni2Q964S9+TJUPdRMp6p6PBFZRyMQ
 XCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2Pk2PaoCA2FAOy0UkNnpDqQxfLHeo0dEKF6M1GkPot0=;
 b=FGMPDDuL7RBsY8DwzLms3xrjcZtnBcYDUolWKLYMAO6U6ycEqT8yScuCA44YC9aeAy
 5itpbjCTLCXTqEqWJHS3Y0tPWJtiULiIz5ccSOvoMIYqkP9qakEiMx6luQFroURKtdtW
 3mZmxxYRQFE0PxiA7YZhDV+3YYlxuG6DDts3eRSzqs2JLhWU2JtW6bhj+3l3naqKSYFv
 9SOkT4KNmiiOPgWs+qf2LbviEgIqDIjywAaafOuQ5RsnnpWQDP0Pt0lRisxuCaOAoNyC
 HFcsE4Vu7i7Y1GsGXcEAnNEoHdfzPxNGSAe4he14Vp+UiEy/qvahe5NGL9Daeoa31Xcu
 KeIw==
X-Gm-Message-State: APjAAAUVNqb8A88lqhza06zciula04RUoAFJNxjUFQl+YFOkt3IacRQo
 WZKr/QE4b+oWCojHKvWU6AspVg==
X-Google-Smtp-Source: APXvYqwYR3tQdQxAsewGTsrtCxprPV4pRHro/wFNkTxlyCk7S8oWGmVVUafm2KBvtNBd0/B4C92AHQ==
X-Received: by 2002:a1c:a546:: with SMTP id o67mr16300078wme.57.1571078834631; 
 Mon, 14 Oct 2019 11:47:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t203sm22713511wmf.42.2019.10.14.11.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 11:47:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C5B41FF87;
 Mon, 14 Oct 2019 19:47:13 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-13-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 12/20] target/arm: Add arm_rebuild_hflags
In-reply-to: <20191011155546.14342-13-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 19:47:13 +0100
Message-ID: <87eezfmafi.fsf@linaro.org>
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This function assumes nothing about the current state of the cpu,
> and writes the computed value to env->hflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h    |  6 ++++++
>  target/arm/helper.c | 30 ++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9909ff89d4..d844ea21d8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3297,6 +3297,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, =
ARMELChangeHookFn *hook,
>  void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, v=
oid
>          *opaque);
>
> +/**
> + * arm_rebuild_hflags:
> + * Rebuild the cached TBFLAGS for arbitrary changed processor state.
> + */
> +void arm_rebuild_hflags(CPUARMState *env);
> +
>  /**
>   * aa32_vfp_dreg:
>   * Return a pointer to the Dn register within env in 32-bit mode.
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 89aa6fd933..85de96d071 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11198,17 +11198,35 @@ static uint32_t rebuild_hflags_a64(CPUARMState =
*env, int el, int fp_el,
>      return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
>  }
>
> +static uint32_t rebuild_hflags_internal(CPUARMState *env)
> +{
> +    int el =3D arm_current_el(env);
> +    int fp_el =3D fp_exception_el(env, el);
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
> +
> +    if (is_a64(env)) {
> +        return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
> +    } else if (arm_feature(env, ARM_FEATURE_M)) {
> +        return rebuild_hflags_m32(env, fp_el, mmu_idx);
> +    } else {
> +        return rebuild_hflags_a32(env, fp_el, mmu_idx);
> +    }
> +}
> +
> +void arm_rebuild_hflags(CPUARMState *env)
> +{
> +    env->hflags =3D rebuild_hflags_internal(env);
> +}
> +
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> -    ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
> -    int current_el =3D arm_current_el(env);
> -    int fp_el =3D fp_exception_el(env, current_el);
>      uint32_t flags, pstate_for_ss;
>
> +    flags =3D rebuild_hflags_internal(env);
> +
>      if (is_a64(env)) {
>          *pc =3D env->pc;
> -        flags =3D rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
>          if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>          }
> @@ -11217,8 +11235,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>          *pc =3D env->regs[15];
>
>          if (arm_feature(env, ARM_FEATURE_M)) {
> -            flags =3D rebuild_hflags_m32(env, fp_el, mmu_idx);
> -
>              if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
>                  FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
>                  !=3D env->v7m.secure) {
> @@ -11242,8 +11258,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>                  flags =3D FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
>              }
>          } else {
> -            flags =3D rebuild_hflags_a32(env, fp_el, mmu_idx);
> -
>              /*
>               * Note that XSCALE_CPAR shares bits with VECSTRIDE.
>               * Note that VECLEN+VECSTRIDE are RES0 for M-profile.


--
Alex Benn=C3=A9e

