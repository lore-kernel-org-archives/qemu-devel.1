Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8519BC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8D221741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqC3jojU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8D221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07Z9-0008Kb-HR
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07Ya-0007MV-P9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07YZ-0002XF-My
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:36:44 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07YZ-0002Wx-HP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:36:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id i1so2735320oie.8
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qCS7/PjVIB76872q8bycQEj+HwDmWuMG5Dh/PFcfB2g=;
 b=pqC3jojUN6ZTZ8n8p8cOUs8HXO8uBReu1Ah+N1R3q3OvXHm+u9McDhs0aOJeA5QysC
 otEkNYJ6gtxIf1qV3cKe7fgM+JhwT5rxnRjlgiMEhhC+ISDZTc+C6LZ33oX2XlSIqJKa
 cse47SvE7AmQ1/Zzb7LF6IVeB99TjAOapIXzZf0IBC/uK0XuNMpNJ95YTXv4KqqjoHpH
 cjo/Hp1gtWbJ87HbVcOxIIRasmgzv9OPHXoMt2fvcyuAqyMJ8Oabu+3GaWGolxlKBQSR
 hsDqgtRy+olUdiC1mxkLT51tUBAfaF2ic75U39tez23IFVEMMOSn3FTkWe8ERSjHYEZX
 7xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qCS7/PjVIB76872q8bycQEj+HwDmWuMG5Dh/PFcfB2g=;
 b=UXEclmHPX8rAG3lWuJaE09wdNcbgTv4l9q3e3EyParP3BJUrshjCHWCp5HQ64g9bFx
 dyvkx/Ij8DMuz8rgeV10cLKQ7bYgKnfN+lR8f738O7ns+riOyTg4/Sq8O/kDoRb3wsxW
 AunqJtXmJE4uqiDAweTM5zHnmucFRJmkc1KkJFG4fQkfbnv4XUb8Hby6yccbWdVVtvFk
 nWvOZZppsuYHkIg7+wr+sZjUUZclRiZStTBxcHaSHtrvL31Ou2TfPRd0UstiS/uqwtKX
 zxLGOHEdNGMKZwQ9PMea9opgcxMsxQo6jAo209w8IvrNgEFMWjYJfkGnz3bVI/e1DVfb
 e6fA==
X-Gm-Message-State: APjAAAUVwg2DUueBaORsYlzFQhjunQYCDwuDfAeEjDMHRbud2Fxv+Ik9
 9B/vVEUNFw0e5x1cw2AQX1wfAV3ZgSb7Ymp6xqgsJw==
X-Google-Smtp-Source: APXvYqxo9IazKB2U+KJkyF6mP/VSUP/b+QHlKS47lfHZqw1VBt4YePMARbr87o6K9Om2LHdxsWKlaTVlJ0KMBVSKYoM=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2846110oif.163.1581097002789; 
 Fri, 07 Feb 2020 09:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-9-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:36:32 +0000
Message-ID: <CAFEAcA9ARyGgvZR8Ob1GYiRhqwmHKnUFodbUVzC-nk+ifP7oCw@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] target/arm: Remove CPSR_RESERVED
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
> The only remaining use was in op_helper.c.  Use PSTATE_SS
> directly, and move the commentary so that it is more obvious
> what is going on.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h       | 6 ------
>  target/arm/op_helper.c | 9 ++++++++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 694b074298..c6dff1d55b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1186,12 +1186,6 @@ void pmu_init(ARMCPU *cpu);
>  #define CPSR_IT_2_7 (0xfc00U)
>  #define CPSR_GE (0xfU << 16)
>  #define CPSR_IL (1U << 20)
> -/* Note that the RESERVED bits include bit 21, which is PSTATE_SS in
> - * an AArch64 SPSR but RES0 in AArch32 SPSR and CPSR. In QEMU we use
> - * env->uncached_cpsr bit 21 to store PSTATE.SS when executing in AArch32,
> - * where it is live state but not accessible to the AArch32 code.
> - */
> -#define CPSR_RESERVED (0x7U << 21)
>  #define CPSR_J (1U << 24)
>  #define CPSR_IT_0_1 (3U << 25)
>  #define CPSR_Q (1U << 27)
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index acf1815ea3..af3020b78f 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -387,7 +387,14 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
>
>  uint32_t HELPER(cpsr_read)(CPUARMState *env)
>  {
> -    return cpsr_read(env) & ~(CPSR_EXEC | CPSR_RESERVED);
> +    /*
> +     * We store the ARMv8 PSTATE.SS bit in env->uncached_cpsr.
> +     * This is convenient for populating SPSR_ELx, but must be
> +     * hidden from aarch32 mode, where it is not visible.
> +     *
> +     * TODO: ARMv8.4-DIT -- need to move SS somewhere else.
> +     */
> +    return cpsr_read(env) & ~(CPSR_EXEC | PSTATE_SS);

So previously we were masking out [23:21], and now we only mask
out [21]. Is this OK because we've now masked everywhere that
might have been able to write non-zero to [23:22] ?

(regarding the TODO comment, I guess the obvious place would
be env->pstate.)

>  }
>
>  void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
> --
> 2.20.1

thanks
-- PMM

