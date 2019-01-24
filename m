Received: from eggs.gnu.org ([209.51.188.92]:54927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmgYI-0003iB-B2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmgYG-0000Rx-CN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:04:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmgYF-0000P2-T2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:04:20 -0500
References: <20190103141013.18019-1-quintela@redhat.com>
	<20190103141013.18019-2-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <660c6dba-de55-f6b0-7783-a3ba60879ca9@redhat.com>
Date: Thu, 24 Jan 2019 16:04:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190103141013.18019-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 01/16] virtio: split vhost vsock bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 2019-01-03 15:09, Juan Quintela wrote:
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> 
> Updated copyright info
> Also split virtio-pci.h bits
> ---
>  hw/virtio/Makefile.objs     |  3 ++
>  hw/virtio/vhost-vsock-pci.c | 86 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c      | 53 -----------------------
>  hw/virtio/virtio-pci.h      | 18 --------
>  4 files changed, 89 insertions(+), 71 deletions(-)
>  create mode 100644 hw/virtio/vhost-vsock-pci.c
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 1b2799cfd8..39884c5f7b 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -11,6 +11,9 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-p
>  
>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
> +ifeq ($(CONFIG_PCI),y)
> +obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
> +endif
>  endif
>  
>  common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
> diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
> new file mode 100644
> index 0000000000..6f43ca35fb
> --- /dev/null
> +++ b/hw/virtio/vhost-vsock-pci.c
> @@ -0,0 +1,86 @@
> +/*
> + * Vhost vsock PCI Bindings
> + *
> + * Copyright 2015 Red Hat, Inc.
> + *
> + * Authors:
> + *  Stefan Hajnoczi <stefanha@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "virtio-pci.h"
> +#include "hw/virtio/vhost-vsock.h"
> +
> +typedef struct VHostVSockPCI VHostVSockPCI;
> +
> +/*
> + * vhost-vsock-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VHOST_VSOCK_PCI "vhost-vsock-pci-base"
> +#define VHOST_VSOCK_PCI(obj) \
> +        OBJECT_CHECK(VHostVSockPCI, (obj), TYPE_VHOST_VSOCK_PCI)
> +
> +struct VHostVSockPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostVSock vdev;
> +};
> +
> +/* vhost-vsock-pci */
> +
> +static Property vhost_vsock_pci_properties[] = {
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void vhost_vsock_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +    k->realize = vhost_vsock_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->props = vhost_vsock_pci_properties;
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_VSOCK;
> +    pcidev_k->revision = 0x00;
> +    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
> +}
> +
> +static void vhost_vsock_pci_instance_init(Object *obj)
> +{
> +    VHostVSockPCI *dev = VHOST_VSOCK_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_VSOCK);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vhost_vsock_pci_info = {
> +    .base_name             = TYPE_VHOST_VSOCK_PCI,
> +    .generic_name          = "vhost-vsock-pci",
> +    .transitional_name     = "vhost-vsock-pci-transitional",
> +    .non_transitional_name = "vhost-vsock-pci-non-transitional",
> +    .instance_size = sizeof(VHostVSockPCI),
> +    .instance_init = vhost_vsock_pci_instance_init,
> +    .class_init    = vhost_vsock_pci_class_init,
> +};
> +
> +static void virtio_pci_vhost_register(void)
> +{
> +    virtio_pci_types_register(&vhost_vsock_pci_info);
> +}
> +
> +type_init(virtio_pci_vhost_register)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index d05066deb8..4312d95fe9 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2357,56 +2357,6 @@ static const VirtioPCIDeviceTypeInfo vhost_user_scsi_pci_info = {
>  };
>  #endif
>  
> -/* vhost-vsock-pci */
> -
> -#ifdef CONFIG_VHOST_VSOCK
> -static Property vhost_vsock_pci_properties[] = {
> -    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> -{
> -    VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
> -    DeviceState *vdev = DEVICE(&dev->vdev);
> -
> -    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> -    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> -}
> -
> -static void vhost_vsock_pci_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> -    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> -    k->realize = vhost_vsock_pci_realize;
> -    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> -    dc->props = vhost_vsock_pci_properties;
> -    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> -    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_VSOCK;
> -    pcidev_k->revision = 0x00;
> -    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
> -}
> -
> -static void vhost_vsock_pci_instance_init(Object *obj)
> -{
> -    VHostVSockPCI *dev = VHOST_VSOCK_PCI(obj);
> -
> -    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> -                                TYPE_VHOST_VSOCK);
> -}
> -
> -static const VirtioPCIDeviceTypeInfo vhost_vsock_pci_info = {
> -    .base_name             = TYPE_VHOST_VSOCK_PCI,
> -    .generic_name          = "vhost-vsock-pci",
> -    .transitional_name     = "vhost-vsock-pci-transitional",
> -    .non_transitional_name = "vhost-vsock-pci-non-transitional",
> -    .instance_size = sizeof(VHostVSockPCI),
> -    .instance_init = vhost_vsock_pci_instance_init,
> -    .class_init    = vhost_vsock_pci_class_init,
> -};
> -#endif
> -
>  /* virtio-balloon-pci */
>  
>  static Property virtio_balloon_pci_properties[] = {
> @@ -2855,9 +2805,6 @@ static void virtio_pci_register_types(void)
>  #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
>      virtio_pci_types_register(&vhost_user_scsi_pci_info);
>  #endif
> -#ifdef CONFIG_VHOST_VSOCK
> -    virtio_pci_types_register(&vhost_vsock_pci_info);
> -#endif
>  }
>  
>  type_init(virtio_pci_register_types)
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 29b4216107..2109d002df 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -37,9 +37,6 @@
>  #ifdef CONFIG_VHOST_SCSI
>  #include "hw/virtio/vhost-scsi.h"
>  #endif
> -#ifdef CONFIG_VHOST_VSOCK
> -#include "hw/virtio/vhost-vsock.h"
> -#endif
>  
>  typedef struct VirtIOPCIProxy VirtIOPCIProxy;
>  typedef struct VirtIOBlkPCI VirtIOBlkPCI;
> @@ -55,7 +52,6 @@ typedef struct VirtIOInputPCI VirtIOInputPCI;
>  typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
>  typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>  typedef struct VirtIOGPUPCI VirtIOGPUPCI;
> -typedef struct VHostVSockPCI VHostVSockPCI;
>  typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
>  
>  /* virtio-pci-bus */
> @@ -388,20 +384,6 @@ struct VirtIOGPUPCI {
>      VirtIOGPU vdev;
>  };
>  
> -#ifdef CONFIG_VHOST_VSOCK
> -/*
> - * vhost-vsock-pci: This extends VirtioPCIProxy.
> - */
> -#define TYPE_VHOST_VSOCK_PCI "vhost-vsock-pci-base"
> -#define VHOST_VSOCK_PCI(obj) \
> -        OBJECT_CHECK(VHostVSockPCI, (obj), TYPE_VHOST_VSOCK_PCI)
> -
> -struct VHostVSockPCI {
> -    VirtIOPCIProxy parent_obj;
> -    VHostVSock vdev;
> -};
> -#endif
> -
>  /*
>   * virtio-crypto-pci: This extends VirtioPCIProxy.
>   */
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
