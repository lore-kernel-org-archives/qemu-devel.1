Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75728C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 07:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3174C21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 07:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="fdPdW7Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3174C21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j297m-0007lc-E6
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 02:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1j296r-0006gJ-1y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1j296p-0006UR-A3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:40:28 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1j296o-0006U1-Qh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:40:27 -0500
Received: by mail-pj1-x1042.google.com with SMTP id d5so2003496pjz.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 23:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qBKIKIFAy0dlr7zquj1Ita2I7qg3TlAHAXkYtjGQ53Q=;
 b=fdPdW7CaBGWTHDALWShenACDQrLu9uxA6EAAavCyr7OkhtqZIhqJXyR93DVFhHvawq
 o9LDHP+Xweie4kWtzvSyzYL0GACsff5G2j16c/hpLtAMIo60N0Jfwxsp0/L/BMtkpoBp
 iwnddE0jewvp28KS3uBn1dbb2op//AmuW7LpDTwTyjMTBOG5nF9OYSbSEOB5SF5D6r4W
 85Ehdot+db0pJDZS5Q/xaZxw8mQjjE7CpV8pn13CzvRzWIEI0dzifiNqH8d3JQME691Q
 tadMngFJmFy1REeNVfKqGvV7a2zBALjrCI4mMTfSGRCl5exWxx+9SODnodYtMPgOugtY
 r6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qBKIKIFAy0dlr7zquj1Ita2I7qg3TlAHAXkYtjGQ53Q=;
 b=NOAGxaaI6tLCitFvimUcR5I0F/N1uZUCUBquToYEGIdL4ivHQ+vCpyc1dDs8+q9q1n
 3SmdyCBoqwskNKcE+EZj1J4ATP1tzhSTV6YMUrvju73UGAl0laTHufnNYIjkXxELyMFw
 ZtbLukSqv/3TqOzl+eiFVMWNHQALPvRoBkEg2R92sjNTmfoQ+cQy4qjeWz4AAlif6VEJ
 YZ+vPMixdsSKkp06mqdaFO2ONNyuti1fJ9GqOH9yLVycfDplHzhp2mnqXH/VcX2CqQds
 Q0RGCMWhOG7Q/zCbTXC9pUcwMXTv7aKAdADtoizajinzMd7iYcFhQvCjnj9EUMMkXlyu
 9SDQ==
X-Gm-Message-State: APjAAAUe8tISuiFq9W7MK3/JzVTvunMGKo1uKehAbPpHAUbqcS6WJwYt
 McC24LBjkId5wP5ggaQ/4qCHhg==
X-Google-Smtp-Source: APXvYqzFO4klsMSUA5HEvK1TWC4wqfodZgD4ET8/zBLITCUh9ERWGNjoWwlKnH8YRU+XayN9koesKQ==
X-Received: by 2002:a17:902:a58a:: with SMTP id
 az10mr26910393plb.20.1581579625597; 
 Wed, 12 Feb 2020 23:40:25 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id j14sm1586010pgs.57.2020.02.12.23.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 23:40:25 -0800 (PST)
Subject: Re: Question about (and problem with) pflash data access
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
References: <20200212184648.GA584@roeck-us.net>
 <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
 <20200212230918.GA27242@roeck-us.net>
 <560224fe-f0a3-c64a-6689-e824225cfbb9@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <279d959f-f7e5-65e1-9c68-459f3fed56d3@ozlabs.ru>
