Received: from eggs.gnu.org ([2001:4830:134:3::10]:48499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1gXp6B-0000jg-Hn
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1gXp66-0005ap-IU
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:09:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:55246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1gXp66-0005XI-3b
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:09:50 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 14 Dec 2018 15:09:35 +0000
Message-ID: <14C853AD-BF3C-457F-87A3-BDFF59657691@nutanix.com>
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-9-quintela@redhat.com>
	<a185dbc7-dc98-db4e-89a5-92745b97556b@redhat.com>
In-Reply-To: <a185dbc7-dc98-db4e-89a5-92745b97556b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0969E2DCC77E1E48BD214D421CF0011C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 08/16] virtio: split vhost user scsi
 bits from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>



> On Dec 14, 2018, at 9:14 AM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> On 2018-12-13 22:00, Juan Quintela wrote:
>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>> hw/virtio/Makefile.objs         |   1 +
>> hw/virtio/vhost-user-scsi-pci.c | 101 ++++++++++++++++++++++++++++++++
>> hw/virtio/virtio-pci.c          |  58 ------------------
>> hw/virtio/virtio-pci.h          |  11 ----
>> 4 files changed, 102 insertions(+), 69 deletions(-)
>> create mode 100644 hw/virtio/vhost-user-scsi-pci.c
>>=20
>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>> index 35b7698446..f851a6f2b5 100644
>> --- a/hw/virtio/Makefile.objs
>> +++ b/hw/virtio/Makefile.objs
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
>> ifeq ($(CONFIG_PCI),y)
>> obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock-pci.o
>> obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk-pci.o
>> +obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-user-scsi-pci.o
>> obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pci.o
>> obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
>> obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
>> diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi=
-pci.c
>> new file mode 100644
>> index 0000000000..5baec9c356
>> --- /dev/null
>> +++ b/hw/virtio/vhost-user-scsi-pci.c
>> @@ -0,0 +1,101 @@
>> +/*
>> + * Vhost user scsi PCI Bindings
>> + *
>> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
>> + *
>> + * Author:
>> + *  Felipe Franciosi <felipe@nutanix.com>
>> + *
>> + * This work is largely based on the "vhost-scsi" implementation by:
>> + *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
>> + *  Nicholas Bellinger <nab@risingtidesystems.com>
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2 or =
later.
>> + * See the COPYING.LIB file in the top-level directory.
>=20
> Not sure whether this should be LGPL (since hw/scsi/vhost-user-scsi.c is
> LGPL, too) or GPLv2+ (since the original code in the file
> hw/virtio/virtio-pci.c is GPLv2+) ... Felipe, any preferences?

I have absolutely no preferences and am perfectly happy with however it is =
decided to take this forward.

Cheers,
Felipe

>=20
> NB: "LGPL, version 2" is also inaccurate. According to our COPYING.LIB
> file which is referenced in the comment, we are using version 2.1 ...
>=20
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "standard-headers/linux/virtio_pci.h"
>> +#include "hw/virtio/vhost-user-scsi.h"
>> +#include "hw/virtio/virtio.h"
>> +#include "hw/virtio/virtio-scsi.h"
>> +#include "hw/pci/pci.h"
>> +#include "qapi/error.h"
>> +#include "qemu/error-report.h"
>> +#include "hw/pci/msi.h"
>> +#include "hw/pci/msix.h"
>> +#include "hw/loader.h"
>> +#include "sysemu/kvm.h"
>> +#include "virtio-pci.h"
>> +
>> +typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
>> +
>> +#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci"
>> +#define VHOST_USER_SCSI_PCI(obj) \
>> +        OBJECT_CHECK(VHostUserSCSIPCI, (obj), TYPE_VHOST_USER_SCSI_PCI)
>> +
>> +struct VHostUserSCSIPCI {
>> +    VirtIOPCIProxy parent_obj;
>> +    VHostUserSCSI vdev;
>> +};
>> +
>> +static Property vhost_user_scsi_pci_properties[] =3D {
>> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
>> +                       DEV_NVECTORS_UNSPECIFIED),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error=
 **errp)
>> +{
>> +    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(vpci_dev);
>> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
>> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
>> +
>> +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
>> +        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
>> +    }
>> +
>> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>> +}
>> +
>> +static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *da=
ta)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
>> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
>> +    k->realize =3D vhost_user_scsi_pci_realize;
>> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>> +    dc->props =3D vhost_user_scsi_pci_properties;
>> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
>> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_SCSI;
>> +    pcidev_k->revision =3D 0x00;
>> +    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
>> +}
>> +
>> +static void vhost_user_scsi_pci_instance_init(Object *obj)
>> +{
>> +    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(obj);
>> +
>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> +                                TYPE_VHOST_USER_SCSI);
>> +    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
>> +                              "bootindex", &error_abort);
>> +}
>> +
>> +static const TypeInfo vhost_user_scsi_pci_info =3D {
>> +    .name          =3D TYPE_VHOST_USER_SCSI_PCI,
>> +    .parent        =3D TYPE_VIRTIO_PCI,
>> +    .instance_size =3D sizeof(VHostUserSCSIPCI),
>> +    .instance_init =3D vhost_user_scsi_pci_instance_init,
>> +    .class_init    =3D vhost_user_scsi_pci_class_init,
>> +};
>> +
>> +static void vhost_user_scsi_pci_register(void)
>> +{
>> +    type_register_static(&vhost_user_scsi_pci_info);
>> +}
>> +
>> +type_init(vhost_user_scsi_pci_register)
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index e9c562b1c0..7c99d9385a 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -2075,61 +2075,6 @@ static const TypeInfo vhost_scsi_pci_info =3D {
>> };
>> #endif
>>=20
>> -#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
>> -/* vhost-user-scsi-pci */
>> -static Property vhost_user_scsi_pci_properties[] =3D {
>> -    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
>> -                       DEV_NVECTORS_UNSPECIFIED),
>> -    DEFINE_PROP_END_OF_LIST(),
>> -};
>> -
>> -static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error=
 **errp)
