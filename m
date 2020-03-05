Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69441C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316E820732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQDu4BhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316E820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rQV-0003vu-DT
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rPa-0002tg-N2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rPZ-0004GK-Hw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:23:42 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9rPZ-0004Fe-Dd
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:23:41 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so6144592oig.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 06:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s+7bS6l8n8+BhRIGmgGOgT4La+ye5ARyZS/sNnK/XjA=;
 b=hQDu4BhMQpYebD+Gc97l4ygie7llkfAsopNrUeaxpYID7Jzd+7aOhicpWqmai37/hH
 hsr/wVQkmtdqS3SEM9f6bupcGIzgijzVuxnjkEhShtnKHxmyFtpqrt6PlDjlT6SMP4x6
 bvZ7Z0aiabLjlXbcC5GScC5XSIEbl96tzQP7IvhJ2dj+kQ42EKVPdND8gC2EJSO37gM2
 XJ4gflk8W8pmczud2tAWIRjp9HhlEpmG/9cEjtdiKYlk+WmvcOATyM1Pcb1fqr1QhPzy
 6BA06LeQ0egI0MGPhvpGcxwnRhRn0mlpyKcke6/xyX/gbxCaOjac3YUp22yoTydiJF6V
 BoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s+7bS6l8n8+BhRIGmgGOgT4La+ye5ARyZS/sNnK/XjA=;
 b=hYjWmFNDfnAeB4prv6/66Bi4dbsVDp4BPVwpg7OHd48z+iyJjtfOlvj6sd3qShw/A7
 t3QAyEl4Drlu0m1N/dh0nmQeVgU6XkBfU79vfil89Cmq2PY3jIr9zk4g5aB7AjYQBPH0
 /1nAiCUiY7/UoqxlgbuhtP66K65pj8K/25ieFFfCYSQhgVxTCHgi7nPumHqMTvpBIuQ5
 siBKSdEK7aoImBDL/yEWEJER6Hl3VGOQDHTOPIqh/hgqoXTeqCFWnc0KCidvJPFEcg1K
 jXFI1iGTcynYSlPKc+/e0JS5UK6Cv+cUG4AZicvkbzAYdldYw9l6P0coANub84EORoCp
 XVPQ==
X-Gm-Message-State: ANhLgQ0i/D9qtRY/dG3N+7rd3KBCCnV+1jdasoU1B4ph9Ic2hAUOrOe5
 RsIXLC+xKCLMq7uToj1dxmqbH9QWorc4QKKIHTve0w==
X-Google-Smtp-Source: ADFU+vtTGvNEKMOX6JUJHvAzTNu//WWCUedwkkD3VQPFPPP3CAvSlSh3CjMP28xjrdn1hKIfHec94ECM6+hAcbDp+gQ=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr5602546oic.48.1583418220700; 
 Thu, 05 Mar 2020 06:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-4-richard.henderson@linaro.org>
In-Reply-To: <20200302175829.2183-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 14:23:29 +0000
Message-ID: <CAFEAcA_ZRi+F6+KH7y_C_ZbAGjLyDWd9LkbtJkLn6mFNjqkaWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] target/arm: Introduce core_to_aa64_mmu_idx
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

On Mon, 2 Mar 2020 at 17:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If by context we know that we're in AArch64 mode, we need not
> test for M-profile when reconstructing the full ARMMMUIdx.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h     | 6 ++++++
>  target/arm/translate-a64.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 9f96a2359f..e633aff36e 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -783,6 +783,12 @@ static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
>      }
>  }
>
> +static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
> +{
> +    /* AArch64 is always a-profile. */
> +    return mmu_idx | ARM_MMU_IDX_A;
> +}
> +
>  int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

