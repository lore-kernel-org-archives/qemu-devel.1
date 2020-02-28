Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FFAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD592468E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCHBan/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD592468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iQM-000629-Jy
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7iPf-0005Ay-NV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7iPe-0005at-Fg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:22:55 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7iPe-0005a8-6y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:22:54 -0500
Received: by mail-ot1-x343.google.com with SMTP id j16so3129201otl.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vUyVrR5UnNRx0q4may4bQIwQNcS0KvoRhyJK6bJDMD4=;
 b=PCHBan/fR4XVM7nCiotyl+2Rjn3+hW6QXudEar8T2pwcrGtaHs7oXV+l0DDddL5Eoh
 q2c2vwg5oA95AYXfJ176eQy681K0Mx1q0gzYAGA3IxzAZaTUctsJziJcQT756DpkbS8w
 BPfln6Pkq0JQlQeKpUOzM/hGDBjDo39H9EXgQdO7dAlwWTwigRTjcYB2F1qb6ZvrzjKK
 gL7DP0Qm8D9TRdK3oAc9mFac3IcfXM90HJ8iUinXQ5VBWdz1JIFDkxVKuNGRWzD6/XDJ
 Ej1lt5goNPujZ6XRmx4Rs94PAlGyBVueDwNh3H1utjb/mxPZpmd+RaC9vvqNvHfnH8Tr
 9OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vUyVrR5UnNRx0q4may4bQIwQNcS0KvoRhyJK6bJDMD4=;
 b=tswBQFvP8RdeWj69M01ZKtyG3oP+lP7+f4ldTcLjvnnL33NoCa+mXobjNWy3RAUgoN
 tEaldTFdf0iXwRTcv3+jHFtml7zRpUD9RptWUkm64PGnY6kxp7S4UDSnipUtjKnR5HFR
 hCBB6FhHXPu3S/TSQ0jqTMkZ9ERefaltwYI73rC2k73VYdOcBL+MErnD9j/bRzsuZUXM
 m1Az+Cy1v3T9dWr+KMVwp5qFHU949WzkyhontWR8RTSlutaeli8nk9xGOu0y306J5CaP
 YQk8QdFkNZQag/RLi/Ps7KusoaMWsTGazcDekc/FwPwrhhUobFE/I6CjFAy+wcav7xvP
 KVDw==
X-Gm-Message-State: APjAAAWrrvkCSz8Y/ERgkE7ReHtQsYs9NJKbR9OEF5gN3d3ivneP1t6z
 x+1NkGaB44WdaWFqYv7uKIkqqEeofMjVPxcHzHxTUrLU
X-Google-Smtp-Source: APXvYqzh9MrjuGvldUGNCEthHAqb1WsVjpXb+OFLvLPXlQQbbO61yIiRhCx5fpUsGwy1iWK1jGcTrM+9Hqk7isl0bEs=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr3762536otq.97.1582906973325; 
 Fri, 28 Feb 2020 08:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20200225180831.26078-1-richard.henderson@linaro.org>
 <20200225180831.26078-2-richard.henderson@linaro.org>
In-Reply-To: <20200225180831.26078-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 16:22:42 +0000
Message-ID: <CAFEAcA8ipK0nZioEgbNq5B1L-tqA+rzn-C2yyfet4_4yNVnYqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] target/arm: Improve masking of HCR RES0 bits
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

On Tue, 25 Feb 2020 at 18:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Don't merely start with v8.0, handle v7VE as well.
> Notice writes from aarch32 mode, and the bits that
> ought not be settable from there.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 79db169e04..d65160fdb3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5089,8 +5089,13 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
>  static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  {
>      ARMCPU *cpu = env_archcpu(env);
> -    /* Begin with bits defined in base ARMv8.0.  */
> -    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
> +    uint64_t valid_mask;
> +
> +    if (arm_feature(env, ARM_FEATURE_V8)) {
> +        valid_mask = MAKE_64BIT_MASK(0, 34);  /* ARMv8.0 */
> +    } else {
> +        valid_mask = MAKE_64BIT_MASK(0, 28);  /* ARMv7VE */
> +    }
>
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
>          valid_mask &= ~HCR_HCD;
> @@ -5114,6 +5119,14 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>          valid_mask |= HCR_API | HCR_APK;
>      }
>
> +    if (ri->state == ARM_CP_STATE_AA32) {
> +        /*
> +         * Writes from aarch32 mode have more RES0 bits.
> +         * This includes TDZ, RW, E2H, and more.
> +         */
> +        valid_mask &= ~0xff80ff8c90000000ull;
> +    }

Isn't bit HCR2 bit 16 (aka bit 32+16==48 here) also RES0 from AArch32 ?
I suppose it's RES0 from AArch64 too, but as far as what we've
implemented goes so are a bunch of other bits.

I'm not really a fan of the hex-number here either, given we
have HCR_* constants.

thanks
-- PMM

