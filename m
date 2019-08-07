Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6912E2229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJMmGeE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6912E2229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPjH-0004xj-Ja
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvPit-0004Oq-4o
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvPis-0003EL-3m
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:27:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvPir-0003DZ-UY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:27:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so79099873ote.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AHdOn7vFi2h++gG3kKrp+8meZRPHwwmLn9Dt/7//sJo=;
 b=JJMmGeE/Xe81+uVR1YItaVDeRa20wwlm1Va4/XnOoVzu2+9YwKP8K0xDGqdGjFKfan
 JVs2FUnsUMXoAaR+caeviE+ZD00DJxDU8YrXEz53RTI/1pjCYWAUxZEgwEzInriyMt9t
 9ntFRnctFFVG1cao4Ouyb3Z2GVuU4o3EUJVQ/QVsd5IEIULRqYOgPtJuCAScdGHAuNFw
 LAuF9XFisDp5D/WYde2Fn+Mji0LM4dWOXJvaFCn1GheRDmklEvrgEXLoj5lrkmDrmfq4
 XmfDQS9kktlZ45Z6lbsIhRzFgKp+tPGx+53q3rkSgM1EyxA5ih2QkUYRiovggSupiED/
 Ng0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AHdOn7vFi2h++gG3kKrp+8meZRPHwwmLn9Dt/7//sJo=;
 b=QTVXzcmXma+jWs3WdLnEatvg/3B2P/1dPBnFCg4TbxxPceHsDm3N8xEYHFXDvP6N1v
 GF9FZIpjnLcDSKfpvEXROBQWcVW/NECwRAbjBEoU6Boq0BU5mVFA9ltZuqkj5fVk9wJ6
 mVjeXdyX9TSr2h3CpeIvRO8IgAKev4PVzGCwmsslAfAkkn0NFPg2eSNGhMi6IY64kdoe
 0zILzmun21Uo/URN215vsL/3+fa0VfqDmORAO0s1KNiolcllEZDQdkd3/tn1yqGAqOgb
 p2BSOBedzMBMNgNYRkPQ8Aw1UiYiniL4p1HbR99OyUHi4fANE579QhAgOY+MOLmwnpUF
 WH+g==
X-Gm-Message-State: APjAAAWNT85zfP0ctaxoXy97pFSV4x/p3AfyP9oSGG/qdiooY/Iqab07
 DxBbIwrSS8ZcUQBXEjGXqqNvyHD/Y199KZ6eZRW16w==
X-Google-Smtp-Source: APXvYqyotskf8azvAj3q5ZZjjCxdAXe5PWo4tahPvxownBDz0FfYX2RzNqDuBzoGowzdHV/SpEntDjhaymcE8gE3tKQ=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr731905oic.170.1565198857134; 
 Wed, 07 Aug 2019 10:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <20190807045335.1361-4-richard.henderson@linaro.org>
In-Reply-To: <20190807045335.1361-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 18:27:26 +0100
Message-ID: <CAFEAcA_MFg1_gpaT5+X71s8r5SYZFTizdXs2vQ_6mLooP7E+kg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 03/11] target/arm: Introduce read_pc
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

On Wed, 7 Aug 2019 at 05:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We currently have 3 different ways of computing the architectural
> value of "PC" as seen in the ARM ARM.
>
> The value of s->pc has been incremented past the current insn,
> but that is all.  Thus for a32, PC = s->pc + 4; for t32, PC = s->pc;
> for t16, PC = s->pc + 2.  These differing computations make it
> impossible at present to unify the various code paths.
>
> With the newly introduced s->pc_curr, we can compute the correct
> value for all cases, using the formula given in the ARM ARM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 59 ++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 36 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 59e35aafbf..61933865d5 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -196,17 +196,17 @@ static inline void store_cpu_offset(TCGv_i32 var, int offset)
>  #define store_cpu_field(var, name) \
>      store_cpu_offset(var, offsetof(CPUARMState, name))
>
> +/* The architectural value of PC.  */
> +static uint32_t read_pc(DisasContext *s)
> +{
> +    return s->pc_curr + (s->thumb ? 4 : 8);
> +}
> +
>  /* Set a variable to the value of a CPU register.  */
>  static void load_reg_var(DisasContext *s, TCGv_i32 var, int reg)
>  {
>      if (reg == 15) {
> -        uint32_t addr;
> -        /* normally, since we updated PC, we need only to add one insn */
> -        if (s->thumb)
> -            addr = (long)s->pc + 2;
> -        else
> -            addr = (long)s->pc + 4;
> -        tcg_gen_movi_i32(var, addr);
> +        tcg_gen_movi_i32(var, read_pc(s));

So previously:
 * for A32 we would return s->pc + 4, which is the same as s->pc_curr + 8
 * for T16 we would return s->pc + 2, which is the same as s->pc_curr + 4
 * for T32 we would return s->pc + 2 -- but that's not the same as
   s->pc_curr + 4, it's s->pc_curr + 6...

Since s->pc_curr + 4 is the right architectural answer, are we
fixing a bug here? Or are all the places where T32 code calls
this function UNPREDICTABLE for the reg == 15 case ?

thanks
-- PMM

