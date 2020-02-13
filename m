Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAD6C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA7124649
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVlLdbJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA7124649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HS6-0000g7-1v
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2HQM-00084l-2V
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2HQH-0000KW-DJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:33:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2HQH-0000IS-9Q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581611583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUf+W35Hpe2yaThfqfG17WqCdg8zY+WTLViRwiCbuho=;
 b=MVlLdbJ1nx3tee3uYxEZvRJVpM7WYYz+UQ90RJBrncDUApS6KcSegwU4UUuaPj+s6iZT40
 QndM594Nkmy8VkB4nRzrWcrnmVoKTyRfD/rke5gNlfr9a1YOghGeWmLtsO2E8QcyEBuTUs
 T5RK/8I5hlIDvf9wCkSJxj301JXhT/c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-TKF2oUCFNR6ejcUOEqFlcQ-1; Thu, 13 Feb 2020 11:33:01 -0500
Received: by mail-wm1-f70.google.com with SMTP id b133so2569657wmb.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 08:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TYOmTMavEJCi5Gd24SNhNkJgFzmWArSmUWU0WtCxi7Y=;
 b=L/IzBg8nkesH/ASwArfD+WrZAqAfhmpMQeHcr3i08/+NqdbzC3dXeBYaVmXt7/g8Ie
 hwT37rZ/Ue+nvBBX/jZ7lvLDjEy0NipuB1c2UEjbikq0v+2jkn3HQ0H8uSwWurdpoJ4d
 uatvgiK+rXAaTX/6WZhSOqW8yulW2U2Y0HuqR5Dn+S68bTYiBQg81x7+ZWnPf/Xh1I/x
 kfC8g0yW8ovDwwD634pDdgInyhsEeyi3yOcDBDf9U4pJQshZONofubqkdMmU31K8ZLnZ
 YKjwMwUEf3wmTW2Pc3yJUTE0Z/oM/y2wG8/VXpNf6gt6BEr1f63Mql+SP1fnES/CA1SE
 MEUQ==
X-Gm-Message-State: APjAAAUB2J5qqvhTsw5nYp6TKrcsZFZerQ/wV2JVBQu35SXl5ZkyMYnY
 UvfhhvyUb95tG7OI8FCI4tNk2JT9aRveQL3eOlsF1BeJzmglbaXk28smZ1xwo9dGyzHPcS2qiAh
 AaMZBa9HCERT+OEc=
X-Received: by 2002:a5d:6709:: with SMTP id o9mr22093547wru.82.1581611579568; 
 Thu, 13 Feb 2020 08:32:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqytEhkQIPaJHHTEa/ayIvLwwhb3AQXuFya2jm6mN+kDY7fbzFf6/sK12/ZkSC8LS2YcaIjSMg==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr22093514wru.82.1581611579232; 
 Thu, 13 Feb 2020 08:32:59 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s1sm3469592wro.66.2020.02.13.08.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 08:32:58 -0800 (PST)
Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
 <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
 <99531e05-f8fc-ef0a-ca62-6d477c899e78@redhat.com>
 <20200212161957.GA5028@habkost.net> <87r1yy4l4g.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <24243b1d-f3a1-1778-8b50-4d4776393cdf@redhat.com>
