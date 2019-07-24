Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B055C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 20:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BD7205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 20:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhFBHWQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BD7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqNVp-0005mY-DD
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 16:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41506)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqNVc-0005LF-BU
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 16:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqNVa-0006WZ-Vu
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 16:05:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqNVa-0006V8-Ox
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 16:05:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id w9so34197602wmd.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NkKlTnhn20dBFaxEPCrvGJI11WXz19rlV8uQGc/+vQg=;
 b=nhFBHWQmwVYotXl44uOu9zj+lfdPVcIkRIJhHpAPRYZLApzh+IajPVcQxBenPO2//r
 hzRKvNUzhdMYhzg/afbM2KsYcz0ETRQp4h1ev/ssAfYxgamVPD33a3Xxo+PV4e2fv71W
 zPBcBJS2Tj4vtCi0EfuUqbtaNH9xCo01RnHiVyZDpZo5xhDSlVigcEVj4BolhEY6KHvo
 AGINbrroK2cC7IWAYkoNTIdYzVjpuMVt7ZaQ0cy2zsYVeo0chBcfTYTy3R5q1T7fpatF
 Vh6rUyruphU0o1Z1kRY2XUlnC/cFER4WrrBeMVVbEPYs2tpzZc1w6f9yxVPFORdsjbci
 9jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NkKlTnhn20dBFaxEPCrvGJI11WXz19rlV8uQGc/+vQg=;
 b=CoZG/3riRbRGYTsN34nUMzDTbxslh8vijesfipwZCiiNpTZuXrrNZLcIy7SjCsGhQK
 ZYL8J1ngdc0cS+Qdx/ZGaGEcY0ZfIpw/gxkQTdtUnga5SBAsTOFp6bQ8FqdCDcglLexw
 9QHvyTg29AbzMj5G+NixkaM2xaAdyU+3beqKvMOcfg8ahOvUttN+ZbgoYzJ7LvsgoSrd
 VvCbgnXAmh7ZI/8LrySTXqSZuLVKAN12zYPiR/hAHurjjl6a4ogC0mArkjymvbxtkK+d
 ouRjrZDxbbAM4Rc16nwG1jgaJcQggO9A13RyumfxYRBNdBNlaD6Yv7CwSzrxZ1M+nfvH
 Pe2Q==
X-Gm-Message-State: APjAAAW/9FLHCe4NrNnx0thzP1TZEpeH+V5qmymbsy1gB7W5Ctl7Yy4U
 OHGS8aiIbXNQRHIMAeTeXziLeg==
X-Google-Smtp-Source: APXvYqynSPhd3l5WPISCZMlu0pJXGxLwGtV3zBowGjVSoSHx/MuWwGVursBQHHClPGcePjpqBG+uHw==
X-Received: by 2002:a1c:1bd7:: with SMTP id b206mr73219019wmb.85.1563998703789; 
 Wed, 24 Jul 2019 13:05:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id i66sm76218082wmi.11.2019.07.24.13.05.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 13:05:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A37701FF87;
 Wed, 24 Jul 2019 21:05:02 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-12-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-12-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2019 21:05:02 +0100
