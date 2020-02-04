Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1ACC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 00:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD99E2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 00:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD99E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iymQ6-0007Jy-Vg
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 19:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iymPQ-0006kx-2l
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iymPO-00009w-Uj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 19:49:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59576 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iymPM-00084Y-6g; Mon, 03 Feb 2020 19:49:40 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BB60B54E231082D8A21F;
 Tue,  4 Feb 2020 08:49:33 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Feb 2020
 08:49:23 +0800
Subject: Re: [PATCH] pl031: add finalize function to avoid memleaks
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203074718.37252-1-pannengyuan@huawei.com>
 <CAFEAcA_2XthfkcyNgQqoxo+Zt66pf7Te56nB8ZAQL948D=kqVw@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <242974c9-9804-9080-0c5e-2bb4ab39fed7@huawei.com>
Date: Tue, 4 Feb 2020 08:49:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2XthfkcyNgQqoxo+Zt66pf7Te56nB8ZAQL948D=kqVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
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
Cc: xuding42@huawei.com, Euler Robot <euler.robot@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/3/2020 5:58 PM, Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 07:47, <pannengyuan@huawei.com> wrote:
>>
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> There is a memory leak when we call 'device_list_properties' with
>> typename = pl031. It's easy to reproduce as follow:
>>
>>   virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties", "arguments": {"typename": "pl031"}}'
>>
>> The memory leak stack:
>>   Direct leak of 48 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f6e0925a970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
>>     #1 0x7f6e06f4d49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>>     #2 0x564a0f7654ea in timer_new_full /mnt/sdb/qemu/include/qemu/timer.h:530
>>     #3 0x564a0f76555d in timer_new /mnt/sdb/qemu/include/qemu/timer.h:551
>>     #4 0x564a0f765589 in timer_new_ns /mnt/sdb/qemu/include/qemu/timer.h:569
>>     #5 0x564a0f76747d in pl031_init /mnt/sdb/qemu/hw/rtc/pl031.c:198
>>     #6 0x564a0fd4a19d in object_init_with_type /mnt/sdb/qemu/qom/object.c:360
>>     #7 0x564a0fd4b166 in object_initialize_with_type /mnt/sdb/qemu/qom/object.c:467
>>     #8 0x564a0fd4c8e6 in object_new_with_type /mnt/sdb/qemu/qom/object.c:636
>>     #9 0x564a0fd4c98e in object_new /mnt/sdb/qemu/qom/object.c:646
>>     #10 0x564a0fc69d43 in qmp_device_list_properties /mnt/sdb/qemu/qom/qom-qmp-cmds.c:204
>>     #11 0x564a0ef18e64 in qdev_device_help /mnt/sdb/qemu/qdev-monitor.c:278
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>  hw/rtc/pl031.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
>> index ae47f09635..50664ca000 100644
>> --- a/hw/rtc/pl031.c
>> +++ b/hw/rtc/pl031.c
>> @@ -194,6 +194,15 @@ static void pl031_init(Object *obj)
>>      s->timer = timer_new_ns(rtc_clock, pl031_interrupt, s);
>>  }
>>
>> +static void pl031_finalize(Object *obj)
>> +{
>> +    PL031State *s = PL031(obj);
>> +    if (s->timer) {
>> +        timer_del(s->timer);
>> +        timer_free(s->timer);
>> +    }
>> +}
>> +
>>  static int pl031_pre_save(void *opaque)
>>  {
>>      PL031State *s = opaque;
>> @@ -329,6 +338,7 @@ static const TypeInfo pl031_info = {
>>      .parent        = TYPE_SYS_BUS_DEVICE,
>>      .instance_size = sizeof(PL031State),
>>      .instance_init = pl031_init,
>> +    .instance_finalize = pl031_finalize,
>>      .class_init    = pl031_class_init,
>>  };
> 
> The more usual way to fix this I think is to delay
> the timer_new until realize rather than putting it
> into instance_init, since the pl031 can't be
> hotplugged.

Hmm, you are right, I will change it in next version.

Thanks.

> 
> thanks
> -- PMM
> .
> 

