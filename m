Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D1DC28CBC
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 02:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F382071C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 02:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kd19CRyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F382071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jULRr-000678-3x
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 22:30:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jULR0-0005UD-R8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 22:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jULQz-0006Oz-GS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 22:29:50 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jULQy-0006H6-W8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 22:29:49 -0400
Received: by mail-pl1-x641.google.com with SMTP id z6so3167711plk.10
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=f4reCtjNzjsXTu75I8NY9VQ9DL2EU8/6lJqM14J8sS8=;
 b=Kd19CRyWXihC/EwF9Kqz4bjaCvR8esjyJhCrjBBPdxyr2MXWKpyO3woYa5WFSJjb6U
 zpe8u4oX7WD32xxqI49OKC90VVqpgu3Gs6ytfn5Ml/l3/uIoAKBmLI2tbGD2jTfSMr1P
 RnqeE64z39Slj7FtwoMl2BBd6+FzEKk2Qv5cdN+GvIVgs/Y0CwLM+eMEiu0A8pe1Q+Rq
 w91AOJ9SdPcdBRNapYHLylW1s8i7bgyj4LA6HFfH3d6NHdMTlf5/+WjG4pFk1F2ANPvQ
 u+G2dXfWqwDhQ++g8y6p5CkVN12oC3kmAS1wsRFgoAYnYDR+B5mAOtoWgDN/0LSTm6OU
 ed8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f4reCtjNzjsXTu75I8NY9VQ9DL2EU8/6lJqM14J8sS8=;
 b=pb/t7Qp8sO2FnCwWtm1krBLi5fDb/dPAliOKqrDGBd0jI4Rm5pfyrsdIyFo6IYIw96
 8iVp0GQqvlvrWBFASj9AWmyflgXvaCaYGo/HbGEqkvYrCGU96cwTvLEOlJQrWAg/cPxc
 BAw27drA6OHc+/quSxbBA/VWooBJyYvf55k+fSq28JRBeg4LfFkuOpcxFRcQk92dymnL
 SKYanpMVzdsnSIQLx2aTKwALsQHTN6Q8KPluvxfP2cDDTeHihxptsCXHIHHaIMyteJOM
 dSQMJrQ42yWXKQR2GpBmTdYO1FVgzrJ2d52DUeeS0PljJFv8VLK5DSzQiJ9PzP5K6vhh
 Z4kw==
X-Gm-Message-State: AGi0Pua5rh28MSNIq+68KhvAjRF12vWFqnlks2/FVwCvFb6ykIPsJQfT
 cvF1yRTsdkPighBJQYCOqBXjjiNAa7Q=
X-Google-Smtp-Source: APiQypKw7VikJhCXSnQ3QTwZSV/0xH1u4QW/wvh6EKmuWljwv4IdrcyeiaAVXpu0O4cyu9Vs+RjbnA==
X-Received: by 2002:a17:90a:8a09:: with SMTP id
 w9mr2091719pjn.95.1588300186727; 
 Thu, 30 Apr 2020 19:29:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u5sm831482pgi.70.2020.04.30.19.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 19:29:46 -0700 (PDT)
Subject: Re: [PATCH 27/36] target/arm: Convert Neon VABA 3-reg-same to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-28-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a60a2de1-b46a-a13b-8a60-4006c9d70ff5@linaro.org>
Date: Thu, 30 Apr 2020 19:29:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-28-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> +    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
> +        tmp = neon_load_reg(a->vn, pass);
> +        tmp2 = neon_load_reg(a->vm, pass);
> +        abd_fn(tmp, tmp, tmp2);
> +        tcg_temp_free_i32(tmp2);
> +        tmp2 = neon_load_reg(a->vd, pass);
> +        add_fn(tmp, tmp, tmp2);
> +        tcg_temp_free_i32(tmp2);
> +        neon_store_reg(a->vd, pass, tmp);
> +    }
> +    return true;
> +}
> +
> +static bool trans_VABA_S_3s(DisasContext *s, arg_3same *a)
> +{
> +    static NeonGenTwoOpFn * const abd_fns[] = {
> +        gen_helper_neon_abd_s8,
> +        gen_helper_neon_abd_s16,
> +        gen_helper_neon_abd_s32,
> +    };
> +    static NeonGenTwoOpFn * const add_fns[] = {
> +        gen_helper_neon_add_u8,
> +        gen_helper_neon_add_u16,
> +        tcg_gen_add_i32,
> +    };

This can be packaged into one operation.  E.g.

static void gen_aba_s8(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m)
{
    TCGv_i32 t = tcg_temp_new_i32();

    gen_helper_neon_abd_s8(t, n, m);
    gen_helper_neon_add_u8(d, d, t);
    tcg_temp_free_i32(t);gen_aba_s8
}

static const GVecGen3 op = {
    .fni4 = gen_aba_s8,
    .load_dest = true
};

etc.

FWIW, this is one that I've fully converted on my sve2 branch.  aba(n,m,a) =
max(n,m) - min(n,m) + a -- four fully vectorized operations.  So anything that
allows a drop-in replacement would be nice.  But whatever is easiest for you.


r~

