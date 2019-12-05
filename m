Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D6C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2712464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkYx/TLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2712464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icurm-00061A-T4
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icujZ-0006gH-7F
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icujX-0002D4-PB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:16:08 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icujX-00028e-DS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:16:07 -0500
Received: by mail-oi1-x244.google.com with SMTP id a67so3434387oib.6
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oR1ydjx5BXUU7AR1HyJMQzYmJztax2heM3c2x5vgaww=;
 b=UkYx/TLRcr9fFREWaRf1PE35hgBubIZ/mtpRBoQxNXQ27b1ry3OaekuUg+GDUgQphg
 j/coNEFyyg8cgbTwDSBh+eeMWEG/dAyZg6tywR0204EAAloUAaQ2U66V2RKzzrlmgDee
 clAWTPZRq/SvYGfvWoWfMPpA24FtCPuPPCBHgL8XeFIzgWJx8Ap8KgtXRMm23x4aV72u
 A2dpS0SWFbRIIwEbGcue0359J8maiYZGG46dH5bm/2ERfhX391UHO+C50b2en7PBq2O+
 1bxqrFfhmP39Rd7ZePjdk9QNrw0zojdauVbc7rFTb4JvPcptjCbz2rJAHBVPMWsJwmqT
 SlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oR1ydjx5BXUU7AR1HyJMQzYmJztax2heM3c2x5vgaww=;
 b=piwjGRh8810Uv+OGlAMlSNhiXPqOKw0ZpBVXRXWdJ21XZ7xCVjr9AWf+StT6zZG+6S
 7Rro0tDvFbH6ISHm62Jl2BLNO0MFHfc0kU8gknt3X5d1pypKSikvEEtUqbA7lC32vum6
 TCQBBX5ApXUxOA03THsqRxEYv4UB0cvgqJgUzONQnYgwAYWpxyj0DbAfooxaP0T1xQei
 tKAIHawe0yqz/0pXKM2Wm8Iv8ewF7n39vv3qpFPD2FLn0GTZ0q9HfXUntEuQXjia1GQI
 qeoYFvYW9ZisPSAYy1vEbZisxfYQ8rapU54ImOf4I9pMtsgdYb9twlwhYbL11JvvuDad
 kkCg==
X-Gm-Message-State: APjAAAWu5+WB0tPCbKrlFnYcPsefV1v/w3gGvZQ+N00lFQnJ1QVC/Ss5
 HNLsCLLUv0ZkKqBiA2FvGb14bqIBNEL7icTlDaYJe3WUEC0=
X-Google-Smtp-Source: APXvYqyc4h+2ImfEMHKTc8Lekx6ViVfBTjA7Q6R6oZODKAsAv3qG9RlH7vTwzNwvONONMCc1g9IdZQfsfWPqg+Y/q44=
X-Received: by 2002:aca:3182:: with SMTP id x124mr8320862oix.170.1575566166437; 
 Thu, 05 Dec 2019 09:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-13-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 17:15:55 +0000
Message-ID: <CAFEAcA88=mVYgG_Pu7HJOToCpNz9GYDRW2iG3tx0QYO7C-gFeQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/22] target/arm: Implement the STGP instruction
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
> v3: Handle atomicity, require pre-cleaned address.
> ---
>  target/arm/translate-a64.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index c17b36ebb2..4ecb0a2fb7 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -2657,7 +2657,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
>   * +-----+-------+---+---+-------+---+-------+-------+------+------+
>   *
>   * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
> - *      LDPSW                    01
> + *      LDPSW/STGP               01
>   *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
>   *   V: 0 -> GPR, 1 -> Vector
>   * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
> @@ -2682,6 +2682,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
>      bool is_signed = false;
>      bool postindex = false;
>      bool wback = false;
> +    bool set_tag = false;
>
>      TCGv_i64 clean_addr, dirty_addr;
>
> @@ -2694,6 +2695,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
>
>      if (is_vector) {
>          size = 2 + opc;
> +    } else if (opc == 1 && !is_load) {
> +        /* STGP */
> +        if (!dc_isar_feature(aa64_mte_insn_reg, s) || index == 0) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        size = 3;
> +        set_tag = true;
>      } else {
>          size = 2 + extract32(opc, 1, 1);
>          is_signed = extract32(opc, 0, 1);
> @@ -2746,6 +2755,15 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
>      }
>      clean_addr = clean_data_tbi(s, dirty_addr, wback || rn != 31);

Don't we need to adjust the 'check' argument to clean_data_tbi()
here? The pseudocode says STGP doesn't do tag-checking.

>
> +    if (set_tag) {
> +        TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
> +        if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> +            gen_helper_stg_parallel(cpu_env, clean_addr, tcg_rn);
> +        } else {
> +            gen_helper_stg(cpu_env, clean_addr, tcg_rn);
> +        }
> +    }
> +
>      if (is_vector) {
>          if (is_load) {
>              do_fp_ld(s, rt, clean_addr, size);
> --
> 2.17.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

