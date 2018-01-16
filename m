Received: from eggs.gnu.org ([2001:4830:134:3::10]:39478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ebRUl-0005yu-5l
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ebRUe-0007ps-Mp
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:41:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1ebRUe-0007oZ-EB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:41:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GDdGk5125293
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:41:34 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fhjf4g4x3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:41:33 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 06:41:32 -0700
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-6-f4bug@amsat.org>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 08:41:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180116131555.14242-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <21f570e0-eae6-e93d-c011-4742d777d843@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] virtio-ccw: convert
 VirtIOCCWDeviceClass::init -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

shouldn't the commit message say exit -> unrealize?


Thanks
Farhan

On 01/16/2018 08:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/s390x/virtio-ccw.h |  2 +-
>   hw/s390x/virtio-ccw.c | 35 +++++++++++++++++------------------
>   2 files changed, 18 insertions(+), 19 deletions(-)
>=20
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
>=20
>   /* Performance improves when virtqueue kick processing is decoupled f=
rom the
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 38f6a8afc9..a71c3feeb5 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -751,7 +751,7 @@ out_err:
>       g_free(sch);
>   }
>=20
> -static int virtio_ccw_exit(VirtioCcwDevice *dev)
> +static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
>   {
>       CcwDevice *ccw_dev =3D CCW_DEVICE(dev);
>       SubchDev *sch =3D ccw_dev->sch;
> @@ -764,7 +764,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>           release_indicator(&dev->routes.adapter, dev->indicators);
>           dev->indicators =3D NULL;
>       }
> -    return 0;
>   }
>=20
>   static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **=
errp)
> @@ -1343,7 +1342,7 @@ static void virtio_ccw_net_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_net_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_net_properties;
>       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> @@ -1371,7 +1370,7 @@ static void virtio_ccw_blk_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_blk_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_blk_properties;
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> @@ -1399,7 +1398,7 @@ static void virtio_ccw_serial_class_init(ObjectCl=
ass *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_serial_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_serial_properties;
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> @@ -1427,7 +1426,7 @@ static void virtio_ccw_balloon_class_init(ObjectC=
lass *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_balloon_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_balloon_properties;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -1455,7 +1454,7 @@ static void virtio_ccw_scsi_class_init(ObjectClas=
s *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_scsi_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_scsi_properties;
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> @@ -1482,7 +1481,7 @@ static void vhost_ccw_scsi_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D vhost_ccw_scsi_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D vhost_ccw_scsi_properties;
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> @@ -1519,7 +1518,7 @@ static void virtio_ccw_rng_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_rng_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_rng_properties;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -1557,7 +1556,7 @@ static void virtio_ccw_crypto_class_init(ObjectCl=
ass *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_crypto_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_crypto_properties;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -1595,7 +1594,7 @@ static void virtio_ccw_gpu_class_init(ObjectClass=
 *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_gpu_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_gpu_properties;
>       dc->hotpluggable =3D false;
> @@ -1624,7 +1623,7 @@ static void virtio_ccw_input_class_init(ObjectCla=
ss *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D virtio_ccw_input_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_input_properties;
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> @@ -1704,12 +1703,12 @@ static void virtio_ccw_busdev_realize(DeviceSta=
te *dev, Error **errp)
>       virtio_ccw_device_realize(_dev, errp);
>   }
>=20
> -static int virtio_ccw_busdev_exit(DeviceState *dev)
> +static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp=
)
>   {
>       VirtioCcwDevice *_dev =3D (VirtioCcwDevice *)dev;
> -    VirtIOCCWDeviceClass *_info =3D VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> +    VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>=20
> -    return _info->exit(_dev);
> +    k->unrealize(_dev, errp);
>   }
>=20
>   static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
> @@ -1727,7 +1726,7 @@ static void virtio_ccw_device_class_init(ObjectCl=
ass *klass, void *data)
>=20
>       k->unplug =3D virtio_ccw_busdev_unplug;
>       dc->realize =3D virtio_ccw_busdev_realize;
> -    dc->exit =3D virtio_ccw_busdev_exit;
> +    dc->unrealize =3D virtio_ccw_busdev_unrealize;
>       dc->bus_type =3D TYPE_VIRTUAL_CSS_BUS;
>   }
>=20
> @@ -1803,7 +1802,7 @@ static void virtio_ccw_9p_class_init(ObjectClass =
*klass, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       k->realize =3D virtio_ccw_9p_realize;
>       dc->reset =3D virtio_ccw_reset;
>       dc->props =3D virtio_ccw_9p_properties;
> @@ -1852,7 +1851,7 @@ static void vhost_vsock_ccw_class_init(ObjectClas=
s *klass, void *data)
>       VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
>=20
>       k->realize =3D vhost_vsock_ccw_realize;
> -    k->exit =3D virtio_ccw_exit;
> +    k->unrealize =3D virtio_ccw_unrealize;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       dc->props =3D vhost_vsock_ccw_properties;
>       dc->reset =3D virtio_ccw_reset;
>=20
