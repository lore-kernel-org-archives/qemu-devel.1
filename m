Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE976C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47B2206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnHdwJIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47B2206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieJJN-0008E0-Sb
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ieJIT-0007PU-Hs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieJIS-0004OP-1f
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:41:57 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieJIR-0004NF-RO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:41:55 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so12153462otc.8
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 05:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bfyOkziDrccksXQrf3rYNVLW8fBFSvlA3an+U6AJQlA=;
 b=rnHdwJIRWajeCr71Z4KdMJIzZCstuIHP66Jc2mwCIYi6+C3QFgJSZywPvj8USR9vCs
 9u8DI2gJepSB/yXl88p04HZ7JhL2VZ7zQj4n0eicJTTKgWJjO7B3T+xsw1ztz2bw3u81
 NF0H3AHQG/CUyzl/tU17qZ7Ek9nKfJ1Szvw5x+JI7kgY52KzD4k2/aV/EcvjaYWgK1Pr
 +YEEPea0j6nk3ZsMIL8rYHq+gjctHFHYSbwQOAY0RqL6MtaMBZQ3sZ94rPZhxNyivbO3
 ixYoS0652lhDKd/8B2tupJMNh5xo4A0A1c0pLynMHce5ova19U4qTEaMiWzud8Fg4kZp
 KQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bfyOkziDrccksXQrf3rYNVLW8fBFSvlA3an+U6AJQlA=;
 b=ZLvNAG+Rmzf4U+jbduq18IJZUvixvhnN0Se2GtqfKpFD5bXGLV/t2h2CIYeipI2WJp
 jG0cT95Fpx3++uXuuxMXJ7uCYptAuaiR7Dk/bub6bNMsHFF+lIINlXgso6HS4mb78EXt
 OLUxQqoHxrAifn/yoXl9GpzNaEkZdT1bz+6XWHPcspSt7tMu8oNDeqZ5Trw7USFiUYyA
 b5gxTvhQOzCPwGD1JwAG4q9lViguwMx9mUD0GzD2NH8hU8rcI0rSCUfckFK6oz+C+RLi
 I0Y8Ya4KkKVlBuS7VayGhyJwjQ8esbdjsDutH9u7NEtelmDrzsEnr1/VpHqvVDRg0LKh
 Ye4w==
X-Gm-Message-State: APjAAAWGDxpi1OMHLB2NnT1lxoWW5slxc4IfMePcIzShI4lIfJ3GDmO5
 uot0I47z7Lo7MniOt1v8B8lm05om3DmAgMj7aGVvjg==
X-Google-Smtp-Source: APXvYqzqprLvNu/LqN6nSmy5MuFfB3Ws6JGgRF0W8YZz3AixXHMi9HE6kdmEaHoGxadXO4U2GBCtEhH5+0cDVBezxhY=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr21831050otq.135.1575898914946; 
 Mon, 09 Dec 2019 05:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-11-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2019 13:41:44 +0000
Message-ID: <CAFEAcA9s279rfuG3_b=7GpMwHKKF7U4vQ8sxh4wartet4pUWTQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] target/arm: Implement ATS1E1 system registers
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
> This is a minor enhancement over ARMv8.1-PAN.
> The *_PAN mmu_idx are used with the existing do_ats_write.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 50 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 043e44d73d..f1eab4fb28 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3360,16 +3360,20 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>
>      switch (ri->opc2 & 6) {
>      case 0:
> -        /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
> +        /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
>          switch (el) {
>          case 3:
>              mmu_idx = ARMMMUIdx_SE3;
>              break;
>          case 2:
> -            mmu_idx = ARMMMUIdx_Stage1_E1;
> -            break;
> +            g_assert(!secure);  /* TODO: ARMv8.4-SecEL2 */
> +            /* fall through */
>          case 1:
> -            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
> +            if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
> +                mmu_idx = secure ? ARMMMUIdx_SE1_PAN : ARMMMUIdx_Stage1_E1_PAN;
> +            } else {
> +                mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
> +            }

This way of writing it is fine, but just to check my understanding:
if the CPSR_PAN bit isn't set, then will a lookup via Idx_SE1_PAN
and a lookup via Idx_SE1 return the same results? (which would mean
you could drop the check on the PAN bit without changing behaviour).
Or do we guarantee that we only use the _PAN versions of the indexes
if the PAN bit is actually active?

> @@ -7426,6 +7434,36 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          };
>          define_arm_cp_regs(cpu, pan_reginfo);
>      }
> +#ifndef CONFIG_USER_ONLY
> +    if (cpu_isar_feature(aa64_ats1e1, cpu)) {
> +        static const ARMCPRegInfo ats1e1_reginfo[] = {
> +            { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
> +              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
> +              .writefn = ats_write64 },
> +            { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
> +              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
> +              .writefn = ats_write64 },
> +            REGINFO_SENTINEL
> +        };
> +        define_arm_cp_regs(cpu, ats1e1_reginfo);
> +    }
> +    if (cpu_isar_feature(aa32_ats1e1, cpu)) {
> +        static const ARMCPRegInfo ats1cp_reginfo[] = {
> +            { .name = "ATS1CPRP",
> +              .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
> +              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
> +              .writefn = ats_write },
> +            { .name = "ATS1CPWP",
> +              .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
> +              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
> +              .writefn = ats_write },
> +            REGINFO_SENTINEL
> +        };

I think having these at file scope rather than local is more
in line with the other regdefs.

> +        define_arm_cp_regs(cpu, ats1cp_reginfo);
> +    }
> +#endif

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

