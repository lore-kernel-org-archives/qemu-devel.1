Received: from eggs.gnu.org ([2001:4830:134:3::10]:36520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFIub-0006MT-KT
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFIuV-0004xY-Nf
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:04:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFIuV-0004wX-FG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:04:47 -0500
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
	<2e0ddd76-3903-d715-9a86-73f1286322e7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
	<6aaaca2b-81ef-a1c1-4745-830d008b3770@redhat.com>
	<5A0D5B1B.3080708@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <55f2edb1-1fe3-d03f-7f4f-418a3b15997a@redhat.com>
Date: Thu, 16 Nov 2017 20:04:34 +0800
MIME-Version: 1.0
In-Reply-To: <5A0D5B1B.3080708@huawei.com>
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
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng.mike@gmail.com>



On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:32, Longpeng (Mike) wrote:
> Hi Jason,
>
> On 2017/11/16 17:13, Jason Wang wrote:
>
>>
>> On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:01, Gonglei (Arei) wrote:
>>> No, Windows guest + vhost-user/DPDK.
>>>
>>> BTW pls see virtio spec in :
>>>
>>> "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveqN th=
at will
>>> be used SHOULD be populated
>>> with receive buffers."
>>>
>>> It is not mandatory that all queues must be initialized.
>> I think not, since it said we should fill receive buffers for each que=
ue which
>> means we should initialize all queues. May Michael can clarify on this=
.
>>
>
> I think this doesn't matter, but QEMU should consider this scenario...
>
> For example, if one queues isn't initialized (Windows guest), the vring=
.avail=3D0,
> so vq->desc_phys=3D0, then vq->desc=3D'a avail HVA'(which is the start =
addr of pc.ram).
>
>      vq->desc_size =3D s =3D l =3D virtio_queue_get_desc_size(vdev, idx=
);
>      vq->desc_phys =3D a =3D virtio_queue_get_desc_addr(vdev, idx);
>      vq->desc =3D vhost_memory_map(dev, a, &l, 0);
>      if (!vq->desc || l !=3D s) {
>          r =3D -ENOMEM;
>          goto fail_alloc_desc;
>      }
>      .....
>      r =3D vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_e=
nabled);
>      if (r < 0) {
>          r =3D -errno;
>          goto fail_alloc;
>      }
>
> Then the HVA is send to the vhost-user.
>
> I think this is wrong, because the '0' here means guest driver doesn't =
init this
> queues, it should not be used to calculate the HVA for this vq.

Yes, workaround is not hard if windows driver won't use the left 3=20
queues any more. But we should have a complete solution. The main=20
problem is when vhost need to be started. For legacy device, there's no=20
easy way to detect whether or not a specific virtqueue is ready to be=20
used. For modern device, we can probably do this through queue_enable=20
(but this is not implemented in current code).

Thanks

>
>> Thanks
>>
>>> Thanks,
>>> -Gonglei
>>>
>>
>>
>>
>> .
>>
>
