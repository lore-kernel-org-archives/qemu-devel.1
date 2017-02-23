Received: from eggs.gnu.org ([2001:4830:134:3::10]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgpmv-0000is-D0
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgpmq-0007x9-Ci
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:34:13 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:46104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cgpmq-0007vw-6I
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:34:08 -0500
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E2E635A215
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:34:05 +0100 (CET)
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
	<c0d16fc6-e149-861d-8f82-5a96619606bd@redhat.com>
	<83a2d0c9-23a4-32b1-ffe7-b33bbe9ea25d@redhat.com>
	<726a3292-9e27-6748-9669-a7c21cbf3b6e@redhat.com>
	<20170222173225.4f48dd99@t450s.home>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <76987077-886a-5c6d-1291-c1734a5bc3b0@kaod.org>
Date: Thu, 23 Feb 2017 10:33:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170222173225.4f48dd99@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 12/23] virtio: use VRingMemoryRegionCaches
 for avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hello,

On 02/23/2017 01:32 AM, Alex Williamson wrote:
> On Wed, 22 Feb 2017 10:03:56 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 21/02/2017 18:54, Laszlo Ersek wrote:
>>> Actually, QEMU segfaults. From the dmesg:
>>>
>>> [Tue Feb 21 18:47:28 2017] CPU 0/KVM[8298]: segfault at 48 ip
>>> 00007fcb5dd02105 sp 00007fcb49efc270 error 4 in
>>> qemu-system-x86_64[7fcb5dae3000+905000]
>>>
>>> Complete backtrace below. (Thread 11 seems to be the one
>>> segfaulting.)  
>>
>> Indeed.  It's the virtio-blk device that is segfaulting, please try
>> this one liner (haven't reproduced it, but it seems obvious with the
>> backtrace and some sleep).
> 
> I hit this as well, the patch below resolves it.

I still have migration issues with this patch on ppc, which fails
on the target guest with : 

qemu-system-ppc64: VQ 0 size 0x80 < last_avail_idx 0xe1e - used_idx 0x0
qemu-system-ppc64: Failed to load virtio-blk:virtio
qemu-system-ppc64: error while loading state for instance 0x0 of device 'pci@800000020000000:01.0/virtio-blk'
qemu-system-ppc64: load of migration failed: Operation not permitted

Thanks,

C. 

> Tested-by: Alex Williamson <alex.williamson@redhat.com>
>  
>> commit c1aa478c7181c543606ca81404c59e126d66213d
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Wed Feb 22 10:02:37 2017 +0100
>>
>>     virtio: check for vring setup in virtio_queue_empty
>>     
>>     If the vring has not been set up, there is nothing in the virtqueue.
>>     virtio_queue_host_notifier_aio_poll calls virtio_queue_empty even in
>>     this case; we have to filter it out just like virtio_queue_notify_aio_vq.
>>     
>>     Reported-by: Gerd Hoffmann <kraxel@redhat.com>
>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 23483c7..e487e36 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2291,7 +2291,7 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>>      VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
>>      bool progress;
>>  
>> -    if (virtio_queue_empty(vq)) {
>> +    if (!vq->vring.desc || virtio_queue_empty(vq)) {
>>          return false;
>>      }
>>  
>>
> 
> 
