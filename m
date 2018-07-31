Received: from eggs.gnu.org ([2001:4830:134:3::10]:42207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fkX2t-0006o9-UG
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fkX2p-0007dE-RC
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:58:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fkX2p-0007d2-Fq
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:58:43 -0400
Date: Tue, 31 Jul 2018 10:58:37 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180731155837.GA15528@troi>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180629221907.3662-4-venu.busireddy@oracle.com>
	<5548ad79-6864-d25a-d78d-bd8328422c04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5548ad79-6864-d25a-d78d-bd8328422c04@gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 3/3] Add "Group Identifier"
 support to Red Hat PCI Express bridge.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 2018-07-07 15:14:11 +0300, Marcel Apfelbaum wrote:
> Hi Venu,
> 
> On 06/30/2018 01:19 AM, Venu Busireddy wrote:
> > Add a new bridge device "pcie-downstream" with a
> > Vendor ID of PCI_VENDOR_ID_REDHAT and a Device ID of
> > PCI_DEVICE_ID_REDHAT_DOWNPORT_FAILOVER.
> 
> Can't we use the current pcie-pci-bridge device (see
> hw/pci-bridge/pcie_pci_bridge.c)
> by adding the new vendor capability to it so we will not need to support a
> new bridge?

Sorry for the delayed response. I was away on vacation.

This question is probably better answered by Michael, but me let me try.
Michael suggested adding a new device to avoid confusion with existing
bridge devices.

Venu


