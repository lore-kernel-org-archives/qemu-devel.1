Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fne98-0000nP-Oc
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fne95-0002wZ-J3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:10:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fne95-0002vl-Bw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:10:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB87381663CE
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 06:10:02 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-12-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51139c7c-9592-d5ac-8541-b9d54febfd2a@redhat.com>
Date: Thu, 9 Aug 2018 08:10:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-12-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/22] virtio: split host bits from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/virtio.mak        |  3 +++
>  hw/virtio/Makefile.objs           |  1 +
>  hw/virtio/virtio-input-host-pci.c | 42 +++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c            | 20 ---------------
>  4 files changed, 46 insertions(+), 20 deletions(-)
>  create mode 100644 hw/virtio/virtio-input-host-pci.c
> 
> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
> index 1304849018..6309dbf938 100644
> --- a/default-configs/virtio.mak
> +++ b/default-configs/virtio.mak
> @@ -12,3 +12,6 @@ CONFIG_VIRTIO_RNG=y
>  CONFIG_SCSI=y
>  CONFIG_VIRTIO_SCSI=y
>  CONFIG_VIRTIO_SERIAL=y
> +CONFIG_VIRTIO_VSOCK=y
> +CONFIG_VIRTIO_INPUT_HOST=$(CONFIG_LINUX)

What's the VIRTIO_VSOCK good for? You don't seem to use it in this patch?

 Thomas


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
> index 0000000000..3159693dd9
> --- /dev/null
> +++ b/hw/virtio/virtio-input-host-pci.c
> @@ -0,0 +1,42 @@
> +/*
> + * Virtio input host PCI Bindings
> + *
> + * Copyright IBM, Corp. 2007
> + * Copyright (c) 2009 CodeSourcery
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Paul Brook        <paul@codesourcery.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "virtio-pci.h"
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
> index 1590b34dc9..f6094bed80 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2567,23 +2567,6 @@ static const TypeInfo virtio_tablet_pci_info = {
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
> @@ -2637,9 +2620,6 @@ static void virtio_pci_register_types(void)
>      type_register_static(&virtio_keyboard_pci_info);
>      type_register_static(&virtio_mouse_pci_info);
>      type_register_static(&virtio_tablet_pci_info);
> -#ifdef CONFIG_LINUX
> -    type_register_static(&virtio_host_pci_info);
> -#endif
>      type_register_static(&virtio_pci_bus_info);
>      type_register_static(&virtio_pci_info);
>  #ifdef CONFIG_VIRTFS
> 
