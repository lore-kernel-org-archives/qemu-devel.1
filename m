Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94BFC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A877321835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dh0rYjcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A877321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvAh-00066z-Th
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icv9K-0005VJ-EF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icv9J-0001hu-2n
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:42:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icv9I-0001d8-Q4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:42:45 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so3321151otc.8
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iNUL6o24JTKX4/e7ryKKlUun/EEBdrrjt6MWlFZHtt0=;
 b=dh0rYjcgJ3RUdG6Gi37DLPiYYqEgTj835qJegCy0kyY+lDtuZ6AKZ/RlvoBGc6KWUW
 eBHRoQ8REevtPRuvV8kANU8dLniuLz7/IAw1gpX/vBEGKoEf+kXVzpe5pbXy6MABH43U
 74s1C5XjKl0rVVXtaDYOiHeLHPmbLFZ9BU9BTlgTzgGs/0ZeLZF9VdA3JuHWdMayVLnw
 X3oDG5Ipcffb9bsqxmEZ0MYyd5k+p+LKRFEXcImh9Y5yAtGfjym8CCqLMrM4RlS1YC+G
 YRn0RanjRCXuwSKKdUS4UgHXTqF8Zmhe9ydXg7pAe9rhXXQZ4DDYvxrFsh9RmYtm8L1j
 /39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iNUL6o24JTKX4/e7ryKKlUun/EEBdrrjt6MWlFZHtt0=;
 b=R+f/8rHfIOnb7PCpPkxinTeNhBHcsH9PXUTvYBGpODf6g0jnV/Qj3H144rjl6Pa1it
 0wBBeAUiJ0FS0uDTv3wn4UGckFkDck62z910foMesbIcEL4WJ8Qb8Z4K8U8oRA4Sp1g7
 fgsvkwqmyIX6gvryD9gXnLuLYZOIgA/lWr5U2X/ESx6JByxS//69nQopufFUeckluFLN
 AI+6KNVL9tbaBqtrTPzZxpN+c1v8FyriX7R2eSNvaXwfmvcjTNEZIVfCYntF+kRTEqcm
 Pmbw6ZIKzyXDxKkSQOUjkkppwmZUFUjZI+YXJCkLtBHGgxku5TzRPdbNrZrNpr+Llkfu
 cydQ==
X-Gm-Message-State: APjAAAXYM6cZZoq8RcL0qTjMPNvmbgilRqe022yGlPUsOlA3ULn78NQi
 VCgUwV9kXC/4B4wLsgy+3fk9a6OA1avmnYQLKniz6A==
X-Google-Smtp-Source: APXvYqx6SnlrN6LSAkuJjUGwQ8ZF+dX5PfYkn6xK3jgnd3etiGbxAubZMq5Ngau/EAcncoEzkJRnNCZf3483Jj6BemU=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr7043345otp.97.1575567763730; 
 Thu, 05 Dec 2019 09:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-14-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 17:42:32 +0000
Message-ID: <CAFEAcA93YL0mkN+uMpOD12U1S6uoPNqpkPZ+EmDabNAQC+m-Sg@mail.gmail.com>
Subject: Re: [PATCH v5 13/22] target/arm: Implement the LDGM and STGM
 instructions
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Require pre-cleaned addresses.
> ---
>  target/arm/helper-a64.h    |  3 ++
>  target/arm/mte_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c | 42 +++++++++++++----
>  3 files changed, 132 insertions(+), 9 deletions(-)
>

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 4ecb0a2fb7..4e049bb4aa 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3592,7 +3592,7 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
>      uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
>      int op2 = extract32(insn, 10, 3);
>      int op1 = extract32(insn, 22, 2);
> -    bool is_load = false, is_pair = false, is_zero = false;
> +    bool is_load = false, is_pair = false, is_zero = false, is_mult = false;
>      int index = 0;
>      TCGv_i64 dirty_addr, clean_addr, tcg_rt;
>
> @@ -3602,13 +3602,18 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
>      }
>

These are the insns that should UNDEF if we have only
the insn_reg dummy flavour of MTE.

(Also, unlike STG and ST2G, none of the M insns want
Xt to be <Xt|SP>.)


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

