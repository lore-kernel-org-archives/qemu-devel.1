Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFD32074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKPa3NCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFD32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZb8-0006mO-UX
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZaM-0006Lw-Ac
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:26:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZaL-0008KX-AR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591691176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vh8U0Y5KvRPeohJhOlJGsTVzVR02Wqpwm4slwW6k0Cc=;
 b=eKPa3NCzNOrfSswKNQaZtJAKsPf2IQY0EGZcTyxHmsf8KizmxWYas4gDx7E4OuF6WuIL5k
 KHBtnbl4bCVCo8OPj1Eb+wTVHT9tEHQyKyoRXe4Sm61nWK+w+wDjw7ren7EY9Y8Q2q998A
 KqUdsT18t3xm8PhoAsTw+dnqFLUa7aQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-4njA9ssGMg6ha40i0530ow-1; Tue, 09 Jun 2020 04:26:14 -0400
X-MC-Unique: 4njA9ssGMg6ha40i0530ow-1
Received: by mail-wr1-f72.google.com with SMTP id a4so8280428wrp.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vh8U0Y5KvRPeohJhOlJGsTVzVR02Wqpwm4slwW6k0Cc=;
 b=G1/mdcG4639too4bwuYi0ouOuxi5xaQm1ecyMd/OEAuKrXa6DfWM/GUCiqFAjXQJ/m
 I42XExVDGVm+XodsR5XfhIXmf8IN5jN5yYRqc7TdJK2kxx2Y8yXGYigCDzjR3x39kWk7
 AgKyqLI2daLY327MOvVV/cC5qxIZ2RVyvO5E+Dk5ib808hbFJfJEeh38TBcenzOhfRS6
 Ugr0vy1YoB9wSyepuI9KbHgEY+SRuyMmM4gjZafYVFtgh+IUXiMjSSxi3m5R9z3guscA
 NKC6WyPSqnWNr2m/F+HGZy8etUU2p+ce7Y4MrhfElC+F9VE6FtV8MzVzfxitqo6+BB87
 iw2g==
X-Gm-Message-State: AOAM531DFujTClc3nIaL9FDv7nmI2vn7/qHzC/+X0yBBPiQg1QM3SkVB
 /RAhknu9KkUzME1/0/7xVD/XJ2uKaIM5kMLpkeVQho+kWLFqDDOcy6mKicQonorXpIwhXvANhGB
 uYpEZswFgPZWBng0=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr3197657wrr.96.1591691173559;
 Tue, 09 Jun 2020 01:26:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd1gHi+UXrBwesxOfhqm1oQaOgUP3vQswxjLErCobBWYSl1uG8nKpLcL0M9LEiRYd1cK0HPA==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr3197639wrr.96.1591691173297;
 Tue, 09 Jun 2020 01:26:13 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l17sm2033958wmi.3.2020.06.09.01.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:26:12 -0700 (PDT)
Subject: Re: [PATCH v2 18/58] isa: New isa_new(), isa_realize_and_unref() etc.
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-19-armbru@redhat.com>
 <bd15d6c2-5576-dcad-18cc-5020f094dcbe@redhat.com>
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
Message-ID: <40af21b5-68f9-3573-9376-0ba60cc94226@redhat.com>
Date: Tue, 9 Jun 2020 10:26:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bd15d6c2-5576-dcad-18cc-5020f094dcbe@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 10:19 AM, Philippe Mathieu-Daudé wrote:
> On 5/29/20 3:44 PM, Markus Armbruster wrote:
>> I'm converting from qdev_create()/qdev_init_nofail() to
>> qdev_new()/qdev_realize_and_unref(); recent commit "qdev: New
>> qdev_new(), qdev_realize(), etc." explains why.
>>
>> ISA devices use qdev_create() through isa_create() and
>> isa_try_create().
>>
>> Provide isa_new(), isa_try_new(), and isa_realize_and_unref() for
>> converting ISA devices.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/hw/isa/isa.h |  3 +++
>>  hw/isa/isa-bus.c     | 15 +++++++++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
>> index 02c2350274..3b6215fafe 100644
>> --- a/include/hw/isa/isa.h
>> +++ b/include/hw/isa/isa.h
>> @@ -105,6 +105,9 @@ MemoryRegion *isa_address_space(ISADevice *dev);
>>  MemoryRegion *isa_address_space_io(ISADevice *dev);
>>  ISADevice *isa_create(ISABus *bus, const char *name);
>>  ISADevice *isa_try_create(ISABus *bus, const char *name);
>> +ISADevice *isa_new(const char *name);
>> +ISADevice *isa_try_new(const char *name);
>> +bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
>>  ISADevice *isa_create_simple(ISABus *bus, const char *name);
>>  
>>  ISADevice *isa_vga_init(ISABus *bus);
>> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
>> index 1c9d7e19ab..e6412d39b4 100644
>> --- a/hw/isa/isa-bus.c
>> +++ b/hw/isa/isa-bus.c
>> @@ -176,6 +176,16 @@ ISADevice *isa_try_create(ISABus *bus, const char *name)
>>      return ISA_DEVICE(dev);
>>  }
>>  
>> +ISADevice *isa_new(const char *name)
>> +{
>> +    return ISA_DEVICE(qdev_new(name));
>> +}
>> +
>> +ISADevice *isa_try_new(const char *name)
>> +{
>> +    return ISA_DEVICE(qdev_try_new(name));
> 
> We have:
> 
> #define ISA_DEVICE(obj) \
>      OBJECT_CHECK(ISADevice, (obj), TYPE_ISA_DEVICE)
> 
> With:
> 
> #define OBJECT_CHECK(type, obj, name) \
>     ((type *)object_dynamic_cast_assert(OBJECT(obj), (name), \
>                                         __FILE__, __LINE__, __func__))
> 
> "If an invalid object is passed to this function, a run time
>  assert will be generated."

Looking at object_dynamic_cast_assert() implementation, NULL is a
"valid" object...

> 
> I'd expect isa_try_new() to return NULL if the type_name is not
> registered...

This is what is returned, as object_dynamic_cast_assert(NULL) = NULL.

This is very unclear (and not the first time I dig to understand that).

So this patch is logically correct.
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>> +}
>> +
>>  ISADevice *isa_create_simple(ISABus *bus, const char *name)
>>  {
>>      ISADevice *dev;
>> @@ -185,6 +195,11 @@ ISADevice *isa_create_simple(ISABus *bus, const char *name)
>>      return dev;
>>  }
>>  
>> +bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp)
>> +{
>> +    return qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp);
>> +}
>> +
>>  ISADevice *isa_vga_init(ISABus *bus)
>>  {
>>      switch (vga_interface_type) {
>>
> 


