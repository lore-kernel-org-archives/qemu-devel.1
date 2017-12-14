Received: from eggs.gnu.org ([2001:4830:134:3::10]:56377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1ePUuV-0002cq-WA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1ePUuS-0002VH-NM
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:54:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1ePUuS-0002SJ-7K
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:54:52 -0500
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
From: Ilya Maximets <i.maximets@samsung.com>
Message-id: <77fe3f09-3b40-2ed1-6226-9909cd606d62@samsung.com>
Date: Thu, 14 Dec 2017 17:54:44 +0300
In-reply-to: <a3421d38-fbdc-f95d-8cfd-66dc5c32a3ac@samsung.com>
Content-language: en-GB
References: <CGME20171206130624eucas1p1f73fd4cf613eaf3ce4ce6918c807f8e1@eucas1p1.samsung.com>
	<1512565578-12078-1-git-send-email-i.maximets@samsung.com>
	<20171206184432-mutt-send-email-mst@kernel.org>
	<249c9e25-0bdb-7a44-6821-59474d25baa5@samsung.com>
	<20171207192456-mutt-send-email-mst@kernel.org>
	<a725504a-957e-d18c-d495-bf4a7c5adc55@samsung.com>
	<20171211062301-mutt-send-email-mst@kernel.org>
	<4ac23512-210b-0543-7ce7-82c9639f321c@samsung.com>
	<20171213214749-mutt-send-email-mst@kernel.org>
	<0e3648df-6aa2-f3e1-5ae6-14fb01d7b476@samsung.com>
	<cdf7bc7a-8ecd-73e7-1129-67c38ab6095d@redhat.com>
	<a3421d38-fbdc-f95d-8cfd-66dc5c32a3ac@samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: fix crash on virtio_error while
 device stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Heetae Ahn <heetae82.ahn@samsung.com>



On 14.12.2017 17:31, Ilya Maximets wrote:
> One update for the testing scenario:
>=20
> No need to kill OVS. The issue reproducible with simple 'del-port'
> and 'add-port'. virtio driver in guest could crash on both operations.
> Most times it crashes in my case on 'add-port' after deletion.
>=20
> Hi Maxime,
> I already saw below patches and original linux kernel virtio issue.
> Just had no enough time to test them.
> Now I tested below patches and they fixes virtio driver crash.
> Thanks for suggestion.
>=20
> Michael,
> I tested "[PATCH] virtio_error: don't invoke status callbacks "
> and it fixes the QEMU crash in case of broken guest index.
> Thanks.
>=20
> Best regards, Ilya Maximets.
>=20
> P.S. Previously I mentioned that I can not reproduce virtio driver
>      crash with "[PATCH] virtio_error: don't invoke status callbacks"

It should be "[PATCH dontapply] virtio: rework set_status callbacks".
Sorry again.

>      applied. I was wrong. I can reproduce now. System was misconfigure=
d.
>      Sorry.
>=20
>=20
> On 14.12.2017 12:01, Maxime Coquelin wrote:
>> Hi Ilya,
>>
>> On 12/14/2017 08:06 AM, Ilya Maximets wrote:
>>> On 13.12.2017 22:48, Michael S. Tsirkin wrote:
>>>> On Wed, Dec 13, 2017 at 04:45:20PM +0300, Ilya Maximets wrote:
>>>>>>> That
>>>>>>> looks very strange. Some of the functions gets 'old_status', othe=
rs
>>>>>>> the 'new_status'. I'm a bit confused.
>>>>>>
>>>>>> OK, fair enough. Fixed - let's pass old status everywhere,
>>>>>> users that need the new one can get it from the vdev.
>>>>>>
>>>>>>> And it's not functional in current state:
>>>>>>>
>>>>>>> hw/net/virtio-net.c:264:28: error: =E2=80=98status=E2=80=99 undec=
lared
>>>>>>
>>>>>> Fixed too. new version below.
>>>>>
>>>>> This doesn't fix the segmentation fault.
>>>>
>>>> Hmm you are right. Looking into it.
>>>>
>>>>> I have exactly same crash stacktrace:
>>>>>
>>>>> #0=C2=A0 vhost_memory_unmap hw/virtio/vhost.c:446
>>>>> #1=C2=A0 vhost_virtqueue_stop hw/virtio/vhost.c:1155
>>>>> #2=C2=A0 vhost_dev_stop hw/virtio/vhost.c:1594
>>>>> #3=C2=A0 vhost_net_stop_one hw/net/vhost_net.c:289
>>>>> #4=C2=A0 vhost_net_stop hw/net/vhost_net.c:368
>>>>> #5=C2=A0 virtio_net_vhost_status (old_status=3D15 '\017', n=3D0x562=
5f3901100) at hw/net/virtio-net.c:180
>>>>> #6=C2=A0 virtio_net_set_status (vdev=3D0x5625f3901100, old_status=3D=
<optimized out>) at hw/net/virtio-net.c:254
>>>>> #7=C2=A0 virtio_set_status (vdev=3Dvdev@entry=3D0x5625f3901100, val=
=3D<optimized out>) at hw/virtio/virtio.c:1152
>>>>> #8=C2=A0 virtio_error (vdev=3D0x5625f3901100, fmt=3Dfmt@entry=3D0x5=
625f014f688 "Guest says index %u is available") at hw/virtio/virtio.c:246=
0
>>>>
>>>> BTW what is causing this? Why is guest avail index corrupted?
>>>
>>> My testing environment for the issue:
>>>
>>> * QEMU 2.10.1
>>
>> Could you try to backport below patch and try again killing OVS?
>>
>> commit 2ae39a113af311cb56a0c35b7f212dafcef15303
>> Author: Maxime Coquelin <maxime.coquelin@redhat.com>
>> Date:=C2=A0=C2=A0 Thu Nov 16 19:48:35 2017 +0100
>>
>> =C2=A0=C2=A0=C2=A0 vhost: restore avail index from vring used index on=
 disconnection
