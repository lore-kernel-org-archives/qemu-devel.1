Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C10C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD6C2396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWqMAmOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD6C2396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfs1-00085k-JB
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKfpT-0006iQ-B0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKfob-00006g-9t
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UvzpHcc+Nv0Uajxbt9FPjK2t1uu4iBC3eocRs4OBPio=;
 b=KWqMAmOuOOJqAMLi3fHRT10IJRt9PmOgyOHVUqcF7OyW+H4A+B7Ql0wIGigYMO6wKXGQAi
 t7BSCSZwl90C35IgWYOfhp1FHqIMOvVcI2jPTDeTGqkaW9sDo/Bo2FJ4v8Cwwb92r0fwXy
 io7+t/1lecnvmrTl9SsMCBCQHK3EUXg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-tSpfJZ6yMGuZYVM6ic7mcA-1; Tue, 22 Sep 2020 06:46:24 -0400
X-MC-Unique: tSpfJZ6yMGuZYVM6ic7mcA-1
Received: by mail-wm1-f70.google.com with SMTP id m19so743340wmg.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UvzpHcc+Nv0Uajxbt9FPjK2t1uu4iBC3eocRs4OBPio=;
 b=GyglsCAHE1s7G5JDhl8rvxy+F2RnchmCAudEC0hdMeb7XG87mFjjLokKN64C5mHFkQ
 FGd/7eH22KI5P8io4dnkY9T4BebTrSn0Bv+3Ba12gOCPduHQy47OQ4/hrW2vidVtDBpw
 fncdg6mjbvOEJRztt24DOd58/Kyb+rgdoEdtRh2TmXbA3I2aym2bbmgKqHD4M6i6jCIS
 oUPSGSVjcTJYtv/SHfVXQuZIY5sb7H5RqiWzdUQE4dQBAn4FkTzaGRjmvHQwxce+c+Kh
 vpffJZZRmne9cuwXeJS6T2b1nq6SE00QmugzwSJGWFC6mVhd724jNOsXO42t5WZOToGn
 uwVw==
X-Gm-Message-State: AOAM533Xjvhf1L2de8YMy1RoLkbReMd9aOgFxOu/y5EGKEGnZVtlkXN6
 2cVT0c+sCvkHmnLSejVgKdQqpD1CVGiFgFdIBaOWWUn7Qghh+Ypm/Iac7Qqw9y7noKbW6RohYek
 ewXxBewW32AtxA04=
X-Received: by 2002:adf:efc9:: with SMTP id i9mr4804276wrp.187.1600771582885; 
 Tue, 22 Sep 2020 03:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybn5zNyA8Knptth868K2fHsgE9GVc8ZRVEiTR+Z+n//NaBTSiwpGzBLPTVPb9fd2HIzIdXCA==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr4804247wrp.187.1600771582648; 
 Tue, 22 Sep 2020 03:46:22 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d2sm25784497wro.34.2020.09.22.03.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 03:46:22 -0700 (PDT)
Subject: Re: [PATCH] hw: ide: check the pointer before do dma memory unmap
To: Li Qiang <liq3ea@gmail.com>
References: <20200815072052.73228-1-liq3ea@163.com>
 <20200922013411.auucs5t2hhw4romx@mozz.bu.edu>
 <8dcc2e29-6bd8-92d5-eaa6-9331aafe752a@redhat.com>
 <CAKXe6S+r2W-jM2kp-Rhai_14STkZP2mVEDYDTn3=tVECgE8bAw@mail.gmail.com>
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
Message-ID: <9fa20393-4a48-d687-3d2b-92156734b685@redhat.com>
Date: Tue, 22 Sep 2020 12:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+r2W-jM2kp-Rhai_14STkZP2mVEDYDTn3=tVECgE8bAw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 12:37 PM, Li Qiang wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> 于2020年9月22日周二 下午4:19写道：
>>
>> On 9/22/20 3:34 AM, Alexander Bulekov wrote:
>>> On 200815 0020, Li Qiang wrote:
>>>> In 'map_page' we need to check the return value of
>>>> 'dma_memory_map' to ensure the we actully maped something.
>>>> Otherwise, we will hit an assert in 'address_space_unmap'.
>>>> This is because we can't find the MR with the NULL buffer.
>>>> This is the LP#1884693:
>>>>
>>>> -->https://bugs.launchpad.net/qemu/+bug/1884693
>>>>
>>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>>> Signed-off-by: Li Qiang <liq3ea@163.com>
>>>
>>> I'm not very familiar with the IDE code, but this seems like a simple
>>> null-ptr check, and Li has not received a response in over a month.
>>
>> Yeah well it is not an easy bug... I spent few hours but at some
>> point it became too AHCI specific. I wanted to understand the bug
>> to answer the "Why do we get there?" "Can we get there with real
>> hardware?" questions, to be able to discern if this patch is OK,
>> or if it is hiding bugs and what we really use here is an assert().
> 
> Hi Philippe,
> I think you have complicated this issue. The root cause is that
> 'dma_memory_map' maybe fail.
> The gpa is from guest and can be any value so this is expected.
> It can return NULL pointer (no map) or it can be do partially
> mapped(len < wanted).
> Though in most situation the map result is 'ret == NULL and len <
> wanted'. It may also has '
> ret != NULL and len < wanted' I think.

Then this form is easier to review to my taste:

-- >8 --
@@ -250,7 +250,7 @@ static void map_page(AddressSpace *as, uint8_t
**ptr, uint64_t addr,
     }

     *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
-    if (len < wanted) {
+    if (*ptr && len < wanted) {
         dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
         *ptr = NULL;
     }
---

> 
> The assert is come from that we pass NULL to 'dma_memory_unmap'.
> 
> So the standard usage of 'dma_memory_map' I think is first check if
> the return value to ensure it is not NULL.
> Then check whether it mapped the len as the caller expected.
> 
> There are several places in the code base that doesn't following this
> usage which I think it is wrong.
> 
> Thanks,
> Li Qiang
> 
>>
>>>
>>> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
>>>
>>>> ---
>>>>  hw/ide/ahci.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>>>> index 009120f88b..63e9fccdbe 100644
>>>> --- a/hw/ide/ahci.c
>>>> +++ b/hw/ide/ahci.c
>>>> @@ -250,6 +250,11 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
>>>>      }
>>>>
>>>>      *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
>>>> +
>>>> +    if (!*ptr) {
>>>> +        return;
>>>> +    }
>>>> +
>>>>      if (len < wanted) {
>>>>          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>>>>          *ptr = NULL;
>>>> --
>>>> 2.17.1
>>>>
>>>
>>
> 


