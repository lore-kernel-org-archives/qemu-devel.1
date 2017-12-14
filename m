Received: from eggs.gnu.org ([2001:4830:134:3::10]:39553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ePPOx-00030L-At
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ePPOu-0007iC-35
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:01:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ePPOt-0007hC-R1
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:01:56 -0500
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
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <cdf7bc7a-8ecd-73e7-1129-67c38ab6095d@redhat.com>
Date: Thu, 14 Dec 2017 10:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <0e3648df-6aa2-f3e1-5ae6-14fb01d7b476@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Ilya Maximets <i.maximets@samsung.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Heetae Ahn <heetae82.ahn@samsung.com>

Hi Ilya,

On 12/14/2017 08:06 AM, Ilya Maximets wrote:
> On 13.12.2017 22:48, Michael S. Tsirkin wrote:
>> On Wed, Dec 13, 2017 at 04:45:20PM +0300, Ilya Maximets wrote:
>>>>> That
>>>>> looks very strange. Some of the functions gets 'old_status', others
>>>>> the 'new_status'. I'm a bit confused.
>>>>
>>>> OK, fair enough. Fixed - let's pass old status everywhere,
>>>> users that need the new one can get it from the vdev.
>>>>
>>>>> And it's not functional in current state:
>>>>>
>>>>> hw/net/virtio-net.c:264:28: error: =E2=80=98status=E2=80=99 undecla=
red
>>>>
>>>> Fixed too. new version below.
>>>
>>> This doesn't fix the segmentation fault.
>>
>> Hmm you are right. Looking into it.
>>
>>> I have exactly same crash stacktrace:
>>>
>>> #0  vhost_memory_unmap hw/virtio/vhost.c:446
>>> #1  vhost_virtqueue_stop hw/virtio/vhost.c:1155
>>> #2  vhost_dev_stop hw/virtio/vhost.c:1594
>>> #3  vhost_net_stop_one hw/net/vhost_net.c:289
>>> #4  vhost_net_stop hw/net/vhost_net.c:368
>>> #5  virtio_net_vhost_status (old_status=3D15 '\017', n=3D0x5625f39011=
00) at hw/net/virtio-net.c:180
>>> #6  virtio_net_set_status (vdev=3D0x5625f3901100, old_status=3D<optim=
ized out>) at hw/net/virtio-net.c:254
>>> #7  virtio_set_status (vdev=3Dvdev@entry=3D0x5625f3901100, val=3D<opt=
imized out>) at hw/virtio/virtio.c:1152
>>> #8  virtio_error (vdev=3D0x5625f3901100, fmt=3Dfmt@entry=3D0x5625f014=
f688 "Guest says index %u is available") at hw/virtio/virtio.c:2460
>>
>> BTW what is causing this? Why is guest avail index corrupted?
>=20
> My testing environment for the issue:
>=20
> * QEMU 2.10.1

Could you try to backport below patch and try again killing OVS?

commit 2ae39a113af311cb56a0c35b7f212dafcef15303
Author: Maxime Coquelin <maxime.coquelin@redhat.com>
Date:   Thu Nov 16 19:48:35 2017 +0100

     vhost: restore avail index from vring used index on disconnection

     vhost_virtqueue_stop() gets avail index value from the backend,
     except if the backend is not responding.

     It happens when the backend crashes, and in this case, internal
     state of the virtio queue is inconsistent, making packets
     to corrupt the vring state.

     With a Linux guest, it results in following error message on
     backend reconnection:

     [   22.444905] virtio_net virtio0: output.0:id 0 is not a head!
     [   22.446746] net enp0s3: Unexpected TXQ (0) queue failure: -5
     [   22.476360] net enp0s3: Unexpected TXQ (0) queue failure: -5

     Fixes: 283e2c2adcb8 ("net: virtio-net discards TX data after link=20
down")
     Cc: qemu-stable@nongnu.org
     Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

commit 2d4ba6cc741df15df6fbb4feaa706a02e103083a
Author: Maxime Coquelin <maxime.coquelin@redhat.com>
Date:   Thu Nov 16 19:48:34 2017 +0100

     virtio: Add queue interface to restore avail index from vring used=20
index

     In case of backend crash, it is not possible to restore internal
     avail index from the backend value as vhost_get_vring_base
     callback fails.

     This patch provides a new interface to restore internal avail index
     from the vring used index, as done by some vhost-user backend on
     reconnection.

     Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Cheers,
Maxime
