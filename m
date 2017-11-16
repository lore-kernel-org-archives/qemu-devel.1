Received: from eggs.gnu.org ([2001:4830:134:3::10]:39362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFGAv-0007hn-Jf
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFGAu-0002dZ-AV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:09:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFGAu-0002Yk-1S
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:09:32 -0500
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
	<2e0ddd76-3903-d715-9a86-73f1286322e7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a7d8545f-efb1-4ee8-d342-6171a059cfb9@redhat.com>
Date: Thu, 16 Nov 2017 17:09:05 +0800
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "Longpeng(Mike)" <longpeng.mike@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>



On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:01, Gonglei (Arei) wrote:
>
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Thursday, November 16, 2017 4:55 PM
>> To: longpeng; mst@redhat.com
>> Cc: Longpeng(Mike); qemu-devel@nongnu.org; Gonglei (Arei); Wangjing (K=
ing,
>> Euler); Huangweidong (C); stefanha@redhat.com
>> Subject: Re: [Question] why need to start all queues in vhost_net_star=
t
>>
>>
>>
>> On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 13:53, Longpeng (Mike) wrote:
>>> On 2017/11/15 23:54, Longpeng(Mike) wrote:
>>>> 2017-11-15 23:05 GMT+08:00 Jason Wang<jasowang@redhat.com>:
>>>>> On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 22:55, Longpeng(Mike) wrote:
>>>>>> Hi guys,
>>>>>>
>>>>>> We got a BUG report from our testers yesterday, the testing scenar=
io was
>>>>>> migrating a VM (Windows guest, *4 vcpus*, 4GB, vhost-user net: *7
>>>>>> queues*).
>>>>>>
>>>>>> We found the cause reason, and we'll report the BUG or send a fix =
patch
>>>>>> to upstream if necessary( we haven't test the upstream yet, sorry.=
.. ).
>>>>> Could you explain this a little bit more?
>>>>>
>>>>>> We want to know why the vhost_net_start() must start*total queues*
>> ( in
>>>>>> our
>>>>>> VM there're 7 queues ) but not*the queues that current used*  ( in=
 our
>> VM,
>>>>>> guest
>>>>>> only uses the first 4 queues because it's limited by the number of=
 vcpus)
>>>>>> ?
>>>>>>
>>>>>> Looking forward to your help, thx:)
>>>>> Since the codes have been there for years and works well for kernel
>>>>> datapath. You should really explain what's wrong.
>>>>>
>>>> OK.:)
>>>>
>>>> In our scenario,  the Windows's virtio-net driver only use the first=
 4
>>>> queues and it
>>>> *only set desc/avail/used table for the first 4 queues*, so in QEMU
>>>> the desc/avail/
>>>> used of the last 3 queues are ZERO,  but unfortunately...
>>>> '''
>>>> vhost_net_start
>>>>     for (i =3D 0; i < total_queues; i++)
>>>>       vhost_net_start_one
>>>>         vhost_dev_start
>>>>           vhost_virtqueue_start
>>>> '''
>>>> In vhost_virtqueue_start(), it will calculate the HVA of
>>>> desc/avail/used table, so for last
>>>> 3 queues, it will use ZERO as the GPA to calculate the HVA, and then
>>>> send the results
>>>> to the user-mode backend ( we use*vhost-user*  ) by
>> vhost_virtqueue_set_addr().
>>>> When the EVS get these address, it will update a*idx*  which will be
>>>> treated as  vq's
>>>> last_avail_idx when virtio-net stop ( pls see vhost_virtqueue_stop()=
 ).
>>>>
>>>> So we get the following result after virtio-net stop:
>>>>     the desc/avail/used of the last 3 queues's vqs are all ZERO, but=
 these
>> vqs's
>>>>     last_avail_idx is NOT ZERO.
>>>>
>>>> At last, virtio_load() reports an error:
>>>> '''
>>>>     if (!vdev->vq[i].vring.desc && vdev->vq[i].last_avail_idx) { // =
<--
>>>> will be TRUE
>>>>         error_report("VQ %d address 0x0 "
>>>>                            "inconsistent with Host index 0x%x",
>>>>                            i, vdev->vq[i].last_avail_idx);
>>>>               return -1;
>>>>      }
>>>> '''
>>>>
>>>> BTW, the problem won't appear if use Linux guest, because the Linux
>> virtio-net
>>>> driver will set all 7 queues's desc/avail/used tables. And the probl=
em
>>>> won't appear
>>>> if the VM use vhost-net, because vhost-net won't update*idx*  in
>> SET_ADDR ioctl.
>>
>> Just to make sure I understand here, I thought Windows guest + vhost_n=
et
>> hit this issue?
>>
> No, Windows guest + vhost-user/DPDK.
>
> BTW pls see virtio spec in :
>
> "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveqN that=
 will be used SHOULD be populated
> with receive buffers."
>
> It is not mandatory that all queues must be initialized.
>
> Thanks,
> -Gonglei
>

Interesting, vhost_net will set last_avail_idx to vq.num during=20
SET_VRING_BASE. So I thought it should hit this.

Btw, maybe we should relax the check to:

if (!vdev->vq[i].vring.desc && (vdev->vq[i].last_avail_idx !=3D=20
vdev->vq[i].vring.num)) {

Thanks
