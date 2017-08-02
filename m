Received: from eggs.gnu.org ([2001:4830:134:3::10]:48479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dcsps-0007D5-80
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dcspp-00067s-2T
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:33:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40617
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dcspo-00067h-TM
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:33:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v72CTBBl102343
	for <qemu-devel@nongnu.org>; Wed, 2 Aug 2017 08:33:06 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c385nv922-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 08:33:05 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 2 Aug 2017 13:33:04 +0100
References: <20170801230155.21083-1-ehabkost@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 2 Aug 2017 14:33:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170801230155.21083-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <61e65941-a035-a1fd-4a09-3dc54aac7354@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Mark virtio-device as
 non-user-creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 08/02/2017 01:01 AM, Eduardo Habkost wrote:
> TYPE_VIRTIO_DEVICE devices are already not usable with -device
> and device_add, but they are reported as user-creatable on
> "-device help" and through monitor interfaces.

I've tried -device virtio-rng on s390x and from what I see, it
seems we 'auto-magically' create the 'controlling' virtio-rng-ccw
device. So I have to ask what do you mean by 'already not usable'?

> 
> Mark them as not user-creatable to avoid confusing users, and to
> allow automated testing (e.g. scripts/device-crash-test) to skip
> them.
> 
> Before this patch, device-crash-test will try to test
> virtio-device devices with all machine-types:
> 
>   $ time ./scripts/device-crash-test -D virtio-device -v ./x86_64-softmmu/qemu-system-x86_64
>   [...]
>   INFO: Total: 1088 test cases
>   INFO: Skipped 408 test cases
> 
>   real    0m49.775s
> 
> After this patch, the script won't try to test virtio-device
> devices:
> 
>   $ time ./scripts/device-crash-test -D virtio-device -v ./x86_64-softmmu/qemu-system-x86_64
>   INFO: Total: 0 test cases
> 
>   real    0m0.092s
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/virtio/virtio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 464947f..c4bdb94 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2653,6 +2653,17 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>      dc->unrealize = virtio_device_unrealize;
>      dc->bus_type = TYPE_VIRTIO_BUS;
>      dc->props = virtio_properties;
> +    /*
> +     * Reason:
> +     * - TYPE_VIRTIO_DEVICE devices are not visible to guests
> +     *   unless they are created and controlled by transport-specific
> +     *   devices (virtio-pci, virtio-mmio, and virtio-ccw).
> +     * - A TYPE_VIRTIO_BUS bus is never available for plugging
> +     *   using -device/device_add, as virtio-bus buses are
> +     *   created on the fly and immediately populated by the
> +     *   transport-specific devices' realize methods.
> +     */
> +    dc->user_creatable = false;
>      vdc->start_ioeventfd = virtio_device_start_ioeventfd_impl;
>      vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
> 
