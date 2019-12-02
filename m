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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43104C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEA820715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vadQ1699"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEA820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmN9-0005cP-77
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1ibmLt-0004qW-Om
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1ibmLr-0007fi-PT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:07:01 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ibmLr-0007fY-Id
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:06:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so2079220wmg.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 06:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IIKgyVfXVR5KF65RgKGn7faumOnflo+l3cHUH3+arw8=;
 b=vadQ1699t34cdwlFzTAcNkyyHoc9j67rsP/t6+XXaVn2RJfYN8dxKvKeiBW4hYUm+m
 eKVsqY/rvTD2pqbk7C66HvgbUJKyrY61A9btoUGIeddx0w478tH1ZuiMVGkOWskRR7rZ
 zCn1I0SXeXD7iR+/BTq+HesmsTd6elieQHup9JAZUkqmYaulSY7l3XusJQkfsYxRBbjj
 kEMt0257Dc/qa1SzJRI7rA0JQe6HLl0foHvosa3sGsbFkf4FntmCy8k1g6RCQGitWcbV
 p7z6FlXjA7Bb3qkAgToGmx22P04xNnryCPRbjlVAoib5g4JAVMvyWJGtZPaXr7MDiIF9
 rCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IIKgyVfXVR5KF65RgKGn7faumOnflo+l3cHUH3+arw8=;
 b=oCGu1nEqqR1qkIMIe6MmG1vnNxy9C68JJPJ3xlq8QArpL04WUZmE06brMVcVx6J128
 Rdaiz4DMhLhJ/XXuFoDZrm7yZb3Dg9S7iY0TJrxa64+tOtBZB6a4+tv1mh8bDujKBSZV
 PQRPJpSoWJ7nnJ3AzfG6dliwwoZklEWIQYIrH8CNSfmhBCbENb+3Zx5rK6aHPnHhlOfN
 aGYqOYSG7/L3hrDTuduXsIzAeluZ2NphNI94oU/PXSbXYhNL3baPCFXD6yt8Iee223tL
 o0qjVzkXk1BiU/ixtLhwvTukkDyiE1ustgj1sSP7UEIIpO/S0/1qAg+KJU/G9Nx/1Ch6
 0tWw==
X-Gm-Message-State: APjAAAW9SE/vYqb9+jP7rFheBEoerzbbFNJc6yEKBpgXa2qXvail+7U/
 WNYLq3JL/ussVSQigtfYZYQ=
X-Google-Smtp-Source: APXvYqzUWGmvlmgYureNsbHYinBd5jGr7Ro6i7jQbSn4dPeLU1H3eaXspWtpviWQjsAlGzLXheT1IA==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr27102618wmd.23.1575295618134; 
 Mon, 02 Dec 2019 06:06:58 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id n1sm12274254wrw.52.2019.12.02.06.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 06:06:57 -0800 (PST)
Date: Mon, 2 Dec 2019 15:07:00 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 5/5] target/arm: Add support for missing Jazelle
 system registers
Message-ID: <20191202140700.GF25295@toto>
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-6-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201122018.25808-6-maz@kernel.org>
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

On Sun, Dec 01, 2019 at 12:20:18PM +0000, Marc Zyngier wrote:
> QEMU lacks the minimum Jazelle implementation that is required
> by the architecture (everything is RAZ or RAZ/WI). Add it
> together with the HCR_EL2.TID0 trapping that goes with it.


Looks good to me:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0ba08d550a..d6fc198a97 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6040,6 +6040,16 @@ static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
>      return CP_ACCESS_OK;
>  }
>  
> +static CPAccessResult access_jazelle(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                     bool isread)
> +{
> +    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID0)) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +
> +    return CP_ACCESS_OK;
> +}
> +
>  void register_cp_regs_for_features(ARMCPU *cpu)
>  {
>      /* Register all the coprocessor registers based on feature bits */
> @@ -6057,6 +6067,23 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_arm_cp_regs(cpu, not_v8_cp_reginfo);
>      }
>  
> +    if (cpu_isar_feature(jazelle, cpu)) {
> +        ARMCPRegInfo jazelle_regs[] = {
> +            { .name = "JIDR",
> +              .cp = 14, .crn = 0, .crm = 0, .opc1 = 7, .opc2 = 0,
> +              .access = PL1_R, .accessfn = access_jazelle,
> +              .type = ARM_CP_CONST, .resetvalue = 0 },
> +            { .name = "JOSCR",
> +              .cp = 14, .crn = 1, .crm = 0, .opc1 = 7, .opc2 = 0,
> +              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +            { .name = "JMCR",
> +              .cp = 14, .crn = 2, .crm = 0, .opc1 = 7, .opc2 = 0,
> +              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +            REGINFO_SENTINEL
> +        };
> +
> +        define_arm_cp_regs(cpu, jazelle_regs);
> +    }
>      if (arm_feature(env, ARM_FEATURE_V6)) {
>          /* The ID registers all have impdef reset values */
>          ARMCPRegInfo v6_idregs[] = {
> -- 
> 2.20.1
> 
> 

