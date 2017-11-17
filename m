Received: from eggs.gnu.org ([2001:4830:134:3::10]:33025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFaOp-0007Yk-KS
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFaOm-00012v-D3
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:45:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFaOm-00011i-4O
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:45:12 -0500
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4d341c53-3826-ead0-0e9b-e5dd71a301cd@redhat.com>
Date: Fri, 17 Nov 2017 14:44:57 +0800
MIME-Version: 1.0
In-Reply-To: <20171117063024-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng.mike@gmail.com>



On 2017=E5=B9=B411=E6=9C=8817=E6=97=A5 12:32, Michael S. Tsirkin wrote:
> On Thu, Nov 16, 2017 at 08:04:34PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:32, Longpeng (Mike) wrote:
>>> Hi Jason,
>>>
>>> On 2017/11/16 17:13, Jason Wang wrote:
>>>
>>>> On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:01, Gonglei (Arei) wrote:
>>>>> No, Windows guest + vhost-user/DPDK.
>>>>>
>>>>> BTW pls see virtio spec in :
>>>>>
>>>>> "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveqN =
that will
>>>>> be used SHOULD be populated
>>>>> with receive buffers."
>>>>>
>>>>> It is not mandatory that all queues must be initialized.
>>>> I think not, since it said we should fill receive buffers for each q=
ueue which
>>>> means we should initialize all queues. May Michael can clarify on th=
is.
>>>>
>>> I think this doesn't matter, but QEMU should consider this scenario..=
.
>>>
>>> For example, if one queues isn't initialized (Windows guest), the vri=
ng.avail=3D0,
>>> so vq->desc_phys=3D0, then vq->desc=3D'a avail HVA'(which is the star=
t addr of pc.ram).
>>>
>>>       vq->desc_size =3D s =3D l =3D virtio_queue_get_desc_size(vdev, =
idx);
>>>       vq->desc_phys =3D a =3D virtio_queue_get_desc_addr(vdev, idx);
>>>       vq->desc =3D vhost_memory_map(dev, a, &l, 0);
>>>       if (!vq->desc || l !=3D s) {
>>>           r =3D -ENOMEM;
>>>           goto fail_alloc_desc;
>>>       }
>>>       .....
>>>       r =3D vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->lo=
g_enabled);
>>>       if (r < 0) {
>>>           r =3D -errno;
>>>           goto fail_alloc;
>>>       }
>>>
>>> Then the HVA is send to the vhost-user.
>>>
>>> I think this is wrong, because the '0' here means guest driver doesn'=
t init this
>>> queues, it should not be used to calculate the HVA for this vq.
>> Yes, workaround is not hard if windows driver won't use the left 3 que=
ues
>> any more. But we should have a complete solution. The main problem is =
when
>> vhost need to be started. For legacy device, there's no easy way to de=
tect
>> whether or not a specific virtqueue is ready to be used. For modern de=
vice,
>> we can probably do this through queue_enable (but this is not implemen=
ted in
>> current code).
>>
>> Thanks
> What isn't implemented?

I mean queue_enable. Virtio spec said:

queue_enable
    The driver uses this to selectively prevent the device from
    executing requests from this virtqueue. 1 - enabled; 0 - disabled.=20


But we have:

 =C2=A0=C2=A0=C2=A0 case VIRTIO_PCI_COMMON_Q_ENABLE:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_queue_set_num(vdev, vd=
ev->queue_sel,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 proxy->vqs[vdev->queue_sel].num);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_queue_set_rings(vdev, =
vdev->queue_sel,
((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proxy->vqs[v=
dev->queue_sel].desc[0],
((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proxy->vqs[v=
dev->queue_sel].avail[0],
((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proxy->vqs[v=
dev->queue_sel].used[0]);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proxy->vqs[vdev->queue_sel].e=
nabled =3D 1;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;

So it looks to me that we need:

- Not assume the value is 1
- Start or stop vhost virtqueue depends on value

Thanks

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
> Client must start ring upon receiving a kick (that is, detecting that f=
ile
> descriptor is readable) on the descriptor specified by
> VHOST_USER_SET_VRING_KICK, and stop ring upon receiving
> VHOST_USER_GET_VRING_BASE.
>
>
> Does someone kick unused rings? What entity does this?
>
>
>
>
>>>> Thanks
>>>>
>>>>> Thanks,
>>>>> -Gonglei
>>>>>
>>>>
>>>>
>>>> .
>>>>
