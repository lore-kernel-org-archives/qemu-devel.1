Received: from eggs.gnu.org ([2001:4830:134:3::10]:49682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFZRj-00025g-CJ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFZRe-0005rW-GY
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:44:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eFZRd-0005pR-Mr
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:44:06 -0500
Message-ID: <5A0E76F3.9060100@huawei.com>
Date: Fri, 17 Nov 2017 13:43:15 +0800
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
	<20171117063024-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171117063024-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng.mike@gmail.com>, yvugenfi@redhat.com



On 2017/11/17 12:32, Michael S. Tsirkin wrote:

> On Thu, Nov 16, 2017 at 08:04:34PM +0800, Jason Wang wrote:
>>
>>
>> On 2017年11月16日 17:32, Longpeng (Mike) wrote:
>>> Hi Jason,
>>>
>>> On 2017/11/16 17:13, Jason Wang wrote:
>>>
>>>>
>>>> On 2017年11月16日 17:01, Gonglei (Arei) wrote:
>>>>> No, Windows guest + vhost-user/DPDK.
>>>>>
>>>>> BTW pls see virtio spec in :
>>>>>
>>>>> "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveqN that will
>>>>> be used SHOULD be populated
>>>>> with receive buffers."
>>>>>
>>>>> It is not mandatory that all queues must be initialized.
>>>> I think not, since it said we should fill receive buffers for each queue which
>>>> means we should initialize all queues. May Michael can clarify on this.
>>>>
>>>
>>> I think this doesn't matter, but QEMU should consider this scenario...
>>>
>>> For example, if one queues isn't initialized (Windows guest), the vring.avail=0,
>>> so vq->desc_phys=0, then vq->desc='a avail HVA'(which is the start addr of pc.ram).
>>>
>>>      vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
>>>      vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
>>>      vq->desc = vhost_memory_map(dev, a, &l, 0);
>>>      if (!vq->desc || l != s) {
>>>          r = -ENOMEM;
>>>          goto fail_alloc_desc;
>>>      }
>>>      .....
>>>      r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
>>>      if (r < 0) {
>>>          r = -errno;
>>>          goto fail_alloc;
>>>      }
>>>
>>> Then the HVA is send to the vhost-user.
>>>
>>> I think this is wrong, because the '0' here means guest driver doesn't init this
>>> queues, it should not be used to calculate the HVA for this vq.
>>
>> Yes, workaround is not hard if windows driver won't use the left 3 queues
>> any more. But we should have a complete solution. The main problem is when
>> vhost need to be started. For legacy device, there's no easy way to detect
>> whether or not a specific virtqueue is ready to be used. For modern device,
>> we can probably do this through queue_enable (but this is not implemented in
>> current code).
>>
>> Thanks
> 
> What isn't implemented?
> 
> Spec is quite explicit:
> 
> 
> Client must only process each ring when it is started.
> 
> Client must only pass data between the ring and the
> backend, when the ring is enabled.
> 
> and later:
> 
> 
> Client must start ring upon receiving a kick (that is, detecting that file
> descriptor is readable) on the descriptor specified by
> VHOST_USER_SET_VRING_KICK, and stop ring upon receiving
> VHOST_USER_GET_VRING_BASE.
> 
> 
> Does someone kick unused rings? What entity does this?
> 


Hi Michael,

Maybe you don't get our point, so let me be clear. :)

Suppose there is a VM with 4 vcpus and 7 queues (vhost-user backend), the
Windows guest will only initialize the first 4 queues, so in QEMU the addresses
of the desc/avail/used tables of last 3 queues are all ZERO (initial value).

However QEMU will start all 7 queues, please look at the codes below:
'''
vhost_net_start
  for (i = 0; i < total_queues; i++) // start all 7 queues
    vhost_net_start_one
      vhost_dev_start
        vhost_virtqueue_start
'''

In vhost_virtqueue_start(), it will use the ZERO to calculate a corresponding
HVA for the last 3 queues and then send to the backend ( by
vhost_virtqueue_set_addr() ).

So our issue here is: the ZERO here means guest doesn't initialize the last 3
queues, so it needn't to calculate the HVA for them and send to then backend.

But, there is no issue on Linux guest, because Linux driver will initialize the
desc/avail/used tables for all 7 queues (even if it only uses the first 4 queues).

Jason has already get our point, now we need to obtain more information about
Windows virtio-net driver from Yan.

> 
> 
> 
>>>
>>>> Thanks
>>>>
>>>>> Thanks,
>>>>> -Gonglei
>>>>>
>>>>
>>>>
>>>>
>>>> .
>>>>
>>>
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
