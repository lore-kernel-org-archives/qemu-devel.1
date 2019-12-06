Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF96C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BC42053B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTIDXKVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BC42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIzX-0006Sj-Vc
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idINP-0006SI-Hk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idINO-0002S8-3Y
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:30:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idINN-0002Pn-Sc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:30:50 -0500
Received: by mail-oi1-x243.google.com with SMTP id v140so669466oie.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5z/6XKC2ep64MfVJ30LGpD9q+AIs6sDy4td/Qd+8kbk=;
 b=yTIDXKVmIliNX0JM4RsjhYWiVmn1KTEpjw5KD9PbkoSVMxb9oXajNFzyvXsCmWQOYF
 dYyhs8egVMofVbF/5/9iJMwi/A4rwU8X0PzlWORStpaTRMWREn2YxmPUaHD2O4MIy6uT
 f5S+4IlbqkWixKbj3fYEsCvjsOLEj2L4DAVo7llBYtgrotqdWQ4t4zo0ESwG5YmqPqNz
 NbfLYoHfMdzXbxT+IcKTqW5p/kwOLPbLcobMfI+W9TNd2WtE2ZMf6/yvEIPXDvh7Qqk7
 NKyvh7YaVPXlqh4dCcujUrJ/Im4Ydsv0knkLlC9zYe4+I7nhied7VcjICXFSOu1avJgd
 uVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5z/6XKC2ep64MfVJ30LGpD9q+AIs6sDy4td/Qd+8kbk=;
 b=TYSJmLt+3vHrmG8daMwQbKZaMI3XUn67ln1WfOKZ4aWybn1k7EyFIuuSw2VbVHnuQm
 p0onOY6xHO3VKL8CDIvVmWyLN2bBoMhC04MCuopzITAyuOnRc8rIrynkgS9UGIcj76+G
 JyF9B9jQ4++PRyn+LwL/n8c6s3LKB6v/ka4BAeIsNc6Yx0PVVeDAmwQJtnVnq40PvSfK
 RcOwJu2/7a64mRP4EdgY4MaXkWA1MDblCVk4T1I1uGmgF461tcSshYPH+axxwNHQuX9A
 6Np/byDHpWAMWX90XzcvN7gO+uXeyXv0GK8AsjRLuKXdtPriPtHYxRB5K7QBGMzhPSTq
 h9Ng==
X-Gm-Message-State: APjAAAUDkTxj2wfY93I4qFWNtu4VxVbZFP9JFE/6+cHtFwiTptah9zzf
 OTBa/ktWAQ3A21Yjr/eveRsm6Lep5xSWSghiWvdKIA==
X-Google-Smtp-Source: APXvYqzmezMfKbw7yMDOjdxzmK0N/3n6k+6/OhECxz7QYxn6hdgwU8w4aqOh8arO+pC8jtzD1TQrm5y1KHvnFb2/MEo=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr13006347oic.146.1575657048818; 
 Fri, 06 Dec 2019 10:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-3-richard.henderson@linaro.org>
In-Reply-To: <20191203234244.9124-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 18:30:37 +0000
Message-ID: <CAFEAcA914CO2vfMAkr4aeEA_FV0Vub6S9eF43qN=14e7nU1uHg@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Update MSR access to UAO
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 23:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |  6 ++++++
>  target/arm/helper.c        | 21 +++++++++++++++++++++
>  target/arm/translate-a64.c | 14 ++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index cdf6caf869..dd284ba5c7 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1228,6 +1228,7 @@ void pmu_init(ARMCPU *cpu);
>  #define PSTATE_IL (1U << 20)
>  #define PSTATE_SS (1U << 21)
>  #define PSTATE_PAN (1U << 22)
> +#define PSTATE_UAO (1U << 23)
>  #define PSTATE_V (1U << 28)
>  #define PSTATE_C (1U << 29)
>  #define PSTATE_Z (1U << 30)
> @@ -3598,6 +3599,11 @@ static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
>  }
>
> +static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 70f2db5447..8941a6c10f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4131,6 +4131,17 @@ static void aa64_pan_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      env->pstate = (env->pstate & ~PSTATE_PAN) | (value & PSTATE_PAN);
>  }
>
> +static uint64_t aa64_uao_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return env->pstate & PSTATE_UAO;
> +}
> +
> +static void aa64_uao_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                           uint64_t value)
> +{
> +    env->pstate = (env->pstate & ~PSTATE_UAO) | (value & PSTATE_UAO);
> +}
> +
>  static CPAccessResult aa64_cacheop_access(CPUARMState *env,
>                                            const ARMCPRegInfo *ri,
>                                            bool isread)
> @@ -7464,6 +7475,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_arm_cp_regs(cpu, ats1cp_reginfo);
>      }
>  #endif
> +    if (cpu_isar_feature(aa64_uao, cpu)) {
> +        static const ARMCPRegInfo uao_reginfo[] = {
> +            { .name = "UAO", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 4,
> +              .type = ARM_CP_NO_RAW, .access = PL1_RW,
> +              .readfn = aa64_uao_read, .writefn = aa64_uao_write, },
> +            REGINFO_SENTINEL
> +        };

This could just be a file-scope global, right?
Also, you can just use define_one_arm_cp_reg() rather
than having a list with one entry. (cf zcr_el1_reginfo).

> +        define_arm_cp_regs(cpu, uao_reginfo);
> +    }
>
>      if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
>          static const ARMCPRegInfo vhe_reginfo[] = {
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 7f5a68106b..2b6846ef01 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1601,6 +1601,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>          s->base.is_jmp = DISAS_NEXT;
>          break;
>
> +    case 0x03: /* UAO */
> +        if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
> +            goto do_unallocated;
> +        }
> +        if (crm & 1) {
> +            set_pstate_bits(PSTATE_UAO);
> +        } else {
> +            clear_pstate_bits(PSTATE_UAO);
> +        }
> +        t1 = tcg_const_i32(s->current_el);
> +        gen_helper_rebuild_hflags_a64(cpu_env, t1);
> +        tcg_temp_free_i32(t1);
> +        break;

Do we also need to end the TB since we've messed with
the hflags, or is some bit of code not in the patch
context handling that?

> +
>      case 0x04: /* PAN */
>          if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
>              goto do_unallocated;
> --
> 2.17.1

Does the "on exception entry PSTATE.UAO is zeroed" behaviour
fall out automatically for us? How about "on exception entry
from aarch32 to aarch64 SPSR_ELx.UAO is set to zero" ?

I think we may also want a minor code change so that an exception
return from aarch64 to aarch32 doesn't copy a bogus SPSR UAO==1
into the pstate/cpsr.

thanks
-- PMM

