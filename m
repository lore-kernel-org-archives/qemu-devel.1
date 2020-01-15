Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD5C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D858924658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D858924658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irXUd-00067K-ST
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 20:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1irXTo-0005Re-Qt
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1irXTn-00009j-Gd
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:28:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2680 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1irXTn-00007e-5c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:28:19 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5D6D31B54BA5A1265ECE;
 Wed, 15 Jan 2020 09:28:16 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 15 Jan
 2020 09:28:06 +0800
Subject: Re: [PATCH] virtio-9p-device: fix memleak in
 virtio_9p_device_unrealize
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, <qemu-devel@nongnu.org>
References: <20200114074020.54696-1-pannengyuan@huawei.com>
 <56394079.B7N9aGhjP3@silver> <1721395.PxUUFA46pP@silver>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <c1d8c97e-6d08-1bac-ccb2-fe651e329bee@huawei.com>
Date: Wed, 15 Jan 2020 09:28:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1721395.PxUUFA46pP@silver>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>,
 groug@kaod.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/14/2020 10:17 PM, Christian Schoenebeck wrote:
> On Dienstag, 14. Januar 2020 11:08:59 CET Christian Schoenebeck wrote:
>> On Dienstag, 14. Januar 2020 08:40:20 CET pannengyuan@huawei.com wrote:
>>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>>
>>> v->vq forgot to cleanup in virtio_9p_device_unrealize, the memory leak
>>> stack is as follow:
>>>
>>> Direct leak of 14336 byte(s) in 2 object(s) allocated from:
>>>   #0 0x7f819ae43970 (/lib64/libasan.so.5+0xef970)  ??:?
>>>   #1 0x7f819872f49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
>>>   #2 0x55a3a58da624 (./x86_64-softmmu/qemu-system-x86_64+0x2c14624)
>>>
>>> /mnt/sdb/qemu/hw/virtio/virtio.c:2327 #3 0x55a3a571bac7
>>> (./x86_64-softmmu/qemu-system-x86_64+0x2a55ac7)
>>> /mnt/sdb/qemu/hw/9pfs/virtio-9p-device.c:209 #4 0x55a3a58e7bc6
>>> (./x86_64-softmmu/qemu-system-x86_64+0x2c21bc6)
>>> /mnt/sdb/qemu/hw/virtio/virtio.c:3504 #5 0x55a3a5ebfb37
>>> (./x86_64-softmmu/qemu-system-x86_64+0x31f9b37)
>>> /mnt/sdb/qemu/hw/core/qdev.c:876
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>>> ---
>>>
>>>  hw/9pfs/virtio-9p-device.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
>>> index b5a7c03f26..b146387ae2 100644
>>> --- a/hw/9pfs/virtio-9p-device.c
>>> +++ b/hw/9pfs/virtio-9p-device.c
>>> @@ -215,6 +215,7 @@ static void virtio_9p_device_unrealize(DeviceState
>>> *dev, Error **errp) V9fsVirtioState *v = VIRTIO_9P(dev);
>>>
>>>      V9fsState *s = &v->state;
>>>
>>> +    virtio_delete_queue(v->vq);
>>>
>>>      virtio_cleanup(vdev);
>>>      v9fs_device_unrealize_common(s, errp);
>>>  
>>>  }
>>
>> Looks like you are using an old interface. The new one is
>>
>> 	void virtio_del_queue(VirtIODevice *vdev, int n);
> 
> Ah, my bad, it is actually the other way around, that is I was not up to date; 
> virtio_delete_queue() was apparently introduced a week ago:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg00723.html
> 
> The old virtio_del_queue() still exists though:
> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio.c#L2339
> 
> Having said that, it would probably still make sense to use virtio_del_queue() 
> instead for now to make it easier for stable branches to merge this fix?
> 

virtio_delete_queue makes the cleanup more clear and it tends to replace the old one gradually.
So I think it would probably still use virtio_delete_queue.

Given that, maybe we can split this patch?
For example:
1. use virtio_del_queue to fix memleak, it's easier for stable to merge.
2. rename virtio_del_queue to virtio_delete_queue

> Best regards,
> Christian Schoenebeck
> 
> 
> 
> 
> .
> 