Date: Thu, 13 Feb 2020 17:32:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1yy4l4g.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: TKF2oUCFNR6ejcUOEqFlcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "i.mitsyanko@gmail.com" <i.mitsyanko@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 3:28 PM, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
>> On Wed, Feb 12, 2020 at 08:39:55AM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> Cc'ing Eduardo & Markus.
>>>
>>> On 2/12/20 7:44 AM, Chenqun (kuhn) wrote:
>>>>> -----Original Message-----
>>>>> From: Philippe Mathieu-Daud=C3=A9 [mailto:philmd@redhat.com]
>>>>> Sent: Wednesday, February 12, 2020 2:16 PM
>>>>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-
>>>>> devel@nongnu.org; i.mitsyanko@gmail.com; peter.maydell@linaro.org
>>>>> Cc: qemu-trivial@nongnu.org; Zhanghailiang
>>>>> <zhang.zhanghailiang@huawei.com>
>>>>> Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
>>>>> exynos4210_uart_init
>>>>>
>>>>> On 2/12/20 4:36 AM, kuhn.chenqun@huawei.com wrote:
>>>>>> From: Chen Qun <kuhn.chenqun@huawei.com>
>>>>>>
>>>>>> It's easy to reproduce as follow:
>>>>>> virsh qemu-monitor-command vm1 --pretty '{"execute":
>>>>>> "device-list-properties", "arguments":{"typename":"exynos4210.uart"}=
}'
>>>>>>
>>>>>> ASAN shows memory leak stack:
>>>>>>      #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb=
)
>>>>>>      #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h:=
530
>>>>>>      #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
>>>>>>      #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:56=
9
>>>>>>      #5 0xaaad270beee3 in exynos4210_uart_init
>>>>> /qemu/hw/char/exynos4210_uart.c:677
>>>>>>      #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/obje=
ct.c:516
>>>>>>      #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:68=
4
>>>>>>      #8 0xaaad2755df2f in qmp_device_list_properties
>>>>>> /qemu/qom/qom-qmp-cmds.c:152
>>>>>>
>>>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>>>>> ---
>>>>>>     hw/char/exynos4210_uart.c | 8 ++++----
>>>>>>     1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
>>>>>> index 25d6588e41..5048db5410 100644
>>>>>> --- a/hw/char/exynos4210_uart.c
>>>>>> +++ b/hw/char/exynos4210_uart.c
>>>>>> @@ -674,10 +674,6 @@ static void exynos4210_uart_init(Object *obj)
>>>>>>         SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
>>>>>>         Exynos4210UartState *s =3D EXYNOS4210_UART(dev);
>>>>>>
>>>>>> -    s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>>>>> -                                         exynos4210_uart_timeout_in=
t, s);
>>>>>> -    s->wordtime =3D NANOSECONDS_PER_SECOND * 10 / 9600;
>>>>>
>>>>> Why are you moving s->wordtime from init() to realize()?
>>>>>
>>>> Hi  Philippe,  thanks for your reply!
>>>>
>>>> Because I found the variable wordtime is usually used with fifo_timeou=
t_timer.
>>>> Eg, they are used together in the exynos4210_uart_rx_timeout_set funct=
ion.
>>>>
>>>> I didn't find anything wrong with wordtime in the realize().
>>>> Does it have any other effects?
>>>
>>> IIUC when we use both init() and realize(), realize() should only conta=
ins
>>> on code that consumes the object properties... But maybe the design is =
not
>>> clear. Then why not move all the init() code to realize()?
>>
>> Normally I would recommend the opposite: delay as much as
>> possible to realize(), to avoid unwanted side effects when (e.g.)
>> running qom-list-properties.
>=20
> Sadly, our documentation on device initialization and realization is
> rather sparse, and developers are left guessing.  Their guesses are
> often based on what existing code does.  Some of the existing code even
> gets things right.
>=20
> A few rules from the top of my head:

Worth a new thread...

>=20
> * Creating and immediately destroying an object must be safe and free of
>    side effects: initialization may only touch the object itself, and
>    finalization must clean up everything initialization creates.
>=20
> * unrealize() must clean up everything realize() creates.

Hmm I guess remember someone once said "only for hot-pluggable objects,=20
else don't bother". But then we make a non-hot-pluggable object as=20
hot-pluggable and have to fix leaks. Or we start a new hot-pluggable=20
device based on some code without unrealize()...

>=20
> * Since initialization cannot fail, code that needs to fail gracefully
>    must live in realize().
>=20
> * Since property values get set between initialization and realization,
>    code that uses property values must live in realize().
>=20
> * Dynamic properties have to be created in initialization to be visible
>    in introspection.
>=20
>> But as s->wordtime is a simple struct field (that we could even
>> decide to expose to the outside as a read-only QOM property), it
>> doesn't really matter.  Personally, I would keep it where it is
>> just to avoid churn.
>=20
>=20


