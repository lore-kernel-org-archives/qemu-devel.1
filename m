Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED514C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76CA214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFJt4/1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76CA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07wx-0004Hf-PJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 13:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07wJ-0003VZ-Rp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07wI-00073h-0G
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:01:15 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07wH-0006z4-Q3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:01:13 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so2849337oic.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bu8jAfUNNx0M7UrXp1dt6MXcfvGiBPlyXSYK/slfxKQ=;
 b=lFJt4/1Hv2d7FKkANEmakNqJH4mFpPXW3ja4ghSMwZL7t4ArCaThtHDxyq4qLft9fI
 Se2lgB0eJB/MHbWukr07hWvqfu50t2c8wSjCTod18XLjzIOJq+65YmdwRyWIDb8IIYMp
 +3NJLA7edQ9iCcW9WPMd1qTR59vdcBcT64WJTxd8N4vAnnqJZ/6WGv70BrUThags3Vqw
 nFY5meAq2Msgvzz/jvg1rA1ycQOHwTA/c5Q/Ph2xu+xLi4/PSCKZCvq7ab3sOtjzteJ/
 n9NtLtx9SloL7soIB/8o+/VTlj0ltMGfUQc5p2yU0yUMjVp4Sl9k3uJxue8e+lP138+a
 OA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bu8jAfUNNx0M7UrXp1dt6MXcfvGiBPlyXSYK/slfxKQ=;
 b=bneDjhNwFNj6096UCfJEaTjuLt7P7GccDwvLWnYzExCYznhzeEGfR9NifEGXh+PRUd
 jrFxcwnn0FxQRO6JsHNJ4VsVlxpGgInxne7uEEQSvN8VtMhRjuRggB4V/sGYAtD9RPx0
 4FQC81Xq9/MIGwueh3EuFh5F5rJ+kQAFTz9mL6Sh8NqHnBohQbOLGc4Kt7lKAv6F4gC/
 fZQ/ZbMxzNtguMEKrM6VgGPhvUqHY1VNhd+5AzhyLYEKopvJT+9gL4VpNMeaO+ZzZ+H8
 5w74bVkTKNYlv8m+ViJUmIVlaAq3C7nKnESODdS4jDOFfqxICfEzvGC0wPDfdWgSz5Af
 +fyw==
X-Gm-Message-State: APjAAAWCsaxQruYQlKUjwvSgDKkLhYlby8N7y3zXf4Hc5+BOOwHq11R2
 pDPR84YWfoQ0vKi8aDbv4yCNp01LpH8PnHfoYuoQVw==
X-Google-Smtp-Source: APXvYqzljVmpm7uU3U6CSxTpchIL+whonxh747V5lk0d/Fduh/PJAkKzcf7nXZ7UeU0rtgpr4rFlDACHeyuNnTrNZj0=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2780502oie.146.1581098472578; 
 Fri, 07 Feb 2020 10:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-15-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 18:01:01 +0000
Message-ID: <CAFEAcA9mkjeis8mavOSQsxvnH3pLv=WpwcKsNKzOONzMB6=+Ww@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] target/arm: Set PAN bit as required on exception
 entry
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 14:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The PAN bit is preserved, or set as per SCTLR_ELx.SPAN,
> plus several other conditions listed in the ARM ARM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Tidy preservation of CPSR_PAN in take_aarch32_exception (pmm).
> ---
>  target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 18e4cbb63c..4c0eb7e7d9 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8772,8 +8772,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>                                     uint32_t mask, uint32_t offset,
>                                     uint32_t newpc)
>  {
> +    int new_el;
> +
>      /* Change the CPU state so as to actually take the exception. */
>      switch_mode(env, new_mode);
> +    new_el = arm_current_el(env);
> +
>      /*
>       * For exceptions taken to AArch32 we must clear the SS bit in both
>       * PSTATE and in the old-state value we save to SPSR_<mode>, so zero it now.
> @@ -8786,7 +8790,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>      env->uncached_cpsr = (env->uncached_cpsr & ~CPSR_M) | new_mode;
>      /* Set new mode endianness */
>      env->uncached_cpsr &= ~CPSR_E;
> -    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
> +    if (env->cp15.sctlr_el[new_el] & SCTLR_EE) {
>          env->uncached_cpsr |= CPSR_E;
>      }
>      /* J and IL must always be cleared for exception entry */
> @@ -8797,6 +8801,12 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
>          env->thumb = (env->cp15.sctlr_el[2] & SCTLR_TE) != 0;
>          env->elr_el[2] = env->regs[15];
>      } else {
> +        /* CPSR.PAN is preserved unless target is EL1 and SCTLR.SPAN == 0. */
> +        if (cpu_isar_feature(aa64_pan, env_archcpu(env))
> +            && new_el == 1
> +            && !(env->cp15.sctlr_el[1] & SCTLR_SPAN)) {
> +            env->uncached_cpsr |= CPSR_PAN;
> +        }

This doesn't catch the "taking exception to EL3 and AArch32 is EL3"
case, which is also supposed to honour SCTLR.SPAN.

Given where this code is, we know we're taking an exception to
AArch32 and that we're not going to Hyp mode, so in fact every
case where we get here is one where we should honour SCTLR.SPAN
and I think we can just drop the "new_el == 1" part of the condition.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

