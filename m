Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA10C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2373B206A5
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYOVdjbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2373B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juNGy-0002mI-EW
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 17:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1juNGO-0002Gw-Co
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:42:28 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1juNGL-0003UO-TX
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:42:28 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k5so4179121pjg.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WAnM+AEg28RYA/0yqxUHhCYjcfhg0sGRVBIvk6M3zVM=;
 b=xYOVdjbxhN/lKp45Dbc6suFqMijEw5NTs0SFzH2Cgx3udjTGF8GYAnItqYOga74aU3
 ZvAJmWxaJt0NWs7pzvlaWhHpAvFpNj5uRmdEu33Zfx28Svvj+t2lHJ6KT/YmBmiodSTo
 u+jAqHvOtrAzg5vVlV22X9nGtn5JO8pSn8hu9iHRerQFx45yTRSPlb47NJ4P6mTcThWD
 fU/a0vNYyO4r4HEcyFr7JiwO/6Gzeqk4bkMgls4g+voYgb4+pWPl4yf+G9877xo+gBXg
 anpNLFX5lE8arA3Q1vqQ2AydiTmtP2Wwi4EPZVjDe4ZXRcTp1WywPtBzqZI21nnPjhq3
 9EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WAnM+AEg28RYA/0yqxUHhCYjcfhg0sGRVBIvk6M3zVM=;
 b=kwg5aHIdgxq0rAmQQ8aHlF9I43s7k3Vl7PDmMvjcCydoIpJfXFfvf0GiYl9UUvGNkp
 itUvNuMCYR21fk2AKnEN2Ayd5gHmex1NlexP58nuv1wQ1Zfo/1npdrXlUFkEa+WUXAbt
 /P3cmHjEhY6kgF24TviK7XWFWgFP7L8kJNEd1LLYtt/9aZOkAg23x3aeO/LfOqgMuMhK
 DkUfXZ9KNpBvruxR+rC7Prf4fhOIDoUBecETuz7BspYE938ybA0yYvSr2Jl2bZDmdV3u
 DK1PhLFN5BfsrsZfWuQ15w/ZK+j29a96hXw/s3llNrr/cPfZfLCzh1rG0BrKagvr14YH
 1yJQ==
X-Gm-Message-State: AOAM53371VSYi4a/iy0jHMvxHJeJ9bKcOz8fXWxjU7vlkc9vE+jNMAxx
 DRDW7OJrzB0u/Z92SLXE/cfsCw==
X-Google-Smtp-Source: ABdhPJw0Ol2Z9UOBsZmqgeBlNoAZjZUdX4T9IWFuLUCP4YeQAg+6ys2Jh/3Mav71XFDf5DTEO3q90g==
X-Received: by 2002:a17:902:b204:: with SMTP id
 t4mr66587134plr.132.1594503744193; 
 Sat, 11 Jul 2020 14:42:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m1sm9290690pjy.0.2020.07.11.14.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2020 14:42:23 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] tcg: Introduce target-specific page data for
 user-only
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-2-richard.henderson@linaro.org>
 <CAFEAcA-qybDD6GWYPFB6tMfTb9Kj+_bCKCxPyDYMZBr8EwbDmQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5659aa8-1e51-455f-c3be-379e3f224817@linaro.org>
Date: Sat, 11 Jul 2020 14:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qybDD6GWYPFB6tMfTb9Kj+_bCKCxPyDYMZBr8EwbDmQ@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 9:20 AM, Peter Maydell wrote:
> On Fri, 5 Jun 2020 at 05:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This data can be allocated by page_alloc_target_data() and
>> released by page_set_flags(start, end, prot | PAGE_RESET).
>>
>> This data will be used to hold tag memory for AArch64 MTE.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
>> @@ -289,6 +295,8 @@ int walk_memory_regions(void *, walk_memory_regions_fn);
>>  int page_get_flags(target_ulong address);
>>  void page_set_flags(target_ulong start, target_ulong end, int flags);
>>  int page_check_range(target_ulong start, target_ulong len, int flags);
>> +void *page_get_target_data(target_ulong address);
>> +void *page_alloc_target_data(target_ulong address, size_t size);
> 
> Could we have a doc comment for any new function that's got
> global scope, please?
> 
>>  #endif
>>
>>  CPUArchState *cpu_copy(CPUArchState *env);
> 
>> +void *page_alloc_target_data(target_ulong address, size_t size)
>> +{
>> +    PageDesc *p = page_find(address >> TARGET_PAGE_BITS);
>> +    void *ret = NULL;
>> +
>> +    if (p) {
>> +        ret = p->target_data;
>> +        if (!ret && (p->flags & PAGE_VALID)) {
>> +            p->target_data = ret = g_malloc0(size);
>> +        }
>> +    }
>> +    return ret;
> 
> Can a PageDesc validly have p->target_data != NULL but
> p->flags with PAGE_VALID not set ?

No.  But we can be called for a page that is not mapped (returning NULL) and
can be called for a page that already has associated data (returning the old
value).

> It's not clear to me why for a !PAGE_VALID page which
> has target_data already we return that pointer but
> if it doesn't have any we don't allocate: either
> "always allocate" or "always return NULL for non-valid pages"
> would seem more self-consistent.

I was expecting a non-valid page to have no data.  I will rearrange this to

    ret = NULL;
    if (p->flags & PAGE_VALID) {
        ret = p->target_data;
        if (!ret) {
            p->target_data = ret = g_malloc0(size);
        }
    }

which is probably clearer.

>> +        /* FIXME: Move page flags and target_data for each page.  */
> 
> Is this something we're going to address later in the patchset?

I had not, but I should.  Will fix.


r~

