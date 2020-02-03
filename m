Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25AC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FF32080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqGbWrK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FF32080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybOv-0004fL-IG
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iybO3-00040x-3e
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iybO1-0003W3-MG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:03:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iybO1-0003So-HQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580735012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZ9Ex9YwysdweURgSa9wr0iOCsn6QgrIQDlOuPP2gvY=;
 b=BqGbWrK+rVQO56/Njz0I1H1D3TYp4QvEsLnGM5IrMpqq93YOBZNiy7vKad2DQc0ky173cI
 HrYQURl2iJgHhHOJrczu82q7MmGv7xN1sGj0b0WS6pBN1h+YJckVobe1ac6YGERGCU8xOa
 d/qBNzMOxq2fwCibfwoUcscyMXjAmFY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-c88EZO-mOBSgd9Uzu6XY3Q-1; Mon, 03 Feb 2020 08:03:30 -0500
Received: by mail-qv1-f72.google.com with SMTP id z39so9404777qve.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aGYVDeDWvd133EDEBrfiNuZyxU/kGHyGYl/gOONlYKg=;
 b=raez4wzYmrz4NYPAUxLpqjnnitgLYKdBS6kNX0/QQ0/Ga/ZMwQ4MAxKdOgT5UujXr2
 dStL2dcdXQ7WQTwf8W3fCEsh0tlZc8paE/hG7bjhmqC/fafJk9n4TPeKc5A0hkpdvTNh
 U7MFnVhRJYc4yVqZ6womPnaUhdLCUmLVVYDmTq9ax9VLt5n8ZyawuWZYbyM8HlFT1QyA
 Ck2ekiLPOxET9z1icICTcGnIyHbqA5QNF6kkpjaqgn6UYMPvxYwPoW3DPtDppW9Ac8Nc
 wO1DGKQ6/XBrxRDltcalaAyEflUE3WCQ9xMzI/PoQBz0sEvghnh1CXQOXJX7Pqay5S0n
 Y1oQ==
X-Gm-Message-State: APjAAAU9R7Qw5Ep7+liOVDFTT0X+1ki3qr5p2AGJ19h0Hr+MtLBJGK4D
 tS+8BPjGbXnOjjlNAf/mJjclD9J2CGJoYiGM7FWfVyZ7PIhJRZxndtDKiTgWO5KPDRSTEuaihd3
 /xgx/wA3HQXKsak4=
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr6561121qkb.122.1580735010033; 
 Mon, 03 Feb 2020 05:03:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCLtZeFsYy9xEuqpnTFQz3bpltD2rCqSUKyq8B+n3TjdBFwT7AwqSYawQksegTMv2E8mSByA==
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr6561096qkb.122.1580735009663; 
 Mon, 03 Feb 2020 05:03:29 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id c8sm9795985qtp.13.2020.02.03.05.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:03:28 -0800 (PST)
Date: Mon, 3 Feb 2020 08:03:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v13 07/10] virtio-iommu-pci: Add virtio iommu pci support
Message-ID: <20200203080122-mutt-send-email-mst@kernel.org>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-8-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200125171955.12825-8-eric.auger@redhat.com>
X-MC-Unique: c88EZO-mOBSgd9Uzu6XY3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, bharatb.linux@gmail.com,
 qemu-arm@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 25, 2020 at 06:19:52PM +0100, Eric Auger wrote:
> This patch adds virtio-iommu-pci, which is the pci proxy for
> the virtio-iommu device.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

I commented on v11 of this patch:
> > Could you send a smaller patchset without pci/acpi bits for now?
And you answered:
> Yes I am about to send v12.

I guess this patch is here by mistake then?

I think PCI devices should always have config space so guests are
not tempted to find work-arounds. Right?

> ---
>=20
> v11 -> v12:
> - added Jean's R-b
> - remove the array of intervals. Will be introduced later?
>=20
> v10 -> v11:
> - add the reserved_regions array property
>=20
> v9 -> v10:
> - include "hw/qdev-properties.h" header
>=20
> v8 -> v9:
> - add the msi-bypass property
> - create virtio-iommu-pci.c
> ---
>  hw/virtio/Makefile.objs          |  1 +
>  hw/virtio/virtio-iommu-pci.c     | 88 ++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h             |  1 +
>  include/hw/virtio/virtio-iommu.h |  1 +
>  qdev-monitor.c                   |  1 +
>  5 files changed, 92 insertions(+)
>  create mode 100644 hw/virtio/virtio-iommu-pci.c
>=20
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 2fd9da7410..4e4d39a0a4 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -29,6 +29,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-=
pci.o
>  obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
>  obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
>  obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon-pci.o
> +obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu-pci.o
>  obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-pci.o
>  obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-scsi-pci.o
>  obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk-pci.o
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> new file mode 100644
> index 0000000000..4cfae1f9df
> --- /dev/null
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -0,0 +1,88 @@
> +/*
> + * Virtio IOMMU PCI Bindings
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + * Written by Eric Auger
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "virtio-pci.h"
> +#include "hw/virtio/virtio-iommu.h"
> +#include "hw/qdev-properties.h"
> +
> +typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> +
> +/*
> + * virtio-iommu-pci: This extends VirtioPCIProxy.
> + *
> + */
> +#define VIRTIO_IOMMU_PCI(obj) \
> +        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
> +
> +struct VirtIOIOMMUPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOIOMMU vdev;
> +};
> +
> +static Property virtio_iommu_pci_properties[] =3D {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **e=
rrp)
> +{
> +    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_link(OBJECT(dev),
> +                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> +                             "primary-bus", errp);
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void virtio_iommu_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +    k->realize =3D virtio_iommu_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->props =3D virtio_iommu_pci_properties;
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_IOMMU;
> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_iommu_pci_instance_init(Object *obj)
> +{
> +    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_IOMMU);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info =3D {
> +    .base_name             =3D TYPE_VIRTIO_IOMMU_PCI,
> +    .generic_name          =3D "virtio-iommu-pci",
> +    .transitional_name     =3D "virtio-iommu-pci-transitional",
> +    .non_transitional_name =3D "virtio-iommu-pci-non-transitional",
> +    .instance_size =3D sizeof(VirtIOIOMMUPCI),
> +    .instance_init =3D virtio_iommu_pci_instance_init,
> +    .class_init    =3D virtio_iommu_pci_class_init,
> +};
> +
> +static void virtio_iommu_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_iommu_pci_info);
> +}
> +
> +type_init(virtio_iommu_pci_register)
> +
> +
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 2acd8321af..cfedf5a995 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -86,6 +86,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
>  #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
> +#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
> =20
>  #define PCI_VENDOR_ID_REDHAT             0x1b36
>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-=
iommu.h
> index 2a2c2ecf83..f39aa0fbb4 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -25,6 +25,7 @@
>  #include "hw/pci/pci.h"
> =20
>  #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
> +#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-device-base"
>  #define VIRTIO_IOMMU(obj) \
>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
> =20
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 3465a1e2d0..97f4022b51 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -66,6 +66,7 @@ static const QDevAlias qdev_alias_table[] =3D {
>      { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X },
>      { "virtio-input-host-pci", "virtio-input-host",
>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> +    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARCH_S39=
0X },
>      { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
>      { "virtio-keyboard-pci", "virtio-keyboard",
>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> --=20
> 2.20.1


