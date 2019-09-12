Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEDEC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8ADB20693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIMbAWTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ADB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Rcy-0006L5-OK
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 12:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8RZp-0003hC-Kh
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8RZo-0006rn-Am
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:04:09 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8RZo-0006qg-4z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:04:08 -0400
Received: by mail-oi1-x241.google.com with SMTP id 12so6347730oiq.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s2Jjte3IicFNSnIdujoo5LTOVDQZOZvERHNYPfd4lRY=;
 b=uIMbAWTrQTxuSnw2rOysr7njJRDPrVn1Z0zm28mGWX1BxNocTSNqwe0NBResti8bsz
 2HOStbJX9TvZbkH/++q82DruL4p+SR/w5hzPSbI9nDpl++OcCtLIEDzTnJgtkS7l7xX0
 9g2zJ7XCBudTQpgnS+Xq5bePy14Z0IIrsyCdKGHk17ZMzA5pN4eBn0TYTGGpQiku196z
 p83m6T/WpU73PRTA87KzY4G/IDHmVMES0q7zfiX6znPKnV51Or46PdpkDyVashfCvKFe
 ktk3JpuozFgME2Q3WeKU5aJW02qczA5dSNCkM365hzKhi7rjBB6sNbMnf6ZB+4bML4vK
 jatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s2Jjte3IicFNSnIdujoo5LTOVDQZOZvERHNYPfd4lRY=;
 b=ReBOCVryt86PqShBQa2FuEavLoRtF5MLOs0TDxDRRQpq7v6YG6qNcJ7wdLSR9E7Shw
 sJKBMoKHaqqX8hCHXhuEWPOokcXD6/KsLUWUPk8kFVWMD//B8+Gv2TjGIpnArVN/k9iI
 sQdFkuMHS7AyZxrCC0tpLNYwpRNmfwHQ/3gos5DTyKSB/wCBvvsnVBJ/ZqYkrg8OLIxW
 L/PFcEQXjof28NtAd3dhQceErnEaFyZ/jZotk1cgTXuKMf8S0WTRUGsTb4FukdtvZdAA
 4evblIdrRKyjgKkHU2EsW3CFamxt3TdvYmSUmEjiU796noXIpu8jJKDIvfVSHeA7UW2C
 ibHA==
X-Gm-Message-State: APjAAAU0nFmPFYRb5oRzcpyAPnvJaeS/cDU5SJQSempjBf7dyj1ZkeI3
 KIQp8tAcG7rUT3kVIIhLPtW/Rf7NCVhNPAThaTZ17A==
X-Google-Smtp-Source: APXvYqwIq5wHUMeukQWK13By24Vv+51Jxa1CuiQzMt6Sgyo0k8HZPSGYFmAvwM4Aow/UIip05tPDArOnoiM3AwX8+sY=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr788702oib.146.1568304246638; 
 Thu, 12 Sep 2019 09:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190912110103.1417887-1-luc.michel@greensocs.com>
In-Reply-To: <20190912110103.1417887-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 17:03:55 +0100
Message-ID: <CAFEAcA-WO=O5zwRDQoNz2zT4sx61j8Jy5px0uFPiWgF_JUpa+A@mail.gmail.com>
To: Luc Michel <luc.michel@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix CBAR register for AArch64
 CPUs
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

On Thu, 12 Sep 2019 at 12:01, Luc Michel <luc.michel@greensocs.com> wrote:
>
> For AArch64 CPUs with a CBAR register, we have two views for it:
>   - in AArch64 state, the CBAR_EL1 register (S3_1_C15_C3_0), returns the
>     full 64 bits CBAR value
>   - in AArch32 state, the CBAR register (cp15, opc1=1, CRn=15, CRm=3, opc2=0)
>     returns a 32 bits view such that:
>       CBAR = CBAR_EL1[31:18] 0..0 CBAR_EL1[43:32]
>
> This commit fixes the current implementation where:
>   - CBAR_EL1 was returning the 32 bits view instead of the full 64 bits
>     value,
>   - CBAR was returning a truncated 32 bits version of the full 64 bits
>     one, instead of the 32 bits view
>   - CBAR was declared as cp15, opc1=4, CRn=15, CRm=0, opc2=0, which is
>     the CBAR register found in the ARMv7 Cortex-Ax CPUs, but not in
>     ARMv8 CPUs.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  target/arm/helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 507026c915..755aa18a2d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6740,12 +6740,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              ARMCPRegInfo cbar_reginfo[] = {
>                  { .name = "CBAR",
>                    .type = ARM_CP_CONST,
> -                  .cp = 15, .crn = 15, .crm = 0, .opc1 = 4, .opc2 = 0,
> -                  .access = PL1_R, .resetvalue = cpu->reset_cbar },
> +                  .cp = 15, .crn = 15, .crm = 3, .opc1 = 1, .opc2 = 0,
> +                  .access = PL1_R, .resetvalue = cbar32 },

This will break the Cortex-A9 &c which use the 15/0/4/0 encoding
and the un-rearranged value for this register.

I think we need to check through the TRMs to confirm which CPUs use
which format for the CBAR, and have a different feature bit for the
newer format/sysreg encoding, so we can provide the right sysregs for
the right cores.

thanks
-- PMM

