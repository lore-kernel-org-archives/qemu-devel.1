Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXVQD-0005hR-MA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXVQ9-00031n-Ti
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:32:29 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:33176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dXVQ9-00030I-Ce
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:32:25 -0400
Received: by mail-lf0-x234.google.com with SMTP id z78so18883144lff.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 09:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
	<1497523981-38449-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-41-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 16:32:13 +0000
Message-ID: <CAJ+F1CJYp-13xa++8_p4g=bNKP3-JsB6-2ZoFRRo=DPPyEJaUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 40/41] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>

On Thu, Jun 15, 2017 at 1:20 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> From: Felipe Franciosi <felipe@nutanix.com>
>
> This commit introduces a vhost-user device for SCSI. This is based
> on the existing vhost-scsi implementation, but done over vhost-user
> instead. It also uses a chardev to connect to the backend. Unlike
> vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>
> To use it, start Qemu with a command line equivalent to:
>
> qemu-system-x86_64 \
>        -chardev socket,id=3Dvus0,path=3D/tmp/vus.sock \
>        -device vhost-user-scsi-pci,chardev=3Dvus0,bus=3Dpci.0,addr=3D...
>
> A separate commit presents a sample application linked with libiscsi to
> provide a backend for vhost-user-scsi.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>

I just realized the patch was missing qemu-options.hx update. Oh wait,
virtio-scsi-pci isn't documented either?

Would it have been possible to add a vhost-user-chr=3Dchr argument on
virtio-scsi-pci instead of introducing a new device? Would that make sense
(to share code, argument etc)?

 .gitignore                          |   1 +
