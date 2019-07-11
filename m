Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC44C74A54
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1FE21537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXlMcnWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1FE21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaY0-0000XX-AE
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlaX6-0008H9-Sp
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlaX5-0006QS-Km
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:58:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlaX5-0006Nx-Fr
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:58:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so6156603oth.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2++xkrP6CNKv5dyr9XhKnyb0crOiXsr2FXISi8XGwX0=;
 b=MXlMcnWTiqxWAz4a7sYA2gGHSUMHwruCRYYmlkPxrWvj6G31Vc0xb5xrGlrEGjtAg8
 yhZxL8ljPCz5CtxCcFAtzfhlqMsglYrOT4H6tWRDXhSBF2Ka43ojKUsfmCW2vXnGY1Wl
 dAhBEMzP9upy4U0eEQp9erHIBQiJHIx+Vw84eZXYH6BUtJOULpzTgAfrOTeXuSdkd7yb
 TQ+ZllJ+9uRjpB9MijI2CUwbbfgbRAQ1NKyzKWcZAv5iIxGyjXIBU41fvj6Vc8tMYk0z
 8DhIjJ78YECNzqg/nRkJ26Pb0YbFLZp0Q1JwOulCmahdtJNnVfE/PrRjmcqsznvdbfcM
 Nk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2++xkrP6CNKv5dyr9XhKnyb0crOiXsr2FXISi8XGwX0=;
 b=WmWCl8bG2VyHHym2cV723v/orwFj0vxcn/vTUAC+BaCmH4VlxA5hm5kixG4s71ICgP
 a/WZt3hxG3IV0FkOEhQV5fvhIrkVabdQyZiKGNp/6UrXcmDHIkpCrsC4HQ7/GMEl/3pJ
 /zRrISQ+AJf8jgU5SDKaPb0IzcNXWGH379+HH2xWudZFutJm+A6sUplFrnsxa1tMfJCp
 6GwL6PqYC+5K8bdqKSJwacTepnob3EK2myQBkoMInr66AH03GVx8ZgYLuT+X7TNHLDJ4
 ylHF5BB1akiiU8YiJae0GRJebll6od6x0aFIvkErlIAQRhgPnJ1AvjeUQAoKdOQ+QG5F
 i3sw==
X-Gm-Message-State: APjAAAVLNj9Tb87dZvJY/uNZKY6bNkhUD6L1auh4xB2oar0Ttnx6B/3m
 ZT5jlEi7UkIAWTtF5AsaX4ytQTlR9MLw+OJV5PMAEA==
X-Google-Smtp-Source: APXvYqwU0sprBDCHakL2zVMQRHXTnNxdDRQk8ZlbDmIamB3l35Gm/92RaBfsatc0EdknZ2d0IyYwljuRw34Nks8ISoU=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr3610111otk.221.1562857129351; 
 Thu, 11 Jul 2019 07:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190705094823.28905-1-peter.maydell@linaro.org>
In-Reply-To: <20190705094823.28905-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 15:58:38 +0100
Message-ID: <CAFEAcA8wWwh7C6KN2YbWs0=Nb_ZxihVBFbSeFpMFKEnx5vQ9fw@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1] target/arm: NS BusFault on
 vector table fetch escalates to NS HardFault
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please?

thanks
-- PMM

On Fri, 5 Jul 2019 at 10:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the M-profile architecture, when we do a vector table fetch and it
> fails, we need to report a HardFault.  Whether this is a Secure HF or
> a NonSecure HF depends on several things.  If AIRCR.BFHFNMINS is 0
> then HF is always Secure, because there is no NonSecure HardFault.
> Otherwise, the answer depends on whether the 'underlying exception'
> (MemManage, BusFault, SecureFault) targets Secure or NonSecure.  (In
> the pseudocode, this is handled in the Vector() function: the final
> exc.isSecure is calculated by looking at the exc.isSecure from the
> exception returned from the memory access, not the isSecure input
> argument.)
>
> We weren't doing this correctly, because we were looking at
> the target security domain of the exception we were trying to
> load the vector table entry for. This produces errors of two kinds:
>  * a load from the NS vector table which hits the "NS access
>    to S memory" SecureFault should end up as a Secure HardFault,
>    but we were raising an NS HardFault
>  * a load from the S vector table which causes a BusFault
>    should raise an NS HardFault if BFHFNMINS == 1 (because
>    in that case all BusFaults are NonSecure), but we were raising
>    a Secure HardFault
>
> Correct the logic.
>
> We also fix a comment error where we claimed that we might
> be escalating MemManage to HardFault, and forgot about SecureFault.
> (Vector loads can never hit MPU access faults, because they're
> always aligned and always use the default address map.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is the one remaining patch from my earlier 'minor M-profile
> bugfixes' series; the rest are in master now.
>
> Changes v1->v2:
>  * rebased on master (function has moved to m_helper.c)
>  * fixed logic bug pointed out by rth
> ---
>  target/arm/m_helper.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
> index 1867435db7d..84609f446e6 100644
> --- a/target/arm/m_helper.c
> +++ b/target/arm/m_helper.c
> @@ -624,7 +624,11 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
>          if (sattrs.ns) {
>              attrs.secure = false;
>          } else if (!targets_secure) {
> -            /* NS access to S memory */
> +            /*
> +             * NS access to S memory: the underlying exception which we escalate
> +             * to HardFault is SecureFault, which always targets Secure.
> +             */
> +            exc_secure = true;
>              goto load_fail;
>          }
>      }
> @@ -632,6 +636,11 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
>      vector_entry = address_space_ldl(arm_addressspace(cs, attrs), addr,
>                                       attrs, &result);
>      if (result != MEMTX_OK) {
> +        /*
> +         * Underlying exception is BusFault: its target security state
> +         * depends on BFHFNMINS.
> +         */
> +        exc_secure = !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
>          goto load_fail;
>      }
>      *pvec = vector_entry;
> @@ -641,13 +650,17 @@ load_fail:
>      /*
>       * All vector table fetch fails are reported as HardFault, with
>       * HFSR.VECTTBL and .FORCED set. (FORCED is set because
> -     * technically the underlying exception is a MemManage or BusFault
> +     * technically the underlying exception is a SecureFault or BusFault
>       * that is escalated to HardFault.) This is a terminal exception,
>       * so we will either take the HardFault immediately or else enter
>       * lockup (the latter case is handled in armv7m_nvic_set_pending_derived()).
> +     * The HardFault is Secure if BFHFNMINS is 0 (meaning that all HFs are
> +     * secure); otherwise it targets the same security state as the
> +     * underlying exception.
>       */
> -    exc_secure = targets_secure ||
> -        !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
> +    if (!(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
> +        exc_secure = true;
> +    }
>      env->v7m.hfsr |= R_V7M_HFSR_VECTTBL_MASK | R_V7M_HFSR_FORCED_MASK;
>      armv7m_nvic_set_pending_derived(env->nvic, ARMV7M_EXCP_HARD, exc_secure);
>      return false;
> --
> 2.20.1

