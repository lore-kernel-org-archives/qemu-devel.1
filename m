Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5517A20748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtDpwqWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5517A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ome-000431-EM
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 18:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3om6-0003ad-AB
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:54:14 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3om4-0007K0-EJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:54:13 -0400
Received: by mail-pj1-x1042.google.com with SMTP id d4so7429538pjx.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oAtsgfErucMWr9Qd+UivYtdHC9uYMXfeC05waK5hHTI=;
 b=TtDpwqWx0b/z25JnoHOvuO+ggrjyj2XNtM0z5lMJVpB2qI6DcgU40GFbz+uw8/75Lk
 L8oBZbzqeAfZXqBG13v9DZQkwEGXJjYGjGwvctcKqHF/DXG9EzfrkQ7ftMWB1gQAaZQI
 NRf7B+c8+a26IPBcidLAjeMjc2h8lMa39aqUuKRihtEPAjTmTpvJCAHBc6ltgI1Pe6vC
 twPz5blk63L4ONxnaU96cVuNzcjC8AvUsNse/HN9oxEf9u5Kex4kLl8a+n+xrPUvyqIm
 gvi6cT123MZkEP98kSv1RfAZEd78R87bn8F+xG1BD1Y2ajesqsYr/gxqiC1rTOo3AgBc
 WuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oAtsgfErucMWr9Qd+UivYtdHC9uYMXfeC05waK5hHTI=;
 b=Z2iAww6sQxkXnvC0oyCpFGUXA3JHYZ29AC217rvxkhhs35uvHunVKYAxo6hAOAkFAV
 9ncCwwcw4IDuuTMX5v1VcoFbroMbP4CFP98icYAuT5Sl18bb0XcOnhQVdAzSi9TFt0tQ
 IUIJf4lPbG1qth+sgDjCKb/t8j7gTLlR2IjIQSjG85H9HpiwVStNrwL6JEpkz597Nlyn
 wZP6hRSKj/0UvdZMpyIev4QG2RrDsGFT8nsAx1wRSN2+//P1nhws5MATlwZ0XmjG8hux
 47IsFwy/grue1c6booHOmivBjCDWUcMqe7aL1vs+PMZ6l6iXmenV4EjxajO03SbrxRHf
 KwTA==
X-Gm-Message-State: AOAM532x+XE/nzRdEwTp3xJ1ESbunI13SbGAT+DlwkgtYljM6BFHIl1w
 7QWRBlY0MX3Na/vLp4yVeri6sQ==
X-Google-Smtp-Source: ABdhPJxsXHfC7UDAyAhpBww+Of1+rbQrasFytnt1E7fCEedA1VYMPaK8oO+Cb+viH6z4JibujiqVBQ==
X-Received: by 2002:a17:902:246:: with SMTP id 64mr9820513plc.70.1596754450510; 
 Thu, 06 Aug 2020 15:54:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b25sm9497672pft.134.2020.08.06.15.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 15:54:09 -0700 (PDT)
Subject: Re: [RFC v3 15/71] target/riscv: introduce more imm value modes in
 translator functions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-16-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e5426634-26f6-cc43-cf23-5fffc49ff2b8@linaro.org>
Date: Thu, 6 Aug 2020 15:54:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-16-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Immediate value in translator function is extended not only
> zero-extended and sign-extended but with more modes to be applicable
> with multiple formats of vector instructions.
> 
> * IMM_ZX:         Zero-extended
> * IMM_SX:         Sign-extended
> * IMM_TRUNC_SEW:  Truncate to log(SEW) bit
> * IMM_TRUNC_2SEW: Truncate to log(2*SEW) bit
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 115 ++++++++++++++----------
>  1 file changed, 66 insertions(+), 49 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index c2d0865bb9b..0a4dd875e96 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1281,8 +1281,32 @@ static void tcg_gen_gvec_rsubs(unsigned vece, uint32_t dofs, uint32_t aofs,
>  
>  GEN_OPIVX_GVEC_TRANS(vrsub_vx, rsubs)
>  
> +enum {
> +    IMM_ZX,         /* Zero-extended */
> +    IMM_SX,         /* Sign-extended */
> +    IMM_TRUNC_SEW,  /* Truncate to log(SEW) bits */
> +    IMM_TRUNC_2SEW, /* Truncate to log(2*SEW) bits */
> +};

Better to name the enumeration and use it...

> +
> +static int64_t extract_imm(DisasContext *s, uint32_t imm, int imm_mode)

... here.

> +{
> +    switch (imm_mode) {
> +    case IMM_ZX:
> +        return extract64(imm, 0, 5);
> +    case IMM_SX:
> +        return sextract64(imm, 0, 5);
> +    case IMM_TRUNC_SEW:
> +        return extract64(imm, 0, 5) & ((1 << (s->sew + 3)) - 1);
> +    case IMM_TRUNC_2SEW:
> +        return extract64(imm, 0, 5) & ((2 << (s->sew + 3)) - 1);

The extract is redundant with the &.

Alternately, put sew into the extract, like so:

    return extract64(imm, 0, s->sew + 3);
and
    return extract64(imm, 0, s->sew + 4);


> +    default:
> +        g_assert_not_reached();
> +        break;

Unreachable break.

>  static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
> -                        gen_helper_opivx *fn, DisasContext *s, int zx)
> +                        gen_helper_opivx *fn, DisasContext *s, int imm_mode)

Use the enum.

>  static inline bool
>  do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen2iFn *gvec_fn,
> -              gen_helper_opivx *fn, int zx)
> +              gen_helper_opivx *fn, int imm_mode)

Use the enum.


r~