>  default-configs/pci.mak             |   1 +
>  default-configs/s390x-softmmu.mak   |   1 +
>  hw/scsi/Makefile.objs               |   1 +
>  hw/scsi/vhost-scsi-common.c         |   1 -
>  hw/scsi/vhost-user-scsi.c           | 205
> ++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c              |  58 ++++++++++
>  hw/virtio/virtio-pci.h              |  11 ++
>  include/hw/virtio/vhost-user-scsi.h |  35 ++++++
>  include/hw/virtio/virtio-scsi.h     |   2 +
>  10 files changed, 315 insertions(+), 1 deletion(-)
>  create mode 100644 hw/scsi/vhost-user-scsi.c
>  create mode 100644 include/hw/virtio/vhost-user-scsi.h
>
> diff --git a/.gitignore b/.gitignore
> index 11bb1b1..09c2363 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -50,6 +50,7 @@
>  /qemu-version.h.tmp
>  /module_block.h
>  /vscclient
> +/vhost-user-scsi
>  /fsdev/virtfs-proxy-helper
>  *.[1-9]
>  *.a
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index 3bbeb62..53ff109 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -43,3 +43,4 @@ CONFIG_VGA=3Dy
>  CONFIG_VGA_PCI=3Dy
>  CONFIG_IVSHMEM=3D$(CONFIG_EVENTFD)
>  CONFIG_ROCKER=3Dy
> +CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
> diff --git a/default-configs/s390x-softmmu.mak
> b/default-configs/s390x-softmmu.mak
> index 18aed56..b227a36 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -1,5 +1,6 @@
>  CONFIG_PCI=3Dy
>  CONFIG_VIRTIO_PCI=3Dy
> +CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
>  CONFIG_VIRTIO=3Dy
>  CONFIG_SCLPCONSOLE=3Dy
>  CONFIG_TERMINAL3270=3Dy
> diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
> index 54d8754..b188f72 100644
> --- a/hw/scsi/Makefile.objs
> +++ b/hw/scsi/Makefile.objs
> @@ -11,4 +11,5 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vscsi.o
>  ifeq ($(CONFIG_VIRTIO),y)
>  obj-y +=3D virtio-scsi.o virtio-scsi-dataplane.o
>  obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-common.o vhost-scsi.o
> +obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-scsi-common.o vhost-user-scsi.o
>  endif
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index e41c031..d434b3e 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -16,7 +16,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include <linux/vhost.h>
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "migration/migration.h"
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> new file mode 100644
> index 0000000..500fa6a
> --- /dev/null
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -0,0 +1,205 @@
> +/*
> + * vhost-user-scsi host device
> + *
> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
> + *
> + * Author:
> + *  Felipe Franciosi <felipe@nutanix.com>
> + *
> + * This work is largely based on the "vhost-scsi" implementation by:
> + *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
> + *  Nicholas Bellinger <nab@risingtidesystems.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or
> later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/typedefs.h"
> +#include "qom/object.h"
> +#include "hw/fw-path-provider.h"
> +#include "hw/qdev-core.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-backend.h"
> +#include "hw/virtio/vhost-user-scsi.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-access.h"
> +#include "chardev/char-fe.h"
> +
> +/* Features supported by the host application */
> +static const int user_feature_bits[] =3D {
> +    VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VIRTIO_RING_F_INDIRECT_DESC,
> +    VIRTIO_RING_F_EVENT_IDX,
> +    VIRTIO_SCSI_F_HOTPLUG,
> +    VHOST_INVALID_FEATURE_BIT
> +};
> +
> +static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t statu=
s)
> +{
> +    VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    bool start =3D (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_runn=
ing;
> +
> +    if (vsc->dev.started =3D=3D start) {
> +        return;
> +    }
> +
> +    if (start) {
> +        int ret;
> +
> +        ret =3D vhost_scsi_common_start(vsc);
> +        if (ret < 0) {
> +            error_report("unable to start vhost-user-scsi: %s",
> strerror(-ret));
> +            exit(1);
> +        }
> +    } else {
> +        vhost_scsi_common_stop(vsc);
> +    }
> +}
> +
> +static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +}
> +
> +static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +    Error *err =3D NULL;
> +    int ret;
> +
> +    if (!vs->conf.chardev.chr) {
> +        error_setg(errp, "vhost-user-scsi: missing chardev");
> +        return;
> +    }
> +
> +    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
> +                               vhost_dummy_handle_output,
> +                               vhost_dummy_handle_output, &err);
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    vsc->dev.nvqs =3D 2 + vs->conf.num_queues;
> +    vsc->dev.vqs =3D g_new(struct vhost_virtqueue, vsc->dev.nvqs);
> +    vsc->dev.vq_index =3D 0;
> +    vsc->dev.backend_features =3D 0;
> +
> +    ret =3D vhost_dev_init(&vsc->dev, (void *)&vs->conf.chardev,
> +                         VHOST_BACKEND_TYPE_USER, 0);
> +    if (ret < 0) {
> +        error_setg(errp, "vhost-user-scsi: vhost initialization failed:
> %s",
> +                   strerror(-ret));
> +        return;
> +    }
> +
> +    /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
> +    vsc->channel =3D 0;
> +    vsc->lun =3D 0;
> +    vsc->target =3D vs->conf.boot_tpgt;
> +}
> +
> +static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
> +
> +    /* This will stop the vhost backend. */
> +    vhost_user_scsi_set_status(vdev, 0);
> +
> +    vhost_dev_cleanup(&vsc->dev);
> +    g_free(vsc->dev.vqs);
> +
> +    virtio_scsi_common_unrealize(dev, errp);
> +}
> +
> +static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
> +                                             uint64_t features, Error
> **errp)
> +{
> +    VHostUserSCSI *s =3D VHOST_USER_SCSI(vdev);
> +
> +    /* Turn on predefined features supported by this device */
> +    features |=3D s->host_features;
> +
> +    return vhost_scsi_common_get_features(vdev, features, errp);
> +}
> +
> +static Property vhost_user_scsi_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
> +    DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0)=
,
> +    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
> 1),
> +    DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors=
,
> +                       0xFFFF),
> +    DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun=
,
> 128),
> +    DEFINE_PROP_BIT64("hotplug", VHostUserSCSI, host_features,
> +                                                VIRTIO_SCSI_F_HOTPLUG,
> +                                                true),
> +    DEFINE_PROP_BIT64("param_change", VHostUserSCSI, host_features,
> +                                                     VIRTIO_SCSI_F_CHANG=
E,
> +                                                     true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static const VMStateDescription vmstate_vhost_scsi =3D {
> +    .name =3D "virtio-scsi",
> +    .minimum_version_id =3D 1,
> +    .version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> +    FWPathProviderClass *fwc =3D FW_PATH_PROVIDER_CLASS(klass);
> +
> +    dc->props =3D vhost_user_scsi_properties;
> +    dc->vmsd =3D &vmstate_vhost_scsi;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    vdc->realize =3D vhost_user_scsi_realize;
> +    vdc->unrealize =3D vhost_user_scsi_unrealize;
> +    vdc->get_features =3D vhost_user_scsi_get_features;
> +    vdc->set_config =3D vhost_scsi_common_set_config;
> +    vdc->set_status =3D vhost_user_scsi_set_status;
> +    fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
> +}
> +
> +static void vhost_user_scsi_instance_init(Object *obj)
> +{
> +    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(obj);
> +
> +    vsc->feature_bits =3D user_feature_bits;
> +
> +    /* Add the bootindex property for this object */
> +    device_add_bootindex_property(obj, &vsc->bootindex, "bootindex", NUL=
L,
> +                                  DEVICE(vsc), NULL);
> +}
> +
> +static const TypeInfo vhost_user_scsi_info =3D {
> +    .name =3D TYPE_VHOST_USER_SCSI,
> +    .parent =3D TYPE_VHOST_SCSI_COMMON,
> +    .instance_size =3D sizeof(VHostUserSCSI),
> +    .class_init =3D vhost_user_scsi_class_init,
> +    .instance_init =3D vhost_user_scsi_instance_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_FW_PATH_PROVIDER },
> +        { }
> +    },
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&vhost_user_scsi_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f9b7244..20d6a08 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2135,6 +2135,61 @@ static const TypeInfo vhost_scsi_pci_info =3D {
>  };
>  #endif
>
> +#ifdef CONFIG_LINUX
> +/* vhost-user-scsi-pci */
> +static Property vhost_user_scsi_pci_properties[] =3D {
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error
> **errp)
> +{
> +    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> +
> +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
> +    }
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *dat=
a)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +    k->realize =3D vhost_user_scsi_pci_realize;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->props =3D vhost_user_scsi_pci_properties;
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_SCSI;
> +    pcidev_k->revision =3D 0x00;
> +    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
> +}
> +
> +static void vhost_user_scsi_pci_instance_init(Object *obj)
> +{
> +    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_SCSI);
> +    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
> +                              "bootindex", &error_abort);
> +}
> +
> +static const TypeInfo vhost_user_scsi_pci_info =3D {
> +    .name          =3D TYPE_VHOST_USER_SCSI_PCI,
> +    .parent        =3D TYPE_VIRTIO_PCI,
> +    .instance_size =3D sizeof(VHostUserSCSIPCI),
> +    .instance_init =3D vhost_user_scsi_pci_instance_init,
> +    .class_init    =3D vhost_user_scsi_pci_class_init,
> +};
> +#endif
> +
>  /* vhost-vsock-pci */
>
>  #ifdef CONFIG_VHOST_VSOCK
> @@ -2612,6 +2667,9 @@ static void virtio_pci_register_types(void)
>  #ifdef CONFIG_VHOST_SCSI
>      type_register_static(&vhost_scsi_pci_info);
>  #endif
> +#ifdef CONFIG_LINUX
> +    type_register_static(&vhost_user_scsi_pci_info);
> +#endif
>  #ifdef CONFIG_VHOST_VSOCK
>      type_register_static(&vhost_vsock_pci_info);
>  #endif
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index b095dfc..69f5959 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -26,6 +26,7 @@
>  #include "hw/virtio/virtio-input.h"
>  #include "hw/virtio/virtio-gpu.h"
>  #include "hw/virtio/virtio-crypto.h"
> +#include "hw/virtio/vhost-user-scsi.h"
>
>  #ifdef CONFIG_VIRTFS
>  #include "hw/9pfs/virtio-9p.h"
> @@ -44,6 +45,7 @@ typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
>  typedef struct VirtIOSerialPCI VirtIOSerialPCI;
>  typedef struct VirtIONetPCI VirtIONetPCI;
>  typedef struct VHostSCSIPCI VHostSCSIPCI;
> +typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
>  typedef struct VirtIORngPCI VirtIORngPCI;
>  typedef struct VirtIOInputPCI VirtIOInputPCI;
>  typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
> @@ -230,6 +232,15 @@ struct VHostSCSIPCI {
>  };
>  #endif
>
> +#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci"
> +#define VHOST_USER_SCSI_PCI(obj) \
> +        OBJECT_CHECK(VHostUserSCSIPCI, (obj), TYPE_VHOST_USER_SCSI_PCI)
> +
> +struct VHostUserSCSIPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostUserSCSI vdev;
> +};
> +
>  /*
>   * virtio-blk-pci: This extends VirtioPCIProxy.
>   */
> diff --git a/include/hw/virtio/vhost-user-scsi.h
> b/include/hw/virtio/vhost-user-scsi.h
> new file mode 100644
> index 0000000..01861f7
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-scsi.h
> @@ -0,0 +1,35 @@
> +/*
> + * vhost-user-scsi host device
> + *
> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
> + *
> + * Author:
> + *  Felipe Franciosi <felipe@nutanix.com>
> + *
> + * This file is largely based on "vhost-scsi.h" by:
> + *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or
> later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#ifndef VHOST_USER_SCSI_H
> +#define VHOST_USER_SCSI_H
> +
> +#include "qemu-common.h"
> +#include "hw/qdev.h"
> +#include "hw/virtio/virtio-scsi.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-scsi-common.h"
> +
> +#define TYPE_VHOST_USER_SCSI "vhost-user-scsi"
> +#define VHOST_USER_SCSI(obj) \
> +        OBJECT_CHECK(VHostUserSCSI, (obj), TYPE_VHOST_USER_SCSI)
> +
> +typedef struct VHostUserSCSI {
> +    VHostSCSICommon parent_obj;
> +    uint64_t host_features;
> +} VHostUserSCSI;
> +
> +#endif /* VHOST_USER_SCSI_H */
> diff --git a/include/hw/virtio/virtio-scsi.h
> b/include/hw/virtio/virtio-scsi.h
> index eac2013..de6ae5a 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -21,6 +21,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
> +#include "chardev/char-fe.h"
>  #include "sysemu/iothread.h"
>
>  #define TYPE_VIRTIO_SCSI_COMMON "virtio-scsi-common"
> @@ -53,6 +54,7 @@ struct VirtIOSCSIConf {
>      char *vhostfd;
>      char *wwpn;
>  #endif
> +    CharBackend chardev;
>      uint32_t boot_tpgt;
>      IOThread *iothread;
>  };
> --
> 1.8.3.1
>
>
>
> --
Marc-Andr=C3=A9 Lureau
