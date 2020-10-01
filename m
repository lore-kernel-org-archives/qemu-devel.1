Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87978C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0380D2075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbARUAn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0380D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1de-0003z5-Ra
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1TQ-0001C2-5H
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:30:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1TN-0003kS-U5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:30:27 -0400
Received: by mail-ot1-x342.google.com with SMTP id m12so6074865otr.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=22dMjxOWJhqG+irRskkFjwXOStfShxVwK0tEpj/xEEo=;
 b=PbARUAn8z8Q+WWaBbK2PCktSA20FwJ/Gie1PmoKW+E1p1KuKX90LKhwnCq+Qim5jrE
 rY/9vtP7d5JfOAJcNcLtmg2XYuECq/QLavsAPebPx2DpGUSON6YceDKVF4GadmOIzXNw
 szbImPWwxfh07sgP035hAhSZED43uG4dGPrmtzH+oJcGHVVMER+LT9fKXqmErOOsEQmm
 d24fBszEzS7fcivEywKGhDI7fRSuqwG9F68ZlykXr/+dzoBePPKQN+QrV5psreIT580h
 Ueld4KH/C78jQqAvuIr9fxeb/erqqWpIDSVXtRGLGwd7PQMIYDvoJrcqQKAbwV4VVLeL
 CjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22dMjxOWJhqG+irRskkFjwXOStfShxVwK0tEpj/xEEo=;
 b=hFAGLiLrdHVK0lEi3mt9QKHHAik8UtfTkz/cvNyyF1LoxL6bC8anBkIbU3fFXTphhz
 ZnMHBXpQsPvGMTlyHSQU3JaB9k6+GyS7to/kn4b+ULIQQUfAC7tlD1CEcjZ/q5HMdnEE
 8LY09Z0pDU1wQ4wYiKr9kF6FxwWKQMBJKcia+iGSb5TFLukMPp0O9UA9XkKAERiFh2ay
 AvuNwm2NuCUJqoxyN195qnBH+/6lVrfEV4lxuW0HOfev/FlLrWXXDiNEucyx8HFQLY92
 W5+BlOs0nwpFUQrfSoyKYM7vAMlrNADriSgTk2CBgQ04xeCY3vAdN2XWlalKTmMzGnTq
 a/YQ==
X-Gm-Message-State: AOAM5319LjWtewsTDnBXvtmfwt3p6RoQnERIMR4cIZa7YxpmqqZ4zZSM
 lGD+wPrhLrVHX9YtQz8o6U+AJQ==
X-Google-Smtp-Source: ABdhPJwxCAVGwhMtQfmMS+GBf5yXsoHub7oDrtOmnycaxWEsVS2cUP6qKhWSCCYnOioWYOB2xWXNNw==
X-Received: by 2002:a9d:24aa:: with SMTP id z39mr5529475ota.258.1601569824635; 
 Thu, 01 Oct 2020 09:30:24 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id i6sm1229838oig.54.2020.10.01.09.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:30:23 -0700 (PDT)
Subject: Re: [PATCH v1 15/20] s390x/tcg: Implement 32/128 bit for VECTOR FP
 TEST DATA CLASS IMMEDIATE
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <755b4603-cca0-c5fc-6996-e521a3bec12f@linaro.org>
Date: Thu, 1 Oct 2020 11:30:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  3 ++
>  target/s390x/translate_vx.c.inc | 26 ++++++++---
>  target/s390x/vec_fpu_helper.c   | 76 +++++++++++++++++++--------------
>  3 files changed, 69 insertions(+), 36 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index bee283e3d4..c2ded83669 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -331,8 +331,11 @@ DEF_HELPER_FLAGS_5(gvec_vfs32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>  DEF_HELPER_FLAGS_5(gvec_vfs64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>  DEF_HELPER_FLAGS_5(gvec_vfs64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>  DEF_HELPER_FLAGS_5(gvec_vfs128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_4(gvec_vftci32, void, ptr, cptr, env, i32)
> +DEF_HELPER_4(gvec_vftci32s, void, ptr, cptr, env, i32)
>  DEF_HELPER_4(gvec_vftci64, void, ptr, cptr, env, i32)
>  DEF_HELPER_4(gvec_vftci64s, void, ptr, cptr, env, i32)
> +DEF_HELPER_4(gvec_vftci128, void, ptr, cptr, env, i32)
>  
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
> diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
> index 7d4811ccf7..6bd599b319 100644
> --- a/target/s390x/translate_vx.c.inc
> +++ b/target/s390x/translate_vx.c.inc
> @@ -2991,16 +2991,32 @@ static DisasJumpType op_vftci(DisasContext *s, DisasOps *o)
>      const uint16_t i3 = get_field(s, i3);
>      const uint8_t fpf = get_field(s, m4);
>      const uint8_t m5 = get_field(s, m5);
> -    gen_helper_gvec_2_ptr *fn = gen_helper_gvec_vftci64;
> +    const bool se = extract32(m5, 3, 1);
> +    gen_helper_gvec_2_ptr *fn = NULL;
>  
> -    if (fpf != FPF_LONG || extract32(m5, 0, 3)) {
> +    switch (fpf) {
> +    case FPF_SHORT:
> +        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
> +            fn = se ? gen_helper_gvec_vftci32s : gen_helper_gvec_vftci32;
> +        }
> +        break;
> +    case FPF_LONG:
> +        fn = se ? gen_helper_gvec_vftci64s : gen_helper_gvec_vftci64;
> +        break;
> +    case FPF_EXT:
> +        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
> +            fn = gen_helper_gvec_vftci128;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    if (!fn || extract32(m5, 0, 3)) {
>          gen_program_exception(s, PGM_SPECIFICATION);
>          return DISAS_NORETURN;
>      }
>  
> -    if (extract32(m5, 3, 1)) {
> -        fn = gen_helper_gvec_vftci64s;
> -    }
>      gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env, i3, fn);
>      set_cc_static(s);
>      return DISAS_NEXT;
> diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
> index b7045e85d6..f18f0ae8e2 100644
> --- a/target/s390x/vec_fpu_helper.c
> +++ b/target/s390x/vec_fpu_helper.c
> @@ -23,6 +23,9 @@
>  const float32 float32_ones = make_float32(-1u);
>  const float64 float64_ones = make_float64(-1ull);
>  const float128 float128_ones = make_float128(-1ull, -1ull);
> +const float32 float32_zeroes = make_float32(0);
> +const float64 float64_zeroes = make_float64(0);
> +const float128 float128_zeroes = make_float128(0, 0);

These already exist as "zero" not "zeroes".

Otherwise looks ok, modulo the same comments as for all the other macros in
this series.


r~