Message-ID: <8736iv19n5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.2 11/24] target/arm: Add the
 hypervisor virtual counter
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu-qom.h |  1 +
>  target/arm/cpu.h     | 11 +++++----
>  target/arm/cpu.c     |  2 ++
>  target/arm/helper.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index 2049fa9612..43fc8296db 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -76,6 +76,7 @@ void arm_gt_ptimer_cb(void *opaque);
>  void arm_gt_vtimer_cb(void *opaque);
>  void arm_gt_htimer_cb(void *opaque);
>  void arm_gt_stimer_cb(void *opaque);
> +void arm_gt_hvtimer_cb(void *opaque);
>
>  #define ARM_AFF0_SHIFT 0
>  #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e37008a4f7..bba4e1f984 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -144,11 +144,12 @@ typedef struct ARMGenericTimer {
>      uint64_t ctl; /* Timer Control register */
>  } ARMGenericTimer;
>
> -#define GTIMER_PHYS 0
> -#define GTIMER_VIRT 1
> -#define GTIMER_HYP  2
> -#define GTIMER_SEC  3
> -#define NUM_GTIMERS 4
> +#define GTIMER_PHYS     0
> +#define GTIMER_VIRT     1
> +#define GTIMER_HYP      2
> +#define GTIMER_SEC      3
> +#define GTIMER_HYPVIRT  4
> +#define NUM_GTIMERS     5
>
>  typedef struct {
>      uint64_t raw_tcr;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1959467fdc..90352decc5 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1218,6 +1218,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>                                            arm_gt_htimer_cb, cpu);
>      cpu->gt_timer[GTIMER_SEC] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_S=
CALE,
>                                            arm_gt_stimer_cb, cpu);
> +    cpu->gt_timer[GTIMER_HYPVIRT] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTIM=
ER_SCALE,
> +                                              arm_gt_hvtimer_cb, cpu);
>  #endif
>
>      cpu_exec_realizefn(cs, &local_err);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3124d682a2..329548e45d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2527,6 +2527,7 @@ static uint64_t gt_tval_read(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>
>      switch (timeridx) {
>      case GTIMER_VIRT:
> +    case GTIMER_HYPVIRT:
>          offset =3D gt_virt_cnt_offset(env);
>          break;
>      }
> @@ -2543,6 +2544,7 @@ static void gt_tval_write(CPUARMState *env, const A=
RMCPRegInfo *ri,
>
>      switch (timeridx) {
>      case GTIMER_VIRT:
> +    case GTIMER_HYPVIRT:
>          offset =3D gt_virt_cnt_offset(env);
>          break;
>      }
> @@ -2698,6 +2700,34 @@ static void gt_sec_ctl_write(CPUARMState *env, con=
st ARMCPRegInfo *ri,
>      gt_ctl_write(env, ri, GTIMER_SEC, value);
>  }
>
> +static void gt_hv_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    gt_timer_reset(env, ri, GTIMER_HYPVIRT);
> +}
> +
> +static void gt_hv_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                             uint64_t value)
> +{
> +    gt_cval_write(env, ri, GTIMER_HYPVIRT, value);
> +}
> +
> +static uint64_t gt_hv_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return gt_tval_read(env, ri, GTIMER_HYPVIRT);
> +}
> +
> +static void gt_hv_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                             uint64_t value)
> +{
> +    gt_tval_write(env, ri, GTIMER_HYPVIRT, value);
> +}
> +
> +static void gt_hv_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                            uint64_t value)
> +{
> +    gt_ctl_write(env, ri, GTIMER_HYPVIRT, value);
> +}
> +
>  void arm_gt_ptimer_cb(void *opaque)
>  {
>      ARMCPU *cpu =3D opaque;
> @@ -2726,6 +2756,13 @@ void arm_gt_stimer_cb(void *opaque)
>      gt_recalc_timer(cpu, GTIMER_SEC);
>  }
>
> +void arm_gt_hvtimer_cb(void *opaque)
> +{
> +    ARMCPU *cpu =3D opaque;
> +
> +    gt_recalc_timer(cpu, GTIMER_HYPVIRT);
> +}
> +
>  static const ARMCPRegInfo generic_timer_cp_reginfo[] =3D {
>      /* Note that CNTFRQ is purely reads-as-written for the benefit
>       * of software; writing it doesn't actually change the timer frequen=
cy.
> @@ -6852,6 +6889,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 =3D 3, .opc1 =3D 4, .crn =3D 2, .crm =3D 0, .opc2 =
=3D 1,
>                .access =3D PL2_RW, .writefn =3D vmsa_tcr_ttbr_el2_write,
>                .fieldoffset =3D offsetof(CPUARMState, cp15.ttbr1_el[2]) },
> +#ifndef CONFIG_USER_ONLY
> +            { .name =3D "CNTHV_CVAL_EL2", .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 3, .opc2 =
=3D 2,
> +              .fieldoffset =3D
> +                offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].cva=
l),
> +              .type =3D ARM_CP_IO, .access =3D PL2_RW,
> +              .writefn =3D gt_hv_cval_write, .raw_writefn =3D raw_write =
},
> +            { .name =3D "CNTHV_TVAL_EL2", .state =3D ARM_CP_STATE_BOTH,
> +              .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 3, .opc2 =
=3D 0,
> +              .type =3D ARM_CP_NO_RAW | ARM_CP_IO, .access =3D PL2_RW,
> +              .resetfn =3D gt_hv_timer_reset,
> +              .readfn =3D gt_hv_tval_read, .writefn =3D gt_hv_tval_write=
 },
> +            { .name =3D "CNTHV_CTL_EL2", .state =3D ARM_CP_STATE_BOTH,
> +              .type =3D ARM_CP_IO,
> +              .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 3, .opc2 =
=3D 1,
> +              .access =3D PL2_RW,
> +              .fieldoffset =3D
> +                offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].ctl=
),
> +              .writefn =3D gt_hv_ctl_write, .raw_writefn =3D raw_write },
> +#endif
>              REGINFO_SENTINEL
>          };
>          define_arm_cp_regs(cpu, vhe_reginfo);


--
Alex Benn=C3=A9e

