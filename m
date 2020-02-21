Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE52C11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D9F2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D9F2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zLK-0007AW-Nt
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j4z8v-00047o-Fx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j4z8t-00027A-QN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:38:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42704 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j4z8p-0001io-Gt; Thu, 20 Feb 2020 22:38:15 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 81C338DD290A4C042835;
 Fri, 21 Feb 2020 11:38:03 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Feb
 2020 11:37:57 +0800
Subject: Re: [PATCH v2 2/2] hw: move timer_new from init() into realize() to
 avoid memleaks
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200217032127.46508-1-pannengyuan@huawei.com>
 <20200217032127.46508-3-pannengyuan@huawei.com>
 <CAFEAcA_AxCVaAgho3g2q=kCifSdhz9Qi72eoVAM9gRjb3-_Sog@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <7e95f201-8f0b-20db-1452-9d0dde1c6f69@huawei.com>
Date: Fri, 21 Feb 2020 11:37:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_AxCVaAgho3g2q=kCifSdhz9Qi72eoVAM9gRjb3-_Sog@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, QEMU
 Developers <qemu-devel@nongnu.org>, mav2-rk.cave-ayland@ilande.co.uk,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/21/2020 1:56 AM, Peter Maydell wrote:
> On Mon, 17 Feb 2020 at 03:22, <pannengyuan@huawei.com> wrote:
>>
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> There are some memleaks when we call 'device_list_properties'. This pa=
tch move timer_new from init into realize to fix it.
>> Meanwhile, do the null check in mos6522_reset() to avoid null deref if=
 we move timer_new into realize().
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>=20
>> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
>> index 19e154b870..980eda7599 100644
>> --- a/hw/misc/mos6522.c
>> +++ b/hw/misc/mos6522.c
>> @@ -465,11 +465,15 @@ static void mos6522_reset(DeviceState *dev)
>>      s->timers[0].frequency =3D s->frequency;
>>      s->timers[0].latch =3D 0xffff;
>>      set_counter(s, &s->timers[0], 0xffff);
>> -    timer_del(s->timers[0].timer);
>> +    if (s->timers[0].timer) {
>> +        timer_del(s->timers[0].timer);
>> +    }
>>
>>      s->timers[1].frequency =3D s->frequency;
>>      s->timers[1].latch =3D 0xffff;
>> -    timer_del(s->timers[1].timer);
>> +    if (s->timers[1].timer) {
>> +        timer_del(s->timers[1].timer);
>> +    }
>>  }
>=20
> What code path calls a device 'reset' method on a device
> that has not yet been realized ? I wasn't expecting that
> to be valid...

I got the follow null-deref case on m68k If I move timer_new into realize=
():

    #0 0x55cbb0d3e9f9 in timer_del /mnt/sdb/qemu-new/qemu/util/qemu-timer=
.c:429
    #1 0x55cbb04f3abe in mos6522_reset /mnt/sdb/qemu-new/qemu/hw/misc/mos=
6522.c:468
    #2 0x55cbb02b5fd5 in mos6522_q800_via2_reset /mnt/sdb/qemu-new/qemu/h=
w/misc/mac_via.c:1098
    #3 0x55cbb047b926 in device_transitional_reset /mnt/sdb/qemu-new/qemu=
/hw/core/qdev.c:1136
    #4 0x55cbb0491a71 in resettable_phase_hold /mnt/sdb/qemu-new/qemu/hw/=
core/resettable.c:182
    #5 0x55cbb048700e in bus_reset_child_foreach /mnt/sdb/qemu-new/qemu/h=
w/core/bus.c:94
    #6 0x55cbb0490f66 in resettable_child_foreach /mnt/sdb/qemu-new/qemu/=
hw/core/resettable.c:96
    #7 0x55cbb0491896 in resettable_phase_hold /mnt/sdb/qemu-new/qemu/hw/=
core/resettable.c:173
    #8 0x55cbb0490c06 in resettable_assert_reset /mnt/sdb/qemu-new/qemu/h=
w/core/resettable.c:60
    #9 0x55cbb0490aec in resettable_reset /mnt/sdb/qemu-new/qemu/hw/core/=
resettable.c:45
    #10 0x55cbb0492668 in resettable_cold_reset_fn /mnt/sdb/qemu-new/qemu=
/hw/core/resettable.c:269
    #11 0x55cbb0494a04 in qemu_devices_reset /mnt/sdb/qemu-new/qemu/hw/co=
