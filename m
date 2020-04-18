Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345DAC2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 02:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4008214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 02:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD41htx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4008214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPd6I-0006Pl-4y
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 22:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPd1x-0004hS-SK
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPd1t-0005Nb-Nl
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:16:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPd1t-0005Bb-8h
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:16:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id v2so1638852plp.9
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DjHYcRx/8/y1DUrBE3XsgoGoKuDrCdYcMnFElMjZXdI=;
 b=hD41htx+CMcgnX0W/Z6lDY27cWBJXRVowPxPNx/BLicmYQ+poPxwuw2TmO+PKyzknZ
 6Cm8S9rv5VnWtP0iD7wc5YZkHkPqOx9/B9rZZpi6VZnI5A/eCu1kbKkeiMCQnZzBw7G2
 LlQBTk6RrncM0tX1V0sK/9WOae/Ki6pRr3kNMLtbmZEaXcMZ/t48MUrZ3TVVa6cTFphN
 xr5Jc0MjpvPO45NKVF7SmSo86/DzZVCZiKx/okDbzMgaBvsvECNCudR8tqxK+r+nwce6
 qbTs/6RMfyWJoIlCKdwrxZkQAzwIAUg6mPvMEjfHM0DDuG1GWHMjGA+yvayVCrY/B8wm
 vq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DjHYcRx/8/y1DUrBE3XsgoGoKuDrCdYcMnFElMjZXdI=;
 b=IQWHTFG/FiZf5ahQy1l+5NsOCX9BaY7kWr2fGy+z4wFVMqDxEZxhLPn6FhfCvSZV9V
 TO26hb46ZEcUTQ8R58WSOnInnKgYn6s3HsYghmErV+0Lfjy91mD25Ly4Eii3DoF0IUk7
 bGzJ/jLVorJdt4ka+66iRdn1tG/ejtlBrvhT7BCg6LjOjigZfERJ6u0xK9nOhexKGc1y
 zXkCY7wVmkynScWmg1DyjE7yAWFKv6xo9ndfFbE7Ff/5ylHg4DjncgIYBBQ0kP6LChmn
 6+PmW6IZd/86RQaHt3ek5cmyrnaYipNyr9Is+uRPjAP5f8A4y5U/l/97/oPD6O8jyY1w
 +eiQ==
X-Gm-Message-State: AGi0PuZU638LRsRxAS0z/iYhF+Y5VhAMlxrQOGDpHveBG8WJXhUBbM2H
 TxYED0xPelzZNeZ0PaVZGueSIA==
X-Google-Smtp-Source: APiQypKRo19mvSlqW+WrbfY1DTel/zl7mySapeL1dbwXOaUgMarj+dUUOGNx5/XUJNyt0CSPsxYZsg==
X-Received: by 2002:a17:90a:5584:: with SMTP id
 c4mr8046632pji.51.1587176183078; 
 Fri, 17 Apr 2020 19:16:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id ml24sm6475441pjb.48.2020.04.17.19.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 19:16:22 -0700 (PDT)
Subject: Re: [PATCH 04/16] target/arm: Use cpu_*_data_ra for sve_ldst_tlb_fn
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-5-richard.henderson@linaro.org>
 <CAFEAcA9D9cpx5vxtuaeVonFJ0NNKjMOB6viPuE0+ppGiqZSMFw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2082f56-8c4b-a075-09c6-06dcd6dced15@linaro.org>
Date: Fri, 17 Apr 2020 19:16:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9D9cpx5vxtuaeVonFJ0NNKjMOB6viPuE0+ppGiqZSMFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 4/16/20 5:19 AM, Peter Maydell wrote:
> On Wed, 11 Mar 2020 at 06:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Use the "normal" memory access functions, rather than the
>> softmmu internal helper functions directly.
>>
>> Since fb901c905dc3, cpu_mem_index is now a simple extract
>> from env->hflags and not a large computation.  Which means
>> that it's now more work to pass around this value than it
>> is to recompute it.
>>
>> This only adjusts the primitives, and does not clean up
>> all of the uses within sve_helper.c.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/sve_helper.c | 241 ++++++++++++++++++----------------------
>>  1 file changed, 107 insertions(+), 134 deletions(-)
> 
>> +#ifdef TARGET_WORDS_BIGENDIAN
>> +# define be_bswap16(x)  ((uint16_t)(x))
>> +# define be_bswap32(x)  ((uint32_t)(x))
>> +# define be_bswap64(x)  ((uint64_t)(x))
>> +# define le_bswap16(x)  bswap16(x)
>> +# define le_bswap32(x)  bswap32(x)
>> +# define le_bswap64(x)  bswap64(x)
>> +#else
>> +# define be_bswap16(x)  bswap16(x)
>> +# define be_bswap32(x)  bswap32(x)
>> +# define be_bswap64(x)  bswap64(x)
>> +# define le_bswap16(x)  ((uint16_t)(x))
>> +# define le_bswap32(x)  ((uint32_t)(x))
>> +# define le_bswap64(x)  ((uint64_t)(x))
>> +#endif
> 
> Am I confused, or are these just reimplementing
> cpu_to_be16()/cpu_to_le16()/le16_to_cpu()/be16_to_cpu() etc from bswap.h ?

Those depend on HOST_WORDS_BIGENDIAN, this is TARGET_WORDS_BIGENDIAN.

> (It seems a pity to have to lose the memory subsystem handling
> endianness for us.)

It is.  I have added a patch to improve the memory subsystem.


r~

