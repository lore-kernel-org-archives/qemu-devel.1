Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D404C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4769022BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMeab0+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4769022BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4ip-0001RP-Ij
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hr4ig-00011D-4M
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hr4if-0006mX-0B
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:13:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hr4ie-0006lh-SK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:13:28 -0400
Received: by mail-oi1-x244.google.com with SMTP id w196so19549366oie.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cB5O7qLZbi7AU1GJPd1XmkLwCN14JF69T6pjBdSiZPc=;
 b=eMeab0+NWmNXAhFgUk8XVALNy+5YcQqpcnBmYQ+i5c3exvgnchG/ene4YaB3q3zrlm
 lm8ZYkWzwb8zQUaoz/tKO7pKtLiK2uO9oivxkzVlb/g7pROZU5BDlf/Nt1cBU1pwhhyi
 DJwJB3WInOEBv3d8XipwTjVGdBZacCmifC68RmmRjqKOZtqcIddBwaYwusrWo4thptsn
 8y2/MbVB/ZEUn9T2meF2pDVPtPudPaiCfqll8ymQPI/dLMV3AODwqvGSjVI0MlvkEJ9v
 ScWZpN8eoi6p5+LPsRDKdUeEqwOq99Ymk/zRbtnoX1xsWZUt0UcZfL42fLtXuSsAF0zL
 1+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cB5O7qLZbi7AU1GJPd1XmkLwCN14JF69T6pjBdSiZPc=;
 b=OwTm3TxyQ52YNzFmjlt1lpsPEG2BzpN5iOwnmbxWKTRdR+Efp/QD7auzNCfnsPa1kj
 NrJkl0X+ZKiL0E0txYZ3i+mklDsd/7YnAps2GWNZWQJE5GBbbzDWLiYqGGvPh0sqamP/
 RuN0mysD4X8EfsW+VBOZHnGEn1rGX+pd3MNDcbdU+Yq6G8oPGIyZrMaYVljiYaCNDXOx
 o1mroWdjPNvBRotrX+XK3X3H4sGfaohSdEjaUA1iUQwbbKl21cbTFPe0GVGjgKva3CdA
 JrbHkckglY2XyeNWslt8JlrXnBqknLmbakIq1qt3G68yj8VPZdC96idUz+WXL1vUyAlI
 RfGQ==
X-Gm-Message-State: APjAAAUiIE+4KW6iFZYDdueeoUBYsU+XAp/iwJuO3R3Z5aLppiratbmv
 xvzPulxyxB/5IQUMeAnVWhyxcNiXaKn53Mq7iFba1w==
X-Google-Smtp-Source: APXvYqwX64ULsHl7H8q2Mn7iWh3WA9YJOpFhKMufQyhTrN3wzqHRpYxqmrU42YSHam0ZSYUTnKtNHPkhUrk/yI6FTZo=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr45720050oij.98.1564164807738; 
 Fri, 26 Jul 2019 11:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-67-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-67-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 19:13:16 +0100
Message-ID: <CAFEAcA9s44Lc58X=C1DzPRRCyi_KOpx0CiMfhKWEzAdDoU326A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 66/67] target/arm: Move singlestep check
 from gen_jmp to gen_goto_tb
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

On Fri, 26 Jul 2019 at 18:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We miss quite a number of single-step events by having
> the check in the wrong place.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index c2b8b86fd2..9ae9b23823 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -2740,7 +2740,10 @@ static void gen_goto_ptr(void)
>   */
>  static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
>  {
> -    if (use_goto_tb(s, dest)) {
> +    if (unlikely(is_singlestepping(s))) {
> +        gen_set_pc_im(s, dest);
> +        gen_singlestep_exception(s);
> +    } else if (use_goto_tb(s, dest)) {
>          tcg_gen_goto_tb(n);
>          gen_set_pc_im(s, dest);
>          tcg_gen_exit_tb(s->base.tb, n);
> @@ -2751,16 +2754,9 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>
> -static inline void gen_jmp (DisasContext *s, uint32_t dest)
> +static inline void gen_jmp(DisasContext *s, uint32_t dest)
>  {
> -    if (unlikely(is_singlestepping(s))) {
> -        /* An indirect jump so that we still trigger the debug exception.  */
> -        if (s->thumb)
> -            dest |= 1;
> -        gen_bx_im(s, dest);
> -    } else {
> -        gen_goto_tb(s, 0, dest);
> -    }
> +    gen_goto_tb(s, 0, dest);
>  }
>
>  static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)

I haven't tested but I'm not sure this change is right.
The idea of the current code is that we handle generating
the actual singlestep exception in arm_tr_tb_stop() at the
end, rather than in the process of generating code for the
insn. This change means we now do a gen_singlestep_exception()
in the gen_jmp()/gen_goto_tb() part of the code, but we haven't
removed the handling of it in arm_tr_tb_stop(), so we're now
doing this in two places. Why doesn't the current design work?
And if we need to do something different for the route to
"change the PC via gen_jmp()" why don't we need to do it
also when we change the PC via eg gen_bx_im() ?

(Incidentally, the only places other than gen_jmp()
which call gen_goto_tb() are:
 * the end-of-TB handling of DISAS_NEXT/DISAS_TOO_MANY
 * four places for barrier insns where we use a
   gen_goto_tb to end the TB -- this isn't consistent
   with how we end the TB for other situations...)

thanks
-- PMM

