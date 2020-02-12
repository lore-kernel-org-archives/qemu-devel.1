Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A0C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2872B20658
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmqeqPQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2872B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1mdX-0003ZN-AT
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1mct-0002ue-H6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1mcs-0008E2-0s
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:40:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1mcr-0008De-Tu
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581493201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpHRjErBuwbVX+QKoiwh0sNK8Q8P9VnadKdFm/cEIn0=;
 b=PmqeqPQLHX8v+CJwn+O+T5EeTBsvmOPbk3dcjCfySTMgPEU/xkTyx/k/krTosOhGFcDQYF
 l7xdUJvkDZzJp33Q8gXOls32AoOgkIJC0yLVma/adlNJsGQAlP9c2KbJgLHU08SzDzL2QH
 iHdRPbbrprXeoZvNMFTHS++YweP8GEo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-uz_Mp-BVOUO8ovKoS6ct1A-1; Wed, 12 Feb 2020 02:39:59 -0500
Received: by mail-wm1-f72.google.com with SMTP id p2so598375wma.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 23:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e8YmZpINAk7OHaSEhxhUmg8LU/LtLrviIG7JmjcRgNs=;
 b=oHyC04TUs0SPWR+QgnQmR34O2XT0gUq4YAp9ah4x9sf2YLBl/Ktj7u/1kEmxhc2ETU
 z6EWARfCA/zE6lsG3XS5ZrNppsRHhkGAIy3JJj22A7JgnN63bL4Eo03Jf8QBGIcwVlyP
 IJgAZjg2Rt+LFWO/4JyM+5EcQKF9iIobJ+fKa6IUPj7DIcL3w4aDBlIwUbiOJgpMBowy
 WrmEmzr/yD0Z4tL1cZXjQTzQiU6mfD7HqXzIVIPSR8LTqCmDFbOcjCSykWVTZT7hcR0N
 ry+PS0D1vs8IN/dwmYpORGcArXL6Fjf2KByDynBGCA9N+krF/Wzn411vr6PSlBOXO7W6
 E+Ww==
X-Gm-Message-State: APjAAAUUq1R32DU7wgNy5diircx9SNgJvrFBxZmySj8y9vHk6TCnaHUh
 o3axiwWjvYqBXDuwuEr8ilZgH3TSbAacsSiHc4twk/syGkrVAH2XLr++S+iChVLs/iAGoZn9OZU
 b6sRv/8ASSIIb8z8=
X-Received: by 2002:a05:600c:294a:: with SMTP id
 n10mr11251390wmd.11.1581493197957; 
 Tue, 11 Feb 2020 23:39:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXNtocGaBI0oWYnXq+BQuIYJnIhKKG50qjNgb9zTM7A79TeQuE8hvmHq0cPVglOfLm2AuoPw==
X-Received: by 2002:a05:600c:294a:: with SMTP id
 n10mr11251351wmd.11.1581493197692; 
 Tue, 11 Feb 2020 23:39:57 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b17sm9022832wrp.49.2020.02.11.23.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 23:39:56 -0800 (PST)
Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "i.mitsyanko@gmail.com" <i.mitsyanko@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
 <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99531e05-f8fc-ef0a-ca62-6d477c899e78@redhat.com>
Date: Wed, 12 Feb 2020 08:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
Content-Language: en-US
X-MC-Unique: uz_Mp-BVOUO8ovKoS6ct1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Eduardo & Markus.

On 2/12/20 7:44 AM, Chenqun (kuhn) wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daud=C3=A9 [mailto:philmd@redhat.com]
>> Sent: Wednesday, February 12, 2020 2:16 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-
>> devel@nongnu.org; i.mitsyanko@gmail.com; peter.maydell@linaro.org
>> Cc: qemu-trivial@nongnu.org; Zhanghailiang
>> <zhang.zhanghailiang@huawei.com>
>> Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
>> exynos4210_uart_init
>>
>> On 2/12/20 4:36 AM, kuhn.chenqun@huawei.com wrote:
>>> From: Chen Qun <kuhn.chenqun@huawei.com>
>>>
>>> It's easy to reproduce as follow:
>>> virsh qemu-monitor-command vm1 --pretty '{"execute":
>>> "device-list-properties", "arguments":{"typename":"exynos4210.uart"}}'
>>>
>>> ASAN shows memory leak stack:
>>>     #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
>>>     #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h:530
>>>     #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
>>>     #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:569
>>>     #5 0xaaad270beee3 in exynos4210_uart_init
>> /qemu/hw/char/exynos4210_uart.c:677
>>>     #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/object.c=
:516
>>>     #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:684
>>>     #8 0xaaad2755df2f in qmp_device_list_properties
>>> /qemu/qom/qom-qmp-cmds.c:152
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>> ---
>>>    hw/char/exynos4210_uart.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
>>> index 25d6588e41..5048db5410 100644
>>> --- a/hw/char/exynos4210_uart.c
>>> +++ b/hw/char/exynos4210_uart.c
>>> @@ -674,10 +674,6 @@ static void exynos4210_uart_init(Object *obj)
>>>        SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
>>>        Exynos4210UartState *s =3D EXYNOS4210_UART(dev);
>>>
>>> -    s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>> -                                         exynos4210_uart_timeout_int, =
s);
>>> -    s->wordtime =3D NANOSECONDS_PER_SECOND * 10 / 9600;
>>
>> Why are you moving s->wordtime from init() to realize()?
>>
> Hi  Philippe,  thanks for your reply!
>=20
> Because I found the variable wordtime is usually used with fifo_timeout_t=
imer.
> Eg, they are used together in the exynos4210_uart_rx_timeout_set function=
.
>=20
> I didn't find anything wrong with wordtime in the realize().
> Does it have any other effects?

IIUC when we use both init() and realize(), realize() should only=20
contains on code that consumes the object properties... But maybe the=20
design is not clear. Then why not move all the init() code to realize()?

>>> -
>>>        /* memory mapping */
>>>        memory_region_init_io(&s->iomem, obj, &exynos4210_uart_ops, s,
>>>                              "exynos4210.uart",
>>> EXYNOS4210_UART_REGS_MEM_SIZE); @@ -691,6 +687,10 @@ static void
>> exynos4210_uart_realize(DeviceState *dev, Error **errp)
>>>    {
>>>        Exynos4210UartState *s =3D EXYNOS4210_UART(dev);
>>>
>>> +    s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>> +                                         exynos4210_uart_timeout_int, =
s);
>>> +    s->wordtime =3D NANOSECONDS_PER_SECOND * 10 / 9600;
>>> +
>>>        qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
>>>                                 exynos4210_uart_receive, exynos4210_uar=
t_event,
>>>                                 NULL, s, NULL, true);
>>>
>=20


