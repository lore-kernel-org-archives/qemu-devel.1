Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16671C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05B62067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnRcF2mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05B62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7wUg-0005F1-4i
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 03:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7wUA-0004o9-Ix
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7wU8-0007AG-My
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597737403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0fYhobhPeANobS6hPvpaDljion0xqQrz25WVgk8ijd8=;
 b=bnRcF2mfe76FCOwP9CshIbvHKwCPTAuaLtJwJNbHbhvbD1gdbw9JM06cVCwu3JknVjmOt9
 /ZQkyzr5b2laNCqrpWVhZtOLadkm5JSavjS3jm3F3i2eMTjQQSjAvR/+kswWylDXPPAd0D
 J0UQFr69AV8HQnc/W0zfhskW5hPF2HA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-fN44rNguPNu9Vk_cgaDQzA-1; Tue, 18 Aug 2020 03:56:40 -0400
X-MC-Unique: fN44rNguPNu9Vk_cgaDQzA-1
Received: by mail-wm1-f72.google.com with SMTP id k204so5776583wmb.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 00:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0fYhobhPeANobS6hPvpaDljion0xqQrz25WVgk8ijd8=;
 b=nt5+uND2VLAqI8BZ3wPu6Lh1Z6w1/ibtnoV+WIXrHw8qJIWAzeT7uAixrwvs2JujS3
 FvEdHGv5CW/Xkg9YSWzPDz4UsrEBuEn4JX7MHFexxSQJdww5Onth7gfr2k7VmYcKBdVD
 WOJtCN+BGWTUKM1MrochOCwmKqwUh3k6V4Xvg12M8HWsazeTs+/xWnZrWGew1n/93o0y
 qo2uLvlJY7AqHawEwnIBDqqvTPMrfX+R37QmhRXkjYCq7xgCDP2ky9hP9Gm/HDQmqdXe
 RRDnz7GOLKY7an9HiO3Krh6DvkdnwtO86ZHkccQ3kL5cpEfG+AoB9w9o8VabmmtpJYmg
 uJtQ==
X-Gm-Message-State: AOAM5328KZKbEZeaSYPOlrMbDFkiVjj+3EM7i4O6sHThqHqjrN+b1AyK
 OLqSEwPxBWYKC29oNVkZRUeYpUCx7PFWt1TrEUgoyjAmit1/ALmq9vBGs8/tDkE37lLKNBt7sLF
 PGjg8Zvkz/SFP/Ao=
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr18462987wrm.382.1597737399213; 
 Tue, 18 Aug 2020 00:56:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+fez4ia7Y6upMEa54A6G46K6GjyYW26czTe0E0DMFP1gWVYG9kIOVcPjubGdUEmo5oDKWtw==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr18462962wrm.382.1597737398970; 
 Tue, 18 Aug 2020 00:56:38 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t25sm30681689wmj.18.2020.08.18.00.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 00:56:38 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] memory: Add trace events to audit MemoryRegionOps
 fields
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200806152613.18523-1-philmd@redhat.com>
 <d87db8e9-40b1-334d-22b0-90674ddf8177@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <161c9d87-677b-6806-b080-4aebfd5275c4@redhat.com>
Date: Tue, 18 Aug 2020 09:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d87db8e9-40b1-334d-22b0-90674ddf8177@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:32 AM, Paolo Bonzini wrote:
> On 06/08/20 17:26, Philippe Mathieu-Daudé wrote:
>> Add trace events to audit MemoryRegionOps field such:
>>  - are all the valid/impl fields provided?
>>  - is the region a power of two?
>>
>> These cases are accepted, but it is interesting to list them.
>>
>> Example:
>>
>>   $ qemu-system-i386 -S -trace memory_region_io_check\*
>>   memory_region_io_check_odd_size mr name:'dma-page' size:0x3

(a)

>>   memory_region_io_check_access_size_incomplete mr name:'acpi-tmr' min/max:[valid:1/4 impl:4/0]
>>   memory_region_io_check_access_size_incomplete mr name:'acpi-evt' min/max:[valid:1/2 impl:2/0]
>>   memory_region_io_check_access_size_incomplete mr name:'acpi-cnt' min/max:[valid:1/2 impl:2/0]

(b)

> 
> Can they be detected using Coccinelle instead?

For static declarations, probably.

(a) is not really fixable (because some datasheets don't
count the reserved space in the device address map [1]),
but is interesting to audit.

I believe (b) has to be updated per maintainers preference,
not by an individual developer. IIUC Michael said [2] while
there is no bus information in MemoryRegionOps (and way to
report a bus specific error), it is pointless to blindly fill
the zero access sizes.

Meanwhile I prefer to share my debugging helpers as trace
events instead of ./configure --enable-maintainer and #ifdef'ry.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg431171.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg709171.html

> 
> Paolo
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Based-on: <20200805130221.24487-1-philmd@redhat.com>
>>           "softmmu: Add missing trace-events file"
>> ---
>>  softmmu/memory.c     | 11 +++++++++++
>>  softmmu/trace-events |  2 ++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index d030eb6f7c..daa0daf2a8 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -1488,6 +1488,17 @@ void memory_region_init_io(MemoryRegion *mr,
>>      mr->ops = ops ? ops : &unassigned_mem_ops;
>>      mr->opaque = opaque;
>>      mr->terminates = true;
>> +    if (size != UINT64_MAX && !is_power_of_2(size)) {
>> +        trace_memory_region_io_check_odd_size(name, size);
>> +    }
>> +    if (ops && (!ops->impl.min_access_size || !ops->impl.max_access_size ||
>> +                !ops->valid.min_access_size || !ops->valid.max_access_size)) {
>> +        trace_memory_region_io_check_access_size_incomplete(name,
>> +                mr->ops->valid.min_access_size,
>> +                mr->ops->valid.max_access_size,
>> +                mr->ops->impl.min_access_size,
>> +                mr->ops->impl.max_access_size);
>> +    }
>>  }
>>  
>>  void memory_region_init_ram_nomigrate(MemoryRegion *mr,
>> diff --git a/softmmu/trace-events b/softmmu/trace-events
>> index b80ca042e1..00eb316aef 100644
>> --- a/softmmu/trace-events
>> +++ b/softmmu/trace-events
>> @@ -18,6 +18,8 @@ memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t
>>  flatview_new(void *view, void *root) "%p (root %p)"
>>  flatview_destroy(void *view, void *root) "%p (root %p)"
>>  flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
>> +memory_region_io_check_odd_size(const char *name, uint64_t size) "mr name:'%s' size:0x%"PRIx64
>> +memory_region_io_check_access_size_incomplete(const char *name, unsigned vmin, unsigned vmax, unsigned imin, unsigned imax) "mr name:'%s' min/max:[valid:%u/%u impl:%u/%u]"
>>  
>>  # vl.c
>>  vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
>>
> 


