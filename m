Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D91C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38BD20708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4qNjWCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38BD20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHQE-0004gl-LZ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHOG-0003OM-Vn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHOC-0001lb-9l
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602584317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StQHRBhbEleOFjNm1Qm4eQcjyNBAT4H9PFvuOkFcM6c=;
 b=C4qNjWCMDYiLQbc+RerC4faL682XF40dfd3I0X/8ntap7mfzlqUyVGYYPjd4nQHy18iItu
 uXuAWWCGP6Gbq2oeA0kQeTfWXcq652MCCI8dSdGgfnYPAZodnDI907L4E/MAm1+ye4rLof
 KYukn4e799wW5SgvALCiWr1N/n78w7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-5Ci7cuKvNz62QyUGhf-f7A-1; Tue, 13 Oct 2020 06:18:35 -0400
X-MC-Unique: 5Ci7cuKvNz62QyUGhf-f7A-1
Received: by mail-wr1-f69.google.com with SMTP id v5so10704355wrr.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=StQHRBhbEleOFjNm1Qm4eQcjyNBAT4H9PFvuOkFcM6c=;
 b=ZW0FupBSkY+t8oZezyTo7mL+ogzC3UrEMHOunGiTnWln3cNq3F8oH4lCROaCYq8xMZ
 NQ/x3J3mywyrqwThHbd0R7uxYNMMRtiJsa0tT5Ks5U0oa9Vf72ZUeKCxZCtEfDI0jh/V
 vShthFUDvOQMM+dW5B/lY/Arap5ES24ORTz9GbPXmTRfhn1QFEw7oFvGQjgeoaELMczD
 LMZI7uYRUNBirWaCUsAAtTXnCskkYFxNA5PS8GiEKl118EO2+ksMr8CkY9V1/hBgBaZs
 xltX7VvJ54iSpKV0DNhBIGr0+Q0+Q5mRpkDm1rxQ4PLzcdaO7b3MCAuN+OA2UZu6ItXT
 q6QA==
X-Gm-Message-State: AOAM531kgU0m7zH5gOQ7QG+XyyGClV/MKKS15XwLtYh7LaAm0Z0o6G1h
 784NtaBdw+yVnb3UWtwRcw+IRovn3dZB4DhCVoWdJbxYoSdSe1WWkRoEt6Bb2CUjHh58JQR+ocz
 mxO4NcbnNouC7Xkw=
X-Received: by 2002:a05:600c:2211:: with SMTP id
 z17mr14389913wml.169.1602584314667; 
 Tue, 13 Oct 2020 03:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlGu3Q9Gq9lXqQ3tRyoX06ths/CyIn/4Obr0rrVQs3LnUOkUx1DZRu6omdGwEssCVS9xdMKA==
X-Received: by 2002:a05:600c:2211:: with SMTP id
 z17mr14389901wml.169.1602584314454; 
 Tue, 13 Oct 2020 03:18:34 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c16sm29252456wrx.31.2020.10.13.03.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 03:18:33 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev-properties-system: Rewrite
 set_pci_host_devaddr using GLib
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201013100315.3554421-1-philmd@redhat.com>
 <20201013100737.GH70612@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <caddf42e-32cf-7d59-e54b-ad6e805681f9@redhat.com>
