Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774AFC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4584721823
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHLCQO0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4584721823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHbo-0000Vl-WE
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idGwx-0006Cc-J2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idGww-0001CS-7j
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:59:27 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idGwv-00019f-R7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:59:26 -0500
Received: by mail-ot1-x343.google.com with SMTP id i15so6364860oto.7
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ozxco/v0ATIuYp6SAGpa0LpaJs8MiQDfwlnY4cKEoYg=;
 b=SHLCQO0FmlhFtt5vysY0yR/duk8SdbonpoIqW0pf89HTXBzuAZEeDp5nsBLUfiKlx8
 nQKThrB42gZ/oPaw4XvE1Eh3TbgDkC9ekoH3tJsKvkk7VewpVF3v4VuFFbGAJxCY3V6c
 FqlZR5Tm9Jo1u066l0bPqI6cZ1ut0zoamoyHFFKKrw8nUi0hTM85+bAU0PeNUAUFx6Mb
 ap5+WkjwHli/aKF5wApbRQDVc9wL/stVuJC79RIj3VIyB1zOlDhxySEMzbrjsluBOuWs
 Z5MOMaO7PsLfzmR8l/bHtWAaQZRbi1WrCQ2L5XP1I3SPkefmeCyzmVZI6LwUO60TxUIC
 oU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ozxco/v0ATIuYp6SAGpa0LpaJs8MiQDfwlnY4cKEoYg=;
 b=tETWVr7BKBdx3XGTCCx32Ys+HDcat+qlYlrUen6xBetbUvCFJYR2g/IDFXVHnl6Cgo
 ACL0Qj5zkTwRh0dG59CQdD50MdNZnh8pwXMWsNGVVBzGwBo0uaU8yv/ar+qgg2p8lwpk
 /9srsvv2KyX9beinmk8hm2Vz7U1vuI1N3k/dG9rVoyLT1oWqXlEwtdM6qxclocIZS+6+
 nfo8VlhDrPU3skvkoii2GwlPNXvcSThchm2L3vCUnHm4QECPJEdE6xDkhkZNI6378K4n
 PXR1BzTiHK5wwcMSyEKBigLBwTKLNEDjQ4+LnAT/7FH1R+rCjD0n2WIJl475WfsKyryn
 NL2w==
X-Gm-Message-State: APjAAAVwCRuIkeXIRiCV7q7FmQefL3CSn3P1bXfIUP0MY5IG/W+F4nHb
 KQjic0H1qJCObE1A1Ieke9bSyu5WvChNtP2ap+vFCfP5
X-Google-Smtp-Source: APXvYqwws4N+eknf6K3KmhOUqqqRohqsJzOl2DvMR2n+sPQauEDq1gpCe0wALo+OePOSEcRHupYZP2VToThNrr4f9sw=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr11941678otq.135.1575651564776; 
 Fri, 06 Dec 2019 08:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-32-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 16:59:13 +0000
Message-ID: <CAFEAcA8DgMK8GR1MHLMKLrxg+H2dEE7yZuYqRfHx-tqa_NwPHg@mail.gmail.com>
Subject: Re: [PATCH v4 31/40] target/arm: Update arm_phys_excp_target_el for
 TGE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The TGE bit routes all asynchronous exceptions to EL2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b059d9f81a..e0b8c81c5f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8316,6 +8316,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
>          break;
>      };
>
> +    /*
> +     * For these purposes, TGE and AMO/IMO/FMO both force the
> +     * interrupt to EL2.  Fold TGE into the bit extracted above.
> +     */
> +    hcr |= (hcr_el2 & HCR_TGE) != 0;
> +

This only has an effect if HCR_EL2.E2H is 1, because if
E2H is 0 then arm_hcr_el2_eff() has already forced
the AMO/IMO/FMO bits to 1. But it seems to match the
way the Arm ARM phrases things in section D1.13.1 and
its accompanying tables.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

