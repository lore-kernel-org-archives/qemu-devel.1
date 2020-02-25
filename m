Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7CAC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389DF20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/dzTKR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389DF20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YeD-0004Rv-DU
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YdY-0003qw-Po
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YdX-0006tA-8c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:44:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6YdX-0006rz-2M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:44:27 -0500
Received: by mail-oi1-x244.google.com with SMTP id q84so12258138oic.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cGUcQGexJ/5mmgi4mqxcVj6PXdsu59Z1YDhGoJZiEcQ=;
 b=F/dzTKR9j8oF7VQe6WDSEwfLkfHNAZekVRweoWqeytv3An9cIPTVKREROGM0GnuCZR
 +tK3YE4ldMaF5rTCLqr52TKSeKDqKnToUOALJnLvwuGh3/CKJoPpBmUJMP6HWxBCmcD5
 +zamd20ZFoc9sv5rtX/jOMsl0RXwyhCnpZ+UKXaz1JEZmC8oSd5KDkPMaqMJv7Bdy5qR
 rSBy7iBR92DoAKhvV6O93ZHL54zHZvCWETbpf2qcPj1Iu6eneiFvPTGRUWOjkt4knoXh
 RXacTtY34FIjlM+WioSQLSW/aBjeGe+LxbiK2BFw3LIbUZCvd5eJsjZCYld0BY+8bxP4
 8tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cGUcQGexJ/5mmgi4mqxcVj6PXdsu59Z1YDhGoJZiEcQ=;
 b=FjkMwjVJXxuHLu/G06iDz0Nb+4A24i/WRBEsob4uEK02j7Qx4yHkJYq+UELvGbRizV
 JjgqOBItE11TWTig18uegMc1zj7RVt3pwULbr2oRlJnMZi2z4wYSfN5mn1TA8jwZFxdN
 oe3Yfveo2t7CFOI4T781dkAKDQ8alD6K4sK7m3LM5hkiBXi5CEnDWL8vfki9pbO/davr
 EJgeta/BSMwI98Sln7eUQ4sYQuLMcmG7+vuN9ebBmGcoG8X4W0jK2I0Aq4QmO0XseBR3
 9xthpFdRT49Y4IOqiYvsanToc/X6WAhG0ZKwFd+IhSffxLjfS4v0mZeXMuest/T84KGZ
 PCnQ==
X-Gm-Message-State: APjAAAUINVid1Abr6AE/zDlFbHko2OM5PA1N9fNnUXIYLgELThEbJhIB
 S3x63BOaNG/jAsT3glyw8d3B4GGfVHII2/e1cyVXjw==
X-Google-Smtp-Source: APXvYqxqMdK8bfzciH5RnlvLuCAZxVKGoaIlwA7DZOFJaNaSs4ehz4Ii8cq4KWWZ81gBwtEQfwFRakBUhq74tRZHmTU=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3316039oiy.170.1582631065954; 
 Tue, 25 Feb 2020 03:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20200218190958.745-1-richard.henderson@linaro.org>
 <20200218190958.745-3-richard.henderson@linaro.org>
In-Reply-To: <20200218190958.745-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 11:44:14 +0000
Message-ID: <CAFEAcA-crDkFHf4kW9DYAoRn_g165+j8dy-=+jDZMvj16epKig@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] target/arm: Honor the HCR_EL2.{TVM,TRVM} bits
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Tue, 18 Feb 2020 at 19:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These bits trap EL1 access to various virtual memory controls.
>
> Buglink: https://bugs.launchpad.net/bugs/1855072
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Include TTBCR.
> ---
>  target/arm/helper.c | 77 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 52 insertions(+), 25 deletions(-)

> +/* Check for traps from EL1 due to HCR_EL2.TVM and HCR_EL2.TRVM.  */
> +static CPAccessResult access_tvm_trvm(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                      bool isread)
> +{
> +    if (arm_current_el(env) == 1) {
> +        uint64_t trap = isread ? HCR_TRVM : HCR_TVM;
> +        if (arm_hcr_el2_eff(env) & trap) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +    }
> +    return CP_ACCESS_OK;
> +}

v7 doesn't have HCR_TRVM -- we should stop the guest being
able to write to that bit if we don't want to do a version
check on the CPU here to see whether to honour it.

