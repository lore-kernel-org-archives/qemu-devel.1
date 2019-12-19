Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67913C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291A521D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUSvjAiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291A521D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjJv-0003FW-Bn
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihjJF-0002qX-AW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihjJD-0003HE-Re
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:04:53 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihjJD-0003GD-Kc
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:04:51 -0500
Received: by mail-pf1-x441.google.com with SMTP id y14so2103420pfm.13
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 16:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cmzFZz/w/XgQgzjuHXS3zgKOo9bcJnUNWHi94c84yuk=;
 b=RUSvjAiVLLaYnbhuHAD67PYJYquGrhQ94x4RDCPoNeoXDP0GBmS1Irs+/7Tx92Vl7r
 u8uLXSSWT7zVU8+u30aL+71RgaCVgfVZH+meqUGJr9lsWQf+uxmmxtrCjfJoVvOP1z/F
 7p6x0XtF9Ou6fjvljrgveFKS3IJlLo3dlj4yBojqxQUPtHtmFpf3B49EdeDEe23WmjFN
 3DJ98sCDJlQZpC+mVQkO5cG6+DlRFxgdTiP9bJ5ybCOmqjQPAg9S5nIwSRs/kR99AjSg
 jBavN5M3Q8wnQ8OX6+Who+4JIogRPtXVgtGJM/wmuN7r3KgxcQ6LLqJaHlXLgwlzT1Y2
 dMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cmzFZz/w/XgQgzjuHXS3zgKOo9bcJnUNWHi94c84yuk=;
 b=e1r6K9tmmdQr0dgNSApEbodFC4U6W1Z5qsU1IqZLG76seFisO9Amtbgf+l07ypxS2a
 uy2ePMKPPdygJAkHd0VrcGqolmoi/wOSizvmGI8lBBzhk2cpDbhmrFoyTKfbsk13gva2
 n4NU9U+4w2+ipkO1uWDFvdKNeCX6Rv4EaCH83JzGRpguA2zPMil3UeO0wJ3IYGdjPRtd
 xYFoDZPjJoS5FOOezWCBGqBmIC0Bc2E+2jVwc6bltOP9iDuB8C3sgLEdD00SxLfjZmt+
 PuChLBEC04ddp/kxhhA7DhU7Q2segt8pad+y7QjFCj74ReM5npHLZf8tNwEzCnlySuwU
 5pyw==
X-Gm-Message-State: APjAAAVTnFEQFVHnulueTns6XgZDBJsAlvINdLqaf/2rZqiMdKPrIdb8
 aYd/TP1+awHkwKcyTwiDj89x1Q==
X-Google-Smtp-Source: APXvYqxJJvFU4mdcFbDf6wYQwWbZGe9MTo4DuXACKPqeGlJCjxJH/HVZw4Pc06HTAry7ihhK+N850Q==
X-Received: by 2002:aa7:93ce:: with SMTP id y14mr6153417pff.185.1576713890227; 
 Wed, 18 Dec 2019 16:04:50 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id s24sm5105057pfd.161.2019.12.18.16.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 16:04:49 -0800 (PST)
Subject: Re: [PATCH] linux-user:Fix align mistake when mmap guest space
To: Laurent Vivier <laurent@vivier.eu>, Xinyu Li <precinct@mail.ustc.edu.cn>, 
 qemu-devel@nongnu.org
References: <20191213022919.5934-1-precinct@mail.ustc.edu.cn>
 <965e1a25-cbdd-a758-371d-dab7a7c2eb4d@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dec81594-8f30-9548-66d0-4d5eec0447ef@linaro.org>
Date: Wed, 18 Dec 2019 14:04:46 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <965e1a25-cbdd-a758-371d-dab7a7c2eb4d@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 11:00 PM, Laurent Vivier wrote:
> Le 13/12/2019 à 03:29, Xinyu Li a écrit :
>> In init_guest_space, we need to mmap guest space. If the return address
>> of first mmap is not aligned with align, which was set to MAX(SHMLBA,
>> qemu_host_page_size), we need unmap and a new mmap(space is larger than
>> first size). The new size is named real_size, which is aligned_size +
>> qemu_host_page_size. alugned_size is the guest space size. And add a
>> qemu_host_page_size to avoid memory error when we align real_start
>> manually (ROUND_UP(real_start, align)). But when SHMLBA >
>> qemu_host_page_size, the added size will smaller than the size to align,
>> which can make a mistake(in a mips machine, it appears). So change
>> real_size from aligned_size +qemu_host_page_size
>> to aligned_size + align will solve it.
>>
>> Signed-off-by: Xinyu Li <precinct@mail.ustc.edu.cn>
>> ---
>>  linux-user/elfload.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index f6693e5760..312ded0779 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -2189,7 +2189,7 @@ unsigned long init_guest_space(unsigned long host_start,
>>               * to where we need to put the commpage.
>>               */
>>              munmap((void *)real_start, host_size);
>> -            real_size = aligned_size + qemu_host_page_size;
>> +            real_size = aligned_size + align;
>>              real_start = (unsigned long)
>>                  mmap((void *)real_start, real_size, PROT_NONE, flags, -1, 0);
>>              if (real_start == (unsigned long)-1) {
>>
> 
> Your change seems correct to me.
> 
> Richard did you miss this in your patch
> 30ab9ef2967d ("linux-user: Fix shmat emulation by honoring host SHMLBA")
> or was it voluntary to keep it?

Looks like I missed it.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


