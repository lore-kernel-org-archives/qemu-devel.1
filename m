Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7298EC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3554D24679
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2Y0vJEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3554D24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIt5-0000du-4d
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idIq1-0007OJ-T1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idIq0-0003ie-Pw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:00:25 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idIq0-0003eb-Hy
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:00:24 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so6692592otd.9
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OIlrXU6lyM9ZnlduZ/SWP+tiDufBK7vbrBlxSQqUrTk=;
 b=h2Y0vJEc63BT0Po91AQpuJDG5ulaHPGqmE/pntZ9fYiVFO506SWycVfIc8wM7NCdSq
 FAyNiVI/cce71FEt9iy/ulBOKL3x2KLP78XFFkD6i1TBdZsVScY9xrkrjSU3DMrzfn8L
 0UsHh2a16iR1ptMyLtZWehpAOOTlGbYB98TmSKh8awlSGFXyWs2T9j/4FfBBSuPcA6YW
 8D28o2BDuGnBQggI0/1EdPBYBn6w3/+HK0bnUIawzVNqR56ajrG27kbjJ7DTNZamdyug
 Q+f3qeNE3dSagCrnWyATRFnp7MmzANJLN+tuAJverS9T8DfazcLBOaXNHTQ6x2trSjG1
 OrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OIlrXU6lyM9ZnlduZ/SWP+tiDufBK7vbrBlxSQqUrTk=;
 b=VPkyA/4RY4lkRGhwI6VjGBV9SFmBkTEmjEAutGvgyAe0iPp2WVy2qmk2KW7rRdNqAb
 6+DT/H8fKDm9fyJe5JxaD6giVQHcg6yBQbp8eR45y2QZNihzOI+aV8zxhXMEuO6SUSGe
 vMKiR6/MRZOJylTwu+nqF5sXTz3E1VCWJshGofcPJClrUbVOQr0Gy/GXb/0prfg6/GPF
 a8XOKG+lOmc6XXVIImEM7A81h6YUznaW6eIV/VCD5cIxaaY8EOlMwwrP6SX38lGQPen4
 zW0fqaIrdSZtt7tkOMDiniaeMZ3wWj2x4RJ/bTODQCBq2m9RcEV73R3eCkwItqg7XKuc
 74Vg==
X-Gm-Message-State: APjAAAXkvySnGFxPufIS44Tc0K22eqyEWPnuyX/0yf2B0eTy0dDlRN+W
 snJovn4hEVYpGoUuntJUJNc5kUfYc9+adLUq5S754Q==
X-Google-Smtp-Source: APXvYqzz1/yABdt998ICfDzAZYBMOziW7jpF5xiDk9fPG67haOXC1IysRh8td6uHqUBExxV3BBC0ddasrG9KEB9FDZ0=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr11800037otm.221.1575658823641; 
 Fri, 06 Dec 2019 11:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-3-richard.henderson@linaro.org>
In-Reply-To: <20191203225333.17055-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 19:00:12 +0000
Message-ID: <CAFEAcA-R4Gb4x+uKDuezp62cpQcjeCrvZwhaFGBQTrBMEiZBbg@mail.gmail.com>
Subject: Re: [PATCH 02/11] target/arm: Add arm_mmu_idx_is_stage1
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 22:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use a common predicate for querying stage1-ness.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 11 +++++++++++
>  target/arm/helper.c    |  8 +++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 49dac2a677..850f204f14 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1034,6 +1034,17 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
>  ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
>  #endif
>
> +static inline bool arm_mmu_idx_is_stage1(ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_Stage1_E0:
> +    case ARMMMUIdx_Stage1_E1:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}

This definition of 'stage 1' doesn't match the architecture's,
which has a lot more than 2 things that are stage1; eg whatever
your renaming is calling S1E2, S1E3, etc are all stage 1.
(That's why those names have 'S1' in them: they're stage 1
translation stages.)

thanks
-- PMM

