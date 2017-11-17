Received: from eggs.gnu.org ([2001:4830:134:3::10]:53948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFXc9-0005SL-Bz
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 22:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFXc6-0004de-8V
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 22:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFXc6-0004cK-0A
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 22:46:46 -0500
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
	<2e0ddd76-3903-d715-9a86-73f1286322e7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
	<6aaaca2b-81ef-a1c1-4745-830d008b3770@redhat.com>
	<5A0D5B1B.3080708@huawei.com>
	<55f2edb1-1fe3-d03f-7f4f-418a3b15997a@redhat.com>
	<5A0E4310.2060803@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <62e5cafb-8e8f-f978-fdb0-3a7edc9a9167@redhat.com>
Date: Fri, 17 Nov 2017 11:46:32 +0800
MIME-Version: 1.0
In-Reply-To: <5A0E4310.2060803@huawei.com>
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
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "Longpeng(Mike)" <longpeng.mike@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>



On 2017=E5=B9=B411=E6=9C=8817=E6=97=A5 10:01, Longpeng (Mike) wrote:
> On 2017/11/16 20:04, Jason Wang wrote:
>
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
t addr of
>>> pc.ram).
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
ues any
>> more. But we should have a complete solution. The main problem is when=
 vhost
>> need to be started. For legacy device, there's no easy way to detect w=
hether or
>> not a specific virtqueue is ready to be used. For modern device, we ca=
n probably
>> do this through queue_enable (but this is not implemented in current c=
ode).
>>
> Can we initialize the vring.desc/vring.avail/vring.used to -1, then we =
can
> detect whether or not a specific vq is ready to be used by check the ad=
dr of its
> tables is -1 or not ?
>
> Initialize to 0 is not suitable, because we don't know whether the gues=
t set GPA
> 0 or the guest not initialize this vq.
>

Unfortunately, it's too late to do this in spec for legacy device. (If=20
you look at the spec, legacy MMIO transport treat 0x0 as an illegal=20
value.) For modern device, we could detect this through queue_enable.

Let's wait for Yan to reply whether or not windows driver can use the=20
left three queues. If not, I will try to post a fix(workaround) for this=20
and let's consider a complete solution.

Thanks
