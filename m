Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBEFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1623D2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/yoIGBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1623D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98Mx-0003Ar-Am
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k98MN-0002f9-VQ; Fri, 21 Aug 2020 10:49:39 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:39300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k98MM-0001N3-4C; Fri, 21 Aug 2020 10:49:39 -0400
Received: by mail-qt1-x843.google.com with SMTP id w9so1351712qts.6;
 Fri, 21 Aug 2020 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3kPMLSSoe7qRPGgfdifoCmxMx3yy1Yzl8fyI3LmmL2w=;
 b=p/yoIGBwp5xSSAH5mcBJilMPctd85YA5Jrdcn9jYqqkT/nf0Q8JZCXZl6vlUJ4ikMB
 vkcsleZsgvesSpTHdZcWumOwbJo+F4QfauOnWoJosi92kw01kpYiyXvmpSUI3uW448av
 o/eSf5D4bKuvgPoyVKU7whkQgMNZAxqTd81Wortc+/V4VqQqVO+2OkSo3uxnzsaRC2nR
 gWGMGFoKdjYGHXNQd9FMAmRtGlReLRVGz73ah69ZSR3ahfGf/EiuFKM4zUourkFnC5Op
 p8YHnJRqN6Pl72Wam1dBt7jWGZNbMzi8znEgK7ro/J/QxUp+eFcU3C1LQYJ4WQZEVq6J
 aLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3kPMLSSoe7qRPGgfdifoCmxMx3yy1Yzl8fyI3LmmL2w=;
 b=TP5pMSFdf7sCrKnZLI+O3U7PJjohRa42DGxWjg85z7B00m+115B4IZtufrHJFootv1
 oG0PuVr4oFtKW2Dkh9Rrhf6kgZDiDbdSM37Rp1AjqrsDW+VcFrdpD63jMXcL06t1h+1x
 X6Wo7rJjSTFbtwPd/6QKjhbOQ22tT56ZYEdDlRQbqwb5h0c9Mx+xqXhvJ9w9DNaLHeQU
 1y5z4GzFsfDYsr3t6ZS2EmMFTh0LP5n8nGx4gw48v/5Aqc//MQQTpsweaER3lGYMXN5W
 7UauoNmEg2bKtoxcNmZTnlbzTj2iYral9i23r66LIGrN+1nPlTdt2dPYiAPznEuR6vP1
 Rmmw==
X-Gm-Message-State: AOAM532AGH+XEgIQQ3Ffss1kqEVfJJbBWgBrusI4NWwD4GLbh+Gtba/S
 /BV2Tn4ZmX4fKX++WuBSe3k=
X-Google-Smtp-Source: ABdhPJw0dKCDf2j08Vnq868tOkWA9ovpruh6esxK3EPyqxQGXk4vUEYwHRu6NUcN/b/S64ABHvo8Ww==
X-Received: by 2002:ac8:7c8d:: with SMTP id y13mr2956542qtv.387.1598021376830; 
 Fri, 21 Aug 2020 07:49:36 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c152:6ea6:a44d:671e:88f?
 ([2804:431:c7c7:c152:6ea6:a44d:671e:88f])
 by smtp.gmail.com with ESMTPSA id c33sm2251884qtk.40.2020.08.21.07.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 07:49:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200820190635.379657-1-danielhb413@gmail.com>
 <7f6ab4e6-42b1-3de4-5893-2ef09fc9dd26@redhat.com>
 <e9b2ce95-d920-24e3-14f7-cb41a5ce3caf@gmail.com>
 <f2580f8a-2028-9bf3-0695-beea3cb8e4c0@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <fc6094bd-8a75-e83f-0cd4-cc177ee5bffd@gmail.com>
