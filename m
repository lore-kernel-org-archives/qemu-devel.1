Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C44C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0CB207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENBlB4v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0CB207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNun-0000kL-Mu
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGNuC-0000Dj-ET
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:50:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGNuB-0002JP-0P
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599749429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lC4J9StLd/QW0XR2r3AbCJXGSYpkjo/xDz5tK2/XdIA=;
 b=ENBlB4v3GFq+aid65NKEK7OCccxutQNdAfop6oCJ6HF2Nvq7gGqgOfNSnJ08TYZEI+8Uvm
 QpdWIp2LA+67IMKQcRAV7Hjjo7PrdBpHyNDoTug0VYVj57aILZnjpwG0o97URxd2Wy8gCY
 dVwJOlR+cGGwmtKxe5Djkq+tCUaMNGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-64R3vwckP_2ER8CFM2Anjg-1; Thu, 10 Sep 2020 10:50:26 -0400
X-MC-Unique: 64R3vwckP_2ER8CFM2Anjg-1
Received: by mail-wm1-f69.google.com with SMTP id d22so87950wmd.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 07:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lC4J9StLd/QW0XR2r3AbCJXGSYpkjo/xDz5tK2/XdIA=;
 b=GeUnhnsWJB78Jd0LHJ0l6CL0vZpz4aW5xi6xw6cq1C/oZ6b5Lb2stR7bjinsKKt/5r
 yXxbT8oACFNd0EWiwm0x2WxCJ8W4A+5svZA4WeTMc3v1O01o7UO30flsHA6wnVP6x0yI
 DegGIW3ELmsdQxm6AAUNmLAIoW+/TN+nSy17lY6yTLgjcN+oIh6W8gCG0KyHXv275ID+
 HLEWRxdscWVfN3ctVnQ62Wtsl9fMhXTfWJPXo2TCvbU1455nCY4LDbZIDd4efq7odZei
 ifXcnXNx3dG7L6t+B8MNYS0cN5CET9/AWJIaEVoS2mOE+vMQqkWQtff1P4Mvg+KUrpus
 4cpA==
X-Gm-Message-State: AOAM531Zls+AAqZXs/wjaiKFBaRDzjBB1WdgXt5YEbZzCuxRjU1aNUii
 ctbRCqkShr/GhLATofpZ8KuzxYr53N7a+14CNVPqRc4dLAM4nMT3JnDTRx+ph2O96X7xiAw0LRO
 jgyGdoclhrhjPsLQ=
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr407301wma.18.1599749424909;
 Thu, 10 Sep 2020 07:50:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7b2Ad+eRTDPyI1AbnaWFgLPT211RlKHRQzAEV4rqOLYg2qtaNKsbVuU4iUkur8RonoJFeoQ==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr407270wma.18.1599749424607;
 Thu, 10 Sep 2020 07:50:24 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z13sm9452327wro.97.2020.09.10.07.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 07:50:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hw/timer/hpet: Remove dead code
To: Li Qiang <liq3ea@gmail.com>
References: <20200910135852.516809-1-philmd@redhat.com>
 <20200910135852.516809-2-philmd@redhat.com>
 <CAKXe6SLhDWvWU_D-87sb0sHfNOO9dkPPS4EiVjuXuHLiCbGKgw@mail.gmail.com>
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
Message-ID: <ad2e06b8-fe5e-628a-7145-e724c85ccf6f@redhat.com>
Date: Thu, 10 Sep 2020 16:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SLhDWvWU_D-87sb0sHfNOO9dkPPS4EiVjuXuHLiCbGKgw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Qemu Developers <qemu-devel@nongnu.org>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 4:46 PM, Li Qiang wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> 于2020年9月10日周四 下午10:01写道：
>>
>> This code was never compiled/used, remove it.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/timer/hpet.c | 14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
>> index 380acfa7c8a..b683f64f1d3 100644
>> --- a/hw/timer/hpet.c
>> +++ b/hw/timer/hpet.c
> 
> Maybe we also remove the
> "//#define HPET_DEBUG"
> in the head of this file?

We need to convert the debug calls to trace events first.

> 
> Thanks,
> Li Qiang
> 
>> @@ -416,20 +416,6 @@ static void hpet_del_timer(HPETTimer *t)
>>      update_irq(t, 0);
>>  }
>>
>> -#ifdef HPET_DEBUG
>> -static uint32_t hpet_ram_readb(void *opaque, hwaddr addr)
>> -{
>> -    printf("qemu: hpet_read b at %" PRIx64 "\n", addr);
>> -    return 0;
>> -}
>> -
>> -static uint32_t hpet_ram_readw(void *opaque, hwaddr addr)
>> -{
>> -    printf("qemu: hpet_read w at %" PRIx64 "\n", addr);
>> -    return 0;
>> -}
>> -#endif
>> -
>>  static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>>                                unsigned size)
>>  {
>> --
>> 2.26.2
>>
>>
> 


