Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A69C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035862082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/cMmw90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035862082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07VI-0004zI-7u
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07UP-0004U3-Bg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07UN-0005oO-Tx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:32:24 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07UN-0005oI-O1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:32:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id j20so59735otq.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eXxU5KOW8IE2h0YTaTE+RD6dSmNCkvpSvE7Bmj8d3Ac=;
 b=k/cMmw90e4LmLZQ65ReRLLUhs7TgadKFmL60DlfeVksUbbRFQi7x4a9qskYjpT1sUu
 OmUmzIoJzWyGD9w4pAkUEGviJXTceJD2FZyw7vROVs6U8cwhRHsk9B7fqniEWaD/dasC
 pOsaGtPREbdU6be5L3aMsWu4gOa0X7mvx9FVwT3C6PTullgLZSrbOXn+8sW2jYJW1Wc5
 CQpzbmeEI/q7PqgJvPzBdtN/UNdUK0a0WGKi/4z5RnbsOZqQiNoDyThXj+9PLtrvEYTE
 3FNy5v98ddYWSe0SW4uisEZB45ZzJ1iQTu3mSLLLtkk8lmAvSvZCHNRxQQArTqUWnUYY
 yYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eXxU5KOW8IE2h0YTaTE+RD6dSmNCkvpSvE7Bmj8d3Ac=;
 b=WSceGMu/10P8aQ5mq4Qd4gxyrVuk4WBEeAVRa3ItLU8Sfz2cFJauamDDtLcvPHBtES
 lWsNBJvF69cNtOcqaV/JMjUaXaGmyfs4xzvufxjwWBTD9D9EiaqFddHCOy0FQv/WdMLN
 lGsMIBWJh4JUpcBPXZX4Enbcdm4JVJtFJGwBZH1289jxoO/Trz84s+XZpGn/lhDrCKSV
 DCsglrPMG1vLy/zLimlEJ2ONgrzOVh2klwExh1vmKyFMm14Cq9DA6pSdyW0NCqgcN6y4
 T5l6qb7nfGDVnArQivvjwszqB8Z/2JCGsda7O4JpqZ0W4KDMEnkg1e6uY/AZmkcoJTUE
 KdVg==
X-Gm-Message-State: APjAAAVrb7A44jTUZl0+3TeF+t1kJq3rYo3WjpgARMcOfUThMBeFgMbc
 qykeUaAulTcZzqae3eaqS8rNmHUP7vbyjTjEFTRcrQ==
X-Google-Smtp-Source: APXvYqy9f3Y1nU/iAcs7uSTiule4ZkC19xsKLzS1WFtHVbQkE83vqD2T9muXGXNnt88D9yFcs33Y0VpJd6HTZJelffY=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr358382otq.135.1581096742719; 
 Fri, 07 Feb 2020 09:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-7-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:32:11 +0000
Message-ID: <CAFEAcA_ceEE_gAnZHJ1R+LCVfdky_7QF7FZ-s1yxMWXu8jdhLg@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] target/arm: Replace CPSR_ERET_MASK with
 aarch32_cpsr_valid_mask
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
> CPSR_ERET_MASK was a useless renaming of CPSR_RESERVED.
> The function also takes into account bits that the cpu
> does not support.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h       | 2 --
>  target/arm/op_helper.c | 5 ++++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 08b2f5d73e..694b074298 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1209,8 +1209,6 @@ void pmu_init(ARMCPU *cpu);
>  #define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
>  /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
>  #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
> -/* Mask of bits which may be set by exception return copying them from SPSR */
> -#define CPSR_ERET_MASK (~CPSR_RESERVED)
>
>  /* Bit definitions for M profile XPSR. Most are the same as CPSR. */
>  #define XPSR_EXCP 0x1ffU
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 27d16ad9ad..acf1815ea3 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -400,11 +400,14 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
>  /* Write the CPSR for a 32-bit exception return */
>  void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
>  {
> +    uint32_t mask;
> +
>      qemu_mutex_lock_iothread();
>      arm_call_pre_el_change_hook(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>
> -    cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
> +    mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
> +    cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
>
>      /* Generated code has already stored the new PC value, but
>       * without masking out its low bits, because which bits need
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

