Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B07C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 01:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDB22075A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 01:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="eumRV4dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDB22075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnYCs-0005Wp-SF
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 21:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jnYCC-0004kE-VD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 21:57:56 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:41144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jnYCB-0007KO-3H
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 21:57:56 -0400
Received: by mail-qk1-x743.google.com with SMTP id z63so5425658qkb.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=J0rOJOfjboePb7+z/BDV9QAtcExXi9JhBM8abs2lC8s=;
 b=eumRV4dvM/I9RcVJx8K6IImMseTsSAHdrSljjwpV+xAyl4fSV5hxk3j3uK0gV3j1dX
 XneRP3ydKs9MON6FVcqAOsP337Knw82uZKhlAQJp27hvqLMt26qUFawGL1lunxrBrTZX
 6No/GxcDH/q+NLRsVjR6OnAc+/jfNQOVu5CFPGfQyg7lKSQ3UscAZSLEw3Q18hU1KrMH
 JR0LuR4CKK5WmaAUyrwer6lVJhTKbxFJBcQ4ysOSzW4VVPdOvQrO6Kjv6+UwUhthftdP
 yz+dZ60nx971bkovLZMqjrs232C0l+QLUnH6IjaQPE2EThLyoifGGEmRCiWd0qV2GUAF
 DF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J0rOJOfjboePb7+z/BDV9QAtcExXi9JhBM8abs2lC8s=;
 b=VsyVIaV6xygzfoNikglBX5A2zmaYNzO/LATPwNULWSDsd1hmVaWPYCwqm1aQ9uIgfE
 Pu6WMO/8U76CcckpXGwQgsvr3Yr1poOwMOMM2YhHm82uFRmKcL8felMP/tAcSKdeEoi6
 onTXHQZu3JWnuQ9dis2vylB9d70CSWVnFwyrX8BNxm2AIvGC2inNqSPfZ0F4/huZtQfw
 vqwNv+C/ESj7IlY2zqIpWvQki0QQ9wohgq1P58a/yLdlRsud1HvGPrjwQ+s1Sc622zU0
 4PV0z3j5Lrx1k0Ut1pOfStINTwJTaiYN2vap9xX+TKqHX46GNInNtxJnMxdpgeLzkZvi
 oo3g==
X-Gm-Message-State: AOAM531f+hR367In6gWa6qVlN4Jae3uHChK5w5rqyEhckTQ9TzHuKebx
 SdLgGQUKwjjltyx5JwJ1OsOEQA==
X-Google-Smtp-Source: ABdhPJyW5VQU//EUmrgt1h1o/rwN2BXsOXTd4y2xSsauKrWm6u9mMIUe9rAy1bKWf1XmUWJfQsMtig==
X-Received: by 2002:a37:488c:: with SMTP id
 v134mr18522350qka.318.1592877473885; 
 Mon, 22 Jun 2020 18:57:53 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id r2sm9641828qtn.27.2020.06.22.18.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 18:57:53 -0700 (PDT)
Date: Mon, 22 Jun 2020 21:57:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] tests/qht-bench: Adjust rate computation and comparisons
Message-ID: <20200623015752.GB280811@sff>
References: <20200620214551.447392-1-richard.henderson@linaro.org>
 <20200621212825.GB168836@sff>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621212825.GB168836@sff>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::743;
 envelope-from=cota@braap.org; helo=mail-qk1-x743.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Philippe, who authored the fix for this in May as I mention below.

		Emilio

On Sun, Jun 21, 2020 at 17:28:25 -0400, Emilio G. Cota wrote:
> On Sat, Jun 20, 2020 at 14:45:51 -0700, Richard Henderson wrote:
> > Use <= comparisons vs the threshold, so that threshold UINT64_MAX
> > is always true, corresponding to rate 1.0 being unity.  Simplify
> > do_threshold scaling to 2**64, with a special case for 1.0.
> > 
> > Cc: Emilio G. Cota <cota@braap.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  tests/qht-bench.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> > index eb88a90137..21b1b7de82 100644
> > --- a/tests/qht-bench.c
> > +++ b/tests/qht-bench.c
> > @@ -132,7 +132,7 @@ static void do_rz(struct thread_info *info)
> >  {
> >      struct thread_stats *stats = &info->stats;
> >  
> > -    if (info->r < resize_threshold) {
> > +    if (info->r <= resize_threshold) {
> >          size_t size = info->resize_down ? resize_min : resize_max;
> >          bool resized;
> 
> This works, but only because info->r cannot be 0 since xorshift never
> returns it. (xorshift returns a random number in the range [1, u64max],
> a fact that I missed when I wrote this code.)
> If r were 0, then we would resize even if resize_threshold == 0.0.
> 
> I think it will be easier to reason about this if we rename info->r
> to info->seed, and then have a local r = info->seed - 1. Then we can keep
> the "if random < threshold" form (and its negated "if random >= threshold"
> as below), which (at least to me) is intuitive provided that random's range
> is [0, threshold), e.g. [0.0, 1.0) with drand48(3).
> 
> > @@ -154,7 +154,7 @@ static void do_rw(struct thread_info *info)
> >      uint32_t hash;
> >      long *p;
> >  
> > -    if (info->r >= update_threshold) {
> > +    if (info->r > update_threshold) {
> >          bool read;
> >  
> >          p = &keys[info->r & (lookup_range - 1)];
> > @@ -281,11 +281,18 @@ static void pr_params(void)
> >  
> >  static void do_threshold(double rate, uint64_t *threshold)
> >  {
> > +    /*
> > +     * For 0 <= rate <= 1, scale to fit in a uint64_t.
> > +     *
> > +     * For rate == 1, returning UINT64_MAX means 100% certainty: all
> > +     * uint64_t will match using <=.  The largest representable value
> > +     * for rate less than 1 is 0.999999999999999889; scaling that
> > +     * by 2**64 results in 0xfffffffffffff800.
> > +     */
> >      if (rate == 1.0) {
> >          *threshold = UINT64_MAX;
> >      } else {
> > -        *threshold = (rate * 0xffff000000000000ull)
> > -                   + (rate * 0x0000ffffffffffffull);
> > +        *threshold = rate * 0x1p64;
> 
> I'm sorry this caused a breakage for some integration tests; I thought
> this was fixed in May with:
>   https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg01477.html
> 
> Just for my own education, why isn't nextafter needed here?
> 
> Thanks,
> 		Emilio

