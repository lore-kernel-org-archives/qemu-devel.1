Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07723C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE78621848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="pCP8P7pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE78621848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0dft-0006f9-UP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 23:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i0ded-0005q6-Me
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i0deb-0006uQ-Pj
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:20:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1i0deb-0006sR-A0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:20:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so2624726pgc.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 20:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tkecvGXeiG9Z+qcwZpcnBYeSLRNGXrmTD19umqSG4uc=;
 b=pCP8P7pfZYf8DvG+O6gquJPeMz+v9mi2q3Fs7VVMeKVxaSF/2lD1iyLTSdYwZlAoVl
 bk2Yh7N17462wgsOM+9kDdMVWyNLxBEI67y8VPaYJgA4/8GQQaeObgm107adIqzDkpTv
 W3XZSeas2R0oVUx1ZvXbS12f4zrcjBn548i0XE1R9trvr4urY7R+axYpVJgQKCnclHG4
 HEpzygqjn1LSEKOcslNiqiSRHI3SBXfREQjAsSJu968SZ2EPapwPv8ampD4zhSgaIrRF
 /57yPJR8mnZhYseuXlvJgt3As1ZYFhHRQu1lGAuPXLm4MNb4ebO/XLqPYjxlIXZrfD2C
 mHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tkecvGXeiG9Z+qcwZpcnBYeSLRNGXrmTD19umqSG4uc=;
 b=RDMvcHZyGo9Oe7GGJ1VX8GcYoQu9knbat71YGivyvj541lyTOQBrbcAc6bf6Wdi0F3
 0Dd+1HLI6K49az0jDYE8stFZ0ADt/ep+OE705G2Tqh+lZQnM5L5sYO7KnsXkRaAG77fZ
 MaBhZGcrF4z1aHr5uaYzNRAQjPzb+Ysn6oDAfrFWw/IzIJZRd6crOv9Ktyj9btbwgVgF
 Kupq0IG6ODpdY8P4DSzR7OMfu55hiPcWSOEjBFc6RjRdEPjOoLzTlU4rjqJE7wDs8wdE
 4qCS0uOLT+f1eCkXGmdyKeiGJZPRtzYg6JmACUmf4FfpMEzBZ/NlHcYL1p8Bpez3pYX0
 Mv9A==
X-Gm-Message-State: APjAAAVsB3NOFEviBUXentW6xgVqwmvfOns4KZ/IJOrF6Mvq98dAV2em
 1NAji5WE+0MDjpBxJ3GUHZTM0g==
X-Google-Smtp-Source: APXvYqwnzoozR/xJdLNP5Q7qc6FccKOA7g9hyCHHqRqb+MbxyljjsFePtGq4PlCvFLd+q0OzIq2btw==
X-Received: by 2002:aa7:91cc:: with SMTP id z12mr39130271pfa.76.1566444048141; 
 Wed, 21 Aug 2019 20:20:48 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id c71sm26127712pfc.106.2019.08.21.20.20.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 20:20:47 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190822011620.106337-1-aik@ozlabs.ru>
 <b9098689-a8cb-0c68-0065-f9362cdcb32d@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2535da96-5e47-b840-d91c-d4d71a9b5981@ozlabs.ru>
Date: Thu, 22 Aug 2019 13:20:43 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b9098689-a8cb-0c68-0065-f9362cdcb32d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qapi: Add query-memory-checksum
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 22/08/2019 11:33, Eric Blake wrote:
> On 8/21/19 8:16 PM, Alexey Kardashevskiy wrote:
>> This returns MD5 checksum of all RAM blocks for migration debugging
>> as this is way faster than saving the entire RAM to a file and checking
>> that.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>>
>> I am actually wondering if there is an easier way of getting these
>> checksums and I just do not see it, it cannot be that we fixed all
>> memory migration bugs :)
> 
> I'm not sure whether the command itself makes sense, but for the interface:
> 
> 
>> +++ b/qapi/misc.json
>> @@ -1194,6 +1194,33 @@
>>   ##
>>   { 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
>>   
>> +##
>> +# @MemoryChecksum:
>> +#
>> +# A string with MD5 checksum of all RAMBlocks.
>> +#
>> +# @checksum: the checksum.
>> +#
>> +# Since: 3.2.0
> 
> This should be 4.2, not 3.2.
> 
>> +##
>> +{ 'struct': 'MemoryChecksum',
>> +  'data'  : { 'checksum': 'str' } }
>> +
>> +##
>> +# @query-memory-checksum:
>> +#
>> +# Return the MD5 checksum of all RAMBlocks.
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-memory-checksum" }
>> +# <- { "return": { "checksum": "a0880304994f64cb2edad77b9a1cd58f" } }
>> +#
>> +# Since: 3.2.0
> 
> and again
> 
>> +##
>> +{ 'command': 'query-memory-checksum',
>> +  'returns': 'MemoryChecksum' }
>> +
>>   
> 
>> +++ b/exec.c
>> @@ -2050,6 +2050,22 @@ void *qemu_ram_get_host_addr(RAMBlock *rb)
>>       return rb->host;
>>   }
>>   
>> +gchar *qemu_ram_chksum(void)
> 
> gchar is a pointless glib type.  Use 'char' instead.
> 
>> +{
>> +    struct RAMBlock *rb;
>> +    GChecksum *chksum = g_checksum_new(G_CHECKSUM_MD5);
>> +    gchar *ret;
>> +
>> +    RAMBLOCK_FOREACH(rb) {
>> +        g_checksum_update(chksum, qemu_ram_get_host_addr(rb),
>> +                          qemu_ram_get_used_length(rb));
>> +    }
>> +    ret = g_strdup(g_checksum_get_string(chksum));
>> +    g_checksum_free(chksum);
>> +
>> +    return ret;
>> +}
> 
> How long does this take to run?  Is it something where you really want
> to block the guest while chewing over the guest's entire memory?


10-20 times faster than "pmemsave" and blocking the guest is not a 
problem here as both - source and destination - guests are stopped 
(otherwise the checksum does not make sense).



-- 
Alexey

