Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2090BC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954AE208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYmz2ucp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954AE208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1EH-000716-HJ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0sZ-0007Qy-5f
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:52:23 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0sW-0005dq-0q
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:52:22 -0400
Received: by mail-ot1-x329.google.com with SMTP id 60so5903117otw.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Rp1olVyD10Ryn3kxXfDXwCjSIOO1hy/QgnZ5VdrFGDM=;
 b=LYmz2ucpkHzvfR6r1vKM2HPrAuVxkoNhqINPuG2w6VQyYpBqSoOm4alWp+oGmtGzoo
 sVCnAIbBAwDgadFmGvBDxrDcV5zTjtkWB5bIHKG9VK/f0uBh5/PYBvxGXWf6btpqxdKO
 ooMogHmmk5vcVv/hPc/ikbm6rzD78DMKzKin1pOOcqRHYAV6rYtNzOcVik2ICnuIxEPk
 iulSXsoA7sIxwTUyFzO+qoAtKpPUuJj5kr6RqQyk1OE90xgEyAmeqXHa6Ey/Gr9nJmTO
 rOLaCuIe+aY0nSkb8DaGZrpvF7dgZFYUw1rntUvMkMNta4f6W5XcccA6OaAg6HUGUP/r
 VByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rp1olVyD10Ryn3kxXfDXwCjSIOO1hy/QgnZ5VdrFGDM=;
 b=KQidiXymk303i05sav8N3Lb3E/enyjxcb8mGHtQYrkKISK6hj8PYqqJ/WYCbg/V5/R
 sWClyc6g6plNLMMGz5SNFyt1gR8etCcbMWb0ymjvhRRIq+RjJGBEzKlQvno5bu/oNIxc
 eOd1rQNXGjO0KMtDzW+07GIlFObPtA73cUXKUWK1fynON+5Q7QzSFxn6ptw8Y+4r5Bs8
 4T2eAuijQ9dqWnZ26x7L+BqHtdEJyINW+iToT9/uvTYfjJ9Xo2WQqmTkXBk/QvUD9his
 gVf3Tim3r75+06DJmq/my5z3IvtyBXgGp1+xsCEt1CsE4WF3sXjyB3IZuyExDil681qu
 jLYw==
X-Gm-Message-State: AOAM531JBwtDTd0aTapljh2nMPRKRwWRVTEWDIaj6ctv9I3wBK8DPJEY
 VkmomtLCbHb83VnAfySUXDlGlA==
X-Google-Smtp-Source: ABdhPJyz9BqtWIhQ+SzHlg0oVcXIdCZqVdUTQ+dWqQCkbIaH7/7d1ERn2PAP8kccalpcFpuzfRt16Q==
X-Received: by 2002:a9d:360b:: with SMTP id w11mr5691634otb.203.1601567538813; 
 Thu, 01 Oct 2020 08:52:18 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id b16sm1280202otq.31.2020.10.01.08.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:52:18 -0700 (PDT)
Subject: Re: [PATCH v1 08/20] s390x/tcg: Implement 32/128 bit for VECTOR FP
 COMPARE (AND SIGNAL) SCALAR
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e87d0716-2e62-33dc-a5b6-6e29d19d225b@linaro.org>
Date: Thu, 1 Oct 2020 10:52:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> @@ -2601,19 +2601,41 @@ static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
>  {
>      const uint8_t fpf = get_field(s, m3);
>      const uint8_t m4 = get_field(s, m4);
> +    gen_helper_gvec_2_ptr *fn = NULL;
>  
> -    if (fpf != FPF_LONG || m4) {
> +    switch (fpf) {
> +    case FPF_SHORT:
> +        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
> +            fn = gen_helper_gvec_wfk32;
> +            if (s->fields.op2 == 0xcb) {

Hoist and name this comparision (e.g. bool signal = ...).

> -static int wfc64(const S390Vector *v1, const S390Vector *v2,
> -                 CPUS390XState *env, bool signal, uintptr_t retaddr)
> -{
> -    /* only the zero-indexed elements are compared */
> -    const float64 a = s390_vec_read_element64(v1, 0);
> -    const float64 b = s390_vec_read_element64(v2, 0);
> -    uint8_t vxc, vec_exc = 0;
> -    int cmp;
> -
> -    if (signal) {
> -        cmp = float64_compare(a, b, &env->fpu_status);
> -    } else {
> -        cmp = float64_compare_quiet(a, b, &env->fpu_status);
> -    }
> -    vxc = check_ieee_exc(env, 0, false, &vec_exc);
> -    handle_ieee_exc(env, vxc, vec_exc, retaddr);
> -
> -    return float_comp_to_cc(env, cmp);
> +#define DEF_WFC(BITS)                                                          \
> +static int wfc##BITS(const S390Vector *v1, const S390Vector *v2,               \
> +                     CPUS390XState *env, bool signal, uintptr_t retaddr)       \
> +{                                                                              \
> +    /* only the zero-indexed elements are compared */                          \
> +    const float##BITS a = s390_vec_read_float##BITS(v1, 0);                    \
> +    const float##BITS b = s390_vec_read_float##BITS(v2, 0);                    \
> +    uint8_t vxc, vec_exc = 0;                                                  \
> +    int cmp;                                                                   \
> +                                                                               \
> +    if (signal) {                                                              \
> +        cmp = float##BITS##_compare(a, b, &env->fpu_status);                   \
> +    } else {                                                                   \
> +        cmp = float##BITS##_compare_quiet(a, b, &env->fpu_status);             \
> +    }                                                                          \
> +    vxc = check_ieee_exc(env, 0, false, &vec_exc);                             \
> +    handle_ieee_exc(env, vxc, vec_exc, retaddr);                               \
> +                                                                               \
> +    return float_comp_to_cc(env, cmp);                                         \
>  }
> +DEF_WFC(32)
> +DEF_WFC(64)
> +DEF_WFC(128)

So, same issue here vs debugging.

If you keep this macroized, I don't see the value in two levels of macros...

> +#define DEF_GVEC_WFC(BITS)                                                     \
> +void HELPER(gvec_wfc##BITS)(const void *v1, const void *v2, CPUS390XState *env,\
> +                            uint32_t desc)                                     \
> +{                                                                              \
> +    env->cc_op = wfc##BITS(v1, v2, env, false, GETPC());                       \
>  }
> +DEF_GVEC_WFC(32)
> +DEF_GVEC_WFC(64)
> +DEF_GVEC_WFC(128)
>  
> +#define DEF_GVEC_WFK(BITS)                                                     \
> +void HELPER(gvec_wfk##BITS)(const void *v1, const void *v2, CPUS390XState *env,\
> +                            uint32_t desc)                                     \
> +{                                                                              \
> +    env->cc_op = wfc##BITS(v1, v2, env, true, GETPC());                        \
>  }
> +DEF_GVEC_WFK(32)
> +DEF_GVEC_WFK(64)
> +DEF_GVEC_WFK(128)

These could be folded in to the first macro via parameters.


r~