>> -{
>> -    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(vpci_dev);
>> -    DeviceState *vdev =3D DEVICE(&dev->vdev);
>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
>> -
>> -    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
>> -        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
>> -    }
>> -
>> -    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>> -    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>> -}
>> -
>> -static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *da=
ta)
>> -{
>> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> -    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
>> -    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
>> -    k->realize =3D vhost_user_scsi_pci_realize;
>> -    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>> -    dc->props =3D vhost_user_scsi_pci_properties;
>> -    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
>> -    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_SCSI;
>> -    pcidev_k->revision =3D 0x00;
>> -    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
>> -}
>> -
>> -static void vhost_user_scsi_pci_instance_init(Object *obj)
>> -{
>> -    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(obj);
>> -
>> -    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> -                                TYPE_VHOST_USER_SCSI);
>> -    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
>> -                              "bootindex", &error_abort);
>> -}
>> -
>> -static const TypeInfo vhost_user_scsi_pci_info =3D {
>> -    .name          =3D TYPE_VHOST_USER_SCSI_PCI,
>> -    .parent        =3D TYPE_VIRTIO_PCI,
>> -    .instance_size =3D sizeof(VHostUserSCSIPCI),
>> -    .instance_init =3D vhost_user_scsi_pci_instance_init,
>> -    .class_init    =3D vhost_user_scsi_pci_class_init,
>> -};
>> -#endif
>> -
>> /* virtio-serial-pci */
>>=20
>> static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
>> @@ -2314,9 +2259,6 @@ static void virtio_pci_register_types(void)
>> #ifdef CONFIG_VHOST_SCSI
>>     type_register_static(&vhost_scsi_pci_info);
>> #endif
>> -#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
>> -    type_register_static(&vhost_user_scsi_pci_info);
>> -#endif
>> }
>>=20
>> type_init(virtio_pci_register_types)