re/reset.c:69
    #12 0x55cbb03ab91d in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c:1=
412
    #13 0x55cbb03bfe04 in main /mnt/sdb/qemu-new/qemu/vl.c:4403

mos6522_init was called in mac_via_realize as follow, but mos6522_realize=
 was not called at all.
So maybe we shouldn't move it into realize or add realize step in this co=
de path?

    #0  0x0000555555789e40 in mos6522_init (obj=3D0x555557537b00) at /mnt=
/sdb/qemu-new/qemu/hw/misc/mos6522.c:476
    #1  0x000055555581b6c3 in object_init_with_type (obj=3D0x555557537b00=
, ti=3D0x55555617c2b0) at /mnt/sdb/qemu-new/qemu/qom/object.c:372
    #2  0x000055555581cc80 in object_initialize_with_type (data=3Ddata@en=
try=3D0x555557537b00, size=3D1504, type=3D0x55555617c2b0) at /mnt/sdb/qem=
u-new/qemu/qom/object.c:516
    #3  0x000055555581cd1f in object_initialize (data=3Ddata@entry=3D0x55=
5557537b00, size=3D<optimized out>, typename=3D<optimized out>) at /mnt/s=
db/qemu-new/qemu/qom/object.c:529
    #4  0x000055555581e387 in object_initialize_childv
    (parentobj=3D0x555557537510, propname=3D0x555555a3c673 "via1", childo=
bj=3D0x555557537b00, size=3D<optimized out>, type=3D<optimized out>, errp=
=3D0x55555613b338 <error_abort>, vargs=3D0x7fffffffdb30)
    at /mnt/sdb/qemu-new/qemu/qom/object.c:552
    #5  0x000055555581e4d3 in object_initialize_child
    (parentobj=3D<optimized out>, propname=3D<optimized out>, childobj=3D=
childobj@entry=3D0x555557537b00, size=3D<optimized out>, type=3D<optimize=
d out>, errp=3D<optimized out>) at /mnt/sdb/qemu-new/qemu/qom/object.c:53=
9
    #6  0x000055555577ba88 in sysbus_init_child_obj (parent=3D<optimized =
out>, childname=3D<optimized out>, child=3D0x555557537b00, childsize=3D<o=
ptimized out>, childtype=3D<optimized out>)
    at /mnt/sdb/qemu-new/qemu/hw/core/sysbus.c:352
    #7  0x000055555570d301 in mac_via_realize (dev=3D0x555557537510, errp=
=3D0x7fffffffdce0) at /mnt/sdb/qemu-new/qemu/hw/misc/mac_via.c:876
    #8  0x0000555555774444 in device_set_realized (obj=3D0x555557537510, =
value=3D<optimized out>, errp=3D0x7fffffffddd0) at /mnt/sdb/qemu-new/qemu=
/hw/core/qdev.c:891
    #9  0x000055555581b266 in property_set_bool (obj=3D0x555557537510, v=3D=
<optimized out>, name=3D<optimized out>, opaque=3D0x555556165f50, errp=3D=
0x7fffffffddd0) at /mnt/sdb/qemu-new/qemu/qom/object.c:2238
    #10 0x000055555581feee in object_property_set_qobject (obj=3D0x555557=
537510, value=3D<optimized out>, name=3D0x555555a5fa67 "realized", errp=3D=
0x7fffffffddd0) at /mnt/sdb/qemu-new/qemu/qom/qom-qobject.c:26
    #11 0x000055555581d60f in object_property_set_bool (obj=3D0x555557537=
510, value=3D<optimized out>, name=3D0x555555a5fa67 "realized", errp=3D0x=
7fffffffddd0) at /mnt/sdb/qemu-new/qemu/qom/object.c:1390
    #12 0x0000555555773381 in qdev_init_nofail (dev=3Ddev@entry=3D0x55555=
7537510) at /mnt/sdb/qemu-new/qemu/hw/core/qdev.c:418
    #13 0x0000555555711fcd in q800_init (machine=3D<optimized out>) at /m=
nt/sdb/qemu-new/qemu/hw/m68k/q800.c:230
    #14 0x0000555555686dfb in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at /mnt/sdb/qemu-new/qemu/vl.c:4308

And I have another quesion, how to distinguish whether the realize() will=
 be called or not.

Thanks.

>=20
> thanks
> -- PMM
> .
>=20

