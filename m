Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEDAC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4035420678
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fs7119Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4035420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8HW-0006U9-9F
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7yn-0002Ju-Nz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:17:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7yg-00051j-A0
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604931421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5KBgy1bptvYMHiVNJXsoIH6QRdqGQ0VK6mil4C/JIM=;
 b=fs7119KgWEPqYN0WYbZi/JT2lNV81EPnLr1QUwcjN5NZIsNDyC34SaTEofswEXOA+0LMht
 0tLwlJMgTiz0e6sSGrh5UBK5iDvDo2WBlsMTWUL0dDwgztZgxmwIUKy7SEG8aGNN6rQQqg
 gnUCrdSfoMhaJ3ZgjURNl7RaS7wg0iA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-OiQx9VWtPfqCkBKyrCRnQQ-1; Mon, 09 Nov 2020 09:16:57 -0500
X-MC-Unique: OiQx9VWtPfqCkBKyrCRnQQ-1
Received: by mail-wr1-f72.google.com with SMTP id p16so1753171wrx.4
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+5KBgy1bptvYMHiVNJXsoIH6QRdqGQ0VK6mil4C/JIM=;
 b=tMsD/IZv4G34O0+3kpIqSJ+CiShZJYAVMwLGt8gcsLerRj1FKmoyAKE//6VcPlFTRV
 PqFbC79Rpop3g95T0aL79472lsAM2dEPKkilb9jazUFJJXdlHFx+lpvUrAzQ2yqCe2xz
 KNh3ke4OO/1BiXhkunF9NeptEjyGyWNZl8wJl/04wwigrBOkErAgbgoej9mU2GklGIjA
 qyEZJJpB6aKSi3WDPqhYAi5SqM/kSYiPp5Otpu2J21qn7O/7MPsCJBxaQJM/9oPJoqpH
 kfdHzefdERnxy42SCVNkuZkCzGM7PJkPaFhkv1Th88uqzxbWP2QIDPBulaXl9QypeaJ0
 GwvA==
X-Gm-Message-State: AOAM530DVMqrYODwBpgXQx/4VsG4FpwCQ3oAznbxypND2YdKZnEitzPS
 pey2CzkM8V9TUGfgNzIz7NUklUt41JlYmGAVg3Xf1xKOhAWKB7LT2xqnIJOWg0MLYxBLUXqq5OZ
 wCiyqsHrJ/NlPfiQ=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr14464339wmc.36.1604931415939; 
 Mon, 09 Nov 2020 06:16:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZnKv9ROmrZKrV7LLt8EJuQBDvH/FY0mFP45Gg7VhRyHcZALGyQEl6q/ktNRS+Hjyp/Upy6g==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr14464321wmc.36.1604931415769; 
 Mon, 09 Nov 2020 06:16:55 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e6sm13311727wme.27.2020.11.09.06.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:16:54 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v2] hw/core/qdev-properties-system: Rewrite
 set_pci_host_devaddr using GLib
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>
References: <20201013102252.3562860-1-philmd@redhat.com>
 <60f5af9c-4153-7702-cd99-b317a6de89c0@redhat.com>
Message-ID: <ccf65075-c0e9-7358-f483-2c7fbbd3fb81@redhat.com>
Date: Mon, 9 Nov 2020 15:16:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <60f5af9c-4153-7702-cd99-b317a6de89c0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing PCI developers (rc2 is scheduled for tomorrow).

On 11/7/20 9:59 AM, Philippe Mathieu-Daudé wrote:
> Ping for 5.2 as this is a bugfix.
> 
> On 10/13/20 12:22 PM, Philippe Mathieu-Daudé wrote:
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
>> v2: Free g_strsplit() with g_auto(GStrv) (Daniel)
>> ---
>>  hw/core/qdev-properties-system.c | 61 ++++++++++++++------------------
>>  1 file changed, 27 insertions(+), 34 deletions(-)
>>
>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
>> index 49bdd125814..36d4fd8b22a 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -878,11 +878,11 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>>      DeviceState *dev = DEVICE(obj);
>>      Property *prop = opaque;
>>      PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
>> -    char *str, *p;
>> -    const char *e;
>> +    g_autofree char *str = NULL;
>> +    g_auto(GStrv) col_s0 = NULL;
>> +    g_auto(GStrv) dot_s = NULL;
>> +    char **col_s;
>>      unsigned long val;
>> -    unsigned long dom = 0, bus = 0;
>> -    unsigned int slot = 0, func = 0;
>>  
>>      if (dev->realized) {
>>          qdev_prop_set_after_realize(dev, name, errp);
>> @@ -893,57 +893,50 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>>          return;
>>      }
>>  
>> -    p = str;
>> -    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
>> +    col_s = col_s0 = g_strsplit(str, ":", 3);
>> +    if (!col_s || !col_s[0] || !col_s[1]) {
>>          goto inval;
>>      }
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
>>              goto inval;
>>          }
>> +        addr->domain = val;
>> +        col_s++;
>> +    } else {
>> +        addr->domain = 0;
>>      }
>> -    slot = val;
>>  
>> -    if (*e != '.') {
>> +    /* bus */
>> +    if (qemu_strtoul(col_s[0], NULL, 16, &val) < 0 || val > 0xff) {
>>          goto inval;
>>      }
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
>>          goto inval;
>>      }
>>  
>> -    if (*e) {
>> +    /* slot */
>> +    if (qemu_strtoul(dot_s[0], NULL, 16, &val) < 0 || val > 0x1f) {
>>          goto inval;
>>      }
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
>>      return;
>>  
>>  inval:
>>      error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
>> -    g_free(str);
>>  }
>>  
>>  const PropertyInfo qdev_prop_pci_host_devaddr = {
>>
> 


