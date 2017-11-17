Received: from eggs.gnu.org ([2001:4830:134:3::10]:58375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFVyx-00021k-7c
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFVyu-0005bq-5U
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:02:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFVyt-0005ZG-KH
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:02:12 -0500
Message-ID: <5A0E4310.2060803@huawei.com>
Date: Fri, 17 Nov 2017 10:01:52 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
	<2e0ddd76-3903-d715-9a86-73f1286322e7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
	<6aaaca2b-81ef-a1c1-4745-830d008b3770@redhat.com>
	<5A0D5B1B.3080708@huawei.com>
	<55f2edb1-1fe3-d03f-7f4f-418a3b15997a@redhat.com>
In-Reply-To: <55f2edb1-1fe3-d03f-7f4f-418a3b15997a@redhat.com>
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
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng.mike@gmail.com>



On 2017/11/16 20:04, Jason Wang wrote:

> 
> 
> On 2017年11月16日 17:32, Longpeng (Mike) wrote:
>> Hi Jason,
>>
>> On 2017/11/16 17:13, Jason Wang wrote:
>>
>>>
>>> On 2017年11月16日 17:01, Gonglei (Arei) wrote:
>>>> No, Windows guest + vhost-user/DPDK.
>>>>
>>>> BTW pls see virtio spec in :
>>>>
>>>> "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveqN that will
>>>> be used SHOULD be populated
>>>> with receive buffers."
>>>>
>>>> It is not mandatory that all queues must be initialized.
>>> I think not, since it said we should fill receive buffers for each queue which
>>> means we should initialize all queues. May Michael can clarify on this.
>>>
>>
>> I think this doesn't matter, but QEMU should consider this scenario...
>>
>> For example, if one queues isn't initialized (Windows guest), the vring.avail=0,
>> so vq->desc_phys=0, then vq->desc='a avail HVA'(which is the start addr of
>> pc.ram).
>>
>>      vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
>>      vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
>>      vq->desc = vhost_memory_map(dev, a, &l, 0);
>>      if (!vq->desc || l != s) {
>>          r = -ENOMEM;
>>          goto fail_alloc_desc;
>>      }
>>      .....
>>      r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
>>      if (r < 0) {
>>          r = -errno;
>>          goto fail_alloc;
>>      }
>>
>> Then the HVA is send to the vhost-user.
>>
>> I think this is wrong, because the '0' here means guest driver doesn't init this
>> queues, it should not be used to calculate the HVA for this vq.
> 
> Yes, workaround is not hard if windows driver won't use the left 3 queues any
> more. But we should have a complete solution. The main problem is when vhost
> need to be started. For legacy device, there's no easy way to detect whether or
> not a specific virtqueue is ready to be used. For modern device, we can probably
> do this through queue_enable (but this is not implemented in current code).
> 


Can we initialize the vring.desc/vring.avail/vring.used to -1, then we can
detect whether or not a specific vq is ready to be used by check the addr of its
tables is -1 or not ?

Initialize to 0 is not suitable, because we don't know whether the guest set GPA
0 or the guest not initialize this vq.

> Thanks
> 
>>
>>> Thanks
>>>
>>>> Thanks,
>>>> -Gonglei
>>>>
>>>
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
