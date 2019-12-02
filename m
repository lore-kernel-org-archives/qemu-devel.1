Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D995BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B94206E1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UogDa1+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B94206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibm8t-0003VD-NG
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1ibm7k-0002Om-GQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1ibm7i-0005yJ-IP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:52:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ibm7g-0005rm-IZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:52:21 -0500
Received: by mail-wm1-x342.google.com with SMTP id u18so21943479wmc.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qzHvAtOXFnh2I6y4Y2DJQ+VkcEOnIcY6xOliHLRVbZY=;
 b=UogDa1+h7X/0DMuKD80ws3nrnJL3oXx/AaN7t0RjGZE+xiFrjAJAsNJF2OZ+Hn9XBZ
 h4/yh3E94hgxfXRjIfQLbpslcUItSRaXRog0oh6euU6XNrslieX+gO3D8qaYtUTgVTzh
 /ffod673V/CmANm0lTLXYcXyzZlRN1OHLwVryRgPW20wfTk25V9rFxBHYBCsz3DNtUJd
 3gaRb8wklixUJhZ11RfyqJeE4pRN7OeWOGn3R+rDJ8xENfp5f5757yi+bFNZzfDC2qyh
 9yVU5Mvg8rvHsHVk5V1hsdXseGseMeaxSFE2MUMEHAheJgoAQcbwdlJmUfgZEwfj9rLU
 Purw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qzHvAtOXFnh2I6y4Y2DJQ+VkcEOnIcY6xOliHLRVbZY=;
 b=mfXOxoRZGIFW82IW8NVr0oSkuuELVKQjL+aLfChhLJTo+XFHAvskTB3MyZbArnryVc
 tD/iQ26n9f0OxIdPQqMZyCv4b8o4a6Qkizdjw9lkdyCc6AlP+qnptJNkap6QnuBb78a2
 IEc6tcUyUx/4vxIxfnkltBt+j7S3Kcod2b5wapox3RSfLvkzbg0hgV74/J0KYkRfGmjz
 T+94ncax+ngI1aNI/VGvn0NppjFe7K3Vi3QV97Ivyj0j7pcuAcgH31fDbzZ/qGALeQmX
 yThJJ3Crx6RARCYSHletI5DT7I8nQwCUchvK4Pdf2hhTyPIE0jtAmf+Edh0kHfAZtRy4
 5z3w==
X-Gm-Message-State: APjAAAUJmUJSTA5ox9ze+nNiGXyU6krEO6mSOpdUQojtdbIq7lA9VaXJ
 K2YhZp0/7dPXUZQmwsXisIA=
X-Google-Smtp-Source: APXvYqzeGaJ4vwUvNMeKihisCiDAJV7PUvPo504vjJ0TmCpcZtJspTFspkE/M1n3jqp1gsUSSKj6xQ==
X-Received: by 2002:a1c:b4c6:: with SMTP id d189mr3949217wmf.176.1575294737140; 
 Mon, 02 Dec 2019 05:52:17 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id z6sm27860074wrw.36.2019.12.02.05.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 05:52:16 -0800 (PST)
Date: Mon, 2 Dec 2019 14:52:18 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/5] target/arm: Honor HCR_EL2.TID2 trapping
 requirements
Message-ID: <20191202135218.GE25295@toto>
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201122018.25808-2-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Dec 01, 2019 at 12:20:14PM +0000, Marc Zyngier wrote:
> HCR_EL2.TID2 mandates that access from EL1 to CTR_EL0, CCSIDR_EL1,
> CCSIDR2_EL1, CLIDR_EL1, CSSELR_EL1 are trapped to EL2, and QEMU
> completely ignores it, making it impossible for hypervisors to
> virtualize the cache hierarchy.
> 
> Do the right thing by trapping to EL2 if HCR_EL2.TID2 is set.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0bf8f53d4b..1e546096b8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1910,6 +1910,17 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>      raw_write(env, ri, value);
>  }
>  
> +static CPAccessResult access_aa64_tid2(CPUARMState *env,
> +                                       const ARMCPRegInfo *ri,
> +                                       bool isread)
> +{
> +    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID2)) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +
> +    return CP_ACCESS_OK;
> +}
> +
>  static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      ARMCPU *cpu = env_archcpu(env);
> @@ -2110,10 +2121,14 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .writefn = pmintenclr_write },
>      { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
> -      .access = PL1_R, .readfn = ccsidr_read, .type = ARM_CP_NO_RAW },
> +      .access = PL1_R,
> +      .accessfn = access_aa64_tid2,
> +      .readfn = ccsidr_read, .type = ARM_CP_NO_RAW },
>      { .name = "CSSELR", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 2, .opc2 = 0,
> -      .access = PL1_RW, .writefn = csselr_write, .resetvalue = 0,
> +      .access = PL1_RW,
> +      .accessfn = access_aa64_tid2,
> +      .writefn = csselr_write, .resetvalue = 0,
>        .bank_fieldoffsets = { offsetof(CPUARMState, cp15.csselr_s),
>                               offsetof(CPUARMState, cp15.csselr_ns) } },
>      /* Auxiliary ID register: this actually has an IMPDEF value but for now
> @@ -5204,6 +5219,11 @@ static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
>      if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
>          return CP_ACCESS_TRAP;
>      }
> +
> +    if (arm_current_el(env) < 2 && arm_hcr_el2_eff(env) & HCR_TID2) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +
>      return CP_ACCESS_OK;
>  }
>  
> @@ -6184,7 +6204,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          ARMCPRegInfo clidr = {
>              .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
>              .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 1,
> -            .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->clidr
> +            .access = PL1_R, .type = ARM_CP_CONST,
> +            .accessfn = access_aa64_tid2,
> +            .resetvalue = cpu->clidr
>          };
>          define_one_arm_cp_reg(cpu, &clidr);
>          define_arm_cp_regs(cpu, v7_cp_reginfo);
> @@ -6717,7 +6739,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              /* These are common to v8 and pre-v8 */
>              { .name = "CTR",
>                .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 1,
> -              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->ctr },
> +              .access = PL1_R, .accessfn = ctr_el0_access,
> +              .type = ARM_CP_CONST, .resetvalue = cpu->ctr },
>              { .name = "CTR_EL0", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 3, .opc2 = 1, .crn = 0, .crm = 0,
>                .access = PL0_R, .accessfn = ctr_el0_access,
> -- 
> 2.20.1
> 
> 

