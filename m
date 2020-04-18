Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9086DC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD7521D91
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3B+2PQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD7521D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPeTV-0004xh-Ue
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 23:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPeM9-0002qE-M4
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPeM0-0000Oz-Gq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:41:18 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPeLy-0000Dh-6T
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:41:14 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t40so1874919pjb.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 20:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kyXs52D+W8xKx80sHVX3U7UyTi/vLCOHtkNQK+UXwVs=;
 b=q3B+2PQ8O4FNhku0/3V7OzCkEKHLlEYLQizS6tHtToz8GYgfCV/pR9ey5iscjJqs1V
 YJmBg5aUQPfRIgmxC4l+7Ni3pC8hEJvyE5YDx1ssis0PpVzrkrKpu3jv2BVo7v8F6KdA
 i+yHp1NiuauEJDlil60atk6qgL5ZkpjHgbGNMyHQkRq3Pg0hHVVG/6upDOmvD6KXbAJn
 cWPlNaoNspkXdafPiyjc/hkbLBTIYrC7hxu6D9fY6ly68rMv+S16xVFlpVG4ISi+bSdh
 LerFjBoyj6cB7AXCheq3zc69pRPHQ8Ul0GjpQuDjUJC7O+XvsHZGj6kVXVHLYn9CXdEV
 0jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kyXs52D+W8xKx80sHVX3U7UyTi/vLCOHtkNQK+UXwVs=;
 b=eq3gvazv5n516twz+U5g2q5WwqhkXF+npqDsOvlLJIs00fq1myoRORJsGJfS1g8FGi
 LSgnleIFRODC7LAN7o/pNHUgzNePegARGiBNRWGMkcYaPtA0EyEThNlAk8wCRJc6T84Q
 OjAAVxAZQfnsRdaMJDJisP79oqej6ReQhThAX2YswkdEkb3QqA6H0H9BnCUyJxP96yAv
 m/kMahCDyvpIbSTL6dM4/62ayuNRSJK5Unc1XcWgl19mVzo8KtwLEd+XvXXSXX+y4BvY
 w14YAGX0BeKjLZiI0Ztz0kMqq6+U5jZtG13Mx126zRNywuUw9yu/2kio9boicLx4licj
 cQFg==
X-Gm-Message-State: AGi0PuZO+vs69QL6hWrdKDZzet/HiIcjj59rgSid/MJ5nl0t98d4XZEJ
 l4o4G5SSCNikTNl6RI2EOMS/rA==
X-Google-Smtp-Source: APiQypJSw6NtoVd2sPZijlUM8mC9mIGktPyZZXfZXg4ubSp9+xfk8M5e3zVTWv1bMCApNluFzb7O0Q==
X-Received: by 2002:a17:90a:f689:: with SMTP id
 cl9mr8422457pjb.43.1587181270468; 
 Fri, 17 Apr 2020 20:41:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id k24sm20548440pfk.164.2020.04.17.20.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 20:41:09 -0700 (PDT)
Subject: Re: [PATCH 08/16] target/arm: Use SVEContLdSt in sve_ld1_r
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-9-richard.henderson@linaro.org>
 <CAFEAcA-v9O6+iZu9_grS6iW=QhmJeLGVfnJ8BOe59KzaPMczzg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ba2b5050-4d21-dfad-ae81-667438dbd89b@linaro.org>
Date: Fri, 17 Apr 2020 20:41:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-v9O6+iZu9_grS6iW=QhmJeLGVfnJ8BOe59KzaPMczzg@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 6:26 AM, Peter Maydell wrote:
> On Wed, 11 Mar 2020 at 06:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> First use of the new helper functions, so we can remove the
>> unused markup.  No longer need a scratch for user-only, as
>> we completely probe the page set before reading; system mode
>> still requires a scratch for MMIO.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +    /* The entire operation is in RAM, on valid pages. */
>> +
>> +    memset(vd, 0, reg_max);
>> +    mem_off = info.mem_off_first[0];
>> +    reg_off = info.reg_off_first[0];
>> +    reg_last = info.reg_off_last[0];
>> +    host = info.page[0].host;
>> +
>> +    while (reg_off <= reg_last) {
>> +        uint64_t pg = vg[reg_off >> 6];
>> +        do {
>> +            if ((pg >> (reg_off & 63)) & 1) {
>> +                host_fn(vd, reg_off, host + mem_off);
>> +            }
>> +            reg_off += 1 << esz;
>> +            mem_off += 1 << msz;
>> +        } while (reg_off <= reg_last && (reg_off & 63));
>> +    }
>> +
>> +    /*
>> +     * Use the slow path to manage the cross-page misalignment.
>> +     * But we know this is RAM and cannot trap.
>> +     */
>> +    mem_off = info.mem_off_split;
>> +    if (unlikely(mem_off >= 0)) {
>> +        tlb_fn(env, vd, info.reg_off_split, addr + mem_off, retaddr);
>> +    }
>> +
>> +    mem_off = info.mem_off_first[1];
>> +    if (unlikely(mem_off >= 0)) {
>> +        reg_off = info.reg_off_first[1];
>> +        reg_last = info.reg_off_last[1];
>> +        host = info.page[1].host;
>> +
>> +        do {
>> +            uint64_t pg = vg[reg_off >> 6];
>> +            do {
>> +                if ((pg >> (reg_off & 63)) & 1) {
>> +                    host_fn(vd, reg_off, host + mem_off);
>> +                }
>> +                reg_off += 1 << esz;
>> +                mem_off += 1 << msz;
>> +            } while (reg_off & 63);
>> +        } while (reg_off <= reg_last);
> 
> Does this loop for the second page need to be phrased
> differently than the loop for the first page was? I was
> expecting the two chunks of code to be identical, and they
> almost are, but not quite...

Yes, they do need to be different.  In particular, the first page may only have
the one element that crosses the page boundary, so we may have reg_first >
reg_last.  The second page is never has that problem.


r~

