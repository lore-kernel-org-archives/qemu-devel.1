Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75326C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424C121835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAFq4fmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424C121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJ1X-0000Qf-3E
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idIzl-00078z-D7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idIzj-0002eB-Rh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:10:29 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idIzj-0002aP-Ji
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:10:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id k14so6742952otn.4
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pnyKgOSe9xttApGxB2XbB9t7TxPD4gRMF4RUK0NKM8o=;
 b=UAFq4fmKZvRRbBF2KQwp1TKUvJaHfgUyW5yLXZlmkLVDWriR0Q5rJjl6Xb0KB++eJJ
 PCwlSO0QLaSymIZxxYEEtkBEd9JUT7BEr4VWg0GHVOwMOLZNvRznNYPfYM3t8zwU6spz
 QP8h2cv5vG9mDvXgbji4sbZ6dl2KmjckXeBkqgLFbT5cLwplmA5arqLPtwKi2RhuJRqv
 Bw4Sr7VE0KjyeKHdY/M4tfeLfx6ZpUIXaabGDFAeLagY2aV3LdO/f4iZeRGnYny4L5Tk
 vstYaV8wXvGTCOTLM13apYgTz/5Zv0mju9qrhlBRskEhgNZY7YXLfeo/J/i+Nj6MY1Sh
 Xkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pnyKgOSe9xttApGxB2XbB9t7TxPD4gRMF4RUK0NKM8o=;
 b=HFMza5s6Y4ga0f6t9RaGVjtmJ9TudhKW72bV/vG0CvabYLfUa0K82ZluGw58uQmnp6
 5X6R2+uuAYP6ohJZsiv9tAbBdUeAUBkI4QHXlvYsfCxHPRw81ubqX3jQOTOLz4cYbMw+
 MXfC/2rSGF+ci5PnQk/AJq/lBtcGJHo5UzjzLGJcXBRItK4LK0lz4gGG+HJCrYSSqVm7
 OGxA2IAkXBuVonUKov1+LJ6mnhTdC3/uQhPuIfhvrDdqD5ZLUPIRKllOKMBNleWApmEt
 4fGdgrRv6XbBQXYcSi7+XGcMwBKzQz/Zi3vMgn7rvFzuIeQb2q4+nqFmhsh6Ma1gsN+K
 ZslQ==
X-Gm-Message-State: APjAAAV7hZppWclRRzlJ3afVWj3UHGuiGgYxVZa40o/7/79sSkAkzXKt
 PcOjVeb2Goi6/SHNsWr54E9o6uEQagDZREfo5rU/9A==
X-Google-Smtp-Source: APXvYqyEPXxUXlF586/q9rt3xrtVLMqKhbOnw3DB9N9YzwjXR1tBiA+1b+e6+pfkjoXI//8Vp4lWHNRAM15lar9LJA4=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr11475707otp.97.1575659426564; 
 Fri, 06 Dec 2019 11:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-7-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 19:10:15 +0000
Message-ID: <CAFEAcA9ncdKmC2nAVtFWU1WAjrki3iM=X9RiO_seBqqTbaiNPw@mail.gmail.com>
Subject: Re: [PATCH 06/11] target/arm: Update MSR access for PAN
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Tue, 3 Dec 2019 at 22:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For aarch64, there's a dedicated msr (imm, reg) insn.
> For aarch32, this is done via msr to cpsr; and writes
> from el0 are ignored.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |  2 ++
>  target/arm/helper.c        | 22 ++++++++++++++++++++++
>  target/arm/translate-a64.c | 14 ++++++++++++++
>  target/arm/translate.c     |  4 ++++
>  4 files changed, 42 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 170dd5b124..f0e61bf34f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1159,6 +1159,7 @@ void pmu_init(ARMCPU *cpu);
>   * We will need to move AArch32 SS somewhere else at that point.
>   */
>  #define CPSR_RESERVED (1U << 21)
> +#define CPSR_PAN (1U << 22)
>  #define CPSR_J (1U << 24)
>  #define CPSR_IT_0_1 (3U << 25)
>  #define CPSR_Q (1U << 27)
> @@ -1225,6 +1226,7 @@ void pmu_init(ARMCPU *cpu);
>  #define PSTATE_BTYPE (3U << 10)
>  #define PSTATE_IL (1U << 20)
>  #define PSTATE_SS (1U << 21)
> +#define PSTATE_PAN (1U << 22)
>  #define PSTATE_V (1U << 28)
>  #define PSTATE_C (1U << 29)
>  #define PSTATE_Z (1U << 30)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4e3fe00316..512be5c644 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4112,6 +4112,17 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      env->daif = value & PSTATE_DAIF;
>  }
>
> +static uint64_t aa64_pan_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return env->pstate & PSTATE_PAN;
> +}
> +
> +static void aa64_pan_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                           uint64_t value)
> +{
> +    env->pstate = (env->pstate & ~PSTATE_PAN) | (value & PSTATE_PAN);
> +}
> +
>  static CPAccessResult aa64_cacheop_access(CPUARMState *env,
>                                            const ARMCPRegInfo *ri,
>                                            bool isread)
> @@ -7405,6 +7416,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_arm_cp_regs(cpu, lor_reginfo);
>      }
>
> +    if (cpu_isar_feature(aa64_pan, cpu)) {
> +        static const ARMCPRegInfo pan_reginfo[] = {
> +            { .name = "PAN", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 3,
> +              .type = ARM_CP_NO_RAW, .access = PL1_RW,
> +              .readfn = aa64_pan_read, .writefn = aa64_pan_write, },
> +            REGINFO_SENTINEL
> +        };

Same remarks about regdef as for UAO.

> +        define_arm_cp_regs(cpu, pan_reginfo);
> +    }
> +
>      if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
>          static const ARMCPRegInfo vhe_reginfo[] = {
>              { .name = "CONTEXTIDR_EL2", .state = ARM_CP_STATE_AA64,
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index b5c7bc2d76..7f5a68106b 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1601,6 +1601,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>          s->base.is_jmp = DISAS_NEXT;
>          break;
>
> +    case 0x04: /* PAN */
> +        if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
> +            goto do_unallocated;
> +        }
> +        if (crm & 1) {
> +            set_pstate_bits(PSTATE_PAN);
> +        } else {
> +            clear_pstate_bits(PSTATE_PAN);
> +        }
> +        t1 = tcg_const_i32(s->current_el);
> +        gen_helper_rebuild_hflags_a64(cpu_env, t1);
> +        tcg_temp_free_i32(t1);
> +        break;

and same question about whether we need to break the TB here.

> +
>      case 0x05: /* SPSel */
>          if (s->current_el == 0) {
>              goto do_unallocated;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 47a374b53d..98e6072dd4 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -2785,6 +2785,10 @@ static int gen_set_psr(DisasContext *s, uint32_t mask, int spsr, TCGv_i32 t0)
>          tcg_gen_or_i32(tmp, tmp, t0);
>          store_cpu_field(tmp, spsr);
>      } else {
> +        /* Data writes to CPSR.PAN using an MSR insn at EL0 are ignored.  */
> +        if (IS_USER(s)) {
> +            mask &= ~CPSR_PAN;
> +        }

I think we should also ignore the write if the PAN feature
isn't present (see remark on earlier patch).

>          gen_set_cpsr(t0, mask);
>      }
>      tcg_temp_free_i32(t0);
> --
> 2.17.1



thanks
-- PMM

