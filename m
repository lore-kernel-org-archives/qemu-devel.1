Received: from eggs.gnu.org ([2001:4830:134:3::10]:44215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1eFFGx-0001Vu-G9
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1eFFGt-0007Nt-E3
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1eFFGt-0007MI-4P
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:11:39 -0500
From: Yan Vugenfirer <yvugenfi@redhat.com>
Message-Id: <2969D220-9E10-4F1B-89D2-87822909F3E2@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 16 Nov 2017 10:11:28 +0200
In-Reply-To: <5A0D27D8.6050506@huawei.com>
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
Content-Type: text/plain;
	charset=utf-8
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
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng.mike@gmail.com>, qemu-devel@nongnu.org, king.wang@huawei.com, arei.gonglei@huawei.com, stefanha@redhat.com

Hi Jason,

Windows driver will initialise only the amount of queue based on the =
amount of available vCPUs. So if there will be more queues in the device =
than we have vCPUs on the guest, the driver will not initialise =
=E2=80=9Cexcessive=E2=80=9D queues. This is tied to the way RSS on =
Windows should be implemented.
Exactly as in described scenario (7 queues, but only 4 vCPUs).

Best regards,
Yan.

> On 16 Nov 2017, at 07:53, Longpeng (Mike) <longpeng2@huawei.com> =
wrote:
>=20
> Hi Jason & Michael,
>=20
> Do you have any idea about this problem ?
>=20
> --=20
> Regards,
> Longpeng(Mike)
>=20
> On 2017/11/15 23:54, Longpeng(Mike) wrote:
>=20
>> 2017-11-15 23:05 GMT+08:00 Jason Wang <jasowang@redhat.com>:
>>>=20
>>>=20
>>> On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 22:55, Longpeng(Mike) wrote:
>>>>=20
>>>> Hi guys,
>>>>=20
>>>> We got a BUG report from our testers yesterday, the testing =
scenario was
>>>> migrating a VM (Windows guest, *4 vcpus*, 4GB, vhost-user net: *7
>>>> queues*).
>>>>=20
>>>> We found the cause reason, and we'll report the BUG or send a fix =
patch
>>>> to upstream if necessary( we haven't test the upstream yet, =
sorry... ).
>>>=20
>>>=20
>>> Could you explain this a little bit more?
>>>=20
>>>>=20
>>>> We want to know why the vhost_net_start() must start *total queues* =
( in
>>>> our
>>>> VM there're 7 queues ) but not *the queues that current used* ( in =
our VM,
>>>> guest
>>>> only uses the first 4 queues because it's limited by the number of =
vcpus)
>>>> ?
>>>>=20
>>>> Looking forward to your help, thx :)
>>>=20
>>>=20
>>> Since the codes have been there for years and works well for kernel
>>> datapath. You should really explain what's wrong.
>>>=20
>>=20
>> OK. :)
>>=20
>> In our scenario,  the Windows's virtio-net driver only use the first =
4
>> queues and it
>> *only set desc/avail/used table for the first 4 queues*, so in QEMU
>> the desc/avail/
>> used of the last 3 queues are ZERO,  but unfortunately...
>> '''
>> vhost_net_start
>>  for (i =3D 0; i < total_queues; i++)
>>    vhost_net_start_one
>>      vhost_dev_start
>>        vhost_virtqueue_start
>> '''
>> In vhost_virtqueue_start(), it will calculate the HVA of
>> desc/avail/used table, so for last
>> 3 queues, it will use ZERO as the GPA to calculate the HVA, and then
>> send the results
>> to the user-mode backend ( we use *vhost-user* ) by =
vhost_virtqueue_set_addr().
>>=20
>> When the EVS get these address, it will update a *idx* which will be
>> treated as  vq's
>> last_avail_idx when virtio-net stop ( pls see vhost_virtqueue_stop() =
).
>>=20
>> So we get the following result after virtio-net stop:
>>  the desc/avail/used of the last 3 queues's vqs are all ZERO, but =
these vqs's
>>  last_avail_idx is NOT ZERO.
>>=20
>> At last, virtio_load() reports an error:
>> '''
>>  if (!vdev->vq[i].vring.desc && vdev->vq[i].last_avail_idx) { // <--
>> will be TRUE
>>      error_report("VQ %d address 0x0 "
>>                         "inconsistent with Host index 0x%x",
>>                         i, vdev->vq[i].last_avail_idx);
>>            return -1;
>>   }
>> '''
>>=20
>> BTW, the problem won't appear if use Linux guest, because the Linux =
virtio-net
>> driver will set all 7 queues's desc/avail/used tables. And the =
problem
>> won't appear
>> if the VM use vhost-net, because vhost-net won't update *idx* in =
SET_ADDR ioctl.
>>=20
>> Sorry for my pool English, Maybe I could describe the problem in =
Chinese for you
>> in private if necessary.
>>=20
>>=20
>>> Thanks
>>=20
>>=20
>=20
>=20
> --=20
> Regards,
> Longpeng(Mike)
