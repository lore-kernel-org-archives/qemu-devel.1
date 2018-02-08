Received: from eggs.gnu.org ([2001:4830:134:3::10]:43207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejsPb-0003Un-C6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejsPY-0004Vz-TN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:03:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180208194226-mutt-send-email-mst@kernel.org>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-11-andrew.smirnov@gmail.com>
	<20180208194226-mutt-send-email-mst@kernel.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Feb 2018 12:03:04 -0800
Message-ID: <CAHQ1cqGZHie0sYudPGr-15LOEjMRT05=0+tsViKfCJBnN96Nag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 10/14] pci: Add support for Designware
 IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Feb 8, 2018 at 9:45 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Feb 06, 2018 at 08:24:34PM -0800, Andrey Smirnov wrote:
>> Add code needed to get a functional PCI subsytem when using in
>> conjunction with upstream Linux guest (4.13+). Tested to work against
>> "e1000e" (network adapter, using MSI interrupts) as well as
>> "usb-ehci" (USB controller, using legacy PCI interrupts).
>>
>> Based on "i.MX6 Applications Processor Reference Manual" (Document
>> Number: IMX6DQRM Rev. 4) as well as corresponding dirver in Linux
>> kernel (circa 4.13 - 4.16 found in drivers/pci/dwc/*)
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  default-configs/arm-softmmu.mak  |   2 +
>>  hw/pci-host/Makefile.objs        |   2 +
>>  hw/pci-host/designware.c         | 759 ++++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/pci-host/designware.h |  97 +++++
>>  include/hw/pci/pci_ids.h         |   2 +
>>  5 files changed, 862 insertions(+)
>>  create mode 100644 hw/pci-host/designware.c
>>  create mode 100644 include/hw/pci-host/designware.h
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softm=
mu.mak
>> index b0d6e65038..0c5ae914ed 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -132,3 +132,5 @@ CONFIG_GPIO_KEY=3Dy
>>  CONFIG_MSF2=3Dy
>>  CONFIG_FW_CFG_DMA=3Dy
>>  CONFIG_XILINX_AXI=3Dy
>> +CONFIG_PCI_DESIGNWARE=3Dy
>> +
>> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
>> index 4b69f737b5..6d6597c065 100644
>> --- a/hw/pci-host/Makefile.objs
>> +++ b/hw/pci-host/Makefile.objs
>> @@ -17,3 +17,5 @@ common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
>>  common-obj-$(CONFIG_PCI_Q35) +=3D q35.o
>>  common-obj-$(CONFIG_PCI_GENERIC) +=3D gpex.o
>>  common-obj-$(CONFIG_PCI_XILINX) +=3D xilinx-pcie.o
>> +
>> +common-obj-$(CONFIG_PCI_DESIGNWARE) +=3D designware.o
>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>> new file mode 100644
>> index 0000000000..551a881af0
>> --- /dev/null
>> +++ b/hw/pci-host/designware.c
>> @@ -0,0 +1,759 @@
>> +/*
>> + * Copyright (c) 2018, Impinj, Inc.
>> + *
>> + * Designware PCIe IP block emulation
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see
>> + * <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/pci/msi.h"
>> +#include "hw/pci/pci_bridge.h"
>> +#include "hw/pci/pci_host.h"
>> +#include "hw/pci/pcie_port.h"
>> +#include "hw/pci-host/designware.h"
>> +
>> +#define PCIE_PORT_LINK_CONTROL          0x710
>> +
>> +#define PCIE_PHY_DEBUG_R1               0x72C
>> +#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP  BIT(4)
>> +
>> +#define PCIE_LINK_WIDTH_SPEED_CONTROL   0x80C
>> +#define PORT_LOGIC_SPEED_CHANGE         (0x1 << 17)
>> +
>> +#define PCIE_MSI_ADDR_LO                0x820
>> +#define PCIE_MSI_ADDR_HI                0x824
>> +#define PCIE_MSI_INTR0_ENABLE           0x828
>> +#define PCIE_MSI_INTR0_MASK             0x82C
>> +#define PCIE_MSI_INTR0_STATUS           0x830
>> +
>> +#define PCIE_ATU_VIEWPORT               0x900
>> +#define PCIE_ATU_REGION_INBOUND         (0x1 << 31)
>> +#define PCIE_ATU_REGION_OUTBOUND        (0x0 << 31)
>> +#define PCIE_ATU_REGION_INDEX2          (0x2 << 0)
>> +#define PCIE_ATU_REGION_INDEX1          (0x1 << 0)
>> +#define PCIE_ATU_REGION_INDEX0          (0x0 << 0)
>> +#define PCIE_ATU_CR1                    0x904
>> +#define PCIE_ATU_TYPE_MEM               (0x0 << 0)
>> +#define PCIE_ATU_TYPE_IO                (0x2 << 0)
>> +#define PCIE_ATU_TYPE_CFG0              (0x4 << 0)
>> +#define PCIE_ATU_TYPE_CFG1              (0x5 << 0)
>> +#define PCIE_ATU_CR2                    0x908
>> +#define PCIE_ATU_ENABLE                 (0x1 << 31)
>> +#define PCIE_ATU_BAR_MODE_ENABLE        (0x1 << 30)
>> +#define PCIE_ATU_LOWER_BASE             0x90C
>> +#define PCIE_ATU_UPPER_BASE             0x910
>> +#define PCIE_ATU_LIMIT                  0x914
>> +#define PCIE_ATU_LOWER_TARGET           0x918
>> +#define PCIE_ATU_BUS(x)                 (((x) >> 24) & 0xff)
>> +#define PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
>> +#define PCIE_ATU_UPPER_TARGET           0x91C
>> +
>> +static DesignwarePCIEHost *
>> +designware_pcie_root_to_host(DesignwarePCIERoot *root)
>> +{
>> +    BusState *bus =3D qdev_get_parent_bus(DEVICE(root));
>> +    return DESIGNWARE_PCIE_HOST(bus->parent);
>> +}
>> +
>> +static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
>> +                                           uint64_t val, unsigned len)
>> +{
>> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(opaque);
>> +    DesignwarePCIEHost *host =3D designware_pcie_root_to_host(root);
>> +
>> +    root->msi.intr[0].status |=3D BIT(val) & root->msi.intr[0].enable;
>> +
>> +    if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
>> +        qemu_set_irq(host->pci.irqs[0], 1);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps designware_pci_host_msi_ops =3D {
>> +    .write =3D designware_pcie_root_msi_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>
>
> Native endian normally means you need to do byteswaps yourself.
> I don't see any here which looks suspicious.
>

Yeah, I think I get away with it by running a little-endian machine. Will f=
ix.

>> +    .valid =3D {
>> +        .min_access_size =3D 4,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void designware_pcie_root_update_msi_mapping(DesignwarePCIERoot =
*root)
>> +
>> +{
>> +    MemoryRegion *mem   =3D &root->msi.iomem;
>> +    const uint64_t base =3D root->msi.base;
>> +    const bool enable   =3D root->msi.intr[0].enable;
>> +
>> +    memory_region_set_address(mem, base);
>> +    memory_region_set_enabled(mem, enable);
>> +}
>> +
>> +static DesignwarePCIEViewport *
>> +designware_pcie_root_get_current_viewport(DesignwarePCIERoot *root)
>> +{
>> +    const unsigned int idx =3D root->atu_viewport & 0xF;
>> +    const unsigned int dir =3D !!(root->atu_viewport & PCIE_ATU_REGION_=
INBOUND);
>> +    return &root->viewports[dir][idx];
>> +}
>> +
>> +static uint32_t
>> +designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int le=
n)
>> +{
>> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(d);
>> +    DesignwarePCIEViewport *viewport =3D
>> +        designware_pcie_root_get_current_viewport(root);
>> +
>> +    uint32_t val;
>> +
>> +    switch (address) {
>> +    case PCIE_PORT_LINK_CONTROL:
>> +        /*
>> +         * Linux guest uses this register only to configure number of
>> +         * PCIE lane (which in our case is irrelevant) and doesn't
>> +         * really care about the value it reads from this register
>> +         */
>> +        val =3D 0xDEADBEEF;
>> +        break;
>> +
>> +    case PCIE_LINK_WIDTH_SPEED_CONTROL:
>> +        /*
>> +         * To make sure that any code in guest waiting for speed
>> +         * change does not time out we always report
>> +         * PORT_LOGIC_SPEED_CHANGE as set
>> +         */
>> +        val =3D PORT_LOGIC_SPEED_CHANGE;
>> +        break;
>> +
>> +    case PCIE_MSI_ADDR_LO:
>> +        val =3D root->msi.base;
>> +        break;
>> +
>> +    case PCIE_MSI_ADDR_HI:
>> +        val =3D root->msi.base >> 32;
>> +        break;
>> +
>> +    case PCIE_MSI_INTR0_ENABLE:
>> +        val =3D root->msi.intr[0].enable;
>> +        break;
>> +
>> +    case PCIE_MSI_INTR0_MASK:
>> +        val =3D root->msi.intr[0].mask;
>> +        break;
>> +
>> +    case PCIE_MSI_INTR0_STATUS:
>> +        val =3D root->msi.intr[0].status;
>> +        break;
>> +
>> +    case PCIE_PHY_DEBUG_R1:
>> +        val =3D PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
>> +        break;
>> +
>> +    case PCIE_ATU_VIEWPORT:
>> +        val =3D root->atu_viewport;
>> +        break;
>> +
>> +    case PCIE_ATU_LOWER_BASE:
>> +        val =3D viewport->base;
>> +        break;
>> +
>> +    case PCIE_ATU_UPPER_BASE:
>> +        val =3D viewport->base >> 32;
>> +        break;
>> +
>> +    case PCIE_ATU_LOWER_TARGET:
>> +        val =3D viewport->target;
>> +        break;
>> +
>> +    case PCIE_ATU_UPPER_TARGET:
>> +        val =3D viewport->target >> 32;
>> +        break;
>> +
>> +    case PCIE_ATU_LIMIT:
>> +        val =3D viewport->limit;
>> +        break;
>> +
>> +    case PCIE_ATU_CR1:
>> +    case PCIE_ATU_CR2:          /* FALLTHROUGH */
>> +        val =3D viewport->cr[(address - PCIE_ATU_CR1) / sizeof(uint32_t=
)];
>> +        break;
>> +
>> +    default:
>> +        val =3D pci_default_read_config(d, address, len);
>> +        break;
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static uint64_t designware_pcie_root_data_access(void *opaque, hwaddr a=
ddr,
>> +                                                 uint64_t *val, unsigne=
d len)
>> +{
>> +    DesignwarePCIEViewport *viewport;
>> +    DesignwarePCIERoot *root;
>> +    PCIBus *pcibus;
>> +
>> +    root     =3D DESIGNWARE_PCIE_ROOT(opaque);
>> +    viewport =3D designware_pcie_root_get_current_viewport(root);
>> +    pcibus   =3D pci_get_bus(PCI_DEVICE(root));
>> +
>> +    addr &=3D PCIE_CONFIG_SPACE_SIZE - 1;
>> +    addr |=3D PCIE_ATU_BUS(viewport->target) << 16;
>> +    addr |=3D PCIE_ATU_DEVFN(viewport->target) << 8;
>> +
>> +    if (val) {
>> +        pci_data_write(pcibus, addr, *val, len);
>> +        return 0;
>> +    }
>> +
>> +    return pci_data_read(pcibus, addr, len);
>> +}
>> +
>> +static uint64_t designware_pcie_root_data_read(void *opaque, hwaddr add=
r,
>> +                                               unsigned len)
>> +{
>> +    return designware_pcie_root_data_access(opaque, addr, NULL, len);
>> +}
>> +
>> +static void designware_pcie_root_data_write(void *opaque, hwaddr addr,
>> +                                            uint64_t val, unsigned len)
>> +{
>> +    designware_pcie_root_data_access(opaque, addr, &val, len);
>> +}
>> +
>> +static const MemoryRegionOps designware_pci_host_conf_ops =3D {
>> +    .read =3D designware_pcie_root_data_read,
>> +    .write =3D designware_pcie_root_data_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>
> Native endian is usually not what's needed for device emulation.
>

Same here. Will fix.

>
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
>> +                                            DesignwarePCIEViewport *vie=
wport)
>> +{
>> +    const uint64_t target =3D viewport->target;
>> +    const uint64_t base   =3D viewport->base;
>> +    const uint64_t size   =3D (uint64_t)viewport->limit - base + 1;
>> +    const bool enabled    =3D viewport->cr[1] & PCIE_ATU_ENABLE;
>> +
>> +    MemoryRegion *current, *other;
>> +
>> +    if (viewport->cr[0] =3D=3D PCIE_ATU_TYPE_MEM) {
>> +        current =3D &viewport->mem;
>> +        other   =3D &viewport->cfg;
>> +        memory_region_set_alias_offset(current, target);
>> +    } else {
>> +        current =3D &viewport->cfg;
>> +        other   =3D &viewport->mem;
>> +    }
>> +
>> +    /*
>> +     * An outbound viewport can be reconfigure from being MEM to CFG,
>> +     * to account for that we disable the "other" memory region that
>> +     * becomes unused due to that fact.
>> +     */
>> +    memory_region_set_enabled(other, false);
>> +    if (enabled) {
>> +        memory_region_set_size(current, size);
>> +        memory_region_set_address(current, base);
>> +    }
>> +    memory_region_set_enabled(current, enabled);
>> +}
>> +
>> +static void designware_pcie_root_config_write(PCIDevice *d, uint32_t ad=
dress,
>> +                                              uint32_t val, int len)
>> +{
>> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(d);
>> +    DesignwarePCIEHost *host =3D designware_pcie_root_to_host(root);
>> +    DesignwarePCIEViewport *viewport =3D
>> +        designware_pcie_root_get_current_viewport(root);
>> +
>> +    switch (address) {
>> +    case PCIE_PORT_LINK_CONTROL:
>> +    case PCIE_LINK_WIDTH_SPEED_CONTROL:
>> +    case PCIE_PHY_DEBUG_R1:
>> +        /* No-op */
>> +        break;
>> +
>> +    case PCIE_MSI_ADDR_LO:
>> +        root->msi.base &=3D 0xFFFFFFFF00000000ULL;
>> +        root->msi.base |=3D val;
>> +        break;
>> +
>> +    case PCIE_MSI_ADDR_HI:
>> +        root->msi.base &=3D 0x00000000FFFFFFFFULL;
>> +        root->msi.base |=3D (uint64_t)val << 32;
>> +        break;
>> +
>> +    case PCIE_MSI_INTR0_ENABLE: {
>> +        const bool update_msi_mapping =3D !root->msi.intr[0].enable ^ !=
!val;
>> +
>> +        root->msi.intr[0].enable =3D val;
>> +
>> +        if (update_msi_mapping) {
>> +            designware_pcie_root_update_msi_mapping(root);
>> +        }
>> +        break;
>> +    }
>> +
>> +    case PCIE_MSI_INTR0_MASK:
>> +        root->msi.intr[0].mask =3D val;
>> +        break;
>> +
>> +    case PCIE_MSI_INTR0_STATUS:
>> +        root->msi.intr[0].status ^=3D val;
>> +        if (!root->msi.intr[0].status) {
>> +            qemu_set_irq(host->pci.irqs[0], 0);
>> +        }
>> +        break;
>> +
>> +    case PCIE_ATU_VIEWPORT:
>> +        root->atu_viewport =3D val;
>> +        break;
>> +
>> +    case PCIE_ATU_LOWER_BASE:
>> +        viewport->base &=3D 0xFFFFFFFF00000000ULL;
>> +        viewport->base |=3D val;
>> +        break;
>> +
>> +    case PCIE_ATU_UPPER_BASE:
>> +        viewport->base &=3D 0x00000000FFFFFFFFULL;
>> +        viewport->base |=3D (uint64_t)val << 32;
>> +        break;
>> +
>> +    case PCIE_ATU_LOWER_TARGET:
>> +        viewport->target &=3D 0xFFFFFFFF00000000ULL;
>> +        viewport->target |=3D val;
>> +        break;
>> +
>> +    case PCIE_ATU_UPPER_TARGET:
>> +        viewport->target &=3D 0x00000000FFFFFFFFULL;
>> +        viewport->target |=3D val;
>> +        break;
>> +
>> +    case PCIE_ATU_LIMIT:
>> +        viewport->limit =3D val;
>> +        break;
>> +
>> +    case PCIE_ATU_CR1:
>> +        viewport->cr[0] =3D val;
>> +        break;
>> +    case PCIE_ATU_CR2:
>> +        viewport->cr[1] =3D val;
>> +        designware_pcie_update_viewport(root, viewport);
>> +        break;
>> +
>> +    default:
>> +        pci_bridge_write_config(d, address, val, len);
>> +        break;
>> +    }
>> +}
>> +
>> +static char *designware_pcie_viewport_name(const char *direction,
>> +                                           unsigned int i,
>> +                                           const char *type)
>> +{
>> +    return g_strdup_printf("PCI %s Viewport %u [%s]",
>> +                           direction, i, type);
>> +}
>> +
>> +static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>> +{
>> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(dev);
>> +    DesignwarePCIEHost *host =3D designware_pcie_root_to_host(root);
>> +    MemoryRegion *address_space =3D &host->pci.memory;
>> +    PCIBridge *br =3D PCI_BRIDGE(dev);
>> +    DesignwarePCIEViewport *viewport;
>> +    /*
>> +     * Dummy values used for initial configuration of MemoryRegions
>> +     * that belong to a give viewport
>> +     */
>> +    const hwaddr dummy_offset =3D 0;
>> +    const uint64_t dummy_size =3D 4;
>> +    size_t i;
>> +
>> +    br->bus_name  =3D "dw-pcie";
>> +
>> +    pci_set_word(dev->config + PCI_COMMAND,
>> +                 PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
>> +
>> +    pci_config_set_interrupt_pin(dev->config, 1);
>> +    pci_bridge_initfn(dev, TYPE_PCIE_BUS);
>> +
>> +    pcie_port_init_reg(dev);
>> +
>> +    pcie_cap_init(dev, 0x70, PCI_EXP_TYPE_ROOT_PORT,
>> +                  0, &error_fatal);
>> +
>> +    msi_nonbroken =3D true;
>> +    msi_init(dev, 0x50, 32, true, true, &error_fatal);
>> +
>> +    for (i =3D 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
>> +        MemoryRegion *source, *destination, *mem;
>> +        const char *direction;
>> +        char *name;
>> +
>> +        viewport =3D &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND]=
[i];
>> +        viewport->inbound =3D true;
>> +        viewport->base    =3D 0x0000000000000000ULL;
>> +        viewport->target  =3D 0x0000000000000000ULL;
>> +        viewport->limit   =3D UINT32_MAX;
>> +        viewport->cr[0]   =3D PCIE_ATU_TYPE_MEM;
>> +
>> +        source      =3D &host->pci.address_space_root;
>> +        destination =3D get_system_memory();
>> +        direction   =3D "Inbound";
>> +
>> +        /*
>> +         * Configure MemoryRegion implementing PCI -> CPU memory
>> +         * access
>> +         */
>> +        mem  =3D &viewport->mem;
>> +        name =3D designware_pcie_viewport_name(direction, i, "MEM");
>> +        memory_region_init_alias(mem, OBJECT(root), name, destination,
>> +                                 dummy_offset, dummy_size);
>> +        memory_region_add_subregion_overlap(source, dummy_offset, mem, =
-1);
>> +        memory_region_set_enabled(mem, false);
>> +        g_free(name);
>> +
>> +        viewport =3D &root->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND=
][i];
>> +        viewport->inbound =3D false;
>> +        viewport->base    =3D 0x0000000000000000ULL;
>> +        viewport->target  =3D 0x0000000000000000ULL;
>> +        viewport->limit   =3D UINT32_MAX;
>> +        viewport->cr[0]   =3D PCIE_ATU_TYPE_MEM;
>> +
>> +        destination =3D &host->pci.memory;
>> +        direction   =3D "Outbound";
>> +        source      =3D get_system_memory();
>> +
>> +        /*
>> +         * Configure MemoryRegion implementing CPU -> PCI memory
>> +         * access
>> +         */
>> +        mem  =3D &viewport->mem;
>> +        name =3D designware_pcie_viewport_name(direction, i, "MEM");
>> +        memory_region_init_alias(mem, OBJECT(root), name, destination,
>> +                                 dummy_offset, dummy_size);
>> +        memory_region_add_subregion(source, dummy_offset, mem);
>> +        memory_region_set_enabled(mem, false);
>> +        g_free(name);
>> +
>> +        /*
>> +         * Configure MemoryRegion implementing access to configuration
>> +         * space
>> +         */
>> +        mem  =3D &viewport->cfg;
>> +        name =3D designware_pcie_viewport_name(direction, i, "CFG");
>> +        memory_region_init_io(&viewport->cfg, OBJECT(root),
>> +                              &designware_pci_host_conf_ops,
>> +                              root, name, dummy_size);
>> +        memory_region_add_subregion(source, dummy_offset, mem);
>> +        memory_region_set_enabled(mem, false);
>> +        g_free(name);
>
> This implements the MMCFG, doesn't it?
> I suspect you need pcie_host_mmcfg_update instead of rolling
> your own.

AFAIU, not quite. MMCFG embeds information about which bus/function to
access into address it is mapped into CPU address space (A/S), whereas
for this controller those concerns are separate and "viewport->base"
determines the placement within CPU A/S and "viewport->target" is used
to figure out which bus/function to access.

Now that've run into problems with my patch for pci_data_*, I am
inclined to revert back to my original implementation of configuration
space accessors, something along the lines of:

static uint64_t designware_pcie_root_data_read(void *opaque,
                                               hwaddr addr, unsigned len)
{
    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(opaque);
    DesignwarePCIEViewport *viewport =3D
        designware_pcie_root_get_current_viewport(root);

    const uint8_t busnum =3D PCIE_ATU_BUS(viewport->target);
    const uint8_t devfn  =3D PCIE_ATU_DEVFN(viewport->target);
    PCIBus    *pcibus    =3D pci_get_bus(PCI_DEVICE(root));
    PCIDevice *pcidev    =3D pci_find_device(pcibus, busnum, devfn);

    if (pcidev) {
        addr &=3D pci_config_size(pcidev) - 1;

        return pci_host_config_read_common(pcidev, addr,
                                           pci_config_size(pcidev), len);
    }

    return UINT64_MAX;
}

does that sound reasonable?

Thanks,
Andrey Smirnov
