Received: from eggs.gnu.org ([209.51.188.92]:48798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwzkq-0006cd-OH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 20:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwzkf-0004dl-5Q
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 20:35:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwzke-00040q-6k
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 20:35:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so816769qta.7
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 17:35:10 -0800 (PST)
Date: Thu, 21 Feb 2019 20:35:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190221203003-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6ea2819-ca95-796c-44e9-0067af82c46a@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org

On Thu, Feb 21, 2019 at 05:40:22PM +0800, Jason Wang wrote:
> 
> On 2019/2/21 下午4:18, Yuri Benditovich wrote:
> 
>         For 1.0 device, we can fix the queue_enable, but for 0.9x device how do
>         you enable one specific queue in this case? (setting status?)
> 
> 
>     Do I understand correctly that for 0.9 device in some cases the device will
>     receive feature _MQ set, but will not receive VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET?
>     Or the problem is different?
> 
> 
> Let me clarify, VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET is used to control the the
> number of queue pairs used by device for doing transmission and reception. It
> was not used to enable or disable a virtqueue.
> 
> For 1.0 device, we should use queue_enable in pci cfg to enable and disable
> queue:
> 
> 
> We could do:
> 
> 1) allocate memory and set queue_enable for vq0
> 
> 2) allocate memory and set queue_enable for vq1
> 
> 3) Set vq paris to 1
> 
> 4) allocate memory and set queue_enable for vq2
> 
> 5) allocate memory and set queue_enable for vq3
> 
> 6) set vq pairs to 2


I do not think spec allows this.


The driver MUST follow this sequence to initialize a device:
1. Reset the device.
2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
3. Set the DRIVER status bit: the guest OS knows how to drive the device.
4. Read device feature bits, and write the subset of feature bits understood by the OS and driver to the
device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration
fields to check that it can support the device before accepting it.
5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step.
6. Re-read device status to ensure the FEATURES_OK bit is still set: otherwise, the device does not
support our subset of features and the device is unusable.
7. Perform device-specific setup, including discovery of virtqueues for the device, optional per-bus setup,
reading and possibly writing the device’s virtio configuration space, and population of virtqueues.
8. Set the DRIVER_OK status bit. At this point the device is “live”.


Thus vqs are setup at step 7.

# of vq pairs are set up through a command which is a special
buffer, and spec says:

The driver MUST NOT send any buffer available notifications to the device before setting DRIVER_OK.


> 
> But this requires a proper implementation for queue_enable for vhost which is
> missed in qemu and probably what you really want to do.
> 
> but for 0.9x device, there's no such way to do this. That's the issue.

0.9x there's no queue enable, assumption is PA!=0 means VQ has
been enabled.


> So
> driver must allocate all queBes before starting the device, otherwise there's
> no way to enable it afterwards.


As per spec queues must be allocated before DRIVER_OK.

That is universal.


> There're tricks to make it work like what is
> done in your patch, but it depends on a specific implementation like qemu which
> is sub-optimal.
> 
> 
> 
> 
>         A fundamental question is what prevents you from just initialization all
>         queues during driver start? It looks to me this save lots of efforts
>         than allocating queue dynamically.
> 
> 
>     This is not so trivial in Windows driver, as it does not have objects for queues
>     that it does not use. Linux driver first of all allocates all the
>     queues and then
>     adds Rx/Tx to those it will use. Windows driver first decides how many queues
>     it will use then allocates objects for them and initializes them from zero to
>     fully functional state.
> 
> 
> Well, you just need to allocate some memory for the virtqueue, there's no need
> to make it visible to the rest until it was enabled.
> 
> Thanks
> 
> 
> 
> 
