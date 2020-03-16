Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35A9C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7519420674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOykOFt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7519420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvYl-0004L6-M2
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvY1-0003V4-GY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvXz-0007Z6-V9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:37:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvXz-0007Qb-NS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:37:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id i13so10528640pfe.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L89ZWrRD+o41kxNk0fnpcdzdsDuN76+Y+I0X9Rp+gms=;
 b=JOykOFt2/Pic/Ya/IJ1Yuxkfir9truF3YSQWCcT0DMz/IOBBBgUasm4tSdf1lbYH+C
 KQFeRRmYukwQXIfxV7PiTbjLDRkheJGHGkIcbWD8ukyAGXKnbe7CmubS9P0iR96MXISV
 QPcDoCC3TJnR7ADHr0FEeX9DuMN4Jpww5d8KoHi8f7iEMCzGYL/zGtMYSWxxXnwWW545
 t4t9ttJSJzT78RaBCd6izDyZnmN8Va//drpARvGb3gsINYt2DZjytGl3i0EjGhogROOl
 nECne9eMCiClmtmHmwomneU1aXuC9lfHDIEMrYLeb6r6lJHz+KR5IlDrMQrtGUlkCovL
 JCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L89ZWrRD+o41kxNk0fnpcdzdsDuN76+Y+I0X9Rp+gms=;
 b=UAlUtQVuwPePsNkqzJuKOV/1JGERssxboCtj1NsFnyStD6wKvY7tUx7g/LUTgp2yMq
 LzH0ZoiP+GdHCVBNmTSVqSCXGrPyYUcTDRTpxbxb26/098kX55l4O44x2e6KdTi+K96m
 8eXEVYilVJ8EfTKfIboaAEdSyAANfIUQmjK1Al2nRaJdeG3U1UbBw4mzepMeGUuIgSUC
 42jfZ+Uzu6SoHztsI/ZfCaiqNgh3CZgkz3jAXhSNs7HtCnoc1yn3cQPzAqJ1x+JGf0Hq
 kk/sqr4iE+aB5JzwU2KgMVq1B7U903TVwe8ZsvXL0an0wmpE0diiejcPvgi77GQhi59L
 FQvA==
X-Gm-Message-State: ANhLgQ3xVVOUDUpXaydISFI7tXjtHgnmu1OvmuKMXj8b/dSRwBiK4M1M
 cBRhV9P6pdWbIPfMtikRkyRP2Q==
X-Google-Smtp-Source: ADFU+vvhNufPP7bu7Lbr300PVxk4IJgWKvd7lJvPzyrN4DkPlsGgJZsWycA0QGAqYFPlScuXekBqTA==
X-Received: by 2002:aa7:8711:: with SMTP id b17mr1118088pfo.315.1584387430595; 
 Mon, 16 Mar 2020 12:37:10 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g13sm673135pfi.183.2020.03.16.12.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:37:09 -0700 (PDT)
Subject: Re: [PATCH v3 04/19] target/arm: Restric the Address Translate
 operations to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c257230b-277c-d568-756b-39acb93ac308@linaro.org>
Date: Mon, 16 Mar 2020 12:37:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> Under KVM the ATS instruction will trap.

Not trap, they'll just work.
Otherwise similar comment as for dcpop.


r~

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/helper.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 924deffd65..a5280c091b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3322,7 +3322,7 @@ static void par_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>      }
>  }
>  
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>  /* get_phys_addr() isn't present for user-mode-only targets */
>  
>  static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3631,7 +3631,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
>  
>      env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx);
>  }
> -#endif
> +#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
>  
>  static const ARMCPRegInfo vapa_cp_reginfo[] = {
>      { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
> @@ -3639,7 +3639,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] = {
>        .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
>                               offsetoflow32(CPUARMState, cp15.par_ns) },
>        .writefn = par_write },
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>      /* This underdecoding is safe because the reginfo is NO_RAW. */
>      { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,
>        .access = PL1_W, .accessfn = ats_access,
> @@ -4880,7 +4880,8 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>        .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 6,
>        .access = PL2_W, .type = ARM_CP_NO_RAW,
>        .writefn = tlbi_aa64_alle1is_write },
> -#ifndef CONFIG_USER_ONLY
> +
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>      /* 64 bit address translation operations */
>      { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
>        .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 8, .opc2 = 0,
> @@ -4929,7 +4930,8 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>        .access = PL1_RW, .resetvalue = 0,
>        .fieldoffset = offsetof(CPUARMState, cp15.par_el[1]),
>        .writefn = par_write },
> -#endif
> +#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
> +
>      /* TLB invalidate last level of translation table walk */
>      { .name = "TLBIMVALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
>        .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
> @@ -5536,7 +5538,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
>        .access = PL2_W, .type = ARM_CP_NO_RAW,
>        .writefn = tlbi_aa64_vae2is_write },
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>      /* Unlike the other EL2-related AT operations, these must
>       * UNDEF from EL3 if EL2 is not implemented, which is why we
>       * define them here rather than with the rest of the AT ops.
> @@ -6992,7 +6994,7 @@ static const ARMCPRegInfo vhe_reginfo[] = {
>      REGINFO_SENTINEL
>  };
>  
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>  static const ARMCPRegInfo ats1e1_reginfo[] = {
>      { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
>        .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
> @@ -7894,14 +7896,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (cpu_isar_feature(aa64_pan, cpu)) {
>          define_one_arm_cp_reg(cpu, &pan_reginfo);
>      }
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>      if (cpu_isar_feature(aa64_ats1e1, cpu)) {
>          define_arm_cp_regs(cpu, ats1e1_reginfo);
>      }
>      if (cpu_isar_feature(aa32_ats1e1, cpu)) {
>          define_arm_cp_regs(cpu, ats1cp_reginfo);
>      }
> -#endif
> +#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
>      if (cpu_isar_feature(aa64_uao, cpu)) {
>          define_one_arm_cp_reg(cpu, &uao_reginfo);
>      }
> 