> 
> Thanks,
> Marcel
> 
> >   Also, add the "Vendor-Specific"
> > capability to the bridge to contain the "Group Identifier" that will be
> > used to pair a virtio device with the passthrough device attached to
> > that bridge.
> > 
> > This capability is added to the bridge iff the "failover-group-id"
> > option is specified for the bridge.
> > 
> > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > ---
> >   default-configs/arm-softmmu.mak    |   1 +
> >   default-configs/i386-softmmu.mak   |   1 +
> >   default-configs/x86_64-softmmu.mak |   1 +
> >   hw/pci-bridge/Makefile.objs        |   1 +
> >   hw/pci-bridge/pcie_downstream.c    | 220 +++++++++++++++++++++++++++++
> >   hw/pci-bridge/pcie_downstream.h    |  10 ++
> >   include/hw/pci/pci.h               |   1 +
> >   7 files changed, 235 insertions(+)
> >   create mode 100644 hw/pci-bridge/pcie_downstream.c
> >   create mode 100644 hw/pci-bridge/pcie_downstream.h
> > 
> > diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> > index 834d45cfaf..b86c6fb122 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -139,6 +139,7 @@ CONFIG_IMX_I2C=y
> >   CONFIG_PCIE_PORT=y
> >   CONFIG_XIO3130=y
> >   CONFIG_IOH3420=y
> > +CONFIG_PCIE_DOWNSTREAM=y
> >   CONFIG_I82801B11=y
> >   CONFIG_ACPI=y
> >   CONFIG_SMBIOS=y
> > diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> > index 8c7d4a0fa0..a900c8f052 100644
> > --- a/default-configs/i386-softmmu.mak
> > +++ b/default-configs/i386-softmmu.mak
> > @@ -56,6 +56,7 @@ CONFIG_ACPI_NVDIMM=y
> >   CONFIG_PCIE_PORT=y
> >   CONFIG_XIO3130=y
> >   CONFIG_IOH3420=y
> > +CONFIG_PCIE_DOWNSTREAM=y
> >   CONFIG_I82801B11=y
> >   CONFIG_SMBIOS=y
> >   CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> > diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> > index 0390b4303c..481e4764be 100644
> > --- a/default-configs/x86_64-softmmu.mak
> > +++ b/default-configs/x86_64-softmmu.mak
> > @@ -56,6 +56,7 @@ CONFIG_ACPI_NVDIMM=y
> >   CONFIG_PCIE_PORT=y
> >   CONFIG_XIO3130=y
> >   CONFIG_IOH3420=y
> > +CONFIG_PCIE_DOWNSTREAM=y
> >   CONFIG_I82801B11=y
> >   CONFIG_SMBIOS=y
> >   CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> > diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
> > index 47065f87d9..5b42212edc 100644
> > --- a/hw/pci-bridge/Makefile.objs
> > +++ b/hw/pci-bridge/Makefile.objs
> > @@ -3,6 +3,7 @@ common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o pcie_pci
> >   common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
> >   common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
> >   common-obj-$(CONFIG_IOH3420) += ioh3420.o
> > +common-obj-$(CONFIG_PCIE_DOWNSTREAM) += pcie_downstream.o
> >   common-obj-$(CONFIG_I82801B11) += i82801b11.o
> >   # NewWorld PowerMac
> >   common-obj-$(CONFIG_DEC_PCI) += dec.o
> > diff --git a/hw/pci-bridge/pcie_downstream.c b/hw/pci-bridge/pcie_downstream.c
> > new file mode 100644
> > index 0000000000..49b0d1e933
> > --- /dev/null
> > +++ b/hw/pci-bridge/pcie_downstream.c
> > @@ -0,0 +1,220 @@
> > +/*
> > + * Red Hat PCI Express downstream port.
> > + *
> > + * pcie_downstream.c
> > + * Most of this code is copied from xio3130_downstream.c
> > + *
> > + * Copyright (c) 2018 Oracle and/or its affiliates.
> > + *         Author: Venu Busireddy <venu.busireddy@oracle.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/pci/pci_ids.h"
> > +#include "hw/pci/msi.h"
> > +#include "hw/pci/pcie.h"
> > +#include "pcie_downstream.h"
> > +#include "qapi/error.h"
> > +
> > +#define REDHAT_PCIE_DOWNSTREAM_REVISION                 0x1
> > +#define REDHAT_PCIE_DOWNSTREAM_MSI_OFFSET               0x70
> > +#define REDHAT_PCIE_DOWNSTREAM_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_64BIT
> > +#define REDHAT_PCIE_DOWNSTREAM_MSI_NR_VECTOR            1
> > +#define REDHAT_PCIE_DOWNSTREAM_SSVID_OFFSET             0x80
> > +#define REDHAT_PCIE_DOWNSTREAM_SSVID_SVID               0
> > +#define REDHAT_PCIE_DOWNSTREAM_SSVID_SSID               0
> > +#define REDHAT_PCIE_DOWNSTREAM_EXP_OFFSET               0x90
> > +#define REDHAT_PCIE_DOWNSTREAM_VENDOR_OFFSET            0xCC
> > +#define REDHAT_PCIE_DOWNSTREAM_AER_OFFSET               0x100
> > +
> > +static void pcie_downstream_write_config(PCIDevice *d, uint32_t address,
> > +                                         uint32_t val, int len)
> > +{
> > +    pci_bridge_write_config(d, address, val, len);
> > +    pcie_cap_flr_write_config(d, address, val, len);
> > +    pcie_cap_slot_write_config(d, address, val, len);
> > +    pcie_aer_write_config(d, address, val, len);
> > +}
> > +
> > +static void pcie_downstream_reset(DeviceState *qdev)
> > +{
> > +    PCIDevice *d = PCI_DEVICE(qdev);
> > +
> > +    pcie_cap_deverr_reset(d);
> > +    pcie_cap_slot_reset(d);
> > +    pcie_cap_arifwd_reset(d);
> > +    pci_bridge_reset(qdev);
> > +}
> > +
> > +static void pcie_downstream_realize(PCIDevice *d, Error **errp)
> > +{
> > +    PCIEPort *p = PCIE_PORT(d);
> > +    PCIESlot *s = PCIE_SLOT(d);
> > +    int rc;
> > +
> > +    pci_bridge_initfn(d, TYPE_PCIE_BUS);
> > +    pcie_port_init_reg(d);
> > +
> > +    rc = pci_bridge_vendor_init(d, REDHAT_PCIE_DOWNSTREAM_VENDOR_OFFSET,
> > +            PCI_DEVICE_ID_REDHAT_DOWNPORT_FAILOVER, errp);
> > +    if (rc < 0) {
> > +        error_append_hint(errp, "Can't init group ID, error %d\n", rc);
> > +        goto err_bridge;
> > +    }
> > +
> > +    rc = msi_init(d, REDHAT_PCIE_DOWNSTREAM_MSI_OFFSET,
> > +            REDHAT_PCIE_DOWNSTREAM_MSI_NR_VECTOR,
> > +            REDHAT_PCIE_DOWNSTREAM_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
> > +            REDHAT_PCIE_DOWNSTREAM_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
> > +            errp);
> > +    if (rc < 0) {
> > +        assert(rc == -ENOTSUP);
> > +        goto err_bridge;
> > +    }
> > +
> > +    rc = pci_bridge_ssvid_init(d, REDHAT_PCIE_DOWNSTREAM_SSVID_OFFSET,
> > +            REDHAT_PCIE_DOWNSTREAM_SSVID_SVID,
> > +            REDHAT_PCIE_DOWNSTREAM_SSVID_SSID, errp);
> > +    if (rc < 0) {
> > +        goto err_bridge;
> > +    }
> > +
> > +    rc = pcie_cap_init(d, REDHAT_PCIE_DOWNSTREAM_EXP_OFFSET,
> > +            PCI_EXP_TYPE_DOWNSTREAM, p->port, errp);
> > +    if (rc < 0) {
> > +        goto err_msi;
> > +    }
> > +    pcie_cap_flr_init(d);
> > +    pcie_cap_deverr_init(d);
> > +    pcie_cap_slot_init(d, s->slot);
> > +    pcie_cap_arifwd_init(d);
> > +
> > +    pcie_chassis_create(s->chassis);
> > +    rc = pcie_chassis_add_slot(s);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Can't add chassis slot, error %d", rc);
> > +        goto err_pcie_cap;
> > +    }
> > +
> > +    rc = pcie_aer_init(d, PCI_ERR_VER, REDHAT_PCIE_DOWNSTREAM_AER_OFFSET,
> > +            PCI_ERR_SIZEOF, errp);
> > +    if (rc < 0) {
> > +        goto err;
> > +    }
> > +
> > +    return;
> > +
> > +err:
> > +    pcie_chassis_del_slot(s);
> > +err_pcie_cap:
> > +    pcie_cap_exit(d);
> > +err_msi:
> > +    msi_uninit(d);
> > +err_bridge:
> > +    pci_bridge_exitfn(d);
> > +}
> > +
> > +static void pcie_downstream_exitfn(PCIDevice *d)
> > +{
> > +    PCIESlot *s = PCIE_SLOT(d);
> > +
> > +    pcie_aer_exit(d);
> > +    pcie_chassis_del_slot(s);
> > +    pcie_cap_exit(d);
> > +    msi_uninit(d);
> > +    pci_bridge_exitfn(d);
> > +}
> > +
> > +PCIESlot *pcie_downstream_init(PCIBus *bus, int devfn, bool multifunction,
> > +                               const char *bus_name, pci_map_irq_fn map_irq,
> > +                               uint8_t port, uint8_t chassis, uint16_t slot)
> > +{
> > +    PCIDevice *d;
> > +    PCIBridge *br;
> > +    DeviceState *qdev;
> > +
> > +    d = pci_create_multifunction(bus, devfn, multifunction, "pcie-downstream");
> > +    if (!d) {
> > +        return NULL;
> > +    }
> > +    br = PCI_BRIDGE(d);
> > +
> > +    qdev = DEVICE(d);
> > +    pci_bridge_map_irq(br, bus_name, map_irq);
> > +    qdev_prop_set_uint8(qdev, "port", port);
> > +    qdev_prop_set_uint8(qdev, "chassis", chassis);
> > +    qdev_prop_set_uint16(qdev, "slot", slot);
> > +    qdev_init_nofail(qdev);
> > +
> > +    return PCIE_SLOT(d);
> > +}
> > +
> > +static Property pcie_downstream_props[] = {
> > +    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> > +            QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> > +    DEFINE_PROP_UINT64(COMPAT_PROP_FAILOVER_GROUP_ID,
> > +            PCIDevice, failover_group_id, ULLONG_MAX),
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> > +
> > +static const VMStateDescription vmstate_pcie_ds = {
> > +    .name = "pcie-downstream-port",
> > +    .priority = MIG_PRI_PCI_BUS,
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .post_load = pcie_cap_slot_post_load,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> > +        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
> > +                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void pcie_downstream_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> > +
> > +    k->is_bridge = 1;
> > +    k->config_write = pcie_downstream_write_config;
> > +    k->realize = pcie_downstream_realize;
> > +    k->exit = pcie_downstream_exitfn;
> > +    k->vendor_id = PCI_VENDOR_ID_REDHAT;
> > +    k->device_id = PCI_DEVICE_ID_REDHAT_DOWNPORT_FAILOVER;
> > +    k->revision = REDHAT_PCIE_DOWNSTREAM_REVISION;
> > +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> > +    dc->desc = "Red Hat PCIe Downstream Port";
> > +    dc->reset = pcie_downstream_reset;
> > +    dc->vmsd = &vmstate_pcie_ds;
> > +    dc->props = pcie_downstream_props;
> > +}
> > +
> > +static const TypeInfo pcie_downstream_info = {
> > +    .name          = "pcie-downstream",
> > +    .parent        = TYPE_PCIE_SLOT,
> > +    .class_init    = pcie_downstream_class_init,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        { INTERFACE_PCIE_DEVICE },
> > +        { }
> > +    },
> > +};
> > +
> > +static void pcie_downstream_register_types(void)
> > +{
> > +    type_register_static(&pcie_downstream_info);
> > +}
> > +
> > +type_init(pcie_downstream_register_types)
> > diff --git a/hw/pci-bridge/pcie_downstream.h b/hw/pci-bridge/pcie_downstream.h
> > new file mode 100644
> > index 0000000000..a7f1aae4bb
> > --- /dev/null
> > +++ b/hw/pci-bridge/pcie_downstream.h
> > @@ -0,0 +1,10 @@
> > +#ifndef QEMU_PCIE_DOWNSTREAM_H
> > +#define QEMU_PCIE_DOWNSTREAM_H
> > +
> > +#include "hw/pci/pcie_port.h"
> > +
> > +PCIESlot *pcie_downstream_init(PCIBus *bus, int devfn, bool multifunction,
> > +        const char *bus_name, pci_map_irq_fn map_irq, uint8_t port,
> > +        uint8_t chassis, uint16_t slot);
> > +
> > +#endif /* QEMU_PCIE_DOWNSTREAM_H */
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index bc38032761..bf04ef59f3 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -103,6 +103,7 @@ extern bool pci_available;
> >   #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE        0x000e
> >   #define PCI_DEVICE_ID_REDHAT_MDPY               0x000f
> >   #define PCI_DEVICE_ID_REDHAT_BRIDGE_FAILOVER    0x0010
> > +#define PCI_DEVICE_ID_REDHAT_DOWNPORT_FAILOVER  0x0011
> >   #define PCI_DEVICE_ID_REDHAT_QXL                0x0100
> >   #define FMT_PCIBUS                      PRIx64
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> 
