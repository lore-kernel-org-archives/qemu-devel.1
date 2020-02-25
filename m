Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AF8C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3CA21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFQ4IyAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3CA21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a3E-0008Dx-Q9
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YuM-0002TE-DI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YuL-000798-9Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:01:50 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6YuL-00075q-1o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:01:49 -0500
Received: by mail-oi1-x243.google.com with SMTP id l136so12282754oig.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1J7xOOcrZGCxuHJzVvyA3UwZSYQB/R1Hrc+5mY2Ikxg=;
 b=EFQ4IyAh7kPUGzXPYO/c8I7bE0S2FNGyrtBqBB9s+aUc6YF0+HFJMlyC3xh9wRsxeK
 qV32gLkdEe7c+Vfzao/fVEaohQrtpBhxYwjpsRDE0O8JE9CibD778cKvn6uLCBEGY7bG
 3hEaFsO3T1cM+xQp5uLtiw18I1Nc+aysKW1mRDtAXpdF7PRnLZ996U+i0aN7wh4Z7bUG
 s4c+aFIJIvbyE9xFFa0Pe2UhHBZe4m64KL/wWwMuChtz8dd0VCluox7wOYYc8+lnB35d
 E3HixOvYLjKfxCcfRBzG/g3WBfNOmEXrazImRpwUX2rKmWniQCSr6hmWYQ7mwk/By9f/
 YgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1J7xOOcrZGCxuHJzVvyA3UwZSYQB/R1Hrc+5mY2Ikxg=;
 b=s128P0+t6sjghfSYMgwhmq+aeiGod5gRkKSqgthnMZWhXWq/phoJj0tU6U33O2GCky
 VUfblmCbXO5j4+IYYoOPZlb9HcJo1tl+E47Nt4vaWdxKn008ly6NtpX3A4kF6RJhCTky
 QBr4CjGbuMg5Q5EIDBBG/TLuQUqv+ruIai8bSik4eIMhl1ip3H4RHvDkLgVCOr2shhmP
 hkUX0zCqhnCn1PHgavEvqMbpn1IQzESxsDWDv8wVxA/ikART5eFK91aC8kkDFbsDYVfZ
 Sk3N8yJ5jmhiL6VMGSYyDKeALxZGiyCBmjs/FxHqnwss0tW+QDV4GEy/ie1PyFBspDAh
 RReA==
X-Gm-Message-State: APjAAAWIeUZMZB/G2KT1T3Z8PFOFWQiqhcuhoXjcaC/1h2y474LiRl+h
 QSSxTs17yyGdk2nCeephvIEufmk0VFIvVry/LUuYAw==
X-Google-Smtp-Source: APXvYqyGv7zpFxnTiw3Ch5Dpi8glCsLacLoWIl8z+xJj+HTd5OLWsWNa23pPMEJjkLE01R/eMHoWtfyg0Bt7lGH/WVg=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3365366oiy.170.1582632104647; 
 Tue, 25 Feb 2020 04:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20200218190958.745-1-richard.henderson@linaro.org>
 <20200218190958.745-8-richard.henderson@linaro.org>
In-Reply-To: <20200218190958.745-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 12:01:33 +0000
Message-ID: <CAFEAcA_QHoRcfv0oLgxNsuEOaRJOoM9sQHqXZEP-tDeJrziVYw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] target/arm: Honor the HCR_EL2.TTLB bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 19:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This bit traps EL1 access to tlb maintenance insns.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 85 +++++++++++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 30 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 21ee9cf7de..87c0cf4a96 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -563,6 +563,16 @@ static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
>      return CP_ACCESS_OK;
>  }
>
> +/* Check for traps from EL1 due to HCR_EL2.TTLB. */
> +static CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                  bool isread)
> +{
> +    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TTLB)) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +    return CP_ACCESS_OK;
> +}

The set of operations this traps differs when ARMv8.4-TLBI is
implemented. It looks like you've applied this access fn to
the wider with-v8.4-TLBI set? (eg TLBI_VMALLE1 is only trapped
with ARMv8.4-TLBI, not without.)

thanks
-- PMM

