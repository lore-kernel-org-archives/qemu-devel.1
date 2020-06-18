Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F4FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504E320739
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJxXhlYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvuU-0007x8-Jz
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlvto-0007Vk-3A
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:52:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlvtm-00064q-AV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592491933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Rb0MA2TldaH/naZwkA0QefrBI/v6W5MVIej3zG8l9Hc=;
 b=GJxXhlYBsxSpOdf2l6aoFNaGO6FhWYKkRcy9mOv+xG/6t/cvdI9zcORi8w0Nt8Qk5UJbxS
 LbWmJIbsgOTd0bhTw9/Y+qk7VVKHDo4Bt9QYXxHvk/FI/JrYDRwvb8DObeo8A2xI79Ten4
 AEuCVzWh4YToxjHCDwtu9VW9gkmTF38=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-5PTJ__TNOomQexvA0zhi9w-1; Thu, 18 Jun 2020 10:52:06 -0400
X-MC-Unique: 5PTJ__TNOomQexvA0zhi9w-1
Received: by mail-wr1-f69.google.com with SMTP id f5so2882998wrv.22
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 07:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Rb0MA2TldaH/naZwkA0QefrBI/v6W5MVIej3zG8l9Hc=;
 b=X/s1wD2PMop3o3nWAfEf/MhMoVwJrdOHZkmpzfGbzQRPvW4pAgRQxfhiJuOKLpPlWd
 Tgd4M6PNlEEiKjXvNy6u2tQXIGyO3Z2BYRfsUapRs7qCx0g40L17KKhvQ0estwbe1s1R
 XIX++fADXklx521lKpSvbEAJVHgI1bOlccljBZ+peO/5fZRa8+poYM0DPanePPwkw5+N
 z3BjZY+78CTHUNLvSA7ZxHmlRkK+AkJg2ik3XOwhqXNG41mWQrfhO8Gen815EcFczN7k
 00vasFGD3UEHquOQwBhezGKnc/l6RqkzXtfN0EAML6Dj//jbWzlfyq4Z+5J7VQfI1JSp
 fHyw==
X-Gm-Message-State: AOAM531mh77YJzbm3FewtbVNSY4y3DQVIYLPuUoWxs+dWFbrCbhlQotG
 gtj3+aG/A6Ne7b8+m3NyKXOj32t+F0j/OaQwZx7jiKawExZoOo/FQxElJytsvCxftAUkWTH5WH/
 duEd60ixn+hX9k04=
X-Received: by 2002:adf:e850:: with SMTP id d16mr5189931wrn.426.1592491925400; 
 Thu, 18 Jun 2020 07:52:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHRsWPcOgnugi/JcJj5Vf60Xh1gOVwOOgjiteXKRpcSfJdzNA3OjNE6DJCfRjkxvBGHEKw5w==
X-Received: by 2002:adf:e850:: with SMTP id d16mr5189912wrn.426.1592491925173; 
 Thu, 18 Jun 2020 07:52:05 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id e25sm4384138wrc.69.2020.06.18.07.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 07:52:04 -0700 (PDT)
Subject: Re: [PATCH v1] memory: assert MemoryRegionOps callbacks are defined
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 P J P <ppandit@redhat.com>
References: <20200618121218.215808-1-ppandit@redhat.com>
 <87r1ucv7pe.fsf@linaro.org>
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
Message-ID: <cdaa70a5-5112-85ab-fe10-89f1394925d0@redhat.com>
Date: Thu, 18 Jun 2020 16:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87r1ucv7pe.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 3:12 PM, Alex Bennée wrote:
> 
> P J P <ppandit@redhat.com> writes:
> 
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> When registering a MemoryRegionOps object, assert that its
>> read/write callback methods are defined. This avoids potential
>> guest crash via a NULL pointer dereference.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  memory.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> Update v1: add assert while registering MemoryRegionOps
>>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05187.html
>>
>> diff --git a/memory.c b/memory.c
>> index 91ceaf9fcf..6e94fd5958 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1495,6 +1495,9 @@ void memory_region_init_io(MemoryRegion *mr,
>>                             const char *name,
>>                             uint64_t size)
>>  {
>> +    assert(ops);
>> +    assert(ops->read);
>> +    assert(ops->write);
> 
> If you look at memory_region_dispatch_write you can see that
> mr->ops->write being empty is acceptable because it implies
> mr->ops->write_with_attrs is set instead. I think the same is true for
> read so I think you need something more like:
> 
>      assert(ops->read || ops->read_with_attrs);
>      assert(ops->write || ops->write_with_attrs);
>      
> 
>>      memory_region_init(mr, owner, name, size);
>>      mr->ops = ops ? ops : &unassigned_mem_ops;
>>      mr->opaque = opaque;
>> @@ -1674,6 +1677,8 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>>  {
>>      Error *err = NULL;
>>      assert(ops);
>> +    assert(ops->read);
>> +    assert(ops->write);
> 
> Do ROM devices need a ->write function?

This is how you put the device in I/O mode, isn't it?

> 
> Also doesn't this break a load of running stuff without fixes for all
> the various missing bits? How far does make check-acceptance get?
> 
>>      memory_region_init(mr, owner, name, size);
>>      mr->ops = ops;
>>      mr->opaque = opaque;
> 
> 


