Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E5C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A682529B
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="UVNkEhCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A682529B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn7WV-00057t-3C
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 17:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jn7Vu-0004iZ-FB
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 17:28:30 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:35705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jn7Vs-0000gi-Fu
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 17:28:30 -0400
Received: by mail-qk1-x741.google.com with SMTP id q198so6061760qka.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eYYxd/8qRFMHr/H9eqV3U5KaxaUju/kYtQUQa98TrQA=;
 b=UVNkEhCqPIZ9WHTHoYeOIxv1w6suxAXplsHFk1+FBvqct06I83X2FBqP4QR5AaQz9+
 5x7NIggRm9COT4NtN2EAZYcdNb+xKgzOTD6q/yp1uFEjOTMxnda6y4ENV9rqMjrcelfI
 jJqril3Au4w8AiE2sFFc0mlJ2qh+b0dqnhkAop45prTI5PiLtUzxyXz06XGddDTB+cVJ
 Vg0M7tZn+KKWnNGDhXMCjOqMsvdQihRVfkBY10QGpkt4f09DaLtFXSSeSSfiMzYZpO3H
 JdeTPNFixWFLmjW0nAgmGGWoIx/2lVnQvGcJANnSJ4gVGYRz6FhelkrhNa7t4mbJcuVD
 95DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eYYxd/8qRFMHr/H9eqV3U5KaxaUju/kYtQUQa98TrQA=;
 b=pEqZwv9r7rn4tWjbTk09UIz8Zsm/QsJJ4lAK00iNRfvCe9vyZV1YORDZXJ3g1lRWMW
 WGXRaeQyUP4X4wwQOgdXSdwUQwAdinhiil6YvIh/xIfJISt+q4CdhQNgOoBcIq+lWLvq
 YhpZD5XT2IfC0ohMpievUnn2MHwlUkCG0C6F/I0JgofrTkdYaS9IhOl1tvINmTbNlCrc
 0+Pzjrcjpajr2MhT7er2nv9knDLJMPAfTuKkTIg+rD9RYE8yT5z7QGVwJaGFVcCoWUiL
 3+ZXga2ojOJcbLfawCttoV4lUTElcKUHje28o3YuHIuy3973IlZfF3IsecglQsuXZAjY
 8vsw==
X-Gm-Message-State: AOAM530UGCFeVwJ5y9eRw2TMaGhRHG8xsVaxmBEDaPsKGss182StBP2Z
 0U+tGsEEPm4ficHXbfjxVSzQ8g==
X-Google-Smtp-Source: ABdhPJymk4MlaWrofJrB3vsHX9zmbiFx/heRVGRVNkqPOabIFM8Z6tXFxbZFvMD2oBIsvt+DQ6UHyQ==
X-Received: by 2002:a37:4e4a:: with SMTP id c71mr12746196qkb.61.1592774907138; 
 Sun, 21 Jun 2020 14:28:27 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id l127sm5831990qkc.117.2020.06.21.14.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 14:28:26 -0700 (PDT)
Date: Sun, 21 Jun 2020 17:28:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] tests/qht-bench: Adjust rate computation and comparisons
Message-ID: <20200621212825.GB168836@sff>
References: <20200620214551.447392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620214551.447392-1-richard.henderson@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::741;
 envelope-from=cota@braap.org; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 20, 2020 at 14:45:51 -0700, Richard Henderson wrote:
> Use <= comparisons vs the threshold, so that threshold UINT64_MAX
> is always true, corresponding to rate 1.0 being unity.  Simplify
> do_threshold scaling to 2**64, with a special case for 1.0.
> 
> Cc: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/qht-bench.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index eb88a90137..21b1b7de82 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -132,7 +132,7 @@ static void do_rz(struct thread_info *info)
>  {
>      struct thread_stats *stats = &info->stats;
>  
> -    if (info->r < resize_threshold) {
> +    if (info->r <= resize_threshold) {
>          size_t size = info->resize_down ? resize_min : resize_max;
>          bool resized;

This works, but only because info->r cannot be 0 since xorshift never
returns it. (xorshift returns a random number in the range [1, u64max],
a fact that I missed when I wrote this code.)
If r were 0, then we would resize even if resize_threshold == 0.0.

I think it will be easier to reason about this if we rename info->r
to info->seed, and then have a local r = info->seed - 1. Then we can keep
the "if random < threshold" form (and its negated "if random >= threshold"
as below), which (at least to me) is intuitive provided that random's range
is [0, threshold), e.g. [0.0, 1.0) with drand48(3).

> @@ -154,7 +154,7 @@ static void do_rw(struct thread_info *info)
>      uint32_t hash;
>      long *p;
>  
> -    if (info->r >= update_threshold) {
> +    if (info->r > update_threshold) {
>          bool read;
>  
>          p = &keys[info->r & (lookup_range - 1)];
> @@ -281,11 +281,18 @@ static void pr_params(void)
>  
>  static void do_threshold(double rate, uint64_t *threshold)
>  {
> +    /*
> +     * For 0 <= rate <= 1, scale to fit in a uint64_t.
> +     *
> +     * For rate == 1, returning UINT64_MAX means 100% certainty: all
> +     * uint64_t will match using <=.  The largest representable value
> +     * for rate less than 1 is 0.999999999999999889; scaling that
> +     * by 2**64 results in 0xfffffffffffff800.
> +     */
>      if (rate == 1.0) {
>          *threshold = UINT64_MAX;
>      } else {
> -        *threshold = (rate * 0xffff000000000000ull)
> -                   + (rate * 0x0000ffffffffffffull);
> +        *threshold = rate * 0x1p64;

I'm sorry this caused a breakage for some integration tests; I thought
this was fixed in May with:
  https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg01477.html

Just for my own education, why isn't nextafter needed here?

Thanks,
		Emilio

