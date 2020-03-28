Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F80C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F8220717
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oX+bRPDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F8220717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI2PW-0005NI-6Z
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 23:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2Ot-0004xw-UK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI2Os-0003jn-NK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:44:47 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI2Os-0003j8-CP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:44:46 -0400
Received: by mail-pj1-x1041.google.com with SMTP id g9so4614877pjp.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 20:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+Xt60DE0ytcxo0y3SPgpvTz1Oor5Fguv0cMoUSzHzag=;
 b=oX+bRPDxr+hM04WdqbMDwcYZn0pzvArZ0NAt+wW2ctKwJHlUld6Z5n6V76JQvBbeGC
 FH1KG9JWmq98sSDH3Xb9Bi7mHwmRGeFMYrM+0o15mALu2VDpGDPefXHyIexuPCi3mK3p
 lpm/kzQ7kgB3nFXp+t2SGbzDgpFIMvtmiwdWX9v+a4mHePGWRcW25H9KhatGirY20u6c
 fue9tGAzPzSQy5OnUX3OY2BUvnMS0U4fPop6p0Nv04XOaG4ULKy3l5rLxoK8WGYGEiUX
 OHQoWySeJs6VgUyPwrtLsFogVRI/PfNqCloFr4fLKzNmV3nrbK9qdJwk7WVUk/V8VlGy
 DB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+Xt60DE0ytcxo0y3SPgpvTz1Oor5Fguv0cMoUSzHzag=;
 b=sb2S8dL+4YRM3lZ4N0MsbbtmAaI0xyaMxwkESZN0yVQjLGNO27VxM9Rz4KzOdin65k
 EOLO87jwPtqQLMFA8Fg9n6c/kpvAC7UwYUq+wv5TSTiYsaJHvHUVpsUWDdRhFGW5Z4py
 t4xM3aPHngGN9G/mGzB5ADlObKvj8bioVaRpzqpCTYLNHSVdP7hqANtQIKokusibMKtN
 t58qYSp7uUNRH08uMoJ25TzNLbTDN+9mdu8js6eRWBrF/zc+q+7DbopMGTN/IUmSMZE6
 eGA0wcfOVb38+5qnUz/ADKj/EDyXyaD9O/SVNG+8n6cdY5AenSL9kbOSdWovVCF2SBqc
 i3mg==
X-Gm-Message-State: ANhLgQ1ZWUUUXZh86SPCpRvKPbDZJKNv22gLFOcaZWtTK5Ccq07fS5cH
 /KfSgGIN09aA7yGfzkGdYCi7hQ==
X-Google-Smtp-Source: ADFU+vsqp9H/T1a8Ou03cqhwRmL8JuvFFJvEA6cNNj7dDrs8D3EJCqXF/Iwnd32j53HXNDVDuoX91Q==
X-Received: by 2002:a17:90b:4910:: with SMTP id
 kr16mr2839200pjb.142.1585367084882; 
 Fri, 27 Mar 2020 20:44:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id np4sm4952893pjb.48.2020.03.27.20.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 20:44:44 -0700 (PDT)
Subject: Re: [PATCH v6 57/61] target/riscv: floating-point scalar move
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-58-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3505142-78fb-4142-1fb0-aafc20c1788f@linaro.org>
Date: Fri, 27 Mar 2020 20:44:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-58-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> +/* Floating-Point Scalar Move Instructions */
> +static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
> +{
> +    if (!s->vill && has_ext(s, RVF) &&
> +        (s->mstatus_fs != 0) && (s->sew != 0)) {
> +#ifdef HOST_WORDS_BIGENDIAN
> +        int ofs = vreg_ofs(s, a->rs2) + ((7 >> s->sew) << s->sew);
> +#else
> +        int ofs = vreg_ofs(s, a->rs2);
> +#endif

Use endian_ofs from patch 55.

> +        switch (s->sew) {
> +        case MO_8:
> +            tcg_gen_ld8u_i64(cpu_fpr[a->rd], cpu_env, ofs);
> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
> +                            0xffffffffffffff00ULL);
> +            break;

MO_8 should be illegal.

> +        case MO_16:
> +            tcg_gen_ld16u_i64(cpu_fpr[a->rd], cpu_env, ofs);
> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
> +                            0xffffffffffff0000ULL);
> +            break;
> +        case MO_32:
> +            tcg_gen_ld32u_i64(cpu_fpr[a->rd], cpu_env, ofs);
> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
> +                            0xffffffff00000000ULL);
> +            break;
> +        default:
> +            if (has_ext(s, RVD)) {
> +                tcg_gen_ld_i64(cpu_fpr[a->rd], cpu_env, ofs);
> +            } else {
> +                tcg_gen_ld32u_i64(cpu_fpr[a->rd], cpu_env, ofs);
> +                tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
> +                                0xffffffff00000000ULL);
> +            }
> +            break;

Maybe better with MO_64 and default: g_assert_not_reached().

> +static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
> +{
> +    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
> +        TCGv_ptr dest;
> +        TCGv_i64 src1;
> +        static gen_helper_vfmv_s_f * const fns[3] = {
> +            gen_helper_vfmv_s_f_h,
> +            gen_helper_vfmv_s_f_w,
> +            gen_helper_vfmv_s_f_d

You shouldn't need to duplicate the vmv_s_x_* helpers.


r~

