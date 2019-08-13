Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6CCC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 01:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432AE2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 01:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="hWaQXr3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432AE2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxLNx-0002bA-Br
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 21:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hxLNS-00026o-Hd
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 21:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hxLNQ-00010T-Th
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 21:13:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hxLNQ-0000zK-H9
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 21:13:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so50596475pfl.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0+MiveWSno43EOdY+wXP4ebsrcIwHcfEkI7cxdee0kQ=;
 b=hWaQXr3EFowwkqttzhjI0sscfB27+0Nj33NGMd4Cg2M/9P+F12bW0fMN9a7N0muQTp
 VcW3UPbLQGxBaal/0JZMl+/0/v80znAbLJNo3l/krzV5cWDy6BCWDEeodJkmcceHrOu8
 SF7W/TBO5/QLthx6KYwCTthgiiBlYo9JCANC6DVvZDTaZImOonUjgoQ7+Aemj+8tHwmF
 5DbnvaQEw8AkPwf6CM18lwGuG5C9KvOamgWtmlHSgbZ9NBHAlvai9oApfxCblZUBLbqm
 8R6C4+jZo22WSg6N9lynjCro4CInAOdMJlNXiQYj++XyyPep3SXTMOvMWPaZyezPOFlI
 dudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0+MiveWSno43EOdY+wXP4ebsrcIwHcfEkI7cxdee0kQ=;
 b=aVkSoTbsh9Cnxv2vMieBDWrEJIHik1F20vIx1Zum8Oz9Xf2dDhANbk4Fph20ELnK+L
 Dnsil8+8G7/4wfFhmJzsBdhaQnU6mfLFhH7ZN9ZK3Tp21unR9pdTODZE5Fi2ggyLSCq3
 IIuFj6mRTIHiHs3fBgTjwbTzrW9Kbba7gx6xglD5A2xkJZ5EasbX055VKTXg5LZ+YD2t
 5utDQupUOeM2sDZqySbyld1+7BJlIkahtdp1MVGaCOxp0HUN1KziUjpIAYjYZtZ7CQXN
 uooZeVpcBh223sknSdfYivM3RYj6LGxdM44jMjAUGJVerXHETzrk/TrknvbJ1s94CIEZ
 Fsqw==
X-Gm-Message-State: APjAAAX4CwejMeVL5eiGTEVUOQjyt81VvVRXn0zU5IDIJZLJb3TDvm7+
 S0rVA5ITw5P43UJ6tY1pKeFVBQ==
X-Google-Smtp-Source: APXvYqzkbmghM5XsJbqunbQu1BEeRkpT9e1ceMElStN4cfW4T9XeEHLIZgYsiPssmNov3Hd33TiZFA==
X-Received: by 2002:a62:642:: with SMTP id 63mr38539559pfg.257.1565658806637; 
 Mon, 12 Aug 2019 18:13:26 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id a12sm32494146pgv.48.2019.08.12.18.13.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 18:13:25 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190812054202.125492-1-aik@ozlabs.ru>
 <2c36b78c-cec9-4122-86a3-d9f4ef762583@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e8f95021-ecc6-96cd-d0c1-d7310aa1bf10@ozlabs.ru>
Date: Tue, 13 Aug 2019 11:13:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2c36b78c-cec9-4122-86a3-d9f4ef762583@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_iommu: Fix xlate trace to print
 translated address
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/08/2019 19:01, Philippe Mathieu-Daudé wrote:
> Hi Alexey,
> 
> On 8/12/19 7:42 AM, Alexey Kardashevskiy wrote:
>> Currently we basically print IO address twice, fix this.
>>
>> Fixes: 7e472264e9e2 ("PPC: spapr: iommu: rework traces")
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   hw/ppc/spapr_iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index bd3d0256a65d..6fe57d799a10 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
>> @@ -137,7 +137,7 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
>>           ret.addr_mask = ~page_mask;
>>           ret.perm = spapr_tce_iommu_access_flags(tce);
>>       }
>> -    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.iova, ret.perm,
>> +    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.translated_addr, ret.perm,
>>                               ret.addr_mask);
> 
> But the trace format is:
> 
> spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned
> perm, unsigned pgsize) "liobn=%"PRIx64" 0x%"PRIx64" -> 0x%"PRIx64"
> perm=%u mask=%x"
> 
> So this could be more appropriate:
> 
>    trace_spapr_iommu_xlate(tcet->liobn, ret.iova, ret.translated_addr,
>                            ret.perm, ret.addr_mask);
> 
> Anyhow your patch is an improvment, so regardless addr/ret.iova:


I'd rather want to see the raw input data than with some bits removed.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks!

> 
>>   
>>       return ret;
>>

-- 
Alexey

