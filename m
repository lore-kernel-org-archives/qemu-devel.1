Received: from eggs.gnu.org ([2001:4830:134:3::10]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRhQp-00049R-VG
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRhQk-0000Fb-Vy
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:36:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRhQk-0000EX-My
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:36:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A07BD4E4CD
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 15:36:46 +0000 (UTC)
Date: Thu, 12 Jan 2017 17:36:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112173106-mutt-send-email-mst@kernel.org>
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
	<1484137136-8021-2-git-send-email-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484137136-8021-2-git-send-email-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 1/3] hw/pcie: Introduce a base class for
 PCI Express Root Ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 11, 2017 at 02:18:54PM +0200, Marcel Apfelbaum wrote:
> The 'base' PCI Express Root Port includes
> the common code to be re-used for all
> Root Ports implementations. Most of the code
> was taken from the current implementation
> of Intel's IOH 3420 Root Port.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  default-configs/arm-softmmu.mak    |   1 +
>  default-configs/i386-softmmu.mak   |   1 +
>  default-configs/x86_64-softmmu.mak |   1 +
>  hw/pci-bridge/Makefile.objs        |   1 +
>  hw/pci-bridge/pcie_root_port.c     | 194 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie_port.h         |  18 ++++
>  6 files changed, 216 insertions(+)
>  create mode 100644 hw/pci-bridge/pcie_root_port.c
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6de3e16..6f2a180 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -108,6 +108,7 @@ CONFIG_FSL_IMX25=y
>  
>  CONFIG_IMX_I2C=y
>  
> +CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 0b51360..9288838 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -51,6 +51,7 @@ CONFIG_PVPANIC=y
>  CONFIG_MEM_HOTPLUG=y
>  CONFIG_NVDIMM=y
>  CONFIG_ACPI_NVDIMM=y
> +CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 7f89503..7d2c2d4 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -51,6 +51,7 @@ CONFIG_PVPANIC=y
>  CONFIG_MEM_HOTPLUG=y
>  CONFIG_NVDIMM=y
>  CONFIG_ACPI_NVDIMM=y
> +CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
> index f2adfe3..4f2039f 100644
> --- a/hw/pci-bridge/Makefile.objs
> +++ b/hw/pci-bridge/Makefile.objs
> @@ -1,5 +1,6 @@
>  common-obj-y += pci_bridge_dev.o
>  common-obj-y += pci_expander_bridge.o
> +common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o
>  common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
>  common-obj-$(CONFIG_IOH3420) += ioh3420.o
>  common-obj-$(CONFIG_I82801B11) += i82801b11.o
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> new file mode 100644
> index 0000000..e84ae14
> --- /dev/null
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -0,0 +1,194 @@
> +/*
> + * Generic PCI Express Root Port emulation
> + *
> + * Copyright (C) 2016 Red Hat Inc
> + *
> + * Authors:
> + *   Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * Most of the code was migrated from hw/pci-bridge/ioh3420.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/pci/pcie_port.h"
> +#include "hw/pci/msi.h"
> +
> +#define PCIE_ROOT_PORT_MSI_VECTORS              2
> +#define PCIE_ROOT_PORT_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_MASKBIT
> +#define PCIE_ROOT_PORT_AER_OFFSET               0x100

This isn't generic either.

> +
> +/*
> + * If two MSI vector


MSI vectors

> are allocated, Advanced Error Interrupt Message Number
> + * is 1. otherwise 0.
> + * 17.12.5.10 RPERRSTS,  32:27 bit Advanced Error Interrupt Message Number.

Hmm I see it in
7.10.10. Root Error Status Register (Offset 30h)

which spec is this number from?


> + */
> +static uint8_t rp_aer_vector(const PCIDevice *d)
> +{
> +    switch (msi_nr_vectors_allocated(d)) {
> +    case 1:
> +        return 0;
> +    case 2:
> +        return 1;
> +    case 4:
> +    case 8:
> +    case 16:
> +    case 32:

what are these doing here?

> +    default:
> +        break;
> +    }
> +    abort();
> +    return 0;
> +}

I don't believe it's a generic thing. This is just how
intel did it, isn't it?


