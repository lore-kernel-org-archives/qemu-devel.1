Received: from eggs.gnu.org ([2001:4830:134:3::10]:51280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFGY4-0007Fd-Vs
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFGY1-0008Kc-2W
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:33:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFGY0-0008Ft-GE
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:33:25 -0500
Message-ID: <5A0D5B1B.3080708@huawei.com>
Date: Thu, 16 Nov 2017 17:32:11 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
	<2e0ddd76-3903-d715-9a86-73f1286322e7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
	<6aaaca2b-81ef-a1c1-4745-830d008b3770@redhat.com>
In-Reply-To: <6aaaca2b-81ef-a1c1-4745-830d008b3770@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Question] why need to start all queues in
 vhost_net_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "Longpeng(Mike)" <longpeng.mike@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>

Hi Jason,

On 2017/11/16 17:13, Jason Wang wrote:

> 
> 
> On 2017年11月16日 17:01, Gonglei (Arei) wrote:
>> No, Windows guest + vhost-user/DPDK.
>>
>> BTW pls see virtio spec in :
>>
>> "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveqN that will
>> be used SHOULD be populated
>> with receive buffers."
>>
>> It is not mandatory that all queues must be initialized.
> 
> I think not, since it said we should fill receive buffers for each queue which
> means we should initialize all queues. May Michael can clarify on this.
> 


I think this doesn't matter, but QEMU should consider this scenario...

For example, if one queues isn't initialized (Windows guest), the vring.avail=0,
so vq->desc_phys=0, then vq->desc='a avail HVA'(which is the start addr of pc.ram).

    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
    vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
    vq->desc = vhost_memory_map(dev, a, &l, 0);
    if (!vq->desc || l != s) {
        r = -ENOMEM;
        goto fail_alloc_desc;
    }
    .....
    r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
    if (r < 0) {
        r = -errno;
        goto fail_alloc;
    }

Then the HVA is send to the vhost-user.

I think this is wrong, because the '0' here means guest driver doesn't init this
queues, it should not be used to calculate the HVA for this vq.

> Thanks
> 
>>
>> Thanks,
>> -Gonglei
>>
> 
> 
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
