Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC2C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1F020674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1F020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFrR-0007qa-NL
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jBFqZ-00076W-3U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jBFqX-0005fF-Tx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:41:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3266 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jBFqX-0005dp-J6; Mon, 09 Mar 2020 06:41:17 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BD5C185AF02A3B0B19EC;
 Mon,  9 Mar 2020 18:41:12 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Mar 2020
 18:41:03 +0800
Subject: Re: [PATCH] core/qdev: fix memleak in qdev_get_gpio_out_connector()
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@gmail.com>
References: <20200307030756.5913-1-pannengyuan@huawei.com>
 <CAJ+F1C+6QSYBhO_M+Vqps4XvOujnV+Wbq6o9Q+qUmC5Z0dmxSQ@mail.gmail.com>
 <87b027ab-7bed-249a-08a2-2c27fdd05a31@vivier.eu>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <a69e324c-21c4-dcfd-516d-0515f86a2f28@huawei.com>
Date: Mon, 9 Mar 2020 18:41:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87b027ab-7bed-249a-08a2-2c27fdd05a31@vivier.eu>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu trival <qemu-trivial@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/9/2020 5:16 PM, Laurent Vivier wrote:
> Le 07/03/2020 =C3=A0 11:39, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
>> Hi
>>
>> On Sat, Mar 7, 2020 at 3:53 AM Pan Nengyuan <pannengyuan@huawei.com> w=
rote:
>>>
>>> Fix a memory leak in qdev_get_gpio_out_connector().
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> good catch,
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> trivial question:
>=20
> Why do we prefer g_autofree() to the g_free() function?

Honestly, it's no special reason in this case, just personal preference. =
:)
Both of them is ok.

Thanks.

>=20
> Thanks,
> Laurent
>=20
>>> ---
>>>  hw/core/qdev.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 3937d1eb1a..85f062def7 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -557,7 +557,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev=
, const char *name, int n,
>>>
>>>  qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *n=
ame, int n)
>>>  {
>>> -    char *propname =3D g_strdup_printf("%s[%d]",
>>> +    g_autofree char *propname =3D g_strdup_printf("%s[%d]",
>>>                                       name ? name : "unnamed-gpio-out=
", n);
>>>
>>>      qemu_irq ret =3D (qemu_irq)object_property_get_link(OBJECT(dev),=
 propname,
>>> --
>>> 2.18.2
>>>
>>>
>>
>>
>=20

