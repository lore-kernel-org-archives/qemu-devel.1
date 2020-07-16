Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125CCC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15E4207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N14gf083"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15E4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw57k-0005Nw-2I
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw56m-0004MH-RH
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:43:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20290
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw56k-0008RB-Rj
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594910614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kp98BPWlphHPhxrVIyBmPDilm/4cM+3lkHpNTpEYCT4=;
 b=N14gf083S6XKeSrzJ5JmEWETCHZZwNyplSJGKEpg5IEiHTlAzm2sDOo4/czh1s2a3uNMFy
 ZM1yw4e6W34kuC4EAKmw2xsF/GtuLu6kFkLzo+tVgwvsysh3hwZ1FpSe7wy/kgptYfB70X
 VaQLq59m7m31f6SgqTtxFweq/pMwE+A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-8fN2qLVIMhCoq3f2f_PmRA-1; Thu, 16 Jul 2020 10:43:32 -0400
X-MC-Unique: 8fN2qLVIMhCoq3f2f_PmRA-1
Received: by mail-wr1-f72.google.com with SMTP id f5so5575816wrv.22
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 07:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Kp98BPWlphHPhxrVIyBmPDilm/4cM+3lkHpNTpEYCT4=;
 b=WDi3Xi+fMa1t2lEypqLyUTMSNSLlK3zeKpySlia1KiygIJe+WtMD8UVd/jpFy3E6ca
 lRrEWDMLSsBD5nKTw+jous0v6rE8QUErruYNcm+4KrFJBy04fwohaf3AldtW6FzDeGjE
 EH8vNJhlx2Mt7yX9dg3Ku9lcOLlYE3lM+Ziivfo8uj77FSONXrvCjnTF6JTAwh2Amt+s
 mDc5+YYTkDONcwSHIW6rWuPnucnS7IKI3ns46/7YSWMif/y73JjGV/K3ytYa8eRY+3jp
 sbb1gyc+psGD/+FxCL9lsfXgbnGysxiJD5QLswAVNfaSM2mPk5+U0S6IaPbXOdHZuk7w
 VTPw==
X-Gm-Message-State: AOAM530iGsd2ojmGJpAh9iX8UdiMkEa2h9U5xgx5b7ZVx9RvjKvNmT6+
 RrdPyBJ1ar166SLBg6P8l274NS8Zo9TBDc4hYXaCAaLOLCRiARSVxNPRyp0ylrbLlhfp9LUeR0A
 PXa7LoDCbydP0HFM=
X-Received: by 2002:a1c:de07:: with SMTP id v7mr4749974wmg.56.1594910610418;
 Thu, 16 Jul 2020 07:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe+8dSpjl9mDZFsgO8Tnj2/BUdYxsouslXjltQtXrM5nwJjJ7AVBrQOP8rpn8KkNlzK6DVAw==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr4749950wmg.56.1594910610108;
 Thu, 16 Jul 2020 07:43:30 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 51sm9751667wrc.44.2020.07.16.07.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 07:43:29 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] hw/s390x: Move S390_ADAPTER_SUPPRESSIBLE from
 'css.h' to 's390_flic.h'
To: Cornelia Huck <cohuck@redhat.com>
References: <20200715131845.30469-1-philmd@redhat.com>
 <20200716131127.6eec15c2.cohuck@redhat.com>
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
Message-ID: <f952afa1-ed33-3165-7f63-07248b691702@redhat.com>
Date: Thu, 16 Jul 2020 16:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200716131127.6eec15c2.cohuck@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 1:11 PM, Cornelia Huck wrote:
> On Wed, 15 Jul 2020 15:18:45 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Not all s390x devices require to have access to the CPU internals.
>>
>> To reduce the include dependencies on "s390x/css.h", move the
>> S390_ADAPTER_SUPPRESSIBLE definition to "s390x/s390_flic.h".
> 
> But css.h is not 'CPU internals', it is the main I/O subsystem?

I meant devices using the main I/O subsystem don't need to have
access to the CPU internals (CPUS390XState and s390_cpu* helpers).

> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/hw/s390x/css.h       | 7 -------
>>  include/hw/s390x/s390_flic.h | 7 +++++++
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>> index 08c869ab0a..7858666307 100644
>> --- a/include/hw/s390x/css.h
>> +++ b/include/hw/s390x/css.h
>> @@ -12,7 +12,6 @@
>>  #ifndef CSS_H
>>  #define CSS_H
>>  
>> -#include "cpu.h"
> 
> FWIW, we should just be able to remove this #include...

Odd it was not working yesterday (missing CONFIG_KVM) but today
it works.

> 
>>  #include "hw/s390x/adapter.h"
>>  #include "hw/s390x/s390_flic.h"
>>  #include "hw/s390x/ioinst.h"
>> @@ -233,12 +232,6 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
>>  void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
>>                                uint8_t flags, Error **errp);
>>  
>> -#ifndef CONFIG_KVM
>> -#define S390_ADAPTER_SUPPRESSIBLE 0x01
>> -#else
>> -#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
>> -#endif
>> -
>>  #ifndef CONFIG_USER_ONLY
>>  SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
>>                           uint16_t schid);
>> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
>> index 4687ecfe83..6bf9d73728 100644
>> --- a/include/hw/s390x/s390_flic.h
>> +++ b/include/hw/s390x/s390_flic.h
>> @@ -17,6 +17,13 @@
>>  #include "hw/s390x/adapter.h"
>>  #include "hw/virtio/virtio.h"
>>  #include "qemu/queue.h"
>> +#include "cpu.h"
> 
> ...and we do not need it here AFAICS.
> 
>> +
>> +#ifndef CONFIG_KVM
>> +#define S390_ADAPTER_SUPPRESSIBLE 0x01
>> +#else
>> +#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
>> +#endif
>>  
>>  /*
>>   * Reserve enough gsis to accommodate all virtio devices.
> 
> Whether the definition of S390_ADAPTER_SUPPRESSIBLE belongs into css.h
> or s390_flic.h is probably a matter of taste: the definition of an I/O
> adapter is in css.h, and registration of an adapter is done via the
> FLIC.
> 
> I think removing the cpu.h include might already do what you wanted to
> do?

Yes :)

Thanks!


