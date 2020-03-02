Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E26C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29602173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnz0lXxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29602173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jsZ-0007fT-Q7
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jrt-0006xo-BN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jrs-0006Th-2t
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:17 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8jrr-0006Sp-UT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:16 -0500
Received: by mail-ot1-x342.google.com with SMTP id j14so5142143otq.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Eq5eUuDb/LmF1e3qVTfRbfQjtiEljJIwf0GKIRN+T/g=;
 b=tnz0lXxH7ivjiEYOGlAHmqcCgszi8dzvUa31bh69VmrCcJmtwnmbNDv4Bju6wvkTGt
 GgTFuUo/moUrWBFyC99sZ8IDP9e8Ku8wM1fr1tVon54SnTk9v8i5chPLx8yPCxSDm1I9
 f/az0fgtZmrmI0SmNTiKxPRghw9g17fL1/YnS8twlCClvz/rSierJFKxx6pdseCYuiqH
 QQxkJgK45qaeIyamwpzp44YCzz200WIu3u5q+9QfjSzpZXUz2y9eJTnjvfCkxwo8UVJL
 krhhgl1oAdwfMsbuvca9i46+y1B+3wkVVvFWjqYKtH5osFPd7gQYokLWgoHd7CRsmbdT
 5Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Eq5eUuDb/LmF1e3qVTfRbfQjtiEljJIwf0GKIRN+T/g=;
 b=suZDrjSz423zDkUWwIiHk5GNXxwEvjZUV76r7EyBJuC/S+pz4AlJl/e2ODaepNWzLX
 hiMjDevRQgtj7Q+rz9fW6ohE35Eak72YmlfH1WLIjevqTJLp6flPEtYbQTUnOh+Z+9BH
 wk9KpzNZ7RYbNYH/o4K/u/vI+86lNfA0CmU1EYE6EqySf1pu+942Ow9eBk1nCiPoW5t1
 gVspMXqWU8QuUaEgodkshMJIAIBZ1w5zRuRzZyTQJA6OVQGkN2scwdVAnT+WdMNuYbZN
 9ITH02aXOcZztG2cvZmGBIYwVzpteY3BRmzySu6ArWWV3xw6Omz1fG/USUtTnzhAJSYD
 14Pg==
X-Gm-Message-State: ANhLgQ0NzsmAPYW1N4W57IV6GKgNaGC9Uie4bCAVFG1zElJY1m5uB3tp
 +CbY1ZKUGA2fJhGv/RjpoCYzETEnrs+zcDhY95zXiA==
X-Google-Smtp-Source: ADFU+vuh5gvbFigCQ8HVjW3TMeu7dAVrf3yjj4F/cfltuP/tUeaEqXpXxn01nHQpK3iPNQwAMzAHS0zXWlPLzrXxi+8=
X-Received: by 2002:a9d:75ca:: with SMTP id c10mr1862741otl.97.1583150894740; 
 Mon, 02 Mar 2020 04:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
 <20200225031414.15649-2-richard.henderson@linaro.org>
In-Reply-To: <20200225031414.15649-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 12:08:03 +0000
Message-ID: <CAFEAcA9VQBzdJ-fJjgxgVuTUYFL=Yqx=eNtimBaVhUGtbuOAZg@mail.gmail.com>
Subject: Re: [PATCH 3/8] target/arm: Apply TBI to ESR_ELx in
 helper_exception_return
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Tue, 25 Feb 2020 at 03:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We missed this case within AArch64.ExceptionReturn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 509ae93069..95e9e879ca 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -1031,6 +1031,8 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>                        "AArch32 EL%d PC 0x%" PRIx32 "\n",
>                        cur_el, new_el, env->regs[15]);
>      } else {
> +        int tbii;
> +
>          env->aarch64 = 1;
>          spsr &= aarch64_pstate_valid_mask(&env_archcpu(env)->isar);
>          pstate_write(env, spsr);
> @@ -1038,8 +1040,27 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>              env->pstate &= ~PSTATE_SS;
>          }
>          aarch64_restore_sp(env, new_el);
> -        env->pc = new_pc;
>          helper_rebuild_hflags_a64(env, new_el);
> +
> +        /*
> +         * Apply TBI to the exception return address.  We had to delay this
> +         * until after we selected the new EL, so that we could select the
> +         * correct TBI+TBID bits.  This is made easier by waiting until after
> +         * the hflags rebuild, since we can pull the composite TBII field
> +         * from there.
> +         */
> +        tbii = FIELD_EX32(env->hflags, TBFLAG_A64, TBII);
> +        if ((tbii >> extract64(new_pc, 55, 1)) & 1) {
> +            /* TBI is enabled. */
> +            int core_mmu_idx = cpu_mmu_index(env, false);
> +            if (regime_has_2_ranges(core_mmu_idx | ARM_MMU_IDX_A)) {

We have core_to_arm_mmu_idx() so you don't need to open-code this.
Or just call arm_mmu_idx(env) to get the ARMMMUIdx directly.

> +                new_pc = sextract64(new_pc, 0, 56);
> +            } else {
> +                new_pc = extract64(new_pc, 0, 56);
> +            }
> +        }
> +        env->pc = new_pc;
> +
>          qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
>                        "AArch64 EL%d PC 0x%" PRIx64 "\n",
>                        cur_el, new_el, env->pc);

thanks
-- PMM

