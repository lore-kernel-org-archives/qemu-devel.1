Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD79C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2394620880
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0+sLiTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2394620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPIC-0005NS-10
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaMvQ-00019A-18
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaMum-0002kn-AF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:45:14 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaMtk-0007Rg-QI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:45:12 -0500
Received: by mail-oi1-x243.google.com with SMTP id s71so23742049oih.11
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UrqjRlYshahOVD0HWvkyoW+BrcTjmjDcjr0CPqteerY=;
 b=U0+sLiTXuzfJL+EfdbfQBYtsRgLQjipRkXJdhhWbGCPoz3IEsrZQFTth8RcBzngWaV
 7aZRnbcYsS+zVYBBJ3/C/RsvKCmm7WaWDPm3DMJr2/P/1h8Z+McYEtsvsImh5j5rqD5d
 AkruxRCf1j2EfZkCojw9Vk3rzSQY43B7/U1xuTxB5vMz66iz8KfKX57x+pnq9YExtuA2
 7d9nIEIdrTDycB4fgM5YJlWfBDAcDRCU5Gyc5+1iplyLs8IQbe6nVtk/CHJFN5cLLqZ/
 EQpGOv1WkIkLqm1Ahzf2SuL4YVYJ298fxFrBR6htoGbIFof74Va+g6DPLAhZja9bqMKD
 FJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UrqjRlYshahOVD0HWvkyoW+BrcTjmjDcjr0CPqteerY=;
 b=W3Hq58v6vwJA7609gMva9kPLNiNqvjY035a8DAd9uzN5RoCyffeQS8HAGdyl2O61E8
 BH7MNlSl2CAvYh4RsZzkVuvalRMFXB5ioKnw2yn5gT+RoBZ+4tT+VSSHxiN0PV3RkBo0
 eV+zXl7Z1w4O5SzgXWT/vYjT36BqUekAS+Xe2x1nf7pY6GkReEvGkgwtWfrnBy82YsXv
 +0qbjJPfhktmC75SOVNrJ4Lb0nbd6YOciN3ZcW/dg36v4lmF6RBLW7FyIL50N/qG4tsi
 CF2eTRR7xHYH4ACWOst68+9dRXjA/HBhGt7y+ugwNJF4x2q4eyAsh2ts3pEWmvPv/0H4
 Zlnw==
X-Gm-Message-State: APjAAAUgXhNziXA6D8Bmmt2zkVLSjSMnmV/MbCyn6sPuqLTn9k2MTKDV
 b7JLba+rHFjWUTMLeJfqTtp0vGKMNKN/RfAxG0AXeA==
X-Google-Smtp-Source: APXvYqypesqVZT4oybvArW5JCDJ2y4Ta5ubYLBbf7eQYXLluxYuXe6tXLFf2zJQOmqwRh6WESRLJQUcrFy6VOoT3s4I=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr7347586oif.170.1574959445482; 
 Thu, 28 Nov 2019 08:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20191128161718.24361-1-maz@kernel.org>
 <20191128161718.24361-4-maz@kernel.org>
