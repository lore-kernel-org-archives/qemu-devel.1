Received: from eggs.gnu.org ([2001:4830:134:3::10]:59673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fFwsC-0000sz-78
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fFws8-00027l-U6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:17:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fFws8-000277-Hi
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:17:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w487Dilg130010
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 03:17:15 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hu53vda4k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:17:15 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 8 May 2018 08:17:12 +0100
References: <20180507155130.21085-1-cohuck@redhat.com>
	<20180507155130.21085-3-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 8 May 2018 09:17:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180507155130.21085-3-cohuck@redhat.com>
Content-Language: en-US
Message-Id: <2eead61e-420f-643c-363c-151f5a066268@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/2] s390x/ccw: make sure all
 ccw devices are properly reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

ACK.

cc stable?



On 05/07/2018 05:51 PM, Cornelia Huck wrote:
> Thomas reported that the subchannel for a  3270 device that ended up
> in a broken state (status pending even though not enabled) did not
> get out of that state even after a reboot (which involves a subsytem
> reset). The reason for this is that the 3270 device did not define
> a reset handler.
> 
> Let's fix this by introducing a base reset handler (set up for all
> ccw devices) that resets the subchannel and have virtio-ccw call
> its virtio-specific reset procedure in addition to that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/ccw-device.c | 8 ++++++++
>  hw/s390x/virtio-ccw.c | 9 ++++++---
>  hw/s390x/virtio-ccw.h | 1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index f9bfa154d6..7cd73df4aa 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -40,6 +40,13 @@ static Property ccw_device_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static void ccw_device_reset(DeviceState *d)
> +{
> +    CcwDevice *ccw_dev = CCW_DEVICE(d);
> +
> +    css_reset_sch(ccw_dev->sch);
> +}
> +
>  static void ccw_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -48,6 +55,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
>      k->realize = ccw_device_realize;
>      k->refill_ids = ccw_device_refill_ids;
>      dc->props = ccw_device_properties;
> +    dc->reset = ccw_device_reset;
>  }
>  
>  const VMStateDescription vmstate_ccw_dev = {
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 40a33302a7..22df33b509 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1058,10 +1058,12 @@ static void virtio_ccw_reset(DeviceState *d)
>  {
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
>      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
> -    CcwDevice *ccw_dev = CCW_DEVICE(d);
> +    VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>  
>      virtio_ccw_reset_virtio(dev, vdev);
> -    css_reset_sch(ccw_dev->sch);
> +    if (vdc->parent_reset) {
> +        vdc->parent_reset(d);
> +    }
>  }
>  
>  static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
> @@ -1715,12 +1717,13 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      CCWDeviceClass *k = CCW_DEVICE_CLASS(dc);
> +    VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_CLASS(klass);
>  
>      k->unplug = virtio_ccw_busdev_unplug;
>      dc->realize = virtio_ccw_busdev_realize;
>      dc->unrealize = virtio_ccw_busdev_unrealize;
>      dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
> -    dc->reset = virtio_ccw_reset;
> +    device_class_set_parent_reset(dc, virtio_ccw_reset, &vdc->parent_reset);
>  }
>  
>  static const TypeInfo virtio_ccw_device_info = {
> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> index 2fc513001e..3453aa1f98 100644
> --- a/hw/s390x/virtio-ccw.h
> +++ b/hw/s390x/virtio-ccw.h
> @@ -77,6 +77,7 @@ typedef struct VirtIOCCWDeviceClass {
>      CCWDeviceClass parent_class;
>      void (*realize)(VirtioCcwDevice *dev, Error **errp);
>      void (*unrealize)(VirtioCcwDevice *dev, Error **errp);
> +    void (*parent_reset)(DeviceState *dev);
>  } VirtIOCCWDeviceClass;
>  
>  /* Performance improves when virtqueue kick processing is decoupled from the
> 