> +
> +static void rp_aer_vector_update(PCIDevice *d)
> +{
> +    pcie_aer_root_set_vector(d, rp_aer_vector(d));
> +}
> +
> +static void rp_write_config(PCIDevice *d, uint32_t address,
> +                            uint32_t val, int len)
> +{
> +    uint32_t root_cmd =
> +        pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
> +
> +    pci_bridge_write_config(d, address, val, len);
> +    rp_aer_vector_update(d);
> +    pcie_cap_slot_write_config(d, address, val, len);
> +    pcie_aer_write_config(d, address, val, len);
> +    pcie_aer_root_write_config(d, address, val, len, root_cmd);
> +}
> +
> +static void rp_reset(DeviceState *qdev)
> +{
> +    PCIDevice *d = PCI_DEVICE(qdev);
> +
> +    rp_aer_vector_update(d);
> +    pcie_cap_root_reset(d);
> +    pcie_cap_deverr_reset(d);
> +    pcie_cap_slot_reset(d);
> +    pcie_cap_arifwd_reset(d);
> +    pcie_aer_root_reset(d);
> +    pci_bridge_reset(qdev);
> +    pci_bridge_disable_base_limit(d);
> +}
> +
> +static void rp_realize(PCIDevice *d, Error **errp)
> +{
> +    PCIEPort *p = PCIE_PORT(d);
> +    PCIESlot *s = PCIE_SLOT(d);
> +    PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
> +    int rc;
> +    Error *local_err = NULL;
> +
> +    pci_config_set_interrupt_pin(d->config, 1);
> +    pci_bridge_initfn(d, TYPE_PCIE_BUS);
> +    pcie_port_init_reg(d);
> +
> +    rc = pci_bridge_ssvid_init(d, rpc->ssvid_offset, dc->vendor_id, rpc->ssid);
> +    if (rc < 0) {
> +        error_setg(errp, "Can't init SSV ID, error %d", rc);
> +        goto err_bridge;
> +    }
> +
> +    rc = msi_init(d, rpc->msi_offset, PCIE_ROOT_PORT_MSI_VECTORS,
> +                  PCIE_ROOT_PORT_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
> +                  PCIE_ROOT_PORT_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
> +                  &local_err);
> +    if (rc < 0) {
> +        assert(rc == -ENOTSUP);
> +        error_propagate(errp, local_err);
> +        goto err_bridge;
> +    }
> +
> +    rc = pcie_cap_init(d, rpc->exp_offset, PCI_EXP_TYPE_ROOT_PORT, p->port);
> +    if (rc < 0) {
> +        error_setg(errp, "Can't add Root Port capability, error %d", rc);
> +        goto err_msi;
> +    }
> +
> +    pcie_cap_arifwd_init(d);
> +    pcie_cap_deverr_init(d);
> +    pcie_cap_slot_init(d, s->slot);
> +    pcie_cap_root_init(d);
> +
> +    pcie_chassis_create(s->chassis);
> +    rc = pcie_chassis_add_slot(s);
> +    if (rc < 0) {
> +        error_setg(errp, "Can't add chassis slot, error %d", rc);
> +        goto err_pcie_cap;
> +    }
> +
> +    rc = pcie_aer_init(d, PCI_ERR_VER, rpc->aer_offset,
> +                       PCI_ERR_SIZEOF, &local_err);
> +    if (rc < 0) {
> +        error_propagate(errp, local_err);
> +        goto err;
> +    }
> +    pcie_aer_root_init(d);
> +    rp_aer_vector_update(d);
> +
> +    return;
> +
> +err:
> +    pcie_chassis_del_slot(s);
> +err_pcie_cap:
> +    pcie_cap_exit(d);
> +err_msi:
> +    msi_uninit(d);
> +err_bridge:
> +    pci_bridge_exitfn(d);
> +}
> +
> +static void rp_exit(PCIDevice *d)
> +{
> +    PCIESlot *s = PCIE_SLOT(d);
> +
> +    pcie_aer_exit(d);
> +    pcie_chassis_del_slot(s);
> +    pcie_cap_exit(d);
> +    msi_uninit(d);
> +    pci_bridge_exitfn(d);
> +}
> +
> +static Property rp_props[] = {
> +    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> +                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void rp_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
> +
> +    k->is_express = 1;
> +    k->is_bridge = 1;
> +    k->config_write = rp_write_config;
> +    k->realize = rp_realize;
> +    k->exit = rp_exit;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->reset = rp_reset;
> +    dc->props = rp_props;
> +    rpc->aer_offset = PCIE_ROOT_PORT_AER_OFFSET;
> +}
> +
> +static const TypeInfo rp_info = {
> +    .name          = TYPE_PCIE_ROOT_PORT,
> +    .parent        = TYPE_PCIE_SLOT,
> +    .class_init    = rp_class_init,
> +    .abstract      = true,
> +    .class_size = sizeof(PCIERootPortClass),
> +};
> +
> +static void rp_register_types(void)
> +{
> +    type_register_static(&rp_info);
> +}
> +
> +type_init(rp_register_types)
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index f7b64db..a8eee56 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -57,4 +57,22 @@ PCIESlot *pcie_chassis_find_slot(uint8_t chassis, uint16_t slot);
>  int pcie_chassis_add_slot(struct PCIESlot *slot);
>  void pcie_chassis_del_slot(PCIESlot *s);
>  
> +#define TYPE_PCIE_ROOT_PORT         "pcie-root-port-base"
> +#define PCIE_ROOT_PORT_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(PCIERootPortClass, (klass), TYPE_PCIE_ROOT_PORT)
> +#define PCIE_ROOT_PORT_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(PCIERootPortClass, (klass), TYPE_PCIE_ROOT_PORT)
> +#define PCIE_ROOT_PORT_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(PCIERootPortClass, (obj), TYPE_PCIE_ROOT_PORT)
> +
> +typedef struct PCIERootPortClass {
> +    PCIDeviceClass parent_class;
> +
> +    int msi_offset;
> +    int exp_offset;
> +    int aer_offset;
> +    int ssvid_offset;
> +    int ssid;
> +} PCIERootPortClass;
> +
>  #endif /* QEMU_PCIE_PORT_H */
> -- 
> 2.5.5
