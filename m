Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C83CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CF921D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CF921D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8wV1-0004Wx-NK
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j8wUM-0003tG-Pb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 20:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j8wUL-0000eS-4Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 20:36:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3256 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j8wUH-0000af-I9; Mon, 02 Mar 2020 20:36:45 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 731EC8A22F7275DE759;
 Tue,  3 Mar 2020 09:36:40 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 09:36:33 +0800
Subject: Re: [PATCH v3 5/6] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-6-pannengyuan@huawei.com>
 <CAFEAcA8yvrYrBONtW46iswbEvMF-WC-j7fHOOfcoEC_RV66BkQ@mail.gmail.com>
 <c2b9eab3-f589-ecb6-0115-f8e673d52998@ilande.co.uk>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <fc807125-1281-707f-0080-cc9b1d3c863e@huawei.com>
Date: Tue, 3 Mar 2020 09:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c2b9eab3-f589-ecb6-0115-f8e673d52998@ilande.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/3/2020 3:17 AM, Mark Cave-Ayland wrote:
> On 02/03/2020 13:21, Peter Maydell wrote:
> 
>> On Thu, 27 Feb 2020 at 02:35, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>>>
>>> There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.
>>> Meanwhile, add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>>> ---
>>> Cc: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>> v2->v1:
>>> - no changes in this patch.
>>> v3->v2:
>>> - remove null check in reset, and add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
>>
>> Hi; this is really fixing two bugs in one patch:
>>
>>> ---
>>>  hw/misc/mac_via.c | 5 +++++
>>>  hw/misc/mos6522.c | 6 ++++++
>>>  2 files changed, 11 insertions(+)
>>>
>>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>>> index b7d0012794..1d72d4ef35 100644
>>> --- a/hw/misc/mac_via.c
>>> +++ b/hw/misc/mac_via.c
>>> @@ -879,6 +879,11 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
>>>      sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
>>>                            sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
>>>
>>> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized",
>>> +                             &error_abort);
>>> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized",
>>> +                             &error_abort);
>>> +
>>>      /* Pass through mos6522 output IRQs */
>>>      ms = MOS6522(&m->mos6522_via1);
>>>      object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
>>
>> This is fixing a bug in mac_via where it failed to actually
>> realize devices it was using. That's a dependency for the bug
>> you're trying to fix, but it's a separate one and should be
>> in its own patch.
> 
> Sigh. Thanks for this - I actually discovered this a little while back and have some
> local patches to do the same, but due to lack of time I never managed to tidy them up
> for submission.

Hmm, maybe you can take this other changes(fix memleaks) into your local patches and send it together?
Or If you have no time, I can help to do it about this device. :)

> 
>> You also want to pass the error back up to the caller, rather
>> than using error_abort. To do that, at the top of the function:
>>
>>     Error *err = NULL;
>>
>> and then here you can do:
>>     object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
>>     if (err) {
>>         error_propagate(errp, err);
>>         return;
>>     }
>>
>> The existing code which inits the mos6522 objects and
>> calls object_property_add_alias on them which is in
>> the mac_via realize function should be moved to the init
>> function. (init should init child objects and set up
>> properties; realize should realize them.)
> 
> And I believe at some point I had a patch lying around to do this too...
> 
>> This is all fixing the incorrect creation of the mos6522
>> devices in mac_via (which has been wrong since the mac_via
>> was first added in commit 6dca62a0000f9), so that can all
>> be one patch I think.
>>
>>> +static void mos6522_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    MOS6522State *s = MOS6522(dev);
>>>
>>>      s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
>>>      s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
>>> @@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
>>>
>>>      dc->reset = mos6522_reset;
>>>      dc->vmsd = &vmstate_mos6522;
>>> +    dc->realize = mos6522_realize;
>>>      device_class_set_props(dc, mos6522_properties);
>>>      mdc->parent_reset = dc->reset;
>>>      mdc->set_sr_int = mos6522_set_sr_int;
>>
>> The changes to hw/misc/mos_6522.c are good, but should be in
>> their own patch.
> 
> 
> ATB,
> 
> Mark.
> .
> 