Date: Tue, 13 Oct 2020 12:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013100737.GH70612@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Klaus Herman <kherman@inbox.lv>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 12:07 PM, Daniel P. Berrangé wrote:
> On Tue, Oct 13, 2020 at 12:03:15PM +0200, Philippe Mathieu-Daudé wrote:
>> set_pci_host_devaddr() is hard to follow, thus bug-prone.
>> We indeed introduced a bug in commit bccb20c49df, as the
>> same line might be used to parse a bus (up to 0xff) or a
>> slot (up to 0x1f). Instead of making things worst, rewrite
>> using g_strsplit().
>>
>> Fixes: bccb20c49df ("Use qemu_strtoul() in set_pci_host_devaddr()")
>> Reported-by: Klaus Herman <kherman@inbox.lv>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   hw/core/qdev-properties-system.c | 61 ++++++++++++++------------------
>>   1 file changed, 27 insertions(+), 34 deletions(-)
>>
>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
>> index 49bdd125814..e6e081efd58 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -878,11 +878,11 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>>       DeviceState *dev = DEVICE(obj);
>>       Property *prop = opaque;
>>       PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
>> -    char *str, *p;
>> -    const char *e;
>> +    g_autofree char *str = NULL;
>> +    g_autofree char **col_s0 = NULL;
>> +    g_autofree char **dot_s = NULL;
> 
> These free the array, but not the array elements.
> 
> You need to use
> 
>     g_auto(GStrv) col_s0 = NULL
> 
> GStrv is a typedef for char **, that exists solely so that there is
> a typename against which g_auto can be used.

Ah I have been wondering how that part works.

Thanks, I'll fix.

> 
>> +    char **col_s;
>>       unsigned long val;
>> -    unsigned long dom = 0, bus = 0;
>> -    unsigned int slot = 0, func = 0;
>>   
>>       if (dev->realized) {
>>           qdev_prop_set_after_realize(dev, name, errp);
>> @@ -893,57 +893,50 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>>           return;
>>       }
>>   
>> -    p = str;
>> -    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
>> +    col_s = col_s0 = g_strsplit(str, ":", 3);
>> +    if (!col_s || !col_s[0] || !col_s[1]) {
>>           goto inval;
>>       }
>> -    if (*e != ':') {
>> -        goto inval;
>> -    }
>> -    bus = val;
>>   
>> -    p = (char *)e + 1;
>> -    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
>> -        goto inval;
>> -    }
>> -    if (*e == ':') {
>> -        dom = bus;
>> -        bus = val;
>> -        p = (char *)e + 1;
>> -        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
>> +    /* domain */
>> +    if (col_s[2]) {
>> +        if (qemu_strtoul(col_s[0], NULL, 16, &val) < 0 || val > 0xffff) {
>>               goto inval;
>>           }
>> +        addr->domain = val;
>> +        col_s++;
>> +    } else {
>> +        addr->domain = 0;
>>       }
>> -    slot = val;
>>   
>> -    if (*e != '.') {
>> +    /* bus */
>> +    if (qemu_strtoul(col_s[0], NULL, 16, &val) < 0 || val > 0xff) {
>>           goto inval;
>>       }
>> -    p = (char *)e + 1;
>> -    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e == p) {
>> -        goto inval;
>> -    }
>> -    func = val;
>> +    addr->bus = val;
>>   
>> -    if (bus > 0xff) {
>> +    /* <slot>.<func> */
>> +    dot_s = g_strsplit(col_s[1], ".", 2);
>> +    if (!dot_s || !dot_s[0] || !dot_s[1]) {
>>           goto inval;
>>       }
>>   
>> -    if (*e) {
>> +    /* slot */
>> +    if (qemu_strtoul(dot_s[0], NULL, 16, &val) < 0 || val > 0x1f) {
>>           goto inval;
>>       }
>> +    addr->slot = val;
>>   
>> -    addr->domain = dom;
>> -    addr->bus = bus;
>> -    addr->slot = slot;
>> -    addr->function = func;
>> +    /* func */
>> +    if (qemu_strtoul(dot_s[1], NULL, 10, &val) < 0 || val > 7) {
>> +        goto inval;
>> +    }
>> +    addr->function = val;
>>   
>> -    g_free(str);
>>       return;
>>   
>>   inval:
>>       error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
>> -    g_free(str);
>>   }
>>   
>>   const PropertyInfo qdev_prop_pci_host_devaddr = {
>> -- 
>> 2.26.2
>>
> 
> Regards,
> Daniel
> 


