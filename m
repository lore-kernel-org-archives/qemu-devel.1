Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA0AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11152078E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vb8yV8b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11152078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnrZ0-0007qX-3d
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 18:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnrYG-0006nx-2J
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 18:38:00 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnrYC-0000el-G3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 18:37:59 -0400
Received: by mail-pl1-x642.google.com with SMTP id bh7so67611plb.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wT6E8j6m4VapGwgCmLEFjV+Geu7JMe2PEbBC/bafX7c=;
 b=Vb8yV8b5wmqFDfNKR8qRmpr5WdpxM4h8ain93+pbhg2FOm1aheAw1U2E3jzrEQnXfS
 cAHuT2rjv6/sQkTsR+cv2kPXRXPP27MJMV+jP4jEYNlrxpCjrc4fChKr8sOUXwE8nD7t
 /xX6hN8tOI9IvU56WQr9uCQgl9r0BOz3r0XI9HwUSC6eKUnYwnHPeK8rwSf/nzHpg1H6
 Bc36S4DWsCzqAcZJtsF+5SQqE6MUewbt0pzo6Cxmv1/UUl/9nCBtz8VKTBHK7GjLKTF+
 A4UQJhO5yFaZcAqJ80asnaVdJPvXsYe/Ne8JkUQzvZWI2ckUHtUirT/A0ATIRsLRZ3M8
 RMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wT6E8j6m4VapGwgCmLEFjV+Geu7JMe2PEbBC/bafX7c=;
 b=q4kcmikqLG93Gs2zR/lCVLBhCCrYz8m3jB/7/LvtkkKXMUabhrwgFwRli4CBR0X/LB
 h5ixkOKE/YVCPtzbxmL4rxgzAZhUh7D5KV/9h4bTjxCOIVY3IdMfHLaAafzglzL3kryH
 qhb9SvvsythylvgYkYUbCBZUt3TXxr/vlfBhH+kggstf6iF4c/WfokFqTAnIVOt5o7B9
 y9GUrTMPHKeVk1nhCmZYpHqQYF1BXc0/Lsh4BB7w/asQta2qVfkMQDsVRfWzl/sfi5yv
 UKT4s4wwlDcZBbdW2uMw9BemMEGz0D48eRfLka4H5xKNb5Jk2wVNR58fik/z92Qfm57t
 TOiw==
X-Gm-Message-State: AOAM530bk9FQFf/DqZYY/SEsjqtEKchY7g9nOmXwUpK7veLo5dUy6dob
 lI+qO3E1VkVSkw05/DZ5ousmoA==
X-Google-Smtp-Source: ABdhPJzqgFEJqVIdqVO1mMlgUr5w+OG3qgRQelLMg2DovreFm7fO65w6wByZiwbaCz7rCBnzXfai0A==
X-Received: by 2002:a17:90a:e283:: with SMTP id
 d3mr4594815pjz.170.1592951873731; 
 Tue, 23 Jun 2020 15:37:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 9sm2553288pfh.160.2020.06.23.15.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 15:37:52 -0700 (PDT)
Subject: Re: [PATCH] tests/qht-bench: Adjust rate computation and comparisons
To: "Emilio G. Cota" <cota@braap.org>
References: <20200620214551.447392-1-richard.henderson@linaro.org>
 <20200621212825.GB168836@sff>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d8e64843-832c-5939-0c85-27b2ad0fe13c@linaro.org>
Date: Tue, 23 Jun 2020 15:37:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200621212825.GB168836@sff>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/21/20 2:28 PM, Emilio G. Cota wrote:
>> -    if (info->r < resize_threshold) {
>> +    if (info->r <= resize_threshold) {
>>          size_t size = info->resize_down ? resize_min : resize_max;
>>          bool resized;
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

Fair enough.

>>  static void do_threshold(double rate, uint64_t *threshold)
>>  {
>> +    /*
>> +     * For 0 <= rate <= 1, scale to fit in a uint64_t.
>> +     *
>> +     * For rate == 1, returning UINT64_MAX means 100% certainty: all
>> +     * uint64_t will match using <=.  The largest representable value
>> +     * for rate less than 1 is 0.999999999999999889; scaling that
>> +     * by 2**64 results in 0xfffffffffffff800.
>> +     */
>>      if (rate == 1.0) {
>>          *threshold = UINT64_MAX;
>>      } else {
>> -        *threshold = (rate * 0xffff000000000000ull)
>> -                   + (rate * 0x0000ffffffffffffull);
>> +        *threshold = rate * 0x1p64;
> 
> I'm sorry this caused a breakage for some integration tests; I thought
> this was fixed in May with:
>   https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg01477.html
> 
> Just for my own education, why isn't nextafter needed here?

I hoped I was being clear in the comment, but re-reading, it doesn't finish the
thought.

We have removed 1.0, so the rate values are between 0 and nextafter(1, 0) =
0x1.fffffffffffff00000p-1 = 0.999999999999999889.

Scaling by 2**64 results in an exact extract of the 53-bit mantessa, evenly
spread across 0 to 0xfffffffffffff800.  Plus 1.0 -> UINT64_MAX, which we could
consider off-by-one its "proper" value.

If we scale by nextafter(0x1p64, 0), then the values are spread across 0 to
0xfffffffffffff000.  The gap is twice as large between 1.0 and nextafter(1, 0).


r~

