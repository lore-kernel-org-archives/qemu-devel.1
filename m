Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B769C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4355821835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxE9KhRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4355821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJ53-0003YU-M7
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idJ0P-00080O-Qc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idJ0O-0004Zx-LX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:11:09 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idJ0O-0004X1-D3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:11:08 -0500
Received: by mail-oi1-x243.google.com with SMTP id 6so739569oix.7
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=po+XPFPyYEqQ51zhdmTvqeYFugK0GQa0LGRWhjgkzZA=;
 b=sxE9KhRYcM0q9qQh0UCVG3mV5M+ymx1T9RJs++RjsKHK1CaZ4rVoXCEVPoGqq1xVbR
 PwG5sVeZGWue40PmuTPEOHSGS0Rm7J7bI4dvBzPHRzOrXVeR75jfbE53m/23GVetloTU
 6Cgsus93WQic5EnrVSg4ZR8vRT47r7S3gQWJ62+cfKT3jopbWlt/DgE8spJsia3M85sY
 B+vIha+WbahBZhuz6RdT6lyVu9ifITu8zFoyo6UWRJR2/Aa13LC6fZ3BWIraYBv15ofV
 YcDqNoTMVm88sB428zShnTG4P6phOmAnbzdy+JEUK1dL1LJLKWuPxAg/0bfRJL2B8dQI
 7d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=po+XPFPyYEqQ51zhdmTvqeYFugK0GQa0LGRWhjgkzZA=;
 b=lSUy6V8cWgLBoDH/W+cWAsX2mgw0Mok87YYfu66l/x/8eRViRhe6vHjveOiM7MgH/M
 0yhJMHLwA3ETUnsfUcYUuFzUhid4iqnpQTLGAN1FwYZHajYG5awq6H/UdDABqSILtZUG
 BKEJB/a6ipvfDNKBzVRKR6LLcSgdb0JqYDKtrMy1ciZqHiwHuUwS2hjIx7z1NhV9J83k
 NouPPS4zrF4v/asZfUsJRMWwO1F0iBYDvHE5fDxfiBBQA6qimCX4LyAO4PefwfiRPA9S
 MSLLNdE3AgISu2UzBkCFnXPhFL4UhiAorgz0MqNM93+/+Wxg3GGCayzjlkfldeWmPq6G
 RdPA==
X-Gm-Message-State: APjAAAVE4bzYQ+pEVIrgh0nUewhhZOZZIpP+vXCp3uSk13RmtR6QR1aM
 xrmxRvphNMZrUr3FP8qGvoX9Qze+xTXJe8l8zkrBUTkF
X-Google-Smtp-Source: APXvYqyw4p1heD1qa0yFY9Y+U5yq10lo6UTE2ms69/Idf1lOkFqa0S3GEd1ZTJzhNu0aFW7r/u2DGh6zFgaDPRF5PGY=
X-Received: by 2002:aca:f484:: with SMTP id s126mr13093482oih.48.1575659467691; 
 Fri, 06 Dec 2019 11:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-8-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 19:10:56 +0000
Message-ID: <CAFEAcA80Qyn8WDqzDaoSdTUtULc+5z0jDpwMepWcJuFpTT=rqQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] target/arm: Update arm_mmu_idx_el for PAN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 22:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Examine the PAN bit for EL1, EL2, and Secure EL1 to
> determine if it applies.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 512be5c644..6c65dd799e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11770,13 +11770,22 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
>          return ARMMMUIdx_EL10_0;
>      case 1:
>          if (arm_is_secure_below_el3(env)) {
> +            if (env->pstate & PSTATE_PAN) {
> +                return ARMMMUIdx_SE1_PAN;
> +            }
>              return ARMMMUIdx_SE1;
>          }
> +        if (env->pstate & PSTATE_PAN) {
> +            return ARMMMUIdx_EL10_1_PAN;
> +        }
>          return ARMMMUIdx_EL10_1;
>      case 2:
>          /* TODO: ARMv8.4-SecEL2 */
>          /* Note that TGE does not apply at EL2.  */
>          if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
> +            if (env->pstate & PSTATE_PAN) {
> +                return ARMMMUIdx_EL20_2_PAN;
> +            }
>              return ARMMMUIdx_EL20_2;
>          }
>          return ARMMMUIdx_E2;
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

