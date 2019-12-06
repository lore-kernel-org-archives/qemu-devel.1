Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD53FC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405B42464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxDFTSLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405B42464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJ7v-0006Sc-T1
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idJ24-0001Ii-En
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idJ22-0000Lw-Pl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:12:52 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idJ1y-0000IS-Eu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:12:48 -0500
Received: by mail-oi1-x241.google.com with SMTP id l136so780385oig.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4IDYNjbqdK7xMKxmKZ6h6eYz3ed7jafNYm4jeAAwsw4=;
 b=UxDFTSLyDUpHXk00l/vZbZueEHuVUy9mHxy2KkiOseOWSvYQFEdQbHbH172W/5PFMn
 KDoNLnLtdqdD7O61aKUwbBd/A+ZezFfor6MYFi6aYThLj1qfjw3xo4aoFnWGdVLZUqfk
 C3M7u3jb327VLSfcZ5QaX6i2thUt1DebTAUXitUb9QxViHXATCmI4jwKr/06zkxAEXu4
 MrgADO7G2NpcaDvS8TrF8ymFYP/ggiqLAU7dZHGLrNjVlsJMbU10Lftf540MgyV+evS/
 QhrZ+Mg2vtZ8b7boEr3C16chI1PiMXoH385D5mpEgbZ/Tl09TTk/PNC5seURaowYc28b
 1xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4IDYNjbqdK7xMKxmKZ6h6eYz3ed7jafNYm4jeAAwsw4=;
 b=CpiDROcgC10sl/T52broy5g2dBkqFz8ZqcXSbDU0OF529rTVm4QVKaw9tBc9wD95rw
 959GiC7Wm/1uLEhtji+4DY6J94a8RuHy4ymLtthEbGDgH4Lk7tn5yC3N8NIfk3TJ2rRv
 3NpwAjSsYTJvwlSeI2+Tbp2fzH/VfV2YLAmdUKKdBX3mRqneZ5/NsqLkkP8OrJx53BoB
 sqU/8mZM1LG/ulBstjl/rvxW6V/5JhZHThKjl8N/FES4yclfrQ1XNZzgQezURcIbBiIW
 RKgq9q4hUUKngewGqjH013dY6Dm9OJ/3UHt5SFkaTCKXrIKWzkMXhpybijlBjAaMyGBT
 rsrA==
X-Gm-Message-State: APjAAAVO/koSiivfYSZ874rg6rQzNYOgG3FSVJxRxZsZXXe9UkjNcjB6
 Q6LKEwyLcVEmyYIh42QB+1fuGpqIRUiWR5ufTuv6Lg==
X-Google-Smtp-Source: APXvYqy/i0lxH8Kt8PUgEY1TtQNck2kimjstF3Ob4x/zVv8EIRg4snwqOoo6WhfsDyPXLib/dqiH46JpTBBeaJuESeg=
X-Received: by 2002:aca:f484:: with SMTP id s126mr13104113oih.48.1575659564431; 
 Fri, 06 Dec 2019 11:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-9-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 19:12:33 +0000
Message-ID: <CAFEAcA9n7NpLu6wA-Fs9Hcp6UO_5EB1Snwmehgp8-BoyKgCb-A@mail.gmail.com>
Subject: Re: [PATCH 08/11] target/arm: Enforce PAN semantics in get_S1prot
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 22:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If we have a PAN-enforcing mmu_idx, set prot == 0 if user_rw != 0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 13 +++++++++++++
>  target/arm/helper.c    |  3 +++
>  2 files changed, 16 insertions(+)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 2408953031..ab3b436379 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -893,6 +893,19 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
>      }
>  }
>
> +static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_Stage1_E1_PAN:
> +    case ARMMMUIdx_EL10_1_PAN:
> +    case ARMMMUIdx_EL20_2_PAN:
> +    case ARMMMUIdx_SE1_PAN:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  /* Return the FSR value for a debug exception (watchpoint, hardware
>   * breakpoint or BKPT insn) targeting the specified exception level.
>   */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6c65dd799e..a1dbafb9b2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9444,6 +9444,9 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
>      if (is_user) {
>          prot_rw = user_rw;
>      } else {
> +        if (user_rw && regime_is_pan(env, mmu_idx)) {
> +            return 0;
> +        }
>          prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
>      }
>
> --
> 2.17.1
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

