Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D946EC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEEB222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEEB222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FHB-0003Nn-RQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j7FGQ-0002Jy-Qb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j7FGP-0000wI-Mf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:15:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3252 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j7FGM-0000rd-Vj; Thu, 27 Feb 2020 04:15:23 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C66B5D06BC57D3EB34DD;
 Thu, 27 Feb 2020 17:15:18 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Feb
 2020 17:15:12 +0800
Subject: Re: [PATCH v3 1/6] s390x: fix memleaks in cpu_finalize
To: David Hildenbrand <david@redhat.com>, <peter.maydell@linaro.org>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-2-pannengyuan@huawei.com>
 <59af1e29-8075-a25c-dd80-e93cc21bb328@redhat.com>
 <46d1fc23-6ef5-947f-becd-c3004a6b76bc@huawei.com>
 <f0576f75-d8b5-0e65-7390-32cd3021e1f2@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <11fc3595-4bc4-a523-cf41-62ca7cfbd70d@huawei.com>
Date: Thu, 27 Feb 2020 17:15:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f0576f75-d8b5-0e65-7390-32cd3021e1f2@redhat.com>
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
Cc: zhang.zhanghailiang@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 euler.robot@huawei.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/27/2020 5:04 PM, David Hildenbrand wrote:
> On 27.02.20 09:58, Pan Nengyuan wrote:
>>
>>
>> On 2/27/2020 4:41 PM, David Hildenbrand wrote:
>>> On 27.02.20 03:50, Pan Nengyuan wrote:
>>>> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s3=
90x. The leak stack is as follow:
>>>>
>>>> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>>>>     #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0=
xef970)
>>>>     #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>>>>     #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/inclu=
de/qemu/timer.h:530
>>>>     #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qe=
mu/timer.h:551
>>>>     #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include=
/qemu/timer.h:569
>>>>     #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/targ=
et/s390x/cpu.c:285
>>>>     #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qem=
u/qom/object.c:372
>>>>     #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-n=
ew/qemu/qom/object.c:516
>>>>     #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu=
/qom/object.c:684
>>>>     #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s39=
0x/s390-virtio-ccw.c:64
>>>>     #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core=
/machine-hmp-cmds.c:57
>>>>     #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/=
monitor/hmp.c:1082
>>>>     #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-ne=
w/qemu/monitor/misc.c:142
>>>>
>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>>>> ---
>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Cornelia Huck <cohuck@redhat.com>
>>>> Cc: qemu-s390x@nongnu.org
>>>> ---
>>>> v2->v1:
>>>> - Similarly to other cleanups, move timer_new into realize(Suggested=
 by Philippe Mathieu-Daud=C3=A9)
>>>> v3->v2:
>>>> - Also do the timer_free in unrealize, it seems more balance.
>>>> ---
>>>
>>>
>>> As I already said, I think this is init and not realize stuff. Do we
>>> have a convention now and documented that?
>>>
>>> Anyhow, I don't really care
>>> [...]
>>>
>>>
>>>> @@ -453,6 +466,7 @@ static void s390_cpu_class_init(ObjectClass *oc,=
 void *data)
>>>> =20
>>>>      device_class_set_parent_realize(dc, s390_cpu_realizefn,
>>>>                                      &scc->parent_realize);
>>>> +    dc->unrealize =3D s390_cpu_unrealizefn;
>>>
>>> Shouldn't we use device_class_set_parent_unrealize?
>>
>> We just only declare parent_realize field in S390CPUClass(), it seems =
nothing to do in parent_unrealize.
>>
>> typedef struct S390CPUClass {
>> ...
>> DeviceRealize parent_realize;    // no parent_unrealize;
>> ...
>> }
>>
>> So I think we can't use it.
>=20
> So you should add it and properly call the parent_unrealize from your
> new unrealize function?
>=20
> AFAIKS you are overwriting cpu_common_unrealizefn set in hw/core/cpu.c
> for TYPE_CPU with this change.

Oh, I think you are right, I will change it.

Thanks.
>=20

