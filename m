Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FC1C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366A8206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYcrDjPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366A8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs63H-0007zv-Hh
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47144)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs62r-0007T0-Aq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs62q-0004Rg-B7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:50:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs62q-0004R5-6L
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:50:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id b7so12423449otl.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u9E9kzr6fZRxsNz5JxBpfqg9DVltmbmfiigEisB9a7Q=;
 b=pYcrDjPIVFKkmYAo0NxgkKanf6B65kN2mio7KyZ+zoe9es81Wt4dGKFWuVDwBdpWqD
 40u9mcSFEhvMxbebwd+G9UijPWHDHMaJcAEVMkYD4KjCWVWyvS/muuJLauI7NoRNSyDp
 Cr0XXDPuEvn1KTl/pf4L1GDT4UAQKqLkpB2BrZFtezPiEbOPhiFfbDfTzhiNZA9sqJWX
 XHyyq8GD0X8N0aumB7TNfTnTjZ9Xxj53uQ7i7s3ajGS4A9SBp7O55RvPH3altfIXKNQT
 T6KucaOy9qW3nEsW+DfNXUXnpRcWfBbdbziF8jkwS9zHbhzm+gkZ+GjR5sRxvQk9ug6k
 3Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u9E9kzr6fZRxsNz5JxBpfqg9DVltmbmfiigEisB9a7Q=;
 b=st+c7211tqEbEcC23JHuyU4K2DQHJtoS4ThMG7TSjPF2A+mBbPPQ/CDYn2X/1ozGW9
 dLXOLo6aZk6enjMMauqea4r2Omi/OhSgdph+fFtFR/rK51Mwny+RY1uLEUXDmP5PRakL
 M2YSYvAS89gyIwBxg87zXjY0Jo5i8XXfaV1Cm0xplmDuM6W9qVU7f/mT7FEUlA8rltu4
 O/gTbMVxHFHaVxuEvfUoL36UsvA0mdm1zgRMEi3v8v/rniSO1oXsjKkvJT67nmKdvBHK
 67iN+krSeQBc8QmFvv63dr4wQ1wXNefrtlfwpPQI2HcQTSaRuG3Vh1nyrvQXylJbPu9p
 jkGQ==
X-Gm-Message-State: APjAAAVINjtNXJXm40xIM8K9wMg7P41PeR3T/CbRMPQSoaabuoyvwEhn
 Il/7xt1swNZJwJbmMivj+CcyncF9dOt9d8dZ1bNoqg==
X-Google-Smtp-Source: APXvYqy5cJvQt7tbenOcDqjCT+saQIbjmoA5EVIcXLzHCDAji2un0WbhJuUmG0SYL96i0BL+LBe8r5w1RCuZMME1LsA=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr26899294otr.232.1564408231320; 
 Mon, 29 Jul 2019 06:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-4-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:50:20 +0100
Message-ID: <CAFEAcA-RCm7zqtYz=kJrfvySvv8TBkej+mu4h8+oR26AYZ3DNw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 03/67] target/arm: Remove offset argument
 to gen_exception_bkpt_insn
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The address of the current insn is still available in s->base.pc_next.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 33f78296eb..19b126d4f3 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1256,12 +1256,12 @@ static void gen_exception_insn(DisasContext *s, int excp, int syn,
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>
> -static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
> +static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
>  {
>      TCGv_i32 tcg_syn;
>
>      gen_set_condexec(s);
> -    gen_set_pc_im(s, s->pc - offset);
> +    gen_set_pc_im(s, s->base.pc_next);
>      tcg_syn = tcg_const_i32(syn);
>      gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
>      tcg_temp_free_i32(tcg_syn);
> @@ -8139,7 +8139,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              case 1:
>                  /* bkpt */
>                  ARCH(5);
> -                gen_exception_bkpt_insn(s, 4, syn_aa32_bkpt(imm16, false));
> +                gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm16, false));
>                  break;
>              case 2:
>                  /* Hypervisor call (v7) */
> @@ -11611,7 +11611,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>          {
>              int imm8 = extract32(insn, 0, 8);
>              ARCH(5);
> -            gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
> +            gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
>              break;
>          }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

