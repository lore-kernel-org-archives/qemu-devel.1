Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519CDC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134C72051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTzdKUgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134C72051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDM5f-0006M4-Sj
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 01:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDM4J-0005mg-FT
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDM4I-0004K9-5A
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:44:11 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDM4H-0004Dc-Sy
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:44:10 -0400
Received: by mail-pj1-x1043.google.com with SMTP id np16so6287572pjb.4
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 22:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uYlvfZRcyb9QoH0KfhkACBfYXYvVoV2t9YSk4TzZWPs=;
 b=oTzdKUgDbtb6yTguR7ygkUZm6IkCRafCeiIkL+EBYIw/wF0IFj6Lop2ZByhS6c/pD2
 81Vevr1HQNDu3ZH0uWYkyRd3Jo9Fd7/kO8TOeArc5vOy2PyYjH5Fh5SB5MLAGFkWG39s
 fcdidqIReJbuSZuErBriK4ZCmtEJYoWYAATG8Kq7iMk37zpd4i+MFJBOrIDCjXT+ZXhA
 MiU5F7n2tVOMcx9yT7+b0RegUMKdgbTBbVB80+I69socdFmvMzAIESjKZzSgDhX9RNs4
 9yeJ6q9Hh8uD/WPvaYMReBMwBxoYrn8fX4Dilfl8AJ2HeoobfJpFXDEQ23HJNUJkVls4
 w6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uYlvfZRcyb9QoH0KfhkACBfYXYvVoV2t9YSk4TzZWPs=;
 b=VekZf4wCmS8pA/R9g6JgpwOimCYgSVT+zKKgKJ01hIlQc24IIg5Y7djtVhkMltSkUg
 NoDp+IR2TIQ/eVcMQp/w8YAgwTmCQmn+6JUNNDKBaiDU39/BW43jrJql8eUZvVh6Lu3n
 w7mI40YdZtBEmfLQFdHbEYLuhxBh5BSXvAzE44jqLw7Sxta0OkIZnjMGNB0REmvVQV9h
 U8M98dR2hRqKjbVr0iYyKMtK0jdOa3HYM3PMRzJPrS21qO8ZNG/dKeXSXZdmOs2DWSj1
 tv04IiMjp1LEfQiQcQRfSgy9IzIRHTRn0bWZaelD15KuglyO8Ko1mu9aFcyIbbfqYqJZ
 LCOA==
X-Gm-Message-State: ANhLgQ0D4Tg/yX+J3arC9sNBBgzkip3ZEUaM+mY7ws0K6QwAdR6GSBhm
 3bE3NTGlw7KgMY9jHl+Ih9cYYw==
X-Google-Smtp-Source: ADFU+vtkrvkqdKBnoTpKn5/+7v0TcT/88yK+XiC+6XTOPN31/xeWATUVvmOqQuC5GnABszQrqlTSKQ==
X-Received: by 2002:a17:902:9f85:: with SMTP id
 g5mr3387075plq.152.1584251048707; 
 Sat, 14 Mar 2020 22:44:08 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 k5sm13086142pgl.3.2020.03.14.22.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 22:44:07 -0700 (PDT)
Subject: Re: [PATCH v5 58/60] target/riscv: vector register gather instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-59-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9bebb0b-324f-c1fa-8bc1-e30a633285db@linaro.org>
Date: Sat, 14 Mar 2020 22:44:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-59-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s, RVV) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            (a->rd != a->rs2));
> +}
> +GEN_OPIVX_TRANS(vrgather_vx, vrgather_vx_check)
> +GEN_OPIVI_TRANS(vrgather_vi, 1, vrgather_vx, vrgather_vx_check)

The unmasked versions of these should use gvec_dup.

For the immediate version, where we can validate the index at translation time,
we can use tcg_gen_gvec_dup_mem, so that the host vector dup-from-memory
instruction can be used.

For the register version, we should re-use the code from vext.x.s where we load
the element, bound the index and squash the value to zero for index >= VLMAX.
Then use tcg_gen_gvec_dup_i64.

For the masked versions, we should load the value, as above, and then re-use
the vmerge helper with vs2 = vd, so that we get

    vd[i] = v0[i].lsb ? val : vd[i]


> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 2219fdd6c5..5788e46dcf 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4647,3 +4647,71 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
>  GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
>  GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
>  GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
> +
> +/* Vector Register Gather Instruction */
> +#define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H, CLEAR_FN)                    \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    uint32_t index, i;                                                    \
> +                                                                          \
> +    for (i = 0; i < vl; i++) {                                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
> +            continue;                                                     \
> +        }                                                                 \
> +        index = *((ETYPE *)vs1 + H(i));                                   \
> +        if (index >= vlmax) {

The type of index should be ETYPE or uint64_t, and similar for vlmax just so
they match.


r~