Date: Fri, 21 Aug 2020 11:49:33 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f2580f8a-2028-9bf3-0695-beea3cb8e4c0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 8/21/20 11:12 AM, Philippe Mathieu-Daudé wrote:
> On 8/21/20 4:08 PM, Daniel Henrique Barboza wrote:
>>
>>
>> On 8/21/20 8:08 AM, Philippe Mathieu-Daudé wrote:
>>> Cc'ing Markus
>>>
>>> On 8/20/20 9:06 PM, Daniel Henrique Barboza wrote:
>>>> We do not implement hotplug in the vscsi bus, but we forgot to
>>>> tell qdev about it. The result is that users are able to hotplug
>>>> devices in the vscsi bus, the devices appear in qdev, but they
>>>> aren't usable by the guest OS unless the user reboots it first.
>>>>
>>>> Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
>>>> qbus_is_hotpluggable(), that we do not support hotplug operations
>>>> in spapr_vscsi.
>>>>
>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1862059
>>>>
>>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>> ---
>>>>    hw/scsi/spapr_vscsi.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
>>>> index d17dc03c73..57f0a1336f 100644
>>>> --- a/hw/scsi/spapr_vscsi.c
>>>> +++ b/hw/scsi/spapr_vscsi.c
>>>> @@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice
>>>> *dev, Error **errp)
>>>>          scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
>>>>                     &vscsi_scsi_info, NULL);
>>>> +
>>>> +    /* ibmvscsi SCSI bus does not allow hotplug. */
>>>> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
>>>
>>> Can't this be a problem later in DeviceClass::unrealize()?
>>
>> Not as far as I've tested. A call to qbus_set_hotplug_handler(bus,NULL)
>> after setting it to NULL isn't breaking anything either (just tested).
>>
>> I verified before sending the patch that setting hotplug_handler to
>> NULL is done in some unrealize() calls in buses, but not on devices.
>> And I'm not sure which instance would cause an unrealize() in the
>> device to fail if the hotplug_handler of the bus is NULL. As far as
>> I'm concerned this shouldn't be happening in our case here, where we're
>> not dealing with hotplug devices in the bus at all.
>>
>> Which potential problems are you referring to?
> 
> I was wondering if qdev_unrealize() runs similar checks than
> qdev_realize().

I have no idea. I would need to check/study the code to answer that.

> 
>>
>>>
>>> I was expecting something like, overwriting the parent bus type:
>>>
>>> -- >8 --
>>> @@ -1271,6 +1271,7 @@ static void spapr_vscsi_class_init(ObjectClass
>>> *klass, void *data)
>>>        DeviceClass *dc = DEVICE_CLASS(klass);
>>>        SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
>>>
>>> +    k->bus_type = NULL; /* ibmvscsi SCSI bus does not allow hotplug. */
>>>        k->realize = spapr_vscsi_realize;
>>>        k->reset = spapr_vscsi_reset;
>>>        k->devnode = spapr_vscsi_devnode;
>>> ---
>>
>> spapr_vscsi is not a bus, is an interface. Setting NULL to bus_type in
>> spapr_vio
>> breaks guest init:
>>
>>
>> qemu-system-ppc64: /home/danielhb/qemu/hw/core/qdev.c:102:
>> qdev_set_parent_bus: Assertion `dc->bus_type &&
>> object_dynamic_cast(OBJECT(bus), dc->bus_type)' failed.
>> Aborted
>>
>>
>> I'm not so sure this would be better than what I'm doing either.
>> qdev_device_add()
>> calls qbus_is_hotpluggable() to see if the chosen bus allows hotplug. This
>> function verifies if bus->hotplug_handler is NULL. What I'm doing is simply
>> setting hotplug_handler to NULL in the SCSI bus instance that belongs to
>> spapr_vscsi. As far as I understand this is a valid use of the qdev API - I
>> should be able to set hotplug_handler to NULL if I don't want devices being
>> hotplugged in the bus I'm instantiating. Either that, or
>> qbus_is_hotpluggable()
>> must check for something else that I can safely turn off.
> 
> I'm not saying I know the correct way to do that, this is why I added
> Markus in the loop :) I'm wondering from an API point of view what is
> the best way to achieve what you want. I'm glad this works this way.


It's alright to question hehehe far too often we're remembered that 'works this
way' is a looong way from 'this is the right way'. Let's see if Markus agrees
with this approach or if there is a better way of doing it. I'll happily
change for a safer approach that will not hit me in the back in the future.


Thanks,


DHB

> 
>>
>>
>> Thanks,
>>
>>
>> DHB
>>
>>
>>
>>
>>>
>>>>    }
>>>>      void spapr_vscsi_create(SpaprVioBus *bus)
>>>>
>>>
>>
> 

