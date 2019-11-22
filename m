Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8606CC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2E520707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co8ETjtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2E520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9sH-0006L9-Bs
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iY9rJ-0005wX-Sg
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iY9rI-0001qp-SS
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:24:29 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iY9rI-0001pR-Jf
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:24:28 -0500
Received: by mail-wm1-x341.google.com with SMTP id n188so5880937wme.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oajMw6bopBcn2xw4RMcvIlJVCq05RCeEnEeSre+FJVY=;
 b=Co8ETjtfV0gzR1QpdPPQwfPj/qjJmc6LaZb0KH0TKTTFFGXzlg2c8HEzo2uYP7J/9O
 fbr7cmk4pFng1feWQSXmuEtHpFJrr4LjzhNVEAn4aUgP3y2lpDCUD+zbEnJi/2GE+5oT
 0RurZR9KPaOtlGS/pv3GhLLalM4XayKkpLK8scoBCOmxJM4k29+XD+SRULGSG4Vb842d
 1DBdSePSMWzfm3EDZ0oAGKGerWvIo8uCUEj52Xh1uMuu6iRcnNGPcmum8hF2isq8EI/z
 bosCMSKqHFrW3MAIhnigaeQmqXcQdlqF5016weC8Xxv3+555Fqw/p9/6T2/3A4HNuCFF
 47ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oajMw6bopBcn2xw4RMcvIlJVCq05RCeEnEeSre+FJVY=;
 b=L3GO22P6sOgP6mt/VYdUs4iI4w2L9bRq38pUQk5D1hIAMFmrqqZJpIVbl7CQcqYDeV
 B5hEq/20NvfxPJpwFtw4e1QmFcYGIOZ344VQF3GX0OZ5nHKhT0hgyLE8SlU3FdBZNsMJ
 ocnhqLGTCTn0fPGBnPklyDzd01ylffI3ttF5NrB2ijAd9CsL8y+y0wAm2psZhWZDOgvc
 nUzpn/FIVmTUefCAi0QNn4cHNX5V9Y0/C1SKa6hdM0jgQUytgX4ayVUYrDhBx7UVQ2PZ
 UpCKBz0RUUgEOVibWg7E/usJPX8KpoikcBOR3Bx3X7PNzd3cE6aEBno8vKMdKokUnJaY
 anLw==
X-Gm-Message-State: APjAAAWnz/BCw51C0m73kLEgAKFaSfs6WipJDz10e4XlgCY/weWm4Wff
 lme+4M/W8HryGXXtIm3h0SU=
X-Google-Smtp-Source: APXvYqz661gn7qGvXXtqOvcBXZQU3HPmGxoswa3pCIdYFrLZ4fUJlrN2n7GywYn1L5CzCp7GskH2pw==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr16085320wme.107.1574432666836; 
 Fri, 22 Nov 2019 06:24:26 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id c12sm2671980wro.96.2019.11.22.06.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 06:24:25 -0800 (PST)
Date: Fri, 22 Nov 2019 15:24:27 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] target/arm: Fix ISR_EL1 tracking when executing at EL2
Message-ID: <20191122142427.GA29312@toto>
References: <20191122135833.28953-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122135833.28953-1-maz@kernel.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>,
 qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 01:58:33PM +0000, Marc Zyngier wrote:
> The ARMv8 ARM states when executing at EL2, EL3 or Secure EL1,
> ISR_EL1 shows the pending status of the physical IRQ, FIQ, or
> SError interrupts.
> 
> Unfortunately, QEMU's implementation only considers the HCR_EL2
> bits, and ignores the current exception level. This means a hypervisor
> trying to look at its own interrupt state actually sees the guest
> state, which is unexpected and breaks KVM as of Linux 5.3.
> 
> Instead, check for the running EL and return the physical bits
> if not running in a virtualized context.
> 
> Fixes: 636540e9c40b
> Reported-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>


Looks good to me:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  target/arm/helper.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a089fb5a69..027fffbff6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1934,8 +1934,11 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      CPUState *cs = env_cpu(env);
>      uint64_t hcr_el2 = arm_hcr_el2_eff(env);
>      uint64_t ret = 0;
> +    bool allow_virt = (arm_current_el(env) == 1 &&
> +                       (!arm_is_secure_below_el3(env) ||
> +                        (env->cp15.scr_el3 & SCR_EEL2)));
>  
> -    if (hcr_el2 & HCR_IMO) {
> +    if (allow_virt && (hcr_el2 & HCR_IMO)) {
>          if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
>              ret |= CPSR_I;
>          }
> @@ -1945,7 +1948,7 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>          }
>      }
>  
> -    if (hcr_el2 & HCR_FMO) {
> +    if (allow_virt && (hcr_el2 & HCR_FMO)) {
>          if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
>              ret |= CPSR_F;
>          }
> -- 
> 2.17.1
> 
> 

