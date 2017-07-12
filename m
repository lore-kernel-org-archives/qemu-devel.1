Received: from eggs.gnu.org ([2001:4830:134:3::10]:32994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVFGv-0004uw-Kx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVFGs-000235-JS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:33 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVFGs-00022c-Et
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:30 -0400
Received: by mail-vk0-f41.google.com with SMTP id y70so10378305vky.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 03:53:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170712095556.GC6923@stefanha-x1.localdomain>
References: <20170712080538.28010-1-lprosek@redhat.com>
	<20170712095556.GC6923@stefanha-x1.localdomain>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 12 Jul 2017 12:53:29 +0200
Message-ID: <CABdb736PVDoxnOGoX5+eESUeKC20m4oL2+A0X=-dS7ZbnmZLVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] virtio: enhance virtio_error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>

On Wed, Jul 12, 2017 at 11:55 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Wed, Jul 12, 2017 at 10:05:38AM +0200, Ladi Prosek wrote:
>> Output like "Virtqueue size exceeded" is not much useful in identifying the
>> culprit. This commit adds virtio device name and queue index to all error
>> messages in virtio.c to improve debuggability.
>>
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> ---
>>  hw/virtio/virtio.c | 74 +++++++++++++++++++++++++++++++++---------------------
>>  1 file changed, 46 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 464947f..5040f26 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -143,7 +143,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
>>      len = address_space_cache_init(&new->desc, vdev->dma_as,
>>                                     addr, size, false);
>>      if (len < size) {
>> -        virtio_error(vdev, "Cannot map desc");
>> +        virtio_error(vdev, "%s queue %u: Cannot map desc", vdev->name, n);
>
> Good idea!
>
> Please build the identifying information into virtio_error() to avoid
> code duplication.
>
> It probably makes sense to add a virtqueue_error(VirtIOQueue *vq, fmt,
> ...) function.  That way the virtqueue number printing doesn't need to
> be duplicated.

Makes sense, will do!

> vdev->name specifies the device type ("virtio-net", "virtio-9p") but
> does not uniquely identify the device instance.  If a guest has multiple
> virtio-net devices then the error message will not identify the device
> instance.  I think you can use DEVICE(vdev)->id instead to get the
> unique -device virtio-net-pci,id=vnet0 identifier.

I had tried this and couldn't get a good id for all devices. Maybe
it's a problem specific to scsi and serial, I'll look into it.

      dev: virtio-scsi-pci, id "vscsi"
        bus: virtio-bus
          dev: virtio-scsi-device, id ""

Thanks!
Ladi
