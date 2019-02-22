Received: from eggs.gnu.org ([209.51.188.92]:34927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gx199-00053A-CJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gx198-0007zt-4U
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:05:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gx197-0006yp-O3
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:05:06 -0500
References: <0801b4b7-ac54-1374-3d97-a59a10579218@redhat.com>
	<CAOEp5Od-1AY=6ARRD9J=W2ZhYqEgKpmMBMcm1fiqSCjLRVREyA@mail.gmail.com>
	<20190218113447-mutt-send-email-mst@kernel.org>
	<CAOEp5OdVUcXTXmEFYyU6iFxd--P+4o5wkAjOr76EUG6eEne+KA@mail.gmail.com>
	<20190218183353-mutt-send-email-mst@kernel.org>
	<3bcc9d51-a5ff-583a-a76d-e7cf9e19bba3@redhat.com>
	<CAOEp5Odi9pScvMnHcAOLz6tp3Yv6rzZSs-rsswBc_oE7VRMt+w@mail.gmail.com>
	<a5c4b4a1-ea82-f357-e076-ade51ade7ddf@redhat.com>
	<CAOEp5Ode1Ue0iLD4qUs+tcSGCZ+t+bm1TQpr3UG59jMU9kyVUg@mail.gmail.com>
	<e6ea2819-ca95-796c-44e9-0067af82c46a@redhat.com>
	<20190221203003-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <51f52046-a491-bd87-a72d-138197012675@redhat.com>
Date: Fri, 22 Feb 2019 11:04:05 +0800
MIME-Version: 1.0
In-Reply-To: <20190221203003-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: do not start queues that are
 not enabled by the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org


On 2019/2/22 =E4=B8=8A=E5=8D=889:35, Michael S. Tsirkin wrote:
> On Thu, Feb 21, 2019 at 05:40:22PM +0800, Jason Wang wrote:
>> On 2019/2/21 =E4=B8=8B=E5=8D=884:18, Yuri Benditovich wrote:
>>
>>          For 1.0 device, we can fix the queue_enable, but for 0.9x dev=
ice how do
>>          you enable one specific queue in this case? (setting status?)
>>
>>
>>      Do I understand correctly that for 0.9 device in some cases the d=
evice will
>>      receive feature _MQ set, but will not receive VIRTIO_NET_CTRL_MQ_=
VQ_PAIRS_SET?
>>      Or the problem is different?
>>
>>
>> Let me clarify, VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET is used to control the=
 the
>> number of queue pairs used by device for doing transmission and recept=
ion. It
>> was not used to enable or disable a virtqueue.
>>
>> For 1.0 device, we should use queue_enable in pci cfg to enable and di=
sable
>> queue:
>>
>>
>> We could do:
>>
>> 1) allocate memory and set queue_enable for vq0
>>
>> 2) allocate memory and set queue_enable for vq1
>>
>> 3) Set vq paris to 1
>>
>> 4) allocate memory and set queue_enable for vq2
>>
>> 5) allocate memory and set queue_enable for vq3
>>
>> 6) set vq pairs to 2
>
> I do not think spec allows this.
>
>
> The driver MUST follow this sequence to initialize a device:
> 1. Reset the device.
> 2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
> 3. Set the DRIVER status bit: the guest OS knows how to drive the devic=
e.
> 4. Read device feature bits, and write the subset of feature bits under=
stood by the OS and driver to the
> device. During this step the driver MAY read (but MUST NOT write) the d=
evice-specific configuration
> fields to check that it can support the device before accepting it.
> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new featu=
re bits after this step.
> 6. Re-read device status to ensure the FEATURES_OK bit is still set: ot=
herwise, the device does not
> support our subset of features and the device is unusable.
> 7. Perform device-specific setup, including discovery of virtqueues for=
 the device, optional per-bus setup,
> reading and possibly writing the device=E2=80=99s virtio configuration =
space, and population of virtqueues.
> 8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9Cl=
ive=E2=80=9D.
>
>
> Thus vqs are setup at step 7.
>
> # of vq pairs are set up through a command which is a special
> buffer, and spec says:
>
> The driver MUST NOT send any buffer available notifications to the devi=
ce before setting DRIVER_OK.


So you meant write to queue_enable is forbidden after DRIVER_OK (though=20
it's not very clear to me from the=C2=A0 spec). And if a driver want to=20
enable new queues, it must reset the device?


>
>
>> But this requires a proper implementation for queue_enable for vhost w=
hich is
>> missed in qemu and probably what you really want to do.
>>
>> but for 0.9x device, there's no such way to do this. That's the issue.
> 0.9x there's no queue enable, assumption is PA!=3D0 means VQ has
> been enabled.
>
>
>> So
>> driver must allocate all queBes before starting the device, otherwise =
there's
>> no way to enable it afterwards.
>
> As per spec queues must be allocated before DRIVER_OK.
>
> That is universal.


If I understand correctly, this is not what is done by current windows=20
drivers.

Thanks


>
>> There're tricks to make it work like what is
>> done in your patch, but it depends on a specific implementation like q=
emu which
>> is sub-optimal.
>>
>>
>>
>>
>>          A fundamental question is what prevents you from just initial=
ization all
>>          queues during driver start? It looks to me this save lots of =
efforts
>>          than allocating queue dynamically.
>>
>>
>>      This is not so trivial in Windows driver, as it does not have obj=
ects for queues
>>      that it does not use. Linux driver first of all allocates all the
>>      queues and then
>>      adds Rx/Tx to those it will use. Windows driver first decides how=
 many queues
>>      it will use then allocates objects for them and initializes them =
from zero to
>>      fully functional state.
>>
>>
>> Well, you just need to allocate some memory for the virtqueue, there's=
 no need
>> to make it visible to the rest until it was enabled.
>>
>> Thanks
>>
>>
>>
>>
