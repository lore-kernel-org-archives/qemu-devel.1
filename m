Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458EC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 03:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE1E206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 03:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXqct+Mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE1E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ApK-0002ZX-5b
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 22:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Aoe-00021q-G1
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 22:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Aoc-0007zo-W5
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 22:41:56 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3Aoc-0007yB-Nj
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 22:41:54 -0500
Received: by mail-pl1-x643.google.com with SMTP id j7so5382367plt.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 19:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+ksXD0DwdmuLCxfx4m4FYg1fC6RAiEAhWQyW1hRC2TQ=;
 b=cXqct+MhNuVTqbLJyLHP8l/EmJNanP4P69mtyJR3nCOacbnYLIyqMnlrmGBGlzsvmw
 zeKOujhSbDoa8TZ0/Y+p9DW5zmbnM4+LHmkw89v+8O0jLk5mpYzna+RGPUiuLKlhbNq+
 trUG8LmvKUrsUZB5UZQRtL/XfZ50oqFB9oKRB9IXhVj6RaN47sLgVJ4PbvX/Wc7T2M52
 SBBrK12fwS/M70m7pF5Y7Mz8TQOtGHTFw4Jx+hP84HD9zJuQHpqZAmAL3XQmOpHUfts7
 h8QMygjwW+c4gdtMZG1Dt8f3c+rjHWsahkc9Ryj4H3yvf/SrVL1nLfsevAcVigib7F+1
 KjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+ksXD0DwdmuLCxfx4m4FYg1fC6RAiEAhWQyW1hRC2TQ=;
 b=ZgdxgUQ6lb0BuyIEzt1OkZ2oYVMHpSlNevPjK9M721hRw4keRrlJcWNWlgGIcENr1H
 vVLw30wWJi4eJsX7Kpp1mZ5bsONMfmKkdNIghYmeKQG8xRfybnWci+rHu7P0OqdfiqGP
 HNz/+TGeYK4NfnQw7E/bjdfiATEOsI2bNxR4wv0EsggYs0o0lmH7NuBRNje0XKnCYUR+
 hmS5XCWQG/K6D9a+I5so/1WP+3Aoh8dftskR059UBLzdljgADE2H/qSsozHiGWivQp1U
 IFwFc0TP33l/eQXXHUiwdkk21tCQaoYFZXDy/V9H2uXaBkzGGl6Rhpx3aqlH4ELfjDjC
 EVCg==
X-Gm-Message-State: APjAAAXlgQoTabpQ/a3ugJEIDGQtPMhQN36YCcDnHCylhFKCE1CZnbRp
 pmQi1mD3/w6Dw+FAUl17h/evGg==
X-Google-Smtp-Source: APXvYqxVwDeaxDUNocsEl4Fy/D2H3IxAY/eVTtfQ85zj+IFQEErFCIdqFfAHbROt5CH4PRzQ4xXjqA==
X-Received: by 2002:a17:90a:b106:: with SMTP id
 z6mr12693083pjq.91.1581824513480; 
 Sat, 15 Feb 2020 19:41:53 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g19sm11679128pfh.134.2020.02.15.19.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 19:41:52 -0800 (PST)
Subject: Re: [PATCH v3 1/2] target/arm: Support SError injection
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200214055950.62477-1-gshan@redhat.com>
 <20200214055950.62477-2-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c00d0d4-19c5-0802-8fd3-f583bb270709@linaro.org>
Date: Sat, 15 Feb 2020 19:41:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214055950.62477-2-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 9:59 PM, Gavin Shan wrote:
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index b0762a76c4..180e29fb83 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -78,7 +78,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>          && cs->interrupt_request &
>          (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
> -         | CPU_INTERRUPT_EXITTB);
> +         | ARM_CPU_SERROR | CPU_INTERRUPT_EXITTB);

CPU_INTERRUPT_SERROR, not ARM_CPU_SERROR.

> @@ -570,6 +573,16 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>              goto found;
>          }
>      }
> +
> +    if (interrupt_request & CPU_INTERRUPT_SERROR) {
> +        excp_idx = EXCP_SERROR;
> +        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> +        if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                              cur_el, secure, hcr_el2)) {
> +            goto found;
> +        }
> +    }
> +
>      return false;
>  
>   found:

If you're intending to use Serror for NMI, perhaps it should be the first bit
tested, not the last.  Otherwise some bug that leaves a normal hard interrupt
line high will keep delivering the interrupt, and not the Serror.

As the comment at the top of the function says, the priority is implementation
defined, so we can put it anywhere we like.

> @@ -594,13 +607,26 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       * (which depends on state like BASEPRI, FAULTMASK and the
>       * currently active exception).
>       */
> -    if (interrupt_request & CPU_INTERRUPT_HARD
> -        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
> -        cs->exception_index = EXCP_IRQ;
> -        cc->do_interrupt(cs);
> -        ret = true;
> +    if (!armv7m_nvic_can_take_pending_exception(env->nvic)) {
> +        return false;
> +    }
> +
> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +        excp_idx = EXCP_IRQ;
> +        goto found;
>      }
> -    return ret;
> +
> +    if (interrupt_request & CPU_INTERRUPT_SERROR) {
> +        excp_idx = EXCP_SERROR;
> +        goto found;
> +    }

Likewise.

> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 5);
>      } else {
> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 5);

I wonder if we should have an ARM_CPU_NUM_IRQ define so that this is more
automatic.

> @@ -98,10 +100,11 @@ enum {
>  #endif
>  
>  /* Meanings of the ARMCPU object's four inbound GPIO lines */
> -#define ARM_CPU_IRQ 0
> -#define ARM_CPU_FIQ 1
> -#define ARM_CPU_VIRQ 2
> -#define ARM_CPU_VFIQ 3
> +#define ARM_CPU_IRQ    0
> +#define ARM_CPU_FIQ    1
> +#define ARM_CPU_VIRQ   2
> +#define ARM_CPU_VFIQ   3
> +#define ARM_CPU_SERROR 4

Comment is now wrong about the count.


r~