In-Reply-To: <20191128161718.24361-4-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2019 16:43:53 +0000
Message-ID: <CAFEAcA_MED0Rtqo1=HNnn7v_zQZGDsoJVsbXAsdhb_sAjvJ40Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: Marc Zyngier <maz@kernel.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 at 16:17, Marc Zyngier <maz@kernel.org> wrote:
>
> HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
> EL2, and that HCR_EL2.TID0 does the same for reads of FPSID.
> In order to handle this, introduce a new TCG helper function that
> checks for these control bits before executing the VMRC instruction.
>
> Tested with a hacked-up version of KVM/arm64 that sets the control
> bits for 32bit guests.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper-a64.h        |  2 ++
>  target/arm/internals.h         |  8 ++++++++
>  target/arm/translate-vfp.inc.c | 12 +++++++++---
>  target/arm/vfp_helper.c        | 27 +++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index a915c1247f..311ced44e6 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -102,3 +102,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
>  DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
> +
> +DEF_HELPER_3(check_hcr_el2_trap, void, env, int, int)
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index f5313dd3d4..5a55e960de 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -430,6 +430,14 @@ static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
>          | (cv << 24) | (cond << 20) | (1 << 5);
>  }
>
> +static inline uint32_t syn_vmrs_trap(int rt, int reg)
> +{
> +    return (EC_FPIDTRAP << ARM_EL_EC_SHIFT)
> +        | ARM_EL_IL
> +        | (1 << 24) | (0xe << 20) | (7 << 14)
> +        | (reg << 10) | (rt << 5) | 1;
> +}
> +
>  static inline uint32_t syn_sve_access_trap(void)
>  {
>      return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 85c5ef897b..4c435b6c35 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -759,15 +759,21 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
>      }
>
>      if (a->l) {
> +        TCGv_i32 tcg_rt, tcg_reg;
> +
>          /* VMRS, move VFP special register to gp register */
>          switch (a->reg) {
> +        case ARM_VFP_MVFR0:
> +        case ARM_VFP_MVFR1:
> +        case ARM_VFP_MVFR2:
>          case ARM_VFP_FPSID:
> +            tcg_rt = tcg_const_i32(a->rt);
> +            tcg_reg = tcg_const_i32(a->reg);

Since the syndrome value depends only on these two things,
you might as well generate the full syndrome value at
translate time rather than doing it at runtime; then
you only need to pass one thing through to the helper rather
than two.

> +            gen_helper_check_hcr_el2_trap(cpu_env, tcg_rt, tcg_reg);

This helper call is potentially going to throw an exception
at runtime. QEMU's JIT doesn't write back all the state
of the CPU to the CPU state structure fields for helper
calls, so to avoid losing non-written-back state there are
two possible approaches:

(1) manually write back the state before the call; for
aarch32 this looks like
            gen_set_condexec(s);
            gen_set_pc_im(s, s->pc_curr);
(you can see this done before we call the access_check_cp_reg()
helper, for instance)

(2) in the helper function, instead of raise_exception(),
call raise_exception_ra(..., GETPC())
This says "when we take the exception, also re-sync the
CPU state by looking at the host PC value in the JITted
code (ie the address of the callsite of the helper) and
looking through a table for this translation block that
cross-references the host PC against the guest PC and
condexec values for that point in execution".

Option 1 is better if the expectation is that the trap will
be taken always, often or usually; option 2 is what we
use if the trap is unlikely (it's how we handle
exceptions on guest load/store insns, which are the main
reason we have the mechanism at all).

Since it's unlikely that guest code will be doing ID
register accesses in hot codepaths, I'd go with option 1,
mostly just for consistency with how we do coprocessor
register access-check function calls.

> +            /* fall through */
>          case ARM_VFP_FPEXC:
>          case ARM_VFP_FPINST:
>          case ARM_VFP_FPINST2:
> -        case ARM_VFP_MVFR0:
> -        case ARM_VFP_MVFR1:
> -        case ARM_VFP_MVFR2:
>              tmp = load_cpu_field(vfp.xregs[a->reg]);
>              break;
>          case ARM_VFP_FPSCR:
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 9710ef1c3e..44e538e51c 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -1322,4 +1322,31 @@ float64 HELPER(frint64_d)(float64 f, void *fpst)
>      return frint_d(f, fpst, 64);
>  }
>
> +void HELPER(check_hcr_el2_trap)(CPUARMState *env, int rt, int reg)
> +{
> +    if (arm_current_el(env) != 1) {
> +        return;
> +    }
> +
> +    switch (reg) {
> +    case ARM_VFP_MVFR0:
> +    case ARM_VFP_MVFR1:
> +    case ARM_VFP_MVFR2:
> +        if (!(arm_hcr_el2_eff(env) & HCR_TID3)) {
> +            return;
> +        }
> +        break;
> +    case ARM_VFP_FPSID:
> +        if (!(arm_hcr_el2_eff(env) & HCR_TID0)) {
> +            return;
> +        }
> +        break;
> +    default:
> +        /* Shouldn't be here... */
> +        return;

We usually write 'impossible' default cases as:
           g_assert_not_reached();

> +    }
> +
> +    raise_exception(env, EXCP_HYP_TRAP, syn_vmrs_trap(rt, reg), 2);
> +}
> +
>  #endif

thanks
-- PMM