>>
>> =C2=A0=C2=A0=C2=A0 vhost_virtqueue_stop() gets avail index value from =
the backend,
>> =C2=A0=C2=A0=C2=A0 except if the backend is not responding.
>>
>> =C2=A0=C2=A0=C2=A0 It happens when the backend crashes, and in this ca=
se, internal
>> =C2=A0=C2=A0=C2=A0 state of the virtio queue is inconsistent, making p=
ackets
>> =C2=A0=C2=A0=C2=A0 to corrupt the vring state.
>>
>> =C2=A0=C2=A0=C2=A0 With a Linux guest, it results in following error m=
essage on
>> =C2=A0=C2=A0=C2=A0 backend reconnection:
>>
>> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 22.444905] virtio_net virtio0: output=
.0:id 0 is not a head!
>> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 22.446746] net enp0s3: Unexpected TXQ=
 (0) queue failure: -5
>> =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 22.476360] net enp0s3: Unexpected TXQ=
 (0) queue failure: -5
>>
>> =C2=A0=C2=A0=C2=A0 Fixes: 283e2c2adcb8 ("net: virtio-net discards TX d=
ata after link down")
>> =C2=A0=C2=A0=C2=A0 Cc: qemu-stable@nongnu.org
>> =C2=A0=C2=A0=C2=A0 Signed-off-by: Maxime Coquelin <maxime.coquelin@red=
hat.com>
>> =C2=A0=C2=A0=C2=A0 Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> =C2=A0=C2=A0=C2=A0 Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> commit 2d4ba6cc741df15df6fbb4feaa706a02e103083a
>> Author: Maxime Coquelin <maxime.coquelin@redhat.com>
>> Date:=C2=A0=C2=A0 Thu Nov 16 19:48:34 2017 +0100
>>
>> =C2=A0=C2=A0=C2=A0 virtio: Add queue interface to restore avail index =
from vring used index
>>
>> =C2=A0=C2=A0=C2=A0 In case of backend crash, it is not possible to res=
tore internal
>> =C2=A0=C2=A0=C2=A0 avail index from the backend value as vhost_get_vri=
ng_base
>> =C2=A0=C2=A0=C2=A0 callback fails.
>>
>> =C2=A0=C2=A0=C2=A0 This patch provides a new interface to restore inte=
rnal avail index
>> =C2=A0=C2=A0=C2=A0 from the vring used index, as done by some vhost-us=
er backend on
>> =C2=A0=C2=A0=C2=A0 reconnection.
>>
>> =C2=A0=C2=A0=C2=A0 Signed-off-by: Maxime Coquelin <maxime.coquelin@red=
hat.com>
>> =C2=A0=C2=A0=C2=A0 Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> =C2=A0=C2=A0=C2=A0 Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>>
>> Cheers,
>> Maxime
>>
>>
>>
>=20
>=20
