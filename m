Received: from eggs.gnu.org ([2001:4830:134:3::10]:33423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS4T5-0007dk-2o
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS4T3-0006cc-5y
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:21:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS4T2-0004zi-DK
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:21:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C74CAC058CB0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 18:21:15 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-3-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <983e7823-75aa-4295-ee71-7450f3ab67c5@redhat.com>
Date: Wed, 28 Nov 2018 19:21:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/16] virtio: split virtio input host
 bits from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

CC: Gerd

On 26/11/2018 20:59, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/virtio.mak        |  1 +
>  hw/virtio/Makefile.objs           |  1 +
>  hw/virtio/virtio-input-host-pci.c | 45 +++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c            | 20 --------------
>  hw/virtio/virtio-pci.h            | 14 ----------
>  5 files changed, 47 insertions(+), 34 deletions(-)
>  create mode 100644 hw/virtio/virtio-input-host-pci.c
> 
> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
> index 1304849018..5ae4a61018 100644
> --- a/default-configs/virtio.mak
> +++ b/default-configs/virtio.mak
> @@ -12,3 +12,4 @@ CONFIG_VIRTIO_RNG=y
>  CONFIG_SCSI=y
>  CONFIG_VIRTIO_SCSI=y
>  CONFIG_VIRTIO_SERIAL=y
> +CONFIG_VIRTIO_INPUT_HOST=$(CONFIG_LINUX)
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 4fbf7de84b..685ae1d866 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -11,6 +11,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-p
>  
>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
> +obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
>  endif
>  
>  common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
> diff --git a/hw/virtio/virtio-input-host-pci.c b/hw/virtio/virtio-input-host-pci.c
> new file mode 100644
> index 0000000000..4048e2f01e
> --- /dev/null
> +++ b/hw/virtio/virtio-input-host-pci.c
> @@ -0,0 +1,45 @@
> +/*
> + * Virtio input host PCI Bindings
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "virtio-pci.h"
> +#include "hw/virtio/virtio-input.h"
> +
> +typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
> +
> +#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
> +#define VIRTIO_INPUT_HOST_PCI(obj) \
> +        OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_PCI)
> +
> +struct VirtIOInputHostPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOInputHost vdev;
> +};
> +
> +static void virtio_input_host_initfn(Object *obj)
> +{
> +    VirtIOInputHostPCI *dev = VIRTIO_INPUT_HOST_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_INPUT_HOST);
> +}
> +
> +static const TypeInfo virtio_input_host_pci_info = {
> +    .name          = TYPE_VIRTIO_INPUT_HOST_PCI,
> +    .parent        = TYPE_VIRTIO_INPUT_PCI,
> +    .instance_size = sizeof(VirtIOInputHostPCI),
> +    .instance_init = virtio_input_host_initfn,
> +};
> +
> +static void virtio_input_host_pci_register(void)
> +{
> +    type_register_static(&virtio_input_host_pci_info);
> +}
> +
> +type_init(virtio_input_host_pci_register)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 56b39a3699..97e40da9e8 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2580,23 +2580,6 @@ static const TypeInfo virtio_tablet_pci_info = {
>      .instance_init = virtio_tablet_initfn,
>  };
>  
> -#ifdef CONFIG_LINUX
> -static void virtio_host_initfn(Object *obj)
> -{
> -    VirtIOInputHostPCI *dev = VIRTIO_INPUT_HOST_PCI(obj);
> -
> -    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> -                                TYPE_VIRTIO_INPUT_HOST);
> -}
> -
> -static const TypeInfo virtio_host_pci_info = {
> -    .name          = TYPE_VIRTIO_INPUT_HOST_PCI,
> -    .parent        = TYPE_VIRTIO_INPUT_PCI,
> -    .instance_size = sizeof(VirtIOInputHostPCI),
> -    .instance_init = virtio_host_initfn,
> -};
> -#endif
> -
>  /* virtio-pci-bus */
>  
>  static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
> @@ -2650,9 +2633,6 @@ static void virtio_pci_register_types(void)
>      type_register_static(&virtio_keyboard_pci_info);
>      type_register_static(&virtio_mouse_pci_info);
>      type_register_static(&virtio_tablet_pci_info);
> -#ifdef CONFIG_LINUX
> -    type_register_static(&virtio_host_pci_info);
> -#endif
>      type_register_static(&virtio_pci_bus_info);
>      type_register_static(&virtio_pci_info);
>  #ifdef CONFIG_VIRTFS
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 25d225bc7d..cf4cbecfab 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -50,7 +50,6 @@ typedef struct VHostUserBlkPCI VHostUserBlkPCI;
>  typedef struct VirtIORngPCI VirtIORngPCI;
>  typedef struct VirtIOInputPCI VirtIOInputPCI;
>  typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
> -typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>  typedef struct VirtIOGPUPCI VirtIOGPUPCI;
>  typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
>  
> @@ -359,19 +358,6 @@ struct VirtIOInputHIDPCI {
>      VirtIOInputHID vdev;
>  };
>  
> -#ifdef CONFIG_LINUX
> -
> -#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
> -#define VIRTIO_INPUT_HOST_PCI(obj) \
> -        OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_PCI)
> -
> -struct VirtIOInputHostPCI {
> -    VirtIOPCIProxy parent_obj;
> -    VirtIOInputHost vdev;
> -};
> -
> -#endif
> -
>  /*
>   * virtio-gpu-pci: This extends VirtioPCIProxy.
>   */
> 
