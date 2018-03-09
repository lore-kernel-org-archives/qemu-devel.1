Received: from eggs.gnu.org ([2001:4830:134:3::10]:46948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1euEFw-00026h-8d
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1euEFr-0000qK-AY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:24:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58978
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1euEFr-0000pm-3q
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:23:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w299NucO123318
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 04:23:56 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gkkybg25x-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 04:23:37 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 09:23:35 -0000
References: <20180307162958.11232-1-nia.alarie@gmail.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 9 Mar 2018 10:23:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180307162958.11232-1-nia.alarie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9fdc51f3-edcb-1811-2501-da1e17e52c97@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/virtio: Convert virtio-ccw from
 *_exit to *_unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org
Cc: jim@groklearning.com, stefanha@gmail.com, cohuck@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, joel@jms.id.au

On 07/03/2018 17:29, Nia Alarie wrote:
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>

What you do seems right to me, naming seems more logical, but=C2=A0 can y=
ou=20
please
add a little commit message explaining why you change the interface?

Thanks,

Pierre

> ---
>   hw/s390x/virtio-ccw.c | 34 +++++++++++++++++-----------------
>   hw/s390x/virtio-ccw.h |  2 +-
>   2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 8f7fbc2ab7..e51fbefd23 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -752,7 +752,7 @@ out_err:
>       g_free(sch);
>   }
>
> -static int virtio_ccw_exit(VirtioCcwDevice *dev)
> +static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
>   {
>       CcwDevice *ccw_dev =3D CCW_DEVICE(dev);
>       SubchDev *sch =3D ccw_dev->sch;
> @@ -760,12 +760,12 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>       if (sch) {
>           css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devn=
o, NULL);
>           g_free(sch);
> +        ccw_dev->sch =3D NULL;
>       }
>       if (dev->indicators) {
>           release_indicator(&dev->routes.adapter, dev->indicators);
>           dev->indicators =3D NULL;
>       }
> -    return 0;
>   }
>
>   static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **=
errp)
> @@ -1344,7 +1344,7 @@ static void virtio_ccw_net_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_net_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_net_properties;
>       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> @@ -1372,7 +1372,7 @@ static void virtio_ccw_blk_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_blk_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_blk_properties;
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> @@ -1400,7 +1400,7 @@ static void virtio_ccw_serial_class_init(ObjectCl=
ass *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_serial_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_serial_properties;
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> @@ -1428,7 +1428,7 @@ static void virtio_ccw_balloon_class_init(ObjectC=
lass *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_balloon_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_balloon_properties;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -1456,7 +1456,7 @@ static void virtio_ccw_scsi_class_init(ObjectClas=
s *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_scsi_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_scsi_properties;
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> @@ -1483,7 +1483,7 @@ static void vhost_ccw_scsi_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D vhost_ccw_scsi_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D vhost_ccw_scsi_properties;
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> @@ -1520,7 +1520,7 @@ static void virtio_ccw_rng_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_rng_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_rng_properties;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -1558,7 +1558,7 @@ static void virtio_ccw_crypto_class_init(ObjectCl=
ass *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_crypto_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_crypto_properties;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -1596,7 +1596,7 @@ static void virtio_ccw_gpu_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_gpu_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_gpu_properties;
>       dc->hotpluggable =3D false;
> @@ -1625,7 +1625,7 @@ static void virtio_ccw_input_class_init(ObjectCla=
ss *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D virtio_ccw_input_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_input_properties;
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> @@ -1705,12 +1705,12 @@ static void virtio_ccw_busdev_realize(DeviceSta=
te *dev, Error **errp)
>       virtio_ccw_device_realize(_dev, errp);
>   }
>
> -static int virtio_ccw_busdev_exit(DeviceState *dev)
> +static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp=
)
>   {
>       VirtioCcwDevice *_dev =3D (VirtioCcwDevice *)dev;
>       VirtIOCCWDeviceClass *_info =3D VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>
> -    return _info->exit(_dev);
> +    _info->unrealize(_dev, errp);
>   }
>
>   static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
> @@ -1728,7 +1728,7 @@ static void virtio_ccw_device_class_init(ObjectCl=
ass *klass, void *data)
>
>       k->unplug =3D virtio_ccw_busdev_unplug;
>       dc->realize =3D virtio_ccw_busdev_realize;
> -    dc->exit =3D virtio_ccw_busdev_exit;
> +    dc->unrealize =3D virtio_ccw_busdev_unrealize;
>       dc->bus_type =3D TYPE_VIRTUAL_CSS_BUS;
>   }
>
> @@ -1804,7 +1804,7 @@ static void virtio_ccw_9p_class_init(ObjectClass =
*klass, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       k->realize =3D virtio_ccw_9p_realize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_9p_properties;
> @@ -1853,7 +1853,7 @@ static void vhost_vsock_ccw_class_init(ObjectClas=
s *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>
>       k->realize =3D vhost_vsock_ccw_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       dc->props =3D vhost_vsock_ccw_properties;
>       dc->reset =3D virtio_ccw_reset;
> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> index 3905f3a3d6..2fc513001e 100644
> --- a/hw/s390x/virtio-ccw.h
> +++ b/hw/s390x/virtio-ccw.h
> @@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
>   typedef struct VirtIOCCWDeviceClass {
>       CCWDeviceClass parent_class;
>       void (*realize)(VirtioCcwDevice *dev, Error **errp);
> -    int (*exit)(VirtioCcwDevice *dev);
> +    void (*unrealize)(VirtioCcwDevice *dev, Error **errp);
>   } VirtIOCCWDeviceClass;
>
>   /* Performance improves when virtqueue kick processing is decoupled f=
rom the


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
