Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5D8C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE03A21781
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUM/t9eN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE03A21781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabb7-00089w-Ao
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iabCR-0002h0-AA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iabCM-0003jk-QQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:00:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iabCM-0003U6-HN
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:00:18 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so1041425wmi.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 00:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+ee4XCjoKvbrVyPiVj9oLKOCyeyLum3UV/GHyTlIxYM=;
 b=kUM/t9eNYO5Sj0IK08qF8PQQ3uaXFcMDeHjDR09kJr24eyxL361WeKH+MWmhYp2wQy
 1r3b0WIR7AtHvu8K5/0zpVt9KM3KKM2iRwiG6rCLZGCU1cqysANrWn1it1ux0dwlgB93
 9LE40KS+b7nnu/pRuB3n7hnolaq63YKMSJHDSPrRc3jGgyNDDOb1Zb+KejnOHTHs1hCO
 e+oORBIEuXvCC56Mbl96z5scxTX4BCW0JQTbl3SdEZCFdxmRZdMKQbxsYuZ8KyO+/YYN
 eGHcY0dgJboBRWNtrtyYjcCBhO+/rPZNuYmnz8gJ82fIqfh5I53gFs+mW/ECV+vLzZ8H
 JiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+ee4XCjoKvbrVyPiVj9oLKOCyeyLum3UV/GHyTlIxYM=;
 b=HST4UHAQoiyKvHGmQST2J1vtkA0HQsjWpeIEXoTCXs9RYRKMWaNhwBfeeVeGAW2Vza
 2hxZD5pz1kAiplAiqH2NSaE2Z617XOvdk2CHwbi80BVnZ1ikQjqKGAePjceCHg8X/ihQ
 WBn117AKwZ69woOIGmQRwOZGoonWaW18ttASpJV4qm1YVfOSliU7UdEDX0zsTCfe0H7d
 mZHOpQ8XZ26Evgl5dbbJgHkfMBEAEJD/lsgk5URon1en/dPPRJyrBxRDS4/40pQujxi6
 RZiqEoee6Po5+nHm+RH6L3MJOjYVSxpQWgWRv5h00BFBOTincJbV35sDfVriRJBzkETL
 4ieg==
X-Gm-Message-State: APjAAAVxuvIs3eczE4ODe5lk2YOxHtPdOXFqw5fCuG6dIkiedLue4giV
 2urKd283qdTFn9DIJnRqsbv/rtkE0t0=
X-Google-Smtp-Source: APXvYqwe09tQue8nHFk39vsJX6xeXrU4LjnL73ldh1erXrGAbZkkczFZHKsgHhvq7oyW2aznTfQtgA==
X-Received: by 2002:a1c:3cd4:: with SMTP id j203mr8250680wma.90.1575014413834; 
 Fri, 29 Nov 2019 00:00:13 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id i127sm13433594wma.35.2019.11.29.00.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 00:00:13 -0800 (PST)
Date: Fri, 29 Nov 2019 09:00:15 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/3] target/arm: Honor HCR_EL2.TID1 trapping requirements
Message-ID: <20191129080015.GE29312@toto>
References: <20191128161718.24361-1-maz@kernel.org>
 <20191128161718.24361-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128161718.24361-3-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 04:17:17PM +0000, Marc Zyngier wrote:
> HCR_EL2.TID1 mandates that access from EL1 to REVIDR_EL1, AIDR_EL1
> (and their 32bit equivalents) as well as TCMTR, TLBTR are trapped
> to EL2. QEMU ignores it, naking it harder for a hypervisor to

Typo: "making it harder"


> virtualize the HW (though to be fair, no known hypervisor actually
> cares).
> 
> Do the right thing by trapping to EL2 if HCR_EL2.TID1 is set.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0b6887b100..9bff769692 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1973,6 +1973,26 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      return ret;
>  }
>  
> +static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                       bool isread)
> +{
> +    if (arm_hcr_el2_eff(env) & HCR_TID1) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }

I think we need to check for EL1 here?

Otherwise:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar


> +
> +    return CP_ACCESS_OK;
> +}
> +
> +static CPAccessResult access_aa32_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                       bool isread)
> +{
> +    if (arm_feature(env, ARM_FEATURE_V8)) {
> +        return access_aa64_tid1(env, ri, isread);
> +    }
> +
> +    return CP_ACCESS_OK;
> +}
> +
>  static const ARMCPRegInfo v7_cp_reginfo[] = {
>      /* the old v6 WFI, UNPREDICTABLE in v7 but we choose to NOP */
>      { .name = "NOP", .cp = 15, .crn = 7, .crm = 0, .opc1 = 0, .opc2 = 4,
> @@ -2136,7 +2156,9 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>       */
>      { .name = "AIDR", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 7,
> -      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +      .access = PL1_R, .type = ARM_CP_CONST,
> +      .accessfn = access_aa64_tid1,
> +      .resetvalue = 0 },
>      /* Auxiliary fault status registers: these also are IMPDEF, and we
>       * choose to RAZ/WI for all cores.
>       */
> @@ -6732,7 +6754,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access = PL1_R, .resetvalue = cpu->midr },
>              { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
> -              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
> +              .access = PL1_R,
> +              .accessfn = access_aa64_tid1,
> +              .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
>              REGINFO_SENTINEL
>          };
>          ARMCPRegInfo id_cp_reginfo[] = {
> @@ -6747,14 +6771,18 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              /* TCMTR and TLBTR exist in v8 but have no 64-bit versions */
>              { .name = "TCMTR",
>                .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 2,
> -              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +              .access = PL1_R,
> +              .accessfn = access_aa32_tid1,
> +              .type = ARM_CP_CONST, .resetvalue = 0 },
>              REGINFO_SENTINEL
>          };
>          /* TLBTR is specific to VMSA */
>          ARMCPRegInfo id_tlbtr_reginfo = {
>                .name = "TLBTR",
>                .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 3,
> -              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0,
> +              .access = PL1_R,
> +              .accessfn = access_aa32_tid1,
> +              .type = ARM_CP_CONST, .resetvalue = 0,
>          };
>          /* MPUIR is specific to PMSA V6+ */
>          ARMCPRegInfo id_mpuir_reginfo = {
> -- 
> 2.20.1
> 
> 

