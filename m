Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152DEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 00:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E111B206E1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 00:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E111B206E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibwUN-00053f-Vp
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 19:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ibwS5-0003Xk-GY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ibwS3-0002j1-Uu
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:54:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2205 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ibwRz-0002aE-AY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:54:00 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7EC59F4C951E81510D3C;
 Tue,  3 Dec 2019 08:53:49 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 08:53:42 +0800
Subject: Re: [PATCH] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
To: Laurent Vivier <lvivier@redhat.com>, <mst@redhat.com>, <amit@kernel.org>, 
 <marcandre.lureau@redhat.com>, <pbonzini@redhat.com>
References: <1575285343-21864-1-git-send-email-pannengyuan@huawei.com>
 <dad28876-1850-32f3-fe47-9e4ec2c68f20@redhat.com>
From: pannengyuan <pannengyuan@huawei.com>
Message-ID: <4e9efebf-1862-8879-ed01-60f8777d4a65@huawei.com>
Date: Tue, 3 Dec 2019 08:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <dad28876-1850-32f3-fe47-9e4ec2c68f20@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.120.177.99]
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/2 21:58, Laurent Vivier wrote:
> On 02/12/2019 12:15, pannengyuan@huawei.com wrote:
>> From: PanNengyuan <pannengyuan@huawei.com>
>>
>> ivqs/ovqs/c_ivq/c_ovq is forgot to cleanup in
>> virtio_serial_device_unrealize, the memory leak stack is as bellow:
>>
>> Direct leak of 1290240 byte(s) in 180 object(s) allocated from:
>>     #0 0x7fc9bfc27560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
>>     #1 0x7fc9bed6f015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
>>     #2 0x5650e02b83e7 in virtio_add_queue /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:2327
>>     #3 0x5650e02847b5 in virtio_serial_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/char/virtio-serial-bus.c:1089
>>     #4 0x5650e02b56a7 in virtio_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:3504
>>     #5 0x5650e03bf031 in device_set_realized /mnt/sdb/qemu-4.2.0-rc0/hw/core/qdev.c:876
>>     #6 0x5650e0531efd in property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom/object.c:2080
>>     #7 0x5650e053650e in object_property_set_qobject /mnt/sdb/qemu-4.2.0-rc0/qom/qom-qobject.c:26
>>     #8 0x5650e0533e14 in object_property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom/object.c:1338
>>     #9 0x5650e04c0e37 in virtio_pci_realize /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio-pci.c:1801
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
>> ---
>>  hw/char/virtio-serial-bus.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>> index 3325904..da9019a 100644
>> --- a/hw/char/virtio-serial-bus.c
>> +++ b/hw/char/virtio-serial-bus.c
>> @@ -1126,9 +1126,15 @@ static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
>>  {
>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>      VirtIOSerial *vser = VIRTIO_SERIAL(dev);
>> +    int i;
>>  
>>      QLIST_REMOVE(vser, next);
>>  
>> +    for (i = 0; i <= vser->bus.max_nr_ports; i++) {
>> +        virtio_del_queue(vdev, 2 * i);
>> +        virtio_del_queue(vdev, 2 * i + 1);
>> +    }
>> +
> 
> According to virtio_serial_device_realize() and the number of
> virtio_add_queue(), I think you have more queues to delete:
> 
>   4 + 2 * vser->bus.max_nr_ports
> 
> (for vser->ivqs[0], vser->ovqs[0], vser->c_ivq, vser->c_ovq,
> vser->ivqs[i], vser->ovqs[i]).
> 
> Thanks,
> Laurent
> 
> 
Thanks, but I think the queues is correct, the queues in
virtio_serial_device_realize is as follow:

// here is 2
vser->ivqs[0] = virtio_add_queue(vdev, 128, handle_input);
vser->ovqs[0] = virtio_add_queue(vdev, 128, handle_output);

// here is 2
vser->c_ivq = virtio_add_queue(vdev, 32, control_in);
vser->c_ovq = virtio_add_queue(vdev, 32, control_out);

// here 2 * (max_nr_ports - 1)  ----- i is from 1 to max_nr_ports - 1
for (i = 1; i < vser->bus.max_nr_ports; i++) {
    vser->ivqs[i] = virtio_add_queue(vdev, 128, handle_input);
    vser->ovqs[i] = virtio_add_queue(vdev, 128, handle_output);
}

so the total queues number is:  2 * (vser->bus.max_nr_ports + 1)


