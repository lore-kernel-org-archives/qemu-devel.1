Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE11C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9500204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKRMLjAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9500204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97ru-0000sD-V7
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97m7-00067X-I7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:12:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97m5-0005Ch-Js
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598019129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TyVYAVN9ZNRXEXadD4rnDB9gzJxiVaVyrTyJrTmEq7g=;
 b=LKRMLjAwCJbvY7Qd2EOyKklyNw+WmkACmwLxO1gUfjFXp0b/5Xo5Ec/kTz5QIuo2hYzCap
 hmpJUidug0bhNhE/GKQwfwU/RLZ9phuJiJt8YzhtKHd58FuLMnn0D58096N2f3cWD3HSnk
 W+5k4Op4FwSyoNaBrU2FwWM1SVm0zlw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-W2Nw7jbNOAiJpQzjdvCRrA-1; Fri, 21 Aug 2020 10:12:07 -0400
X-MC-Unique: W2Nw7jbNOAiJpQzjdvCRrA-1
Received: by mail-wm1-f71.google.com with SMTP id z1so856090wmf.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 07:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TyVYAVN9ZNRXEXadD4rnDB9gzJxiVaVyrTyJrTmEq7g=;
 b=QoYo9dY+4lNyOhSgE5iC+7bfnBnucvrG1u9a5MhoP9LTmW+QiiYS1Ckxhr7eZjE0D2
 actQo9B9lQCv90TISIey6xCSjAfK9yUgN0/FTNoJ+QI2+/Yx19aMV5d6xFU93T79JVND
 xo88yrRhZ+S7X71fFFOXxchHXyGwGtOrHMnkEEbnojFab3Tpxa/dDVNAdl0I+w1ZDU7o
 G9kuMAV6HYPFNTAOEErodUttp+axvnAvfcNmgdqKRBJK2KHDx+sqNINHDavuG6XABD65
 Y0u6ziKxX+sbcXm7o7MX9QJWp6ppJMXRF+HIOvmkN72CYhsEeAG0yCpyvTiG+rnvaMz2
 M/ig==
X-Gm-Message-State: AOAM531PXw/+jfEzw/yQ2czNOD5TQcVn6QSz/mpEAyRgGWOn3VdCoiZL
 mdDGXjmH5brYVH5RWHPyp6eYsGa3lYkCHucKE7oaDFnrsi6AseBZS0KgUdFhKqygHDBfSw6f65s
 gkLafsE9gk/I85io=
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr2889304wrq.199.1598019125742; 
 Fri, 21 Aug 2020 07:12:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFCl8L9d68FO7yxEFT8s5MfS58KGACbHXHW3+lEtIcdbEgoEOKX549TM/vVbT7CgR8RVoEbA==
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr2889257wrq.199.1598019125287; 
 Fri, 21 Aug 2020 07:12:05 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l18sm4765480wrm.52.2020.08.21.07.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 07:12:04 -0700 (PDT)
Subject: Re: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200820190635.379657-1-danielhb413@gmail.com>
 <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com>
 <e9b2ce95-d920-24e3-14f7-cb41a5ce3caf@gmail.com>
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
Message-ID: <f2580f8a-2028-9bf3-0695-beea3cb8e4c0@redhat.com>
Date: Fri, 21 Aug 2020 16:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e9b2ce95-d920-24e3-14f7-cb41a5ce3caf@gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
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
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 4:08 PM, Daniel Henrique Barboza wrote:
> 
> 
> On 8/21/20 8:08 AM, Philippe Mathieu-Daudé wrote:
>> Cc'ing Markus
>>
>> On 8/20/20 9:06 PM, Daniel Henrique Barboza wrote:
>>> We do not implement hotplug in the vscsi bus, but we forgot to
>>> tell qdev about it. The result is that users are able to hotplug
>>> devices in the vscsi bus, the devices appear in qdev, but they
>>> aren't usable by the guest OS unless the user reboots it first.
>>>
>>> Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
>>> qbus_is_hotpluggable(), that we do not support hotplug operations
>>> in spapr_vscsi.
>>>
>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1862059
>>>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> ---
>>>   hw/scsi/spapr_vscsi.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
>>> index d17dc03c73..57f0a1336f 100644
>>> --- a/hw/scsi/spapr_vscsi.c
>>> +++ b/hw/scsi/spapr_vscsi.c
>>> @@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice
>>> *dev, Error **errp)
>>>         scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
>>>                    &vscsi_scsi_info, NULL);
>>> +
>>> +    /* ibmvscsi SCSI bus does not allow hotplug. */
>>> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
>>
>> Can't this be a problem later in DeviceClass::unrealize()?
> 
> Not as far as I've tested. A call to qbus_set_hotplug_handler(bus,NULL)
> after setting it to NULL isn't breaking anything either (just tested).
> 
> I verified before sending the patch that setting hotplug_handler to
> NULL is done in some unrealize() calls in buses, but not on devices.
> And I'm not sure which instance would cause an unrealize() in the
> device to fail if the hotplug_handler of the bus is NULL. As far as
> I'm concerned this shouldn't be happening in our case here, where we're
> not dealing with hotplug devices in the bus at all.
> 
> Which potential problems are you referring to?

I was wondering if qdev_unrealize() runs similar checks than
qdev_realize().

> 
>>
>> I was expecting something like, overwriting the parent bus type:
>>
>> -- >8 --
>> @@ -1271,6 +1271,7 @@ static void spapr_vscsi_class_init(ObjectClass
>> *klass, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
>>
>> +    k->bus_type = NULL; /* ibmvscsi SCSI bus does not allow hotplug. */
>>       k->realize = spapr_vscsi_realize;
>>       k->reset = spapr_vscsi_reset;
>>       k->devnode = spapr_vscsi_devnode;
>> ---
> 
> spapr_vscsi is not a bus, is an interface. Setting NULL to bus_type in
> spapr_vio
> breaks guest init:
> 
> 
> qemu-system-ppc64: /home/danielhb/qemu/hw/core/qdev.c:102:
> qdev_set_parent_bus: Assertion `dc->bus_type &&
> object_dynamic_cast(OBJECT(bus), dc->bus_type)' failed.
> Aborted
> 
> 
> I'm not so sure this would be better than what I'm doing either.
> qdev_device_add()
> calls qbus_is_hotpluggable() to see if the chosen bus allows hotplug. This
> function verifies if bus->hotplug_handler is NULL. What I'm doing is simply
> setting hotplug_handler to NULL in the SCSI bus instance that belongs to
> spapr_vscsi. As far as I understand this is a valid use of the qdev API - I
> should be able to set hotplug_handler to NULL if I don't want devices being
> hotplugged in the bus I'm instantiating. Either that, or
> qbus_is_hotpluggable()
> must check for something else that I can safely turn off.

I'm not saying I know the correct way to do that, this is why I added
Markus in the loop :) I'm wondering from an API point of view what is
the best way to achieve what you want. I'm glad this works this way.

> 
> 
> Thanks,
> 
> 
> DHB
> 
> 
> 
> 
>>
>>>   }
>>>     void spapr_vscsi_create(SpaprVioBus *bus)
>>>
>>
> 


