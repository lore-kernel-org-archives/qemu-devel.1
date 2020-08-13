Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5184BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B1720855
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pt7DE+PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B1720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6G10-00070W-Cv
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6G0Q-0006Ts-BU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:23:06 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6G0O-0000Uh-N7
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:23:06 -0400
Received: by mail-pj1-x1041.google.com with SMTP id c10so4443918pjn.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=58H6ZzsrhOuoVWULktITFqhwXRDdPK96sRu8lerSH/w=;
 b=Pt7DE+PSdyPpI+EO4jBxEQwYanYQhIfMRksX7elRZadyZk+oF4PQQAT+Efb6X0+Ugp
 IzcTqOYuuuPSABxrl82tYAiUd7b773LxYZ0EHLB6wdiFDVi5NDrwz6WLLhR6W7v3yWq+
 cyY1/SIYj8KvWw1wgyRH8WXkRuSwAlsbAbcqgDnwWFK2IRQeoZPK8aMxTU++VGjjLR0S
 wRAi5i1c0i54rCPkq+T6MU9m21g5DW5kUVYBEaOsRoOJbvXcP+oW40+fTyRKj3lJrRVw
 YwVyOnJarkP557rYaBcxjkQ0HgdgxBeXPMlJFgKJZFBR8m6h6oWTZ2R7PqnZHHg0Gt9c
 31IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=58H6ZzsrhOuoVWULktITFqhwXRDdPK96sRu8lerSH/w=;
 b=W9GdU5RlkHdbWURukkuqUqfPFPkd+RKugRDUHXIosLfIFMgHwrQcCUg5w2nDQ2x3MA
 Tk1W05LuCfYfi45U6OXLAJ3Dt2rrWMqGREU7QUT+MomRByXcgH4PwWJs2kWqxjKu87tG
 YE29gH3b/0A2DD/DMU8YNX0BFV9kVjuieo4bUkrYIYv/EmmijYv+ArAwybdjEY7YbEY8
 Xq/zZCGjQjXMluTnv1QQuOFfvEXWbnIuiARYkMxN3p+GLxl/n1hMCuxlP+P8U6Oq0rQ1
 FhgSeq8nIdy5JggNguHwFV1dYcVvpHNBBgCrVCBNx4ymvLxjZXVyJkv82JDshCJaprlF
 Cgvw==
X-Gm-Message-State: AOAM533COFiz6JUbYm6kpvqjDUq0LtyltcbkTimhWMKFdyESwPR2za3c
 +m01myle/Fi4GdF2r2Sc6FhhDw==
X-Google-Smtp-Source: ABdhPJwcd6cmTdWOZCkIoXlDPiKqljkbV6QLuOQLeCeGgigAlImGDwe4SImhP5RUgqyxCPTkIGYBCg==
X-Received: by 2002:a17:90a:bb81:: with SMTP id
 v1mr5670699pjr.168.1597335782597; 
 Thu, 13 Aug 2020 09:23:02 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x28sm6618410pfq.141.2020.08.13.09.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 09:23:01 -0700 (PDT)
Subject: Re: [PATCH 08/11] tcg/optimize: Remove redundant statement in
 tcg_optimize()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-9-kuhn.chenqun@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <800035ed-a522-a974-1c1d-437efe7ff25b@linaro.org>
Date: Thu, 13 Aug 2020 09:22:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813073712.4001404-9-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: Richard Henderson <rth@twiddle.net>, pannengyuan@huawei.com,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 12:37 AM, Chen Qun wrote:
> Clang static code analyzer show warning:
> tcg/optimize.c:1267:17: warning: Value stored to 'nb_iargs' is never read
>                 nb_iargs = 2;
>                 ^          ~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/optimize.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 53aa8e5329..d5bea37290 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1264,7 +1264,6 @@ void tcg_optimize(TCGContext *s)
>                  op->opc = opc = (opc == INDEX_op_movcond_i32
>                                   ? INDEX_op_setcond_i32
>                                   : INDEX_op_setcond_i64);
> -                nb_iargs = 2;
>              }
>              goto do_default;

I prefer not to make this change.

nb_iargs is the cached value that corresponds to opc, which we have just
changed.  If we later make a change at "do_default" that uses nb_iargs, failure
to update the value here will be a very hard bug to find.

I am happy to let the compiler remove this as dead code itself.


r~

