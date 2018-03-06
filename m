Received: from eggs.gnu.org ([2001:4830:134:3::10]:33795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etBPl-00034C-JO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etBPi-00088D-UN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:09:53 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etBPi-00087p-Nx
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:09:50 -0500
Received: by mail-ot0-x244.google.com with SMTP id t2so18118334otj.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 04:09:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-2-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-2-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 12:09:29 +0000
Message-ID: <CAFEAcA8pdpA1MUAyKNyAdM9QH6_n2NBvZPYdiFKK20N9FG2z1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 01/14] hw/arm/smmu-common: smmu base
 device and datatypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> The patch introduces the smmu base device and class for the ARM
> smmu. Devices for specific versions will be derived from this
> base device.
>
> We also introduce some important datatypes.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>

> + * Author: Prem Mallappa <pmallapp@broadcom.com>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "exec/address-spaces.h"
> +#include "trace.h"
> +#include "exec/target_page.h"
> +#include "qom/cpu.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +
> +#include "qemu/error-report.h"
> +#include "hw/arm/smmu-common.h"
> +
> +static void smmu_base_realize(DeviceState *dev, Error **errp)
> +{
> +    SMMUState *s = ARM_SMMU(dev);
> +
> +    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
> +    s->iotlb = g_hash_table_new_full(NULL, NULL, NULL, g_free);

Shouldn't we also invoke the parent_realize ?

> +}
> +
> +static void smmu_base_reset(DeviceState *dev)
> +{
> +    SMMUState *s = ARM_SMMU(dev);
> +
> +    g_hash_table_remove_all(s->configs);
> +    g_hash_table_remove_all(s->iotlb);
> +}
> +
> +static Property smmu_dev_properties[] = {
> +    DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
> +    DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus, "PCI", PCIBus *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void smmu_base_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    SMMUBaseClass *sbc = ARM_SMMU_CLASS(klass);
> +
> +    dc->props = smmu_dev_properties;
> +    sbc->parent_realize = dc->realize;
> +    dc->realize = smmu_base_realize;

There's a device_class_set_parent_realize() in the tree now that
we should probably use instead of these 2 lines:
       device_class_set_parent_realize(dc, smmu_base_realize,
                                       &sbc->parent_realize);

> +    dc->reset = smmu_base_reset;
> +}
> +
> +static const TypeInfo smmu_base_info = {
> +    .name          = TYPE_ARM_SMMU,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SMMUState),
> +    .class_data    = NULL,
> +    .class_size    = sizeof(SMMUBaseClass),
> +    .class_init    = smmu_base_class_init,
> +    .abstract      = true,
> +};
> +
> +static void smmu_base_register_types(void)
> +{
> +    type_register_static(&smmu_base_info);
> +}
> +
> +type_init(smmu_base_register_types)
> +
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> new file mode 100644
> index 0000000..8a9d931
> --- /dev/null
> +++ b/include/hw/arm/smmu-common.h
> @@ -0,0 +1,124 @@
> +/*
> + * ARM SMMU Support
> + *
> + * Copyright (C) 2015-2016 Broadcom Corporation
> + * Copyright (c) 2017 Red Hat, Inc.
> + * Written by Prem Mallappa, Eric Auger
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef HW_ARM_SMMU_COMMON_H
> +#define HW_ARM_SMMU_COMMON_H
> +
> +#include <hw/sysbus.h>

QEMU headers should be included using "", not <>.

> +#include "hw/pci/pci.h"
> +
> +#define SMMU_PCI_BUS_MAX      256
> +#define SMMU_PCI_DEVFN_MAX    256
> +
> +#define SMMU_MAX_VA_BITS      48
> +
> +/*
> + * Page table walk error types
> + */
> +typedef enum {
> +    SMMU_PTW_ERR_NONE,
> +    SMMU_PTW_ERR_WALK_EABT,   /* Translation walk external abort */
> +    SMMU_PTW_ERR_TRANSLATION, /* Translation fault */
> +    SMMU_PTW_ERR_ADDR_SIZE,   /* Address Size fault */
> +    SMMU_PTW_ERR_ACCESS,      /* Access fault */
> +    SMMU_PTW_ERR_PERMISSION,  /* Permission fault */
> +} SMMUPTWEventType;
> +
> +typedef struct SMMUPTWEventInfo {
> +    SMMUPTWEventType type;
> +    dma_addr_t addr; /* fetched address that induced an abort, if any */
> +} SMMUPTWEventInfo;
> +
> +typedef struct SMMUTransTableInfo {
> +    bool disabled;             /* is the translation table disabled? */
> +    uint64_t ttb;              /* TT base address */
> +    uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
> +    uint8_t granule_sz;        /* granule page shift */
> +    uint8_t initial_level;     /* initial lookup level */
> +} SMMUTransTableInfo;
> +
> +/*
> + * Generic structure populated by derived SMMU devices
> + * after decoding the configuration information and used as
> + * input to the page table walk
> + */
> +typedef struct SMMUTransCfg {
> +    int      stage;            /* translation stage */
> +    bool     aa64;             /* arch64 or aarch32 translation table */
> +    bool     disabled;         /* smmu is disabled */
> +    bool     bypassed;         /* translation is bypassed */
> +    bool     aborted;          /* translation is aborted */
> +    uint64_t ttb;              /* TT base address */
> +    uint8_t oas;               /* output address width */
> +    uint8_t  tbi;              /* Top Byte Ignore */
> +    uint16_t asid;
> +    SMMUTransTableInfo tt[2];

Can you be consistent about either lining up the field names or not doing so,
please? (I would suggest going for 'not'.)

> +} SMMUTransCfg;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
