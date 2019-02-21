Received: from eggs.gnu.org ([209.51.188.92]:44873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gwl1o-0007GW-5w
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gwkql-0000Gl-Vb
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:41:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gwkql-000801-B2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:41:03 -0500
References: <20190213145116.20654-1-yuri.benditovich@daynix.com>
	<0801b4b7-ac54-1374-3d97-a59a10579218@redhat.com>
	<CAOEp5Od-1AY=6ARRD9J=W2ZhYqEgKpmMBMcm1fiqSCjLRVREyA@mail.gmail.com>
	<20190218113447-mutt-send-email-mst@kernel.org>
	<CAOEp5OdVUcXTXmEFYyU6iFxd--P+4o5wkAjOr76EUG6eEne+KA@mail.gmail.com>
	<20190218183353-mutt-send-email-mst@kernel.org>
	<3bcc9d51-a5ff-583a-a76d-e7cf9e19bba3@redhat.com>
	<CAOEp5Odi9pScvMnHcAOLz6tp3Yv6rzZSs-rsswBc_oE7VRMt+w@mail.gmail.com>
	<a5c4b4a1-ea82-f357-e076-ade51ade7ddf@redhat.com>
	<CAOEp5Ode1Ue0iLD4qUs+tcSGCZ+t+bm1TQpr3UG59jMU9kyVUg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e6ea2819-ca95-796c-44e9-0067af82c46a@redhat.com>
Date: Thu, 21 Feb 2019 17:40:22 +0800
MIME-Version: 1.0
In-Reply-To: <CAOEp5Ode1Ue0iLD4qUs+tcSGCZ+t+bm1TQpr3UG59jMU9kyVUg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


On 2019/2/21 =E4=B8=8B=E5=8D=884:18, Yuri Benditovich wrote:
>> For 1.0 device, we can fix the queue_enable, but for 0.9x device how d=
o
>> you enable one specific queue in this case? (setting status?)
>>
> Do I understand correctly that for 0.9 device in some cases the device =
will
> receive feature _MQ set, but will not receive VIRTIO_NET_CTRL_MQ_VQ_PAI=
RS_SET?
> Or the problem is different?


Let me clarify, VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET is used to control the=20
the number of queue pairs used by device for doing transmission and=20
reception. It was not used to enable or disable a virtqueue.

For 1.0 device, we should use queue_enable in pci cfg to enable and=20
disable queue:


We could do:

1) allocate memory and set queue_enable for vq0

2) allocate memory and set queue_enable for vq1

3) Set vq paris to 1

4) allocate memory and set queue_enable for vq2

5) allocate memory and set queue_enable for vq3

6) set vq pairs to 2


But this requires a proper implementation for queue_enable for vhost=20
which is missed in qemu and probably what you really want to do.

but for 0.9x device, there's no such way to do this. That's the issue.=20
So driver must allocate all queBes before starting the device, otherwise=20
there's no way to enable it afterwards. There're tricks to make it work=20
like what is done in your patch, but it depends on a specific=20
implementation like qemu which is sub-optimal.


>
>> A fundamental question is what prevents you from just initialization a=
ll
>> queues during driver start? It looks to me this save lots of efforts
>> than allocating queue dynamically.
>>
> This is not so trivial in Windows driver, as it does not have objects f=
or queues
> that it does not use. Linux driver first of all allocates all the
> queues and then
> adds Rx/Tx to those it will use. Windows driver first decides how many =
queues
> it will use then allocates objects for them and initializes them from z=
ero to
> fully functional state.


Well, you just need to allocate some memory for the virtqueue, there's=20
no need to make it visible to the rest until it was enabled.

Thanks


>