Date: Thu, 13 Feb 2020 18:40:19 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <560224fe-f0a3-c64a-6689-e824225cfbb9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 13/02/2020 10:50, Philippe Mathieu-Daudé wrote:
> Cc'ing Paolo and Alexey.
> 
> On 2/13/20 12:09 AM, Guenter Roeck wrote:
>> On Wed, Feb 12, 2020 at 10:39:30PM +0100, Philippe Mathieu-Daudé wrote:
>>> Cc'ing Jean-Christophe and Peter.
>>>
>>> On 2/12/20 7:46 PM, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> I have been playing with pflash recently. For the most part it works,
>>>> but I do have an odd problem when trying to instantiate pflash on sx1.
>>>>
>>>> My data file looks as follows.
>>>>
>>>> 0000000 0001 0000 aaaa aaaa 5555 5555 0000 0000
>>>> 0000020 0000 0000 0000 0000 0000 0000 0000 0000
>>>> *
>>>> 0002000 0002 0000 aaaa aaaa 5555 5555 0000 0000
>>>> 0002020 0000 0000 0000 0000 0000 0000 0000 0000
>>>> *
>>>> 0004000 0003 0000 aaaa aaaa 5555 5555 0000 0000
>>>> 0004020 0000 0000 0000 0000 0000 0000 0000 0000
>>>> ...
>>>>
>>>> In the sx1 machine, this becomes:
>>>>
>>>> 0000000 6001 0000 aaaa aaaa 5555 5555 0000 0000
>>>> 0000020 0000 0000 0000 0000 0000 0000 0000 0000
>>>> *
>>>> 0002000 6002 0000 aaaa aaaa 5555 5555 0000 0000
>>>> 0002020 0000 0000 0000 0000 0000 0000 0000 0000
>>>> *
>>>> 0004000 6003 0000 aaaa aaaa 5555 5555 0000 0000
>>>> 0004020 0000 0000 0000 0000 0000 0000 0000 0000
>>>> *
>>>> ...
>>>>
>>>> pflash is instantiated with "-drive
>>>> file=flash.32M.test,format=raw,if=pflash".
>>>>
>>>> I don't have much success with pflash tracing - data accesses don't
>>>> show up there.
>>>>
>>>> I did find a number of problems with the sx1 emulation, but I have
>>>> no clue
>>>> what is going on with pflash. As far as I can see pflash works fine on
>>>> other machines. Can someone give me a hint what to look out for ?
>>>
>>> This is specific to the SX1, introduced in commit 997641a84ff:
>>>
>>>   64 static uint64_t static_read(void *opaque, hwaddr offset,
>>>   65                             unsigned size)
>>>   66 {
>>>   67     uint32_t *val = (uint32_t *) opaque;
>>>   68     uint32_t mask = (4 / size) - 1;
>>>   69
>>>   70     return *val >> ((offset & mask) << 3);
>>>   71 }
>>>
>>> Only guessing, this looks like some hw parity, and I imagine you need to
>>> write the parity bits in your flash.32M file before starting QEMU,
>>> then it
>>> would appear "normal" within the guest.
>>>
>> I thought this might be related, but that is not the case. I added log
>> messages, and even ran the code in gdb. static_read() and static_write()
>> are not executed.
>>
>> Also,
>>
>>      memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val,
>>                            "sx1.cs0", OMAP_CS0_SIZE - flash_size);
>>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>      memory_region_add_subregion(address_space,
>>                                  OMAP_CS0_BASE + flash_size, &cs[0]);
>>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> suggests that the code is only executed for memory accesses _after_
>> the actual flash. The memory tree is:
>>
>> memory-region: system
>>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>      0000000000000000-0000000001ffffff (prio 0, romd): omap_sx1.flash0-1
>>      0000000000000000-0000000001ffffff (prio 0, rom): omap_sx1.flash0-0
> 
> Eh two memory regions with same size and same priority... Is this legal?


I'd say yes if used with memory_region_set_enabled() to make sure only
one is enabled. Having both enabled is weird and we should print a
warning. Thanks,



> 
> (qemu) info mtree -f -d
> FlatView #0
>  AS "memory", root: system
>  AS "cpu-memory-0", root: system
>  Root memory region: system
>   0000000000000000-0000000001ffffff (prio 0, romd): omap_sx1.flash0-1
>   0000000002000000-0000000003ffffff (prio 0, i/o): sx1.cs0
>   0000000004000000-0000000007ffffff (prio 0, i/o): sx1.cs1
>   0000000008000000-000000000bffffff (prio 0, i/o): sx1.cs3
>   0000000010000000-0000000011ffffff (prio 0, ram): omap1.dram
>   0000000020000000-000000002002ffff (prio 0, ram): omap1.sram
>   ...
>   Dispatch
>     Physical sections
>       #0 @0000000000000000..ffffffffffffffff (noname) [unassigned]
>       #1 @0000000000000000..0000000001ffffff omap_sx1.flash0-1 [not dirty]
>       #2 @0000000002000000..0000000003ffffff sx1.cs0 [ROM]
>       #3 @0000000004000000..0000000007ffffff sx1.cs1 [watch]
>       #4 @0000000008000000..000000000bffffff sx1.cs3
>       #5 @0000000010000000..0000000011ffffff omap1.dram
>       #6 @0000000020000000..000000002002ffff omap1.sram
>       ...
>     Nodes (9 bits per level, 6 levels) ptr=[3] skip=4
>       [0]
>           0       skip=3  ptr=[3]
>           1..511  skip=1  ptr=NIL
>       [1]
>           0       skip=2  ptr=[3]
>           1..511  skip=1  ptr=NIL
>       [2]
>           0       skip=1  ptr=[3]
>           1..511  skip=1  ptr=NIL
>       [3]
>           0       skip=1  ptr=[4]
>           1       skip=1  ptr=[5]
>           2       skip=2  ptr=[7]
>           3..13   skip=1  ptr=NIL
>          14       skip=2  ptr=[9]
>          15       skip=2  ptr=[11]
>          16..511  skip=1  ptr=NIL
>       [4]
>           0..63   skip=0  ptr=#1
>          64..127  skip=0  ptr=#2
>         128..255  skip=0  ptr=#3
>         256..383  skip=0  ptr=#4
>         384..511  skip=1  ptr=NIL
> 
> So the romd wins.
> 
>>      0000000002000000-0000000003ffffff (prio 0, i/o): sx1.cs0
>>
>> I thought that the dual memory assignment (omap_sx1.flash0-1 and
>> omap_sx1.flash0-0) might play a role, but removing that didn't make
>> a difference either (not that I have any idea what it is supposed
>> to be used for).
>>
>> Thanks,
>> Guenter
>>
> 

-- 
Alexey

