Received: from eggs.gnu.org ([2001:4830:134:3::10]:44710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7zSY-0006gB-9L
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1g7zSM-0003Yn-HB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:58:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1g7zSK-0003WS-Fo
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:58:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w948uSLj102400
	for <qemu-devel@nongnu.org>; Thu, 4 Oct 2018 04:57:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mwd7e6jdj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:57:58 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 4 Oct 2018 09:57:55 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-5-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 4 Oct 2018 10:57:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180926225440.6204-5-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d6f4a7fc-595c-f96f-2d79-8147c06b4daf@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 4/6] s390x/ap: base Adjunct Processor
 (AP) object model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 27/09/2018 00:54, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
>=20
> Introduces the base object model for virtualizing AP devices.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   MAINTAINERS                  | 12 ++++++
>   hw/s390x/Makefile.objs       |  2 +
>   hw/s390x/ap-bridge.c         | 81 +++++++++++++++++++++++++++++++++++=
+
>   hw/s390x/ap-device.c         | 39 +++++++++++++++++
>   hw/s390x/s390-virtio-ccw.c   |  4 ++
>   include/hw/s390x/ap-bridge.h | 37 ++++++++++++++++
>   include/hw/s390x/ap-device.h | 38 +++++++++++++++++
>   7 files changed, 213 insertions(+)
>   create mode 100644 hw/s390x/ap-bridge.c
>   create mode 100644 hw/s390x/ap-device.c
>   create mode 100644 include/hw/s390x/ap-bridge.h
>   create mode 100644 include/hw/s390x/ap-device.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d12518c08f10..97e8ed808bc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1199,6 +1199,18 @@ F: include/hw/s390x/s390-ccw.h
>   T: git git://github.com/cohuck/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>=20
> +vfio-ap
> +M: Christian Borntraeger <borntraeger@de.ibm.com>
> +M: Tony Krowiak <akrowiak@linux.ibm.com>
> +M: Halil Pasic <pasic@linux.ibm.com>
> +M: Pierre Morel <pmorel@linux.ibm.com>
> +S: Supported
> +F: hw/s390x/ap-device.c
> +F: hw/s390x/ap-bridge.c
> +F: include/hw/s390x/ap-device.h
> +F: include/hw/s390x/ap-bridge.h
> +L: qemu-s390x@nongnu.org
> +
>   vhost
>   M: Michael S. Tsirkin <mst@redhat.com>
>   S: Supported
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 93282f7c593c..add89b150d90 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -20,3 +20,5 @@ obj-$(CONFIG_TCG) +=3D tod-qemu.o
>   obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>   obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
>   obj-y +=3D s390-ccw.o
> +obj-y +=3D ap-device.o
> +obj-y +=3D ap-bridge.o
> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
> new file mode 100644
> index 000000000000..8564dfa96ee7
> --- /dev/null
> +++ b/hw/s390x/ap-bridge.c
> @@ -0,0 +1,81 @@
> +/*
> + * ap bridge
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Halil Pasic <pasic@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "qemu/bitops.h"
> +#include "hw/s390x/ap-bridge.h"
> +#include "cpu.h"
> +
> +static char *vfio_ap_bus_get_dev_path(DeviceState *dev)
> +{
> +    /* at most one */
> +    return g_strdup_printf("/1");
> +}
> +
> +static void vfio_ap_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *k =3D BUS_CLASS(klass);
> +
> +    k->get_dev_path =3D vfio_ap_bus_get_dev_path;
> +    /* More than one vfio-ap device does not make sense */
> +    k->max_dev =3D 1;
> +}
> +
> +static const TypeInfo vfio_ap_bus_info =3D {
> +    .name =3D TYPE_AP_BUS,
> +    .parent =3D TYPE_BUS,
> +    .instance_size =3D sizeof(APBus),
> +    .class_init =3D vfio_ap_bus_class_init,
> +};
> +
> +void s390_init_ap(void)
> +{
> +    DeviceState *dev;
> +
> +    /* If no AP instructions then no need for AP bridge */
> +    if (!s390_has_feat(S390_FEAT_AP)) {
> +        return;
> +    }
> +
> +    /* Create bridge device */
> +    dev =3D qdev_create(NULL, TYPE_AP_BRIDGE);
> +    object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
> +                              OBJECT(dev), NULL);
> +    qdev_init_nofail(dev);
> +
> +    /* Create bus on bridge device */
> +    qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
> + }
> +
> +
> +
> +static void ap_bridge_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +}
> +
> +static const TypeInfo ap_bridge_info =3D {
> +    .name          =3D TYPE_AP_BRIDGE,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(APBridge),
> +    .class_init    =3D ap_bridge_class_init,
> +};
> +
> +static void ap_register(void)
> +{
> +    type_register_static(&ap_bridge_info);
> +    type_register_static(&vfio_ap_bus_info);
> +}
> +
> +type_init(ap_register)
> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
> new file mode 100644
> index 000000000000..3cd4bae52591
> --- /dev/null
> +++ b/hw/s390x/ap-device.c
> @@ -0,0 +1,39 @@
> +/*
> + * Adjunct Processor (AP) matrix device
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/qdev.h"
> +#include "hw/s390x/ap-device.h"
> +
> +static void ap_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "AP device class";
> +    dc->hotpluggable =3D false;
> +}
> +
> +static const TypeInfo ap_device_info =3D {
> +    .name =3D AP_DEVICE_TYPE,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(APDevice),
> +    .class_size =3D sizeof(APDeviceClass),
> +    .class_init =3D ap_class_init,
> +    .abstract =3D true,
> +};
> +
> +static void ap_device_register(void)
> +{
> +    type_register_static(&ap_device_info);
> +}
> +
> +type_init(ap_device_register)
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index f0f7fdcaddf2..3c100c24f3e8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -32,6 +32,7 @@
>   #include "ipl.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "hw/s390x/css-bridge.h"
> +#include "hw/s390x/ap-bridge.h"
>   #include "migration/register.h"
>   #include "cpu_models.h"
>   #include "hw/nmi.h"
> @@ -263,6 +264,9 @@ static void ccw_init(MachineState *machine)
>       /* init the SIGP facility */
>       s390_init_sigp();
>=20
> +    /* create AP bridge and bus(es) */
> +    s390_init_ap();
> +
>       /* get a BUS */
>       css_bus =3D virtual_css_bus_init();
>       s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdli=
ne,
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.=
h
> new file mode 100644
> index 000000000000..b6ca6ae4ab17
> --- /dev/null
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -0,0 +1,37 @@
> +/*
> + * ap bridge
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Halil Pasic <pasic@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +
> +#ifndef HW_S390X_AP_BRIDGE_H
> +#define HW_S390X_AP_BRIDGE_H
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +#include "hw/sysbus.h"
> +
> +typedef struct APBridge {
> +    SysBusDevice sysbus_dev;
> +    bool css_dev_path;
> +} APBridge;
> +
> +#define TYPE_AP_BRIDGE "ap-bridge"
> +#define AP_BRIDGE(obj) \
> +    OBJECT_CHECK(APBridge, (obj), TYPE_AP_BRIDGE)
> +
> +typedef struct APBus {
> +    BusState parent_obj;
> +} APBus;
> +
> +#define TYPE_AP_BUS "ap-bus"
> +#define AP_BUS(obj) \
> +     OBJECT_CHECK(APBus, (obj), TYPE_AP_BUS)
> +
> +void s390_init_ap(void);
> +
> +#endif
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.=
h
> new file mode 100644
> index 000000000000..693df90cc041
> --- /dev/null
> +++ b/include/hw/s390x/ap-device.h
> @@ -0,0 +1,38 @@
> +/*
> + * Adjunct Processor (AP) matrix device interfaces
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
> + * directory.
> + */
> +#ifndef HW_S390X_AP_DEVICE_H
> +#define HW_S390X_AP_DEVICE_H
> +
> +#define AP_DEVICE_TYPE       "ap-device"
> +
> +typedef struct APDevice {
> +    DeviceState parent_obj;
> +} APDevice;
> +
> +typedef struct APDeviceClass {
> +    DeviceClass parent_class;
> +} APDeviceClass;
> +
> +static inline APDevice *to_ap_dev(DeviceState *dev)
> +{
> +    return container_of(dev, APDevice, parent_obj);
> +}
> +
> +#define AP_DEVICE(obj) \
> +    OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
> +
> +#define AP_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(APDeviceClass, (obj), AP_DEVICE_TYPE)
> +
> +#define AP_DEVICE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)
> +
> +#endif /* HW_S390X_AP_DEVICE_H */
>=20


Appart of the current discussions on the implementation:
Bus and devices appear correctly on the qtree.


Tested-by: Pierre Morel<pmorel@linux.ibm.com>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
