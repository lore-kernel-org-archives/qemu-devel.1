Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6920DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E452073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGoyRrPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E452073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rOW-0000uO-Cv
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rNR-0007lP-Ce
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rNQ-00020t-Am
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:21:29 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9rNQ-0001zH-4X
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:21:28 -0500
Received: by mail-ot1-x343.google.com with SMTP id x19so5826092otp.7
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MmVNlVoG5+r9EgwrJZuwCWK7AZ0/9oroAwsFmb1pWHs=;
 b=zGoyRrPeSq5RPtJL+rqfrcS5WrsKke3+ZWZUS8L9Em8xhosmhEQ8a5DaUQMEJUDel8
 j1CB9h0wXh3pSw0QaDs4t37AFgwJFlDQeJvZzekp/6YdfJN9RkuYwIDlN09QIhRSoVTR
 YvPQD5mD+vuMNNJpK8oxR+XQvhohg4xzSg5REJ7JeGxGuQmEXUCpLMnuyBYiRyMK8+Mu
 2XiCpPpcaV0QuRLI5Vp1a+m2nFczApV5HBtcB7xsads42AqAbbhySqrzqOSqBYiZB4O9
 8ZchsHsdjfzFv9u9pzeGjmNvU5GIYEiFgOQYU7zRwkfMklS2/xmEJtA4CFlI852VYc56
 je9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MmVNlVoG5+r9EgwrJZuwCWK7AZ0/9oroAwsFmb1pWHs=;
 b=Sq1SSJ16a0p551aLC6PJ4TGjEoAXbHKJ9KIcBwxoAeHhqSg/X0qkX04rCC68wk0uxk
 tiWL+oNIV88IjjxUKj0n37JdCtCdMdkCOEJ3QsU5soWepCaCWmG0exrydfsd6EQ8fX7c
 nGgNzVFMTCDfEuP5g2GMsAOUF6FCRNxx4IejwsqQh9zagUQwzCJPY9vS6hXoeKtpTHpU
 0q5LXyivG+dTNNxqkKbKxMuUupLL/4k8t0u7DpRrNKllRPvNpScd8DjIVya08LweC7fP
 YiTzg+Yac6PXkOwRk4JG1ZK5XpeFewWIsoN/nF1LeCAXGn9p9KUO6YHYdY+O4/tze28K
 2vUw==
X-Gm-Message-State: ANhLgQ2eUxJTvMauq3LwF4nZQCgZGacL1K+0eiYa5TrMAdwI+WLYOOuA
 djvEnrvB8Oq5tdTT3IXnT1ru9xoGAic5LVdeMJiwmQ==
X-Google-Smtp-Source: ADFU+vuvq4iULcXwBzx1+Bn4r0LYXP6GHufRNWS/S2L3S09AI3pVIyLkm6VQRFr2ZI/EJpfr5kn57B3bwJspNKnvn2I=
X-Received: by 2002:a05:6830:30ac:: with SMTP id
 g12mr5538264ots.221.1583418086899; 
 Thu, 05 Mar 2020 06:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-9-richard.henderson@linaro.org>
In-Reply-To: <20200302175829.2183-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 14:21:14 +0000
Message-ID: <CAFEAcA8vEHctFuYfaziQs1QobbrHJgMioATwF7QkWL-e=gLxJw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] target/arm: Check addresses for disabled regimes
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

On Mon, 2 Mar 2020 at 17:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We fail to validate the upper bits of a virtual address on a
> translation disabled regime, as per AArch64.TranslateAddressS1Off.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index addbec91d8..0ef32d3c24 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11634,7 +11634,38 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
>      /* Definitely a real MMU, not an MPU */
>
>      if (regime_translation_disabled(env, mmu_idx)) {
> -        /* MMU disabled. */
> +        /*
> +         * MMU disabled.  S1 addresses are still checked for bounds.
> +         * C.f. AArch64.TranslateAddressS1Off.
> +         */
> +        if (is_a64(env) && mmu_idx != ARMMMUIdx_Stage2) {

This looks weird -- why do we care about whether the current
EL is aarch64, rather than looking at the controlling EL
for the translation regime ?

thanks
-- PMM

