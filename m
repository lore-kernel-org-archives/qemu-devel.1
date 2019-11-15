Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24149C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8A32072B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rL3WkwuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8A32072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVZHa-0000Ry-2J
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 05:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVZGS-0007ZW-AZ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVZGQ-0005Vu-Nc
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:55:44 -0500
Received: from mail-eopbgr140125.outbound.protection.outlook.com
 ([40.107.14.125]:39047 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVZGN-0005Ug-3i; Fri, 15 Nov 2019 05:55:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO1FciSt8wZLQTe6PsH30I3E8D1OT6F162450M3HdNtgVXODO8DIUbs66vr5GabMUz1XqinFW8w3ckoWuP9IPuCtU1oM1z3VhlkN3qccSLAiAgFZnvgZv85CVAroLlOK6vZeCB/PjXFlFmbMA8u6fcQWfVJh2zyfPafLa1PX+3IXiHSioNkFcFqlPC/UlGMy1Mrm5tYMmNK99gl2Bb7RH5ZbyHYFoyzfqHXTLOs4eXAdrGhmB+aAy81BdQJl7R6Q+x+Rq7zGu2aZGRE1v0lnQhD/c/DxeAvqVKv+AmwgI7Bgxf2lRicPrfKevvglgXPMOmIAMYFetIzhtCZyToLEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QzDkwsxu+opiEtRbPYHqBUwK/syXB29fxVlKAPv36M=;
 b=NQ19necAK8DgriEhZhhXJCwJjU5vepCJ7UCu64uRlKH097N9drgXSNRVNhG1bCQEDTPUkjgZOgK683wxfQ4pWG7EfCUaUk0L1xsu0nV8qLU+9YMjIcOS2zhFEcK0p3sekb311KxsIeNxDjx5GfSwx9VxOOD4Dlj9C1F/VpcnOYqAyZOqqLdCfxPeoGiIf6Yt7xT5EqDmxjObzshV1cUbiSTCwDaRsOlB7hUDVPPZo97CoUFPQyLYwlP4mR7Emaol3ztSzKojELfhbFQSukQAsCCYiIu9sC3PWg5jWczB3lIcQeChBQjSCI12zkMsvsV4RqzYFO7FFlPv3A+RHwayXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QzDkwsxu+opiEtRbPYHqBUwK/syXB29fxVlKAPv36M=;
 b=rL3WkwuBPNyAlicNYMS68AXDRTd1aMV9z+Mv2cGRAiwcqT+3ZI2hjM2V8ne1BD6vQdvj9uoexawScOciRtDWIDji9WpLdFqPD/iUcIyD2osdVqfXXLrWoDUfYlzsa9apmstvODdym3hfX+ksLrAq8EnARJzVKOfz/z3YmgntE2I=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3494.eurprd08.prod.outlook.com (20.177.112.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Fri, 15 Nov 2019 10:55:36 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 10:55:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Index: AQHVmlI7eO4+ta1idUecy2WkuY5gm6eKiHMAgAAI8QCAAWlEgIAAFikAgAAA8wA=
Date: Fri, 15 Nov 2019 10:55:36 +0000
Message-ID: <16fdb163-c6d2-367e-ba60-da2774f9f722@virtuozzo.com>
References: <1573670589-229357-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573670589-229357-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a5dd3514-a804-6c63-2158-0dff9ac37ab3@redhat.com>
 <96bda153-8923-41fb-5374-10711098901d@virtuozzo.com>
 <dcc46a1b-cd8a-78e3-6353-bf9fb2210d9b@redhat.com>
 <36394cc3-9d68-5f56-7d44-ca56ff3cf7e3@virtuozzo.com>
In-Reply-To: <36394cc3-9d68-5f56-7d44-ca56ff3cf7e3@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0187.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191115135534297
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4b64af7-bd03-423a-8851-08d769ba584c
x-ms-traffictypediagnostic: AM6PR08MB3494:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3494C6A2E2AAC8CA3DB564B3C1700@AM6PR08MB3494.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(346002)(39850400004)(136003)(199004)(189003)(7736002)(110136005)(486006)(31696002)(14454004)(54906003)(316002)(36756003)(66066001)(5660300002)(81166006)(66946007)(81156014)(966005)(6512007)(107886003)(6306002)(8676002)(6246003)(8936002)(4326008)(2501003)(99286004)(6486002)(6436002)(229853002)(71200400001)(2906002)(66446008)(64756008)(66556008)(305945005)(6506007)(386003)(76176011)(71190400001)(66476007)(53546011)(446003)(31686004)(2201001)(478600001)(86362001)(186003)(52116002)(26005)(476003)(3846002)(6116002)(256004)(5024004)(25786009)(102836004)(11346002)(2616005)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3494;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3E4S+sGbRyVTtNZitrGvxB6tNBYbzWrwlQZWYG1m4p1AbV5AqOq8tzUC3bloViAsIr2o7PcxNlSuZJzQfJOaJyUEbUvHDFc5wfEOcIfrOc21pZPtx+DNax7vr/Xtz8vO1/8UyayTLWrKvaaJt4O8WqiPuDmMrfX26hHLn5JxCNM3tjjJjrmsVu1Xh5BSIxxk5KDBeiMT6CefqJe+ZY3VJWsOpUh/wrci1b9XundSuv7HrEr8PZ6IAJ9sgyceKNlYt7KQEC5NiLwh6d90xLdYZBrP57VyKUpHaXmmiLt7dC8L7pQ7bnMBDsC8BfypZh8QDWVa+MZjsv2GbzFBqf8UB7VnBripwRyjfMOnrBPtd1os8ebS4RkvfIcfus+gW9TP7Fc1pCU13IK1pWwQuDLUL+y8RjHLE+bOZvkeqLLVv+fFw97Up+LG7G65ANJSNOuzCELh2ypULl8NxsJTWji1wyZvxHP8A8DOt6SbIzwyN0=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4C9B7A2A84C10541B58FD44F4B3DE830@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b64af7-bd03-423a-8851-08d769ba584c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:55:36.3847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPifEbcoPGuCuRPQnmEYO0tODZ0+IZ8zu6hMHYET4hOtXx1UaGtM7PBbAUMh6qaIeS6Mu5D6+pp1oU5HPJ6aCGPk5FAHUyO+aFmsjBS9sPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3494
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.125
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.11.2019 13:52, Vladimir Sementsov-Ogievskiy wrote:
> 15.11.2019 12:32, Max Reitz wrote:
>> On 14.11.19 12:59, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.11.2019 14:27, Max Reitz wrote:
>>>> On 13.11.19 19:43, Andrey Shinkevich wrote:
>>>>> Allow writing all the data compressed through the filter driver.
>>>>> The written data will be aligned by the cluster size.
>>>>> Based on the QEMU current implementation, that data can be written to
>>>>> unallocated clusters only. May be used for a backup job.
>>>>>
>>>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>> =A0=A0 block/Makefile.objs=A0=A0=A0=A0 |=A0=A0 1 +
>>>>> =A0=A0 block/filter-compress.c | 201 ++++++++++++++++++++++++++++++++=
++++++++++++++++
>>>>> =A0=A0 qapi/block-core.json=A0=A0=A0 |=A0 10 ++-
>>>>> =A0=A0 3 files changed, 208 insertions(+), 4 deletions(-)
>>>>> =A0=A0 create mode 100644 block/filter-compress.c
>>>>>
>>>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>>>> index e394fe0..330529b 100644
>>>>> --- a/block/Makefile.objs
>>>>> +++ b/block/Makefile.objs
>>>>> @@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
>>>>> =A0=A0 block-obj-y +=3D aio_task.o
>>>>> =A0=A0 block-obj-y +=3D backup-top.o
>>>>> +block-obj-y +=3D filter-compress.o
>>>>> =A0=A0 common-obj-y +=3D stream.o
>>>>> diff --git a/block/filter-compress.c b/block/filter-compress.c
>>>>> new file mode 100644
>>>>> index 0000000..64b1ee5
>>>>> --- /dev/null
>>>>> +++ b/block/filter-compress.c
>>>>> @@ -0,0 +1,201 @@
>>>>> +/*
>>>>> + * Compress filter block driver
>>>>> + *
>>>>> + * Copyright (c) 2019 Virtuozzo International GmbH
>>>>> + *
>>>>> + * Author:
>>>>> + *=A0=A0 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> + *=A0=A0 (based on block/copy-on-read.c by Max Reitz)
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or
>>>>> + * modify it under the terms of the GNU General Public License as
>>>>> + * published by the Free Software Foundation; either version 2 or
>>>>> + * (at your option) any later version of the License.
>>>>> + *
>>>>> + * This program is distributed in the hope that it will be useful,
>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the
>>>>> + * GNU General Public License for more details.
>>>>> + *
>>>>> + * You should have received a copy of the GNU General Public License
>>>>> + * along with this program; if not, see <http://www.gnu.org/licenses=
/>.
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +#include "block/block_int.h"
>>>>> +#include "qemu/module.h"
>>>>> +
>>>>> +
>>>>> +static int compress_open(BlockDriverState *bs, QDict *options, int f=
lags,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Error **errp)
>>>>> +{
>>>>> +=A0=A0=A0 bs->backing =3D bdrv_open_child(NULL, options, "file", bs,=
 &child_file, false,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 errp);
>>>>
>>>> Please don=92t attach something that the QAPI schema calls =93file=94 =
as
>>>> bs->backing.
>>>
>>>
>>> Agree, it's a mistake. If we want backing and user set backing in optio=
ns, it's opened automatically, I think..
>>>
>>>>
>>>> Yes, attaching it as bs->file would break backing chains.=A0 That=92s =
a bug
>>>> in the block layer.=A0 I=92ve been working on a fix for a long time.
>>>>
>>>> Please don=92t introduce more weirdness just because we have a bug in =
the
>>>> block layer.
>>>>
>>>> (Note that I=92d strongly oppose calling the child =93backing=94 in th=
e QAPI
>>>> schema, as this would go against what all other user-creatable filters=
 do.)
>>>>
>>>
>>> So, are you opposite to correct backing-based user-creatable filter (wi=
th backing both
>>> in QAPI and code)?
>>
>> I=92m not opposed to fixing it, but I don=92t think the fix is to make a=
ll
>> filters use bs->backing.
>>
>>> Do you think, that if we make backup-top to be user-creatable, we shoul=
d move it to be
>>> file-child-based, or support both backing and file child?
>>
>> I definitely don=92t think it would be wrong.
>>
>> It depends on how difficult it is.=A0 I=92m currently working on (more
>> groundwork for the filter series v7) a series to rework BdrvChildRole so
>> we can see from it what a child is used for (data, metadata, filter,
>> COW).=A0 I can already see that it won=91t work out perfectly because
>> whenever we attach "backing", the question is whether that=92s a COW chi=
ld
>> now or whether it=92s a filtered child.=A0 I suppose I=92m going to gues=
s COW
>> when there=92s no way to get the information, and maybe sometimes be wro=
ng.
>>
>> In my honest opinion, reusing bs->backing for filters was wrong.=A0 I=92=
m
>> not saying that bs->file was any better.=A0 But I have a bit of a gripe
>> with filters using bs->backing, because it=92s acknowledging a bug but n=
ot
>> fixing it at the same time.=A0 Had we fixed the bug when we first notice=
d
>> it with the introduction of the mirror filter, maybe we wouldn=92t be in
>> this position now.=A0 Or maybe we should have just added a bs->filtered =
link.
>>
>> But maybes aside, it still means that using bs->backing instead of
>> bs->file is not really better.=A0 Right now it=92s both wrong, and we ne=
ed
>> to fix the block layer so it isn=92t.
>>
>> So what to do for new filters?=A0 Sure, bs->backing works around a bug
>> now.=A0 But it=92ll be weird once the bug is fixed.=A0 Then we=92ll have=
 filters
>> that use @file and others will use @backing.=A0 I don=92t think we want
>> that, I think we want a uniform interface for all filters.
>>
>> And yes, that implies we probably should change backup-top to use file
>> instead of backing once it gets an external interface.
>>
>> (Compare
>> https://lists.nongnu.org/archive/html/qemu-block/2017-09/msg00380.html
>> )
>>
>> Max
>>
>=20
> OK, got your point. Let's use file child in compress filter. Hope for you=
r series!
>=20

Interesting, how much of your series needed to make it possible to use comp=
ress filter
in stream? To make it work in 5.0?

--=20
Best regards,
Vladimir

