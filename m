Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE7FC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E529E20643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="kEddQkht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E529E20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2kr-0003ir-Ua
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ip2dL-00016q-EQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ip2dI-0007Ey-Bw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:07:49 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ip2dH-0007D3-UV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:07:48 -0500
Received: by mail-pg1-x542.google.com with SMTP id x7so876490pgl.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 20:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=68cnW6jRwwd0MYsZJw4OoLbMhZb0LHMF9qa5WRZDFNM=;
 b=kEddQkhtToSAkCpJN4cwoGFqcYnpNLYvY+y3UgyVq+92srZ4yFPf3cVJkY49mb2/BT
 FUWLi9AQ+ARLK1yyayfhgRJeGXJLpMqpQyaHD6FPv2chEHckasjTONS0YPMVyk6KfhTv
 oX9ACDuLJbFC/FYa+sGVbqwKor9HoS2QgJEaM99c6cnhxXs6mLUm+e+kZ+qjrPw7i0rY
 OJMoV4LVFH+RjMfDXNQp3n0JTbLktLy0991eKsWPtk+97UGwpSwZkY2xbkGFknZXggDH
 94z9HLKAZ5Ezks74bwQ1BMJ6Z81tRd7sG+kVQvxzNE1YWvAMaNXC7b1wpmE+JofFB0jG
 rbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=68cnW6jRwwd0MYsZJw4OoLbMhZb0LHMF9qa5WRZDFNM=;
 b=swF72NzCWLjyjizOXanj0qfY2MbfRLzNBCh1gnCiwxo4bGV/mLIjEoyjTRTSWIJtT6
 NXPmDDME8hqMvmbXDbjQL5y+z4QmkPpu7P2LvDEzKHkFEBkw8i13N02kg8inWjicQ9Q1
 bf12ECpiYAUjfKh8brcc1VdvJdF7hxmoCcVrN8Rhn9DGgz2dfOoOpuCHNGl8Whcp2Xft
 2Y3+MEpxBudvpnb4iCSlbN6Z7dvOAi4pbJ+N/tM/D12Uu2PTi8pQDM0V5H+Ar6CoSmyz
 ITHVPN9NGtjhv3tyl+lT/Rr4rmiViZqRyoM9eaDX96qnW1QUS1rdrBsm0R4EDwJxbUul
 K2aQ==
X-Gm-Message-State: APjAAAUGOWKGCWVs9IAgzmGjKePqPEQqTNNKSmo5JmhybTNQf4I45JVD
 3bFCGdR0mzr57WFKvN7GXh30xQ==
X-Google-Smtp-Source: APXvYqz+az6z5sDn4ZQWhz9m7R0w127108G0hB0cwtmtACwciGrT0hMFvDLUhjbUBWHWN94CByEdng==
X-Received: by 2002:a63:5f91:: with SMTP id t139mr3091890pgb.185.1578456466818; 
 Tue, 07 Jan 2020 20:07:46 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 11sm1208291pfz.25.2020.01.07.20.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 20:07:45 -0800 (PST)
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
 <20200106085042.GW2098@umbus>
 <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
 <20200107052604.GH2098@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <a76e906f-4cf0-aa49-759d-e64b7f219a1b@ozlabs.ru>
Date: Wed, 8 Jan 2020 15:07:41 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200107052604.GH2098@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 07/01/2020 16:26, David Gibson wrote:

>>>>>> +static uint32_t client_setprop(SpaprMachineState *sm,
>>>>>> +                               uint32_t nodeph, uint32_t pname,
>>>>>> +                               uint32_t valaddr, uint32_t vallen)
>>>>>> +{
>>>>>> +    char propname[64];
>>>>>> +    uint32_t ret = -1;
>>>>>> +    int proplen = 0;
>>>>>> +    const void *prop;
>>>>>> +
>>>>>> +    readstr(pname, propname);
>>>>>> +    if (vallen == sizeof(uint32_t) &&
>>>>>> +        ((strncmp(propname, "linux,rtas-base", 15) == 0) ||
>>>>>> +         (strncmp(propname, "linux,rtas-entry", 16) == 0))) {
>>>>>> +
>>>>>> +        sm->rtas_base = readuint32(valaddr);
>>>>>> +        prop = fdt_getprop_namelen(sm->fdt_blob,
>>>>>> +                                   fdt_node_offset_by_phandle(sm->fdt_blob,
>>>>>> +                                                              nodeph),
>>>>>> +                                   propname, strlen(propname), &proplen);
>>>>>> +        if (proplen == vallen) {
>>>>>> +            *(uint32_t *) prop = cpu_to_be32(sm->rtas_base);
>>>>>> +            ret = proplen;
>>>>>> +        }
>>>>>
>>>>> Is there a particular reason to restrict this to the rtas properties,
>>>>> rather than just allowing the guest to fdt_setprop() something
>>>>> arbitrary?
>>>>
>>>> The FDT is flatten and I am not quite sure if libfdt can handle updating
>>>> properties if the length has changed.
>>>
>>> fdt_setprop() will handle updating properties with changed length (in
>>> fact there's a special fdt_setprop_inplace() optimized for the case
>>> where you don't need that).  It's not particularly efficient, but it
>>> should work fine for the cases we have here.  In fact, I think you're
>>> already relying on this for the code that adds the phandles to
>>> everything.
>>
>> Well, I used to add phandles before calling fdt_pack() so it is not exactly the same.
> 
> Ah, right, that's why adding the phandles worked.
> 
>>> One complication is that it can return FDT_ERR_NOSPACE if there isn't
>>> enough buffer for the increased thing.  We could either trap that,
>>> resize and retry, or we could leave a bunch of extra space.  The
>>> latter would be basically equivalent to not doing fdt_pack() on the
>>> blob in the nobios case.
>>
>>
>> This is what I ended up doing.
>>
>>
>>>> Also, more importantly, potentially property changes like this may have
>>>> to be reflected in the QEMU device tree so I allowed only the properties
>>>> which I know how to deal with.
>>>
>>> That's a reasonable concern, but the nice thing about not having SLOF
>>> is that there's only one copy of the device tree - the blob in qemu.
>>> So a setprop() on that is automatically a setprop() everywhere (this
>>> is another reason not to write the fdt into guest memory in the nobios
>>> case - it will become stale as soon as the client changes anything).
>>
>>
>> True to a degree. It is "setprop" to the current fdt blob which we do not
>> analyze after we build the fdt. We either need to do parse the tree before
>> we rebuild it as CAS so we do not lose the updates or do selective changes
>> to the QEMUs objects from the "setprop" handler (this is what I do
>> now).
> 
> Hrm.. do those setprops happen before CAS?

Yes, vmlinux/zimage call "setprop" for "linux,initrd-start",
"linux,initrd-end", "bootargs", "linux,stdout-path"; vmlinux sets
properties if linux,initrd-* came from r3/r4 and zImage sets properties
no matter how it discovered them - from r3/r4 or the device tree.

btw we write them as "cells" (==4bytes long) in qemu but vminux changes
them to 8 bytes and zImage keeps it 4 bytes. Not a problem but an
interesting fact, this is why I had to allow extending the properties in
"setprop" :)


>  I would have thought we'd
> call CAS before instantiating RTAS.

This is correct but I do not think the order is mandatory.


-- 
Alexey

