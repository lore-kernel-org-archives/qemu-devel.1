Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C85C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB47206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e78gdWVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB47206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6iX-0006na-96
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ic6fy-0005zd-TC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ic6fw-0000U8-AM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:49:06 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ic6fv-0000QU-TZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:49:04 -0500
Received: by mail-oi1-x242.google.com with SMTP id b8so2988170oiy.5
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J9a9Q25g3Pw3d8B2XWQ6fSo3JvscZVrNGGE/LmkOG4U=;
 b=e78gdWVplLjIhNu/AMecMmugJ37cfElNi4nZQ+auDgqzXWKfTKcP1e/vdTAzmge50y
 P2EW9SgCi43AXrcRvIuM+L45DLOzK83HOKlaCSNRmUoGn00+5S8kPjUBzIWC8Jm02mKt
 Wl7ejaJTVqkQvK3JK/ZEaXXCugrO77bUSRyveZxKPzgodz+3ypCD9uY/QD5qyGgQaUu1
 NOmW7u9R4AB/GWPdZvPsz8/pGK4o0ccofLbG1K7CQBq0RZhxKFqhrAVPph5IufrqTyCo
 nIPfvmX3M33lM0G/85H3q2Wdi31Vm1LyXoG94w6qwkP/BHWHJ2RKTnwUbmSSBejchftA
 +SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J9a9Q25g3Pw3d8B2XWQ6fSo3JvscZVrNGGE/LmkOG4U=;
 b=lNMb/qbr3LMjaXW0dzR8O52RY1RH+g8RNfsIQgADZUVm8R81AA5SJtUlCfjcxdIUEN
 hHZER8InycnUQBMV8vlCg2NjiHbgSIa84auLCjzu9+LMOC3Au+CG6LOabkYz9jNcriL5
 wCaGEXo0/RfylKmico7WGCFvFGAahO4hiz1Dwxe5wPH53AI+4Du9ZHW/1dYBGVjC9bTN
 VRAtR6EqiKy39ytIPIkXsxb00vn+232mlSeMxr5Lhm7forXxTpGmzfVxbgH8CyJsmB8Q
 VA4cSaKssDxSwhSgvtQOq2U0CENaPoQ1KGD8/G+dCf2j8ardSi6J1fkutgnPGcp5msXx
 lP9Q==
X-Gm-Message-State: APjAAAVqjpfBVDgEr3fEr8q6EqgJCYBKHR3Z0IRewnMsStpuqlPgCCXK
 liimsYuVVC/214l97M4389abh16T9d4BHZxsge0pZQ==
X-Google-Smtp-Source: APXvYqzjjemuY92HI8Gpo8GGUfhYG7/mB8dIIvujLoGZ28kexWC4M67NLNov85A5LxXWTT/IRsM4VgGNYQseumhrG0k=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3275663oix.170.1575373742707; 
 Tue, 03 Dec 2019 03:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-4-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2019 11:48:51 +0000
Message-ID: <CAFEAcA8_SQ6ugs360PJD58547mmZY1yu5xb=Fq0P006HJ1yGRA@mail.gmail.com>
Subject: Re: [PATCH v5 03/22] target/arm: Add MTE system registers
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is TFSRE0_EL1, TFSR_EL1, TFSR_EL2, TFSR_EL3,
> RGSR_EL1, GCR_EL1, GMID_EL1, and PSTATE.TCO.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Add GMID; add access_mte.
> v4: Define only TCO at mte_insn_reg.
> ---
>  target/arm/cpu.h           |  3 ++
>  target/arm/internals.h     |  6 ++++
>  target/arm/helper.c        | 73 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c | 11 ++++++
>  4 files changed, 93 insertions(+)


> +    { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
> +      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },

This should trap if HCR_EL2.TID5 is 1 (since we're adding
support for the TID* ID reg trap bits now).

> +    REGINFO_SENTINEL
> +};
> +
> +static const ARMCPRegInfo mte_tco_reginfo[] = {
> +    { .name = "TCO", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
> +      .type = ARM_CP_NO_RAW,
> +      .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
> +    REGINFO_SENTINEL
> +};
>  #endif
>
>  static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -6881,6 +6948,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (cpu_isar_feature(aa64_rndr, cpu)) {
>          define_arm_cp_regs(cpu, rndr_reginfo);
>      }

So, aa64_mte_insn_reg here is checking for ID_AA64PFR1_EL1 != 0
("instructions accessible at EL0 are implemented")
and aa64_mte is checking for >= 2 ("full implementation").
I think a couple of brief comments would clarify:

> +    if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
           /* EL0-visible MTE registers, present even for dummy
implementation */
> +        define_arm_cp_regs(cpu, mte_tco_reginfo);
> +    }
> +    if (cpu_isar_feature(aa64_mte, cpu)) {
           /* MTE registers present for a full implementation */
> +        define_arm_cp_regs(cpu, mte_reginfo);
> +    }

(The other way to arrange this would be to have the 'real'
TCO regdef in mte_reginfo, and separately have "reginfo
if we only have the dummy visible-from-EL0-parts-only
which defines a constant 0 TCO" (and also make the MSR_i
code implement a RAZ/WI for this case, for consistency).
An implementation that allows the guest to toggle the PSTATE.TCO
bit to no visible effect is architecturally valid, though.)

>  #endif
>
>      /*
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index c85db69db4..62bdf50796 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1611,6 +1611,17 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>          s->base.is_jmp = DISAS_UPDATE;
>          break;
>
> +    case 0x1c: /* TCO */
> +        if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
> +            goto do_unallocated;
> +        }
> +        if (crm & 1) {
> +            set_pstate_bits(PSTATE_TCO);
> +        } else {
> +            clear_pstate_bits(PSTATE_TCO);
> +        }
> +        break;
> +
>      default:
>      do_unallocated:
>          unallocated_encoding(s);
> --
> 2.17.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


thanks
-- PMM

