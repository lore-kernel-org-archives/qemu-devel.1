Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF79C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D096B20674
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aao1Xk9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D096B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybg1-0005A9-0U
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iybfB-0004io-L3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iybfA-0001D4-1H
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:21:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33088
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iybf9-0001Ch-Sm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580736075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utXAOcPSDBxEbFLOeCWUxz3rn5iEkDlYHZik124EMrE=;
 b=aao1Xk9Mz/HTfaiKW2kAVInx7Pc2c/glr1380YP2iFcqgIOpml6KnBXm4n/NLeXvH0A+jl
 lJ542D1jHqiSsS6QRh02xAX/O056FuK836IQrK399mybOQfK10QpvrZGB4Mxo/hxAvj+BP
 norMIA0DwfzaBVAoLLSEy4lkj9IyPvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-HzboTvEPOoim4TPJ34MTIA-1; Mon, 03 Feb 2020 08:21:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C32213E6;
 Mon,  3 Feb 2020 13:21:08 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 078A32103;
 Mon,  3 Feb 2020 13:20:57 +0000 (UTC)
Subject: Re: [PATCH v13 07/10] virtio-iommu-pci: Add virtio iommu pci support
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-8-eric.auger@redhat.com>
 <20200203080122-mutt-send-email-mst@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <037666c2-6124-0db6-3688-a134f9f0845a@redhat.com>
Date: Mon, 3 Feb 2020 14:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203080122-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HzboTvEPOoim4TPJ34MTIA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 2/3/20 2:03 PM, Michael S. Tsirkin wrote:
> On Sat, Jan 25, 2020 at 06:19:52PM +0100, Eric Auger wrote:
>> This patch adds virtio-iommu-pci, which is the pci proxy for
>> the virtio-iommu device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> I commented on v11 of this patch:
>>> Could you send a smaller patchset without pci/acpi bits for now?
> And you answered:
>> Yes I am about to send v12.
> 
> I guess this patch is here by mistake then?
> 
> I think PCI devices should always have config space so guests are
> not tempted to find work-arounds. Right?
No it is not here by mistake. I removed everything related non DT
integration as we discussed.

DT support is fully upstream even for virtio-iommu-pci.
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/virtio/iommu.txt

So what's wrong implementing that at the moment. As we discussed we
would use the PCIe config space integration for non DT.

If I use the MMIO based device, I am forced to lock an MMIO region for
it in the machvirt memory map:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/virtio/mmio.txt

I guess Peter (Maydell) will not be happy with this situation either.

Thanks

Eric

> 
>> ---
>>
>> v11 -> v12:
>> - added Jean's R-b
>> - remove the array of intervals. Will be introduced later?
>>
>> v10 -> v11:
>> - add the reserved_regions array property
>>
>> v9 -> v10:
>> - include "hw/qdev-properties.h" header
>>
>> v8 -> v9:
>> - add the msi-bypass property
>> - create virtio-iommu-pci.c
>> ---
>>  hw/virtio/Makefile.objs          |  1 +
>>  hw/virtio/virtio-iommu-pci.c     | 88 ++++++++++++++++++++++++++++++++
>>  include/hw/pci/pci.h             |  1 +
>>  include/hw/virtio/virtio-iommu.h |  1 +
>>  qdev-monitor.c                   |  1 +
>>  5 files changed, 92 insertions(+)
>>  create mode 100644 hw/virtio/virtio-iommu-pci.c
>>
>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>> index 2fd9da7410..4e4d39a0a4 100644
>> --- a/hw/virtio/Makefile.objs
>> +++ b/hw/virtio/Makefile.objs
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
>>  obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
>>  obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
>>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
>> +obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu-pci.o
>>  obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
>>  obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
>>  obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
>> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
>> new file mode 100644
>> index 0000000000..4cfae1f9df
>> --- /dev/null
>> +++ b/hw/virtio/virtio-iommu-pci.c
>> @@ -0,0 +1,88 @@
>> +/*
>> + * Virtio IOMMU PCI Bindings
>> + *
>> + * Copyright (c) 2019 Red Hat, Inc.
>> + * Written by Eric Auger
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 or
>> + *  (at your option) any later version.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "virtio-pci.h"
>> +#include "hw/virtio/virtio-iommu.h"
>> +#include "hw/qdev-properties.h"
>> +
>> +typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
>> +
>> +/*
>> + * virtio-iommu-pci: This extends VirtioPCIProxy.
>> + *
>> + */
>> +#define VIRTIO_IOMMU_PCI(obj) \
>> +        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
>> +
>> +struct VirtIOIOMMUPCI {
>> +    VirtIOPCIProxy parent_obj;
>> +    VirtIOIOMMU vdev;
>> +};
>> +
>> +static Property virtio_iommu_pci_properties[] = {
>> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>> +{
>> +    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
>> +    DeviceState *vdev = DEVICE(&dev->vdev);
>> +
>> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>> +    object_property_set_link(OBJECT(dev),
>> +                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
>> +                             "primary-bus", errp);
>> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>> +}
>> +
>> +static void virtio_iommu_pci_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
>> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>> +    k->realize = virtio_iommu_pci_realize;
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +    dc->props = virtio_iommu_pci_properties;
>> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_IOMMU;
>> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
>> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
>> +}
>> +
>> +static void virtio_iommu_pci_instance_init(Object *obj)
>> +{
>> +    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(obj);
>> +
>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> +                                TYPE_VIRTIO_IOMMU);
>> +}
>> +
>> +static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
>> +    .base_name             = TYPE_VIRTIO_IOMMU_PCI,
>> +    .generic_name          = "virtio-iommu-pci",
>> +    .transitional_name     = "virtio-iommu-pci-transitional",
>> +    .non_transitional_name = "virtio-iommu-pci-non-transitional",
>> +    .instance_size = sizeof(VirtIOIOMMUPCI),
>> +    .instance_init = virtio_iommu_pci_instance_init,
>> +    .class_init    = virtio_iommu_pci_class_init,
>> +};
>> +
>> +static void virtio_iommu_pci_register(void)
>> +{
>> +    virtio_pci_types_register(&virtio_iommu_pci_info);
>> +}
>> +
>> +type_init(virtio_iommu_pci_register)
>> +
>> +
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index 2acd8321af..cfedf5a995 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -86,6 +86,7 @@ extern bool pci_available;
>>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
>>  #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
>> +#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
>>  
>>  #define PCI_VENDOR_ID_REDHAT             0x1b36
>>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index 2a2c2ecf83..f39aa0fbb4 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -25,6 +25,7 @@
>>  #include "hw/pci/pci.h"
>>  
>>  #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
>> +#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-device-base"
>>  #define VIRTIO_IOMMU(obj) \
>>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
>>  
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 3465a1e2d0..97f4022b51 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -66,6 +66,7 @@ static const QDevAlias qdev_alias_table[] = {
>>      { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X },
>>      { "virtio-input-host-pci", "virtio-input-host",
>>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
>> +    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
>>      { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
>>      { "virtio-keyboard-pci", "virtio-keyboard",
>>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
>> -- 
>> 2.20.1
> 
> 


