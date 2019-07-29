Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1684C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E68C20578
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEDuSBPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E68C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs65W-0000li-Jy
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs659-0000Md-IT
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs658-0005m9-22
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:52:55 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs657-0005lt-Gj
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:52:54 -0400
Received: by mail-oi1-x241.google.com with SMTP id 65so45269649oid.13
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AJIPApmunRaDVleF7ASJ0u00EHmTdBgJRyKlvg7vvbQ=;
 b=VEDuSBPCaubJRL/6B8k84wXeRJeNGZuEbznNn7YKAWS+oXoHqb5Lc03aHsscZftA2v
 vGB91YB4SD4yxkuZAkCkQ6uE77rGc6YWFcf2EBP8tDv2okH+XWktlZzTXhqr2igeKPW+
 sGYTqksbcuxBcFbO6OJGbPPBDL6+TOXzplO+DY8anE6vTnBFMZVopokJ3PgeCdOn8FMZ
 1KUhAy9tFSDRCbrWnXBD0TDkZ6deckrJdhI+jxthXkpcVzcB/dpEbaJrkD7o5Pdy1diB
 w/rnlg9yU7T1fnPYmfW9uwSjdWKA9R/6/bImWDD229MxcuksFrhbgcQJw/qHxYwIceou
 s7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AJIPApmunRaDVleF7ASJ0u00EHmTdBgJRyKlvg7vvbQ=;
 b=BWZ+TN/wUkE6w/GweOj9IoUDYz/mwhWfBPJ1m/wUXMJymts6A7ahxVUDeU8ECLfkth
 ImT45crRNoWrLJxnQMU27IwZ3hOn85P9DsIX25VThNhaH4TcwkF+DDjg3qlPQ1iQi6vY
 6GGGeiKr/M+m8leB2Pngx0PMIKIsHrAx9Uo8/R0A2oYZhIySFBONn4Sa1dEgIRt7gST8
 MvoovXNjEeTXTf2kzRxRrsJQV598/kPqi8nejG8h14OxbClaNJMFTCE8YQkAlGDqh00V
 0fu5xoF2IZdq0e2C9guq9K9XK9vZYpREyk2vNWURkgFTPmCCXHHv32crS1wdXB3KnGTH
 67uw==
X-Gm-Message-State: APjAAAXJbCSuJRz+L4RGZyKeocrF/QbSVWfBeV1RBBHq7RGjGdgq1YN6
 wzN3BWK6rvgZaiGYOJHWepH/WDtZXhaUh7/VoGJfNteW
X-Google-Smtp-Source: APXvYqySCUbdvELL8v0YCzLbJlmtHQNPecqJ3XF1wVcNLXQdgadSRLXga8fe4ExovbTJGbcoqzpbcaISj42ruktfArA=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr49047676oib.146.1564408372825; 
 Mon, 29 Jul 2019 06:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-5-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:52:42 +0100
Message-ID: <CAFEAcA-W7idBRdD-DHxrVqfnBsKmAOPZoQAJkaUVOcjnLnGugw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 04/67] target/arm: Remove offset argument
 to gen_exception_internal_insn
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
> The actual argument is 0 for all callers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 19b126d4f3..0848fb933a 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1239,10 +1239,10 @@ static inline void gen_smc(DisasContext *s)
>      s->base.is_jmp = DISAS_SMC;
>  }
>
> -static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
> +static void gen_exception_internal_insn(DisasContext *s, int excp)
>  {
>      gen_set_condexec(s);
> -    gen_set_pc_im(s, s->pc - offset);
> +    gen_set_pc_im(s, s->pc);
>      gen_exception_internal(excp);
>      s->base.is_jmp = DISAS_NORETURN;
>  }
> @@ -1294,7 +1294,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
>          s->current_el != 0 &&
>  #endif
>          (imm == (s->thumb ? 0x3c : 0xf000))) {
> -        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
> +        gen_exception_internal_insn(s, EXCP_SEMIHOST);
>          return;
>      }
>
> @@ -11984,7 +11984,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
>          /* End the TB early; it's likely not going to be executed */
>          dc->base.is_jmp = DISAS_TOO_MANY;
>      } else {
> -        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
> +        gen_exception_internal_insn(dc, EXCP_DEBUG);
>          /* The address covered by the breakpoint must be
>             included in [tb->pc, tb->pc + tb->size) in order
>             to for it to be properly cleared -- thus we
> --
> 2.17.1


I'm not so convinced about this one -- gen_exception_insn()
and gen_exception_internal_insn() shouldn't have the
same pattern of function prototype but different semantics
like this, it's confusing. It happens that both the cases
of wanting to generate an "internal" exception happen to want
it to be taken with the PC being for the following insn,
not the current one, but that seems more coincidence to
me than anything else.

thanks
-- PMM

