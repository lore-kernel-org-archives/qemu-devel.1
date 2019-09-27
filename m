Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD1CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8333B2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcFWW4Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8333B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrJe-0000kP-PL
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqN6-0005Ap-MM
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqN5-0001xB-6W
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:33:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDqN5-0001x4-0g
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:33:19 -0400
Received: by mail-oi1-x241.google.com with SMTP id k20so5206847oih.3
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XpRff2jEEJjun5C2nBwnEy0mpg4KSV3BL/CHwT484IE=;
 b=qcFWW4Gw2Z1hHz2R8mU/7PNImqDSLwQyb9YokkDvkIFBQGNra8ryGJ0Mu/u0rqwqLc
 9NMqnwwG/iPr9oGSWsYCfiQOvZoZOLQcIx37TenROPvMxcIlNLsszFebmz/ISrP1I002
 nNKTwl7k6+zZBC90PoaDCvyHQ5jsc8CZImfI/O+2g6UWFgnUHjMBN9edyv10srOnB0aB
 zWVJKjFkmhJ7UTofs8uuCyw7EBlDbXtoflkBUeseFk0Qp/QkuOJsFy6S2GmeIhPT50fR
 Imoh+XTDM1Uf1uKnWGcunaRpKbyBqhJWOUtLXAK8/mbTyTnfmhOR3Xdn1DX+1qi6udvt
 1+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XpRff2jEEJjun5C2nBwnEy0mpg4KSV3BL/CHwT484IE=;
 b=q9lETtwq8Md39b5G42ZSw/gw6iWMFVpihjz9RuCpXQm7VOX2PkJKBPJbxsurVxOAxo
 Sh63Fu2Up2FI0/oHCmJ9Np3OZpAlbU55+Hs8Awq0BV1IiI3jpnNfTNUzHyS/O0TV3V70
 eUCQ9RP667/WZpdeSTBKDkggLNPJnQBkhV6dOxnP0Im50NVoY7HRWu+HzNOohZRmaSOz
 C1haKs5bsDbnrmtCk7p5VEvzIgA4jxG6KBjmkIdAiWJDyhvspKeQChRqMGISzjuy6jD1
 f/RMwNTqjf/zzTL5sSaY0Ze9FyGmhrjz250oVQyHiK2xBJuPIoPUpLjt2SxlkxO6d4rG
 IPtw==
X-Gm-Message-State: APjAAAXEC6Tu4ZRsytIsFgzpoDyFLyuXWsp38dxsYm3xRBRhb5ZU7ne8
 CeNwrAV06/ZXUYLONDPHWMk3mUIt7KkqZ8HJfN1QPg==
X-Google-Smtp-Source: APXvYqzq1Mf0Cwsntez7S0gT5ElVn+nWXKGzokuwMctHq6cA/F3Ytm0RCygkiV1cnVmxGAYhvxowxpAmouCw/rKpz6k=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr7301167oif.98.1569591198389; 
 Fri, 27 Sep 2019 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-6-zhengxiang9@huawei.com>
In-Reply-To: <20190906083152.25716-6-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 14:33:07 +0100
Message-ID: <CAFEAcA-xc2XUq2Kwa1cK=4sAMq8B-2jUFAmxiGOQbmRCp-+UmQ@mail.gmail.com>
Subject: Re: [PATCH v18 5/6] target-arm: kvm64: inject synchronous External
 Abort
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Introduce kvm_inject_arm_sea() function in which we will setup the type
> of exception and the syndrome information in order to inject a virtual
> synchronous external abort. When switching to guest, it will jump to the
> synchronous external abort vector table entry.
>
> The ESR_ELx.DFSC is set to synchronous external abort(0x10), and
> ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
> not valid and hold an UNKNOWN value. These values will be set to KVM
> register structures through KVM_SET_ONE_REG IOCTL.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

> +/* Inject synchronous external abort */
> +static void kvm_inject_arm_sea(CPUState *c)

This will cause a compilation failure at this point in
the patch series, because the compiler will complain about
a static function which is defined but never used.
To avoid breaking bisection, we need to put the definition
of the function in the same patch where it's used.

> +{
> +    ARMCPU *cpu = ARM_CPU(c);
> +    CPUARMState *env = &cpu->env;
> +    CPUClass *cc = CPU_GET_CLASS(c);
> +    uint32_t esr;
> +    bool same_el;
> +
> +    /**
> +     * Set the exception type to synchronous data abort
> +     * and the target exception Level to EL1.
> +     */

This comment doesn't really tell us anything that's not obvious
from the two lines of code that it's commenting on:

> +    c->exception_index = EXCP_DATA_ABORT;
> +    env->exception.target_el = 1;
> +
> +    /*
> +     * Set the DFSC to synchronous external abort and set FnV to not valid,
> +     * this will tell guest the FAR_ELx is UNKNOWN for this abort.
> +     */
> +
> +    /* This exception comes from lower or current exception level. */

This comment too is stating the obvious I think.

> +    same_el = arm_current_el(env) == env->exception.target_el;
> +    esr = syn_data_abort_no_iss(same_el, 1, 0, 0, 0, 0, 0x10);
> +
> +    env->exception.syndrome = esr;
> +
> +    /**

There's a stray second '*' in this comment-start.


> +     * The vcpu thread already hold BQL, so no need hold again when
> +     * calling do_interrupt

I think this requirement would be better placed as a
comment at the top of the function noting that callers
must hold the iothread lock.

> +     */
> +    cc->do_interrupt(c);
> +}
> +
>  #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>
> diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
> index 5feb312941..499672ebbc 100644
> --- a/target/arm/tlb_helper.c
> +++ b/target/arm/tlb_helper.c
> @@ -33,7 +33,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
>       * ISV field.
>       */
>      if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
> -        syn = syn_data_abort_no_iss(same_el,
> +        syn = syn_data_abort_no_iss(same_el, 0,
>                                      ea, 0, s1ptw, is_write, fsc);
>      } else {
>          /*
> --
> 2.19.1

thanks
-- PMM

