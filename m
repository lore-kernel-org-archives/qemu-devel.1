Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fneLT-0005e9-Rv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fneLQ-0000PV-My
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:22:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fneLQ-0000PM-Fm
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:22:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06550402332F
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 06:22:48 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-14-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <84788423-c6f3-63ed-4cf4-150aa6fa58cf@redhat.com>
Date: Thu, 9 Aug 2018 08:22:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-14-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/22] virtio: split rng bits from
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
>  hw/virtio/Makefile.objs    |  1 +
>  hw/virtio/virtio-pci.c     | 52 -------------------------
>  hw/virtio/virtio-rng-pci.c | 77 ++++++++++++++++++++++++++++++++++++++
>  tests/Makefile.include     |  4 +-
>  4 files changed, 80 insertions(+), 54 deletions(-)
>  create mode 100644 hw/virtio/virtio-rng-pci.c
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 6819ed4e14..2efa544a2d 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -13,6 +13,7 @@ obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
>  obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
> +obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
>  endif
>  
>  common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 992d3bc3b4..309fb20fef 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2409,57 +2409,6 @@ static const TypeInfo virtio_net_pci_info = {
>      .class_init    = virtio_net_pci_class_init,
>  };
>  
> -/* virtio-rng-pci */
> -
> -static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> -{
> -    VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
> -    DeviceState *vdev = DEVICE(&vrng->vdev);
> -    Error *err = NULL;
> -
> -    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> -    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> -    object_property_set_link(OBJECT(vrng),
> -                             OBJECT(vrng->vdev.conf.rng), "rng",
> -                             NULL);
> -}
> -
> -static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> -    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> -
> -    k->realize = virtio_rng_pci_realize;
> -    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> -
> -    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> -    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_RNG;
> -    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> -    pcidev_k->class_id = PCI_CLASS_OTHERS;
> -}
> -
> -static void virtio_rng_initfn(Object *obj)
> -{
> -    VirtIORngPCI *dev = VIRTIO_RNG_PCI(obj);
> -
> -    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> -                                TYPE_VIRTIO_RNG);
> -}
> -
> -static const TypeInfo virtio_rng_pci_info = {
> -    .name          = TYPE_VIRTIO_RNG_PCI,
> -    .parent        = TYPE_VIRTIO_PCI,
> -    .instance_size = sizeof(VirtIORngPCI),
> -    .instance_init = virtio_rng_initfn,
> -    .class_init    = virtio_rng_pci_class_init,
> -};
> -
>  /* virtio-pci-bus */
>  
>  static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
> @@ -2507,7 +2456,6 @@ static const TypeInfo virtio_pci_bus_info = {
>  
>  static void virtio_pci_register_types(void)
>  {
> -    type_register_static(&virtio_rng_pci_info);
>      type_register_static(&virtio_pci_bus_info);
>      type_register_static(&virtio_pci_info);
>  #ifdef CONFIG_VIRTFS
> diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
> new file mode 100644
> index 0000000000..b7651c8b66
> --- /dev/null
> +++ b/hw/virtio/virtio-rng-pci.c
> @@ -0,0 +1,77 @@
> +/*
> + * Virtio rng PCI Bindings
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

virtio-rng has been added by Amit in June 2012 (see commit 16c915ba42b4)
so you can use GPLv2+ text only here, too.

 Thomas

(Sorry for being picky here, but these "contributions after ...." texts
really look cumbersome to me - we should use this occasion of your
rework to clean them up if possible)
