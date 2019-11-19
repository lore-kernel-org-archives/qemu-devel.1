Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8127C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84479222A0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdJZ4Bpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84479222A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0AF-0005Fr-FC
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX09L-0004SN-Sw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX09H-0004wU-Cp
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:50:19 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX09H-0004wF-7L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:50:15 -0500
Received: by mail-oi1-x241.google.com with SMTP id a14so18320608oid.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y4SuE2xg68j/eA79AQrvLVGegerOzUsaDYhxMDwOTRU=;
 b=zdJZ4BplflonYJtKtGDGW+cDHK2CWNgCmGRZc9tuaixZpofBA6y6KjUrcBgI4JeiFE
 z3UDUhYWUZ30NSnMb3Wj8xdpkQ7D6dEPRu+cOA0vJMK6OfAubhMQDpW8FrKpOk6w1P5Z
 exKxT9e+HyC0OeS+ypQF61OO/JFR70Z+Jnvo/MP7ou5iSmQVJ62Imn9091d4VSqtwiUX
 SNAn9Lehcbpftn+oZQUBU53hRjxw0/3OlBOJsdHS4jpKMAOeLq2mZXYp5P3vWj4LNYsM
 nT0+inLbMNbeOimDWPS4zbiqy09XVDZPHWy5f2CQhEO0Y/f+WNtHKRcIgELn1vfimA8Q
 4gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y4SuE2xg68j/eA79AQrvLVGegerOzUsaDYhxMDwOTRU=;
 b=Ma+6xxPS98v3sBcnoPxuhLlpgu6I17J+vyZ7X1ct+JS5Eqv8BTxjCx0SQhc8bzJmMk
 OaxBNFBTexzzBAHq5Qv3ZsIhlLJzdh6W6rJetDdD5ttCupPD2rX5WKIRXekSPeXEClt1
 HGbfEnoMXjOIUiSJgZc4BasW7SLzQMAxPmaBLrn02Agj8qamTWPBtt34dZ5XgRt/NeWQ
 RNkEyhO14mUN21OZ8YOmgXFx40CgXtT5bLcKVyoHoYjTTYAt9LqC0013cJVoJh9DmDj8
 qHWZn5f3APerAPMgxRXgPl7K6TU4MjtV77ghI4y+wwLoG+ccUzofhZEHR2VZmJGKXG6L
 TyEw==
X-Gm-Message-State: APjAAAWNG27/MdiEAyo6xHy1RO92YBj3bOMSFcCZq8yD9o+FfsqiB6ns
 w6dl50c46xTAiRQlxbm8+2y4G2f0p1KZ4fltLzUY+Q==
X-Google-Smtp-Source: APXvYqyqJtt/XpQTHu+kJzAupH1hNDNFnoXFSaq2kwh4sp5QLwxJdaUdsKOBiZPQZ+p6FTiuWmy4OWcdvwXGUKIM+rs=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr3205374oie.146.1574157014139; 
 Tue, 19 Nov 2019 01:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20191118194916.3670-1-richard.henderson@linaro.org>
In-Reply-To: <20191118194916.3670-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 09:50:03 +0000
Message-ID: <CAFEAcA86i=q7oBVEEmKGvb-7ckcPm8MWAJ3=0kLc-ZUDfSsfPw@mail.gmail.com>
Subject: Re: [PATCH for-4.2] target/arm: Support EL0 v7m msr/mrs for
 CONFIG_USER_ONLY
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: Christophe Lyon <christophe.lyon@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Simply moving the non-stub helper_v7m_mrs/msr outside of
> !CONFIG_USER_ONLY is not an option, because of all of the
> other system-mode helpers that are called.
>
> But we can split out a few subroutines to handle the few
> EL0 accessible registers without duplicating code.
>
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h      |   2 +
>  target/arm/m_helper.c | 110 ++++++++++++++++++++++++++----------------
>  2 files changed, 70 insertions(+), 42 deletions(-)
>
>  /* These should probably raise undefined insn exceptions.  */

This comment is now wrong -- all the 'dummy version for user
mode' helpers below it are either "known to never be called" or
have a "works for user-mode" implementation, so we can just delete it.

> -void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
> +void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>  {
> -    ARMCPU *cpu = env_archcpu(env);
> +    uint32_t mask = extract32(maskreg, 8, 4);
> +    uint32_t reg = extract32(maskreg, 0, 8);
>
> -    cpu_abort(CPU(cpu), "v7m_msr %d\n", reg);
> +    switch (reg) {
> +    case 0 ... 7: /* xPSR sub-fields */
> +        v7m_msr_xpsr(env, mask, reg, val);
> +        break;
> +    case 20: /* CONTROL */
> +        /* There are no sub-fields that are actually writable from EL0. */
> +        break;

I feel like somebody's static analysis is probably going to complain
if we don't have a default case here:
   default:
        /* Writes to all other registers from EL0 are ignored */
        break;

Looks good otherwise, so I'll apply it to target-arm.next with those fixups.

thanks
-- PMM

