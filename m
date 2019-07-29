Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D9EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695552070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib5miL4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695552070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6Rb-0002Kv-Nk
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6R9-0001mI-Q5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6R8-0005bb-JC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:15:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs6R8-0005aI-96
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:15:38 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so56651248otq.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KQrl1BFn7FHz3PBVwJtYxz4acbe9CFGzumyCZ9gkleM=;
 b=Ib5miL4NAiQszXsR5dFJDTfv8nIxoMXpYuqJWbha37asuk2aov23uXthBzDiCNEjJw
 vxXxpbOF6AfCx45L5XPM7P12Vn7UwWBy6DqaoUMEbKo6E102BMMpywERatK/417ynN7F
 KEPZxpjvkvM+M38LiZ0CKVtQvmla7kY+FcHZdJWpCeGwDICpjYMmEwq9OabPx2sf79cm
 0WwDuC2nbweeMlP3bijcFRUyCxOhP2klCNOlQ+yZ4kFF67AkxlBbfqDYWTCVCKi9Xs3U
 qYu01ltttZbCvb52Ztnqoi/LTCoeq/DFg6DtH3hmzrVcpauqInb8kmTYfxfRqNzAyWz8
 l6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KQrl1BFn7FHz3PBVwJtYxz4acbe9CFGzumyCZ9gkleM=;
 b=nNKLkdaHVbuIUMfYsSraBUZWiAQ3x2zcKeHg2w3/rkhbzZMKBn8PMK9egKvjO2Fvvj
 Q6y7kSmOZHt5pij0BRNWcbOdUj3Pe5/Qa4nC7EzlBUg6FmGkgN93F1fk7bqByIpHoG/s
 Wk/47d6SOZsjIhcw27xWhlUOlhO687XTgITdkqwSjrz9IcXZepANMyPfQShF/DVazWbM
 2sNuiY68Bs7grzPJW6akNqGgaLR5mUI0OOTkAHTvUYxK9njSzdsHjFc2GkXCs8ULqIO6
 L8EAzeezPvNJ58cPvZbWuzCxymcHDU+KuGDpQtanH9a7P2JttQa6yG/jGVaIz0Y7Dsoo
 e08w==
X-Gm-Message-State: APjAAAXJjviUor3ZI8/XOb/kRJ9mR1wtD6AHsUTy/m9WSzMkaHc4EiaY
 1ADXzGNKZrpAzCO9PnTUGJShGeAmpGrCLUQnZSElFg==
X-Google-Smtp-Source: APXvYqx5B5+80R6D8ZZRXEitZM26v+oEEicdccDuUJRcP9DwfeOsPQd9TWQlOAlFnke971OXUYhS0Lxo6XHraTNktjM=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr52343390otn.135.1564409737009; 
 Mon, 29 Jul 2019 07:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-8-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 15:15:26 +0100
Message-ID: <CAFEAcA_HY=WuGEPxTEm5g5tYuCDHXRDs=9EXQd6r+zvsL6_=Uw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 07/67] target/arm: Introduce add_reg_for_lit
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
> Used only on the thumb side so far, but will be more obvious
> once we start unifying the implementation of A32+T32.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c |  34 +------
>  target/arm/translate.c         | 163 +++++++++++++++------------------
>  2 files changed, 76 insertions(+), 121 deletions(-)
>
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index e7389bc057..4066b2febf 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -941,14 +941,7 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
>          offset = -offset;
>      }
>
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> -    tcg_gen_addi_i32(addr, addr, offset);
> +    addr = add_reg_for_lit(s, a->rn, offset);
>      tmp = tcg_temp_new_i32();
>      if (a->l) {
>          gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
> @@ -983,14 +976,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
>          offset = -offset;
>      }
>
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> -    tcg_gen_addi_i32(addr, addr, offset);
> +    addr = add_reg_for_lit(s, a->rn, offset);
>      tmp = tcg_temp_new_i64();
>      if (a->l) {
>          gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
> @@ -1029,13 +1015,7 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
>          return true;
>      }
>
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> +    addr = add_reg_for_lit(s, a->rn, 0);
>      if (a->p) {
>          /* pre-decrement */
>          tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
> @@ -1112,13 +1092,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
>          return true;
>      }
>
> -    if (s->thumb && a->rn == 15) {
> -        /* This is actually UNPREDICTABLE */
> -        addr = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(addr, s->pc & ~2);
> -    } else {
> -        addr = load_reg(s, a->rn);
> -    }
> +    addr = add_reg_for_lit(s, a->rn, 0);
>      if (a->p) {
>          /* pre-decrement */
>          tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index a48e9a90f8..5e2dd8bb16 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -214,6 +214,23 @@ static inline TCGv_i32 load_reg(DisasContext *s, int reg)
>      return tmp;
>  }
>
> +/*
> + * Create a new temp, incremented by OFS, except PC is aligned but not
> + * incremented for thumb.  This is used for load/store for which use of
> + * PC implies (literal), or ADD that implies ADR.
> + */
> +static TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
> +{
> +    TCGv_i32 tmp = tcg_temp_new_i32();
> +
> +    if (reg == 15) {
> +        tcg_gen_movi_i32(tmp, (s->pc_read & ~3) + ofs);
> +    } else {
> +        tcg_gen_addi_i32(tmp, cpu_R[reg], ofs);
> +    }
> +    return tmp;
> +}

This is losing the information in the comments about the UNPREDICTABLE
cases. Are there callsites where the new function is called where
"thumb and reg == 15" is not UNPREDICTABLE, or are they all
that way?

thanks
-- PMM

