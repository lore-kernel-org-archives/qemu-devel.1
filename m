Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC7C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC6720675
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUNJNG/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC6720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvSd-0007f3-4L
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icvG0-0001XG-L8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icvFz-0001xB-3D
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:49:40 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icvFy-0001rZ-PI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:49:38 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so3557559oic.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7TZrodYeXioGpPRAE8ETahiLdBZLUfn2Bk6fVVqCSEE=;
 b=HUNJNG/dr1YTRjWt3dX54M87sHzpPiOvZQre8eN8yoJpamPABH+Kh6Isj8UR3GJh0f
 mBL30w3DXmU2D7ge6BEDL0rCIl6R6EeVAx0MfF16CjbcCqjVfxGA/RJT9JY8JYqtl5+i
 LUO7SuZMqr5QA2DrFxo6G5zEV+ASvZdQecLM69Wrs/LmTeHdEw+PLa3KgIN0v5kLTrKW
 4XSw+n7YPYB/2OYM91K/WI3ULiMp4Np35xvQXUFBY/hK9VEKyNEqhhJxbsG+WJIQl5Se
 ZlYflHgu3NyCyGD8az9dwFBOKBXpG/Cj/7IKqPXdfmm6xj18SWN2YORi4PmpuNSmhQQS
 iyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7TZrodYeXioGpPRAE8ETahiLdBZLUfn2Bk6fVVqCSEE=;
 b=MJlUdHHHmI1e7pdlSP8LgJoS6z+ENBqlAJ1M16fhYZ4y7vqgTDA6/j3GspzlFv5eU9
 5UYj8oT+QmTB5Xd1nYp14z4afKOu2QbeNb02U65Nxi1vwIdyrufWYkCJYJQQvwbwcm+1
 X9uNQxoG6o1dpdFKnoSKJ5BJBRTDmBOzZdravwVz99VcP8fYFwKsIqoZ9JYuc7Y/5qTz
 v3fIvpN4uyRva6H4oLIEKuCG63hqiiHjQmLHUOPx2j2bAFkeFpizes7QQDhENTDk7SqM
 5ft7Ja5qRr52jWOgnplbsbuaZlK+TPAy/SMQ2fXhK/9EG4/aZhXnCYXk0Bp+EatZ8fjY
 deag==
X-Gm-Message-State: APjAAAWHv7UxQXRvV/8yDRdMzVdEONvAWSm2Wq0P7qeo0GKGKhpWhyQZ
 N+4zslXBmzFoASfQMmmDW3YD5uUVZgTV67hjLx6VhA==
X-Google-Smtp-Source: APXvYqxz4uaWdLhYj/w4g6/vR65niMndWEAx9/kARVQUdtjT6Y7737Yk4n5sFptfNJhhLagz90O2RyazktSQVyCUEQM=
X-Received: by 2002:aca:3182:: with SMTP id x124mr8488329oix.170.1575568177597; 
 Thu, 05 Dec 2019 09:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-15-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 17:49:26 +0000
Message-ID: <CAFEAcA9tHvwN-FbVWoMRfidGC8uJD6k8w=ucs537Gh-=CtmxeA@mail.gmail.com>
Subject: Re: [PATCH v5 14/22] target/arm: Implement the access tag cache
 flushes
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Like the regular data cache flushes, these are nops within qemu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f435a8d8bd..33bc176e1c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5978,6 +5978,54 @@ static const ARMCPRegInfo mte_reginfo[] = {
>      { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
>        .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },
> +    { .name = "IGVAC", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 3,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "IGSW", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 4,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "IGDVAC", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 5,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "IGDSW", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 6,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGSW", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 4,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGDSW", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 6,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CIGSW", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 4,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CIGDSW", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 6,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGVAC", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 3,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGDVAC", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 5,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGVAP", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 3,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGDVAP", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 5,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGVADP", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 3,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CGDVADP", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 5,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CIGVAC", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 3,
> +      .type = ARM_CP_NOP, .access = PL1_W },
> +    { .name = "CIGDVAC", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
> +      .type = ARM_CP_NOP, .access = PL1_W },
>      REGINFO_SENTINEL
>  };

Some of these, but not all, are conditionally available at EL0,
which means that for those that are:
 * .access should be PL0_W
 * .accessfn should be aa64_cacheop_access() (which checks
    SCTLR_EL1.UCI)
 * they need to be in a reginfo that makes them available
   for the insns-and-regs-only flavour of MTE

thanks
-- PMM

