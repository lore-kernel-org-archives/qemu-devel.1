Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7279BC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C75620578
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzebcQ5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C75620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6Hb-0006dF-GR
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6H8-00067a-RP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6H7-0006NX-Po
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:05:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs6H7-0006M9-HJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:05:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id w196so23992163oie.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=USX6y8+1fsXPlwx9uOCSISQRlydjOW3x000APgYHOHY=;
 b=UzebcQ5BPjIKHmFrsqS4kZb7gWxpB0U0A/8pT2vT5RtKJifEgrRjby9litqO3PTOo2
 r4wz6HE8Vs+dwPLoX/xkdImJY/JQbH8Npbri6I3UzG5nmm9z69eJOVWh9dufmHbOHDwp
 YTUBWkGlgN/lLGrUGHJANOEerq4MXjM4pppzP7JfFYRtn1JCaR1k2RXitJMcEC71lEbt
 I7/DRGgIDh5IjDLrCkyyZ2sFBP0Y+40nWtsAwQdUwIvspnZB5v6/1kBB90C/5g1jXrJB
 NibXDDXXXAHulfFGjvILs0DQHsgW5+rtrpcnqy3e9+p9OdF3nnuOWw6nyahVUgylNl3C
 jRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=USX6y8+1fsXPlwx9uOCSISQRlydjOW3x000APgYHOHY=;
 b=GibaKzaVrtFhu/twgaNNd1fTuc80QycRqjD1NT416qVHxnur8UB5PlUANbi1zQ1vmN
 D4JeVq/323IUdq3OAf4x1SxKuTD/Frt5jxPRYa88JDBtB+YykO1OniujhwhHzosjXQFR
 7q4cSEhqDsQ3avVfEoAHwIQr/gVkOQIzJMDyHmb1sAIvT2safMFMl/22XzGYDOHZKpRs
 6g5jtxpCj6lLrYMXJrCTsXcdcG1l52mU+Ce/p42Uo4M8UlfdHenFWitgEThDmDQYh7oC
 CRUyPj6yvIbYuOkKPLHV/QmQKpbhkWC6brGXAcjajZEvCt/ZaoTM8S9S5VNzn3/8NMet
 1UfA==
X-Gm-Message-State: APjAAAXO4KiNaih4ccA5b2hvhjtVwnLeExYj3Qzea+1ywK0lTG1evqpJ
 G+LB9VWfnFl3tJ8IlEzsvawd6J/ZzdbenrbcVUJRaA==
X-Google-Smtp-Source: APXvYqz0IdKAfVjqUVPP4+n2JcQrQ1t0ugQpGM3Ak8HNssMq2qiPgkmGP0MVrFS0P/3DeziFDdbl1269BepFrF58FKs=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr55702001oib.163.1564409116669; 
 Mon, 29 Jul 2019 07:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-7-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 15:05:05 +0100
Message-ID: <CAFEAcA_kmuX6bxR50eU_3nTdRcjON2nVTqVWiRamSRe6jui3ig@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 06/67] target/arm: Introduce pc_read
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We currently have 3 different ways of computing the architectural
> value of "PC" as seen in the ARM ARM.
>
> The value of s->pc has been incremented past the current insn,
> but that is all.  Thus for a32, PC = s->pc + 4; for t32, PC = s->pc;
> for t16, PC = s->pc + 2.  These differing computations make it
> impossible at present to unify the various code paths.
>
> Let s->pc_read hold the architectural value of PC for all cases.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.h | 10 ++++++++
>  target/arm/translate.c | 53 ++++++++++++++++++------------------------
>  2 files changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index a20f6e2056..2dfdd8ca66 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -9,7 +9,17 @@ typedef struct DisasContext {
>      DisasContextBase base;
>      const ARMISARegisters *isar;
>
> +    /*
> +     * Summary of the various values for "PC":
> +     * base.pc_next -- the start of the current insn
> +     * pc           -- the start of the next insn

These are confusingly named -- logically "pc_next" ought to
be the PC of the next instruction and "pc" ought to be
that of the current one...

> +     * pc_read      -- the value for "PC" in the ARM ARM;

nit: this line should end with a colon, rather than a semicolon

> +     *                 in arm mode, the current insn + 8;
> +     *                 in thumb mode, the current insn + 4;
> +     *                 in aa64 mode, unused.
> +     */
>      target_ulong pc;
> +    target_ulong pc_read;
>      target_ulong page_start;
>      uint32_t insn;

Why target_ulong rather than uint32_t, given this is
aarch32 only?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