> +
>  static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  {
>      ARMCPU *cpu = env_archcpu(env);
> @@ -785,7 +798,8 @@ static const ARMCPRegInfo cp_reginfo[] = {
>       */
>      { .name = "CONTEXTIDR_EL1", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 1,
> -      .access = PL1_RW, .secure = ARM_CP_SECSTATE_NS,
> +      .access = PL1_RW, .accessfn = access_tvm_trvm,
> +      .secure = ARM_CP_SECSTATE_NS,
>        .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[1]),
>        .resetvalue = 0, .writefn = contextidr_write, .raw_writefn = raw_write, },
>      { .name = "CONTEXTIDR_S", .state = ARM_CP_STATE_AA32,

We could I guess add the accessfn to CONTEXTIDR_S, which will
do nothing now but would save us forgetting it if we ever
implement emulation of secure EL2... (For the other regs
touched by this patch this happens automatically because they
don't specify a secure-state and so one regdef does both.)

> @@ -877,9 +891,11 @@ static const ARMCPRegInfo not_v7_cp_reginfo[] = {
>        .opc1 = CP_ANY, .opc2 = 3, .access = PL1_W, .writefn = tlbimvaa_write,
>        .type = ARM_CP_NO_RAW },
>      { .name = "PRRR", .cp = 15, .crn = 10, .crm = 2,
> -      .opc1 = 0, .opc2 = 0, .access = PL1_RW, .type = ARM_CP_NOP },
> +      .opc1 = 0, .opc2 = 0, .access = PL1_RW, .accessfn = access_tvm_trvm,
> +      .type = ARM_CP_NOP },
>      { .name = "NMRR", .cp = 15, .crn = 10, .crm = 2,
> -      .opc1 = 0, .opc2 = 1, .access = PL1_RW, .type = ARM_CP_NOP },
> +      .opc1 = 0, .opc2 = 1, .access = PL1_RW, .accessfn = access_tvm_trvm,
> +      .type = ARM_CP_NOP },

Why are we adding an accessfn that checks bits in a v7-and-later
register to regdefs in the "not_v7_cp_reginfo" array? These only
get used for v6 and earlier CPUs...

> @@ -4158,12 +4185,12 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
>      /* NOP AMAIR0/1 */
>      { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
> -      .access = PL1_RW, .type = ARM_CP_CONST,
> -      .resetvalue = 0 },
> +      .access = PL1_RW, .accessfn = access_tvm_trvm,
> +      .type = ARM_CP_CONST, .resetvalue = 0 },
>      /* AMAIR1 is mapped to AMAIR_EL1[63:32] */
>      { .name = "AMAIR1", .cp = 15, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 1,
> -      .access = PL1_RW, .type = ARM_CP_CONST,
> -      .resetvalue = 0 },
> +      .access = PL1_RW, .accessfn = access_tvm_trvm,
> +      .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "PAR", .cp = 15, .crm = 7, .opc1 = 0,
>        .access = PL1_RW, .type = ARM_CP_64BIT, .resetvalue = 0,
>        .bank_fieldoffsets = { offsetof(CPUARMState, cp15.par_s),

I think you have missed adding the accessfn to the 64-bit
TTBR0 and TTBR1 regdefs in lpae_cp_reginfo[].

> @@ -4889,7 +4916,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>        .type = ARM_CP_NOP, .access = PL1_W },
>      /* MMU Domain access control / MPU write buffer control */
>      { .name = "DACR", .cp = 15, .opc1 = 0, .crn = 3, .crm = 0, .opc2 = 0,
> -      .access = PL1_RW, .resetvalue = 0,
> +      .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
>        .writefn = dacr_write, .raw_writefn = raw_write,
>        .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.dacr_s),
>                               offsetoflow32(CPUARMState, cp15.dacr_ns) } },

There is also a DACR definition in not_v8_cp_reginfo[] which
I think needs the accessfn as well.

> @@ -7716,7 +7743,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          ARMCPRegInfo sctlr = {
>              .name = "SCTLR", .state = ARM_CP_STATE_BOTH,
>              .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
> -            .access = PL1_RW,
> +            .access = PL1_RW, .accessfn = access_tvm_trvm,
>              .bank_fieldoffsets = { offsetof(CPUARMState, cp15.sctlr_s),
>                                     offsetof(CPUARMState, cp15.sctlr_ns) },
>              .writefn = sctlr_write, .resetvalue = cpu->reset_sctlr,

thanks
-- PMM

