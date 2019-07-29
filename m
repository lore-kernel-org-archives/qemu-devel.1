Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A37C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D792070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/FjCcYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D792070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6iF-000622-BD
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59969)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6hl-0005Xd-8V
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6hk-00030O-3h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:32:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs6hj-0002yo-TK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:32:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so24266110otq.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y4uTZe1iLPCTbwbv7JO1AauwerbUATMzGm0b+xtEgu4=;
 b=C/FjCcYjLkaiNRDktm/1scMIFuzOARlTrLpt/sPnglsobEQlEQxD/mhLen1M6u83BB
 Pj9FFjrEe3KYQvzUyj7RV1eFdxiHdOliNuVi+UtheMXbySEcv9ptbWbrLs7yY5xy84RF
 8GFi6Z15v83HxFMB/HejHgatV6k5Uq6G35bTVKxi65WYqOyWx6flGv9mjKxyOAQzy0EP
 23XBxnUl4XGTDneOJtyCWnqr8IYNkzAzoadwcdbfTOj24GAu0ettZTKCttMHxGb6lFIN
 rBnvDjjHv6n+5AjvQKfJ1iyjitRgZPrEwfBaH+2KlDyR4v2qgEM8llSOO85jdibBMgj1
 WLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y4uTZe1iLPCTbwbv7JO1AauwerbUATMzGm0b+xtEgu4=;
 b=FJ/sqP391EY39nRiwgaYsXPVCORvl3/Bx5+q7M5IoC2fg+gcU2AjQV5gdZqRHgQlyA
 YAHHlx4wcnU9M+DBgWUNLEv2er+HzBwukZNU8DVv84waHEan7LkbfWWaftQEUaaclzFj
 JhaiXaxnqEneE6mwPdFIfgV3xSj7VcTjpB7NBi1xW2UYFutkVAeN5mDNzCJxFthsUzuU
 kvdGA1H5bSFB9/1sAShVYtjKcseg2yKCUnhAlZ3Dymai35FZNYvGyws1gUDQmee0Z3IH
 OeRamnRFUG+xY6Au6cB7QZFfx224mrfU11NsdpCg0ZJR1+fvHioYA7PaAzHleGxtRlo4
 BP0w==
X-Gm-Message-State: APjAAAUqykVsLweaH7zi8YcwqXhcR6qIn5sy95BjcTIogkey6SPlOX10
 lq5FEmR0k5XO4fvgUxs2K9B4mrWVCMGpqhRuQdRBCQ==
X-Google-Smtp-Source: APXvYqyzKuoiX99/Bp+1oZQ1A181XulahGQTDbpbna1CJQGe2t2zkqjn+/dcdrIqjtE8KnzVHOPbC2rZ4CfdMa1m8Nk=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr52414428otn.135.1564410766876; 
 Mon, 29 Jul 2019 07:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-11-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 15:32:36 +0100
Message-ID: <CAFEAcA83GM6wgWs1xGygmqCoir=CXtFXYkzPBMdUeb638kCzmw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 10/67] target/arm: Move test for AL into
 arm_skip_unless
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
> We will shortly be calling this function much more often.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 53c46fcdc4..36419025db 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7705,8 +7705,14 @@ static void arm_gen_condlabel(DisasContext *s)
>  /* Skip this instruction if the ARM condition is false */
>  static void arm_skip_unless(DisasContext *s, uint32_t cond)
>  {
> -    arm_gen_condlabel(s);
> -    arm_gen_test_cc(cond ^ 1, s->condlabel);
> +    /*
> +     * Conditionally skip the insn. Note that both 0xe and 0xf mean
> +     * "always"; 0xf is not "never".
> +     */
> +    if (cond < 0xe) {
> +        arm_gen_condlabel(s);
> +        arm_gen_test_cc(cond ^ 1, s->condlabel);
> +    }
>  }
>
>  static void disas_arm_insn(DisasContext *s, unsigned int insn)
> @@ -7944,11 +7950,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>          }
>          goto illegal_op;
>      }
> -    if (cond != 0xe) {
> -        /* if not always execute, we generate a conditional jump to
> -           next instruction */
> -        arm_skip_unless(s, cond);
> -    }
> +
> +    arm_skip_unless(s, cond);
> +
>      if ((insn & 0x0f900000) == 0x03000000) {
>          if ((insn & (1 << 21)) == 0) {
>              ARCH(6T2);
> @@ -12095,15 +12099,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>      dc->insn = insn;
>
>      if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
> -        uint32_t cond = dc->condexec_cond;
> -
> -        /*
> -         * Conditionally skip the insn. Note that both 0xe and 0xf mean
> -         * "always"; 0xf is not "never".
> -         */
> -        if (cond < 0x0e) {
> -            arm_skip_unless(dc, cond);
> -        }
> +        arm_skip_unless(dc, dc->condexec_cond);
>      }

In the other callsites for arm_skip_unless() the cond argument
can never be 0xe or 0xf.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

