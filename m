Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5310DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C40C20714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4+ZfWyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C40C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYByY-0000Vg-T8
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qperret@google.com>) id 1iYB1C-0004Jf-SC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qperret@google.com>) id 1iYB1B-0000rs-PE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:38:46 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <qperret@google.com>) id 1iYB1B-0000qX-Gb
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:38:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id x26so7619751wmk.4
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2bXdv451uXtHSKP2mFUlRRcnaTmxXQD2UXLdESeqDYQ=;
 b=K4+ZfWyCelA/4gucez16m+FoaIk5SAyV4dEBlLeZrYV2Fcx2ZuN1RnnDTU+v1NQxk/
 KShVhuHqA2e7tdi6hlnAeQvYF+V6uxLsUdYhP6qxGl+IRmHLG7GFMW2K9O454pscCuhW
 SOtgnyfpbqm5bYW9xQ0DayvbhIZKVF0asKljlThCDSzd0hdvWP/cSlvgiz0EupNBYz9W
 J+k7U21fb5PXj8UIY0qKU+gmI/yAwNHiodLtHpDygZCeHQELU751kbbjU7I1SZoo+tAX
 LAaV2b4Oo9MkHAJ8JjMNfDebWdr5rzvwlppw7UehseKtw0x8DdO0TDEeklZJEyH3AuYN
 5n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2bXdv451uXtHSKP2mFUlRRcnaTmxXQD2UXLdESeqDYQ=;
 b=sTYfozt6pyb6UN0h/fU8afdUANGToWwyDNk8DZgG2tHQ1rWgdEM7hSf6bSzTYHDTU3
 9wP52ELPgS1vU8zn8jiI9L4jxwX1EL0u0xAov7zuYfG9sPqPIow75Nu30lelGKTO2Roc
 fRXGzuhF/LaKYhRYPTzRS+UQB4aQ/ZhJga0rNYp0MA3NNbtxKXyWCXi2cFeLrurHtf2i
 vcI3GnHPkK41odYl68gOre+Pj1jHEBiCnn0XZ7dckxNTi54L9QURdfn3uVmMNn9wN/Ga
 abEVPBpwWobi55JO2O5NrcbXaO3fdkB8DTpJEIv/7qbzjXctD7oxKqrIS1aRRM8iOvsi
 eYxA==
X-Gm-Message-State: APjAAAWYbclx9hOQDFzDA4h5EDY9tgBp1LOb2xWTkOCrZpUpIZhYkin9
 9A0DIDPKq+KjJjxngr+lOkPnuA==
X-Google-Smtp-Source: APXvYqxt4TgJV1dS5Bjno9tHw1KVHIZBIvkkQpeod6YkQ3wdPI4vcJ6Tlj3WAb1Og+1pOLvFbZ0HZQ==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr18046942wmc.113.1574437120711; 
 Fri, 22 Nov 2019 07:38:40 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
 by smtp.gmail.com with ESMTPSA id k4sm4123806wmk.26.2019.11.22.07.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 07:38:40 -0800 (PST)
Date: Fri, 22 Nov 2019 15:38:36 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
 Will Deacon <will@kernel.org>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Fix ISR_EL1 tracking when executing at EL2
Message-ID: <20191122153836.GA222628@google.com>
References: <20191122135833.28953-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122135833.28953-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Fri, 22 Nov 2019 11:34:39 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday 22 Nov 2019 at 13:58:33 (+0000), Marc Zyngier wrote:
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

And FWIW, Tested-by: Quentin Perret <qperret@google.com>

Thanks Marc :)
Quentin

> Signed-off-by: Marc Zyngier <maz@kernel.org>
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

