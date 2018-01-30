Received: from eggs.gnu.org ([2001:4830:134:3::10]:49867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@zoho.com>) id 1egVoy-00074H-3C
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@zoho.com>) id 1egVot-0002vs-VU
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:19:32 -0500
Reply-To: marcel@redhat.com
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-10-andrew.smirnov@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Message-ID: <76017d4e-0b11-93a4-94c7-553f7baee3ff@zoho.com>
Date: Tue, 30 Jan 2018 15:18:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-10-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/14] pci: Add support for Designware
 IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi Andrei,

Sorry for letting you wait,
I have some comments/questions below.

On 16/01/2018 3:37, Andrey Smirnov wrote:
> Add code needed to get a functional PCI subsytem when using in
> conjunction with upstream Linux guest (4.13+). Tested to work against
> "e1000e" (network adapter, using MSI interrupts) as well as
> "usb-ehci" (USB controller, using legacy PCI interrupts).
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>   default-configs/arm-softmmu.mak  |   2 +
>   hw/pci-host/Makefile.objs        |   2 +
>   hw/pci-host/designware.c         | 618 ++++++++++++++++++++++++++++++=
+++++++++
>   include/hw/pci-host/designware.h |  93 ++++++
>   include/hw/pci/pci_ids.h         |   2 +
>   5 files changed, 717 insertions(+)
>   create mode 100644 hw/pci-host/designware.c
>   create mode 100644 include/hw/pci-host/designware.h
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> index b0d6e65038..0c5ae914ed 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -132,3 +132,5 @@ CONFIG_GPIO_KEY=3Dy
>   CONFIG_MSF2=3Dy
>   CONFIG_FW_CFG_DMA=3Dy
>   CONFIG_XILINX_AXI=3Dy
> +CONFIG_PCI_DESIGNWARE=3Dy
> +
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index 9c7909cf44..0e2c0a123b 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -17,3 +17,5 @@ common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
>   common-obj-$(CONFIG_PCI_Q35) +=3D q35.o
>   common-obj-$(CONFIG_PCI_GENERIC) +=3D gpex.o
>   common-obj-$(CONFIG_PCI_XILINX) +=3D xilinx-pcie.o
> +
> +common-obj-$(CONFIG_PCI_DESIGNWARE) +=3D designware.o
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> new file mode 100644
> index 0000000000..98fff5e5f3
> --- /dev/null
> +++ b/hw/pci-host/designware.c
> @@ -0,0 +1,618 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
2018 :)
> + *
> + * Designware PCIe IP block emulation
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_port.h"
> +#include "hw/pci-host/designware.h"
> +
> +#define PCIE_PORT_LINK_CONTROL          0x710
> +
> +#define PCIE_PHY_DEBUG_R1               0x72C
> +#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP  BIT(4)
> +
> +#define PCIE_LINK_WIDTH_SPEED_CONTROL   0x80C
> +
> +#define PCIE_MSI_ADDR_LO                0x820
> +#define PCIE_MSI_ADDR_HI                0x824
> +#define PCIE_MSI_INTR0_ENABLE           0x828
> +#define PCIE_MSI_INTR0_MASK             0x82C
> +#define PCIE_MSI_INTR0_STATUS           0x830
> +
> +#define PCIE_ATU_VIEWPORT               0x900
> +#define PCIE_ATU_REGION_INBOUND         (0x1 << 31)
> +#define PCIE_ATU_REGION_OUTBOUND        (0x0 << 31)
> +#define PCIE_ATU_REGION_INDEX2          (0x2 << 0)
> +#define PCIE_ATU_REGION_INDEX1          (0x1 << 0)
> +#define PCIE_ATU_REGION_INDEX0          (0x0 << 0)
> +#define PCIE_ATU_CR1                    0x904
> +#define PCIE_ATU_TYPE_MEM               (0x0 << 0)
> +#define PCIE_ATU_TYPE_IO                (0x2 << 0)
> +#define PCIE_ATU_TYPE_CFG0              (0x4 << 0)
> +#define PCIE_ATU_TYPE_CFG1              (0x5 << 0)
> +#define PCIE_ATU_CR2                    0x908
> +#define PCIE_ATU_ENABLE                 (0x1 << 31)
> +#define PCIE_ATU_BAR_MODE_ENABLE        (0x1 << 30)
> +#define PCIE_ATU_LOWER_BASE             0x90C
> +#define PCIE_ATU_UPPER_BASE             0x910
> +#define PCIE_ATU_LIMIT                  0x914
> +#define PCIE_ATU_LOWER_TARGET           0x918
> +#define PCIE_ATU_BUS(x)                 (((x) >> 24) & 0xff)
> +#define PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
> +#define PCIE_ATU_UPPER_TARGET           0x91C
> +
> +static DesignwarePCIEHost *
> +designware_pcie_root_to_host(DesignwarePCIERoot *root)
> +{
> +    BusState *bus =3D qdev_get_parent_bus(DEVICE(root));
> +    return DESIGNWARE_PCIE_HOST(bus->parent);
> +}
> +
> +static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
> +                                           uint64_t val, unsigned len)
> +{
> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(opaque);
> +    DesignwarePCIEHost *host =3D designware_pcie_root_to_host(root);
> +
> +    root->msi.intr[0].status |=3D (1 << val) & root->msi.intr[0].enabl=
e;
> +
> +    if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
> +        qemu_set_irq(host->pci.irqs[0], 1);

Sorry for the possibly dumb question, but "msi_write"
will result in raising an INTx ?
> +    }
> +}
> +
> +const MemoryRegionOps designware_pci_host_msi_ops =3D {
> +    .write =3D designware_pcie_root_msi_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,

You may want to limit the access size.
> +};
> +
> +static void designware_pcie_root_update_msi_mapping(DesignwarePCIERoot=
 *root)
> +
> +{
> +    DesignwarePCIEHost *host =3D designware_pcie_root_to_host(root);
> +    MemoryRegion *address_space =3D &host->pci.memory;
> +    MemoryRegion *mem =3D &root->msi.iomem;
> +    const uint64_t base =3D root->msi.base;
> +    const bool enable =3D root->msi.intr[0].enable;
> +
> +    if (memory_region_is_mapped(mem)) {
> +        memory_region_del_subregion(address_space, mem);
> +        object_unparent(OBJECT(mem));
> +    }
> +
> +    if (enable) {
> +        memory_region_init_io(mem, OBJECT(root),
> +                              &designware_pci_host_msi_ops,
> +                              root, "pcie-msi", 0x1000);
> +
> +        memory_region_add_subregion(address_space, base, mem);

What happens if is enabled twice?
Is it possible to be also disabled?

> +    }
> +}
> +
> +static DesignwarePCIEViewport *
> +designware_pcie_root_get_current_viewport(DesignwarePCIERoot *root)
> +{
> +    const unsigned int idx =3D root->atu_viewport & 0xF;
> +    const unsigned int dir =3D !!(root->atu_viewport & PCIE_ATU_REGION=
_INBOUND);
> +    return &root->viewports[dir][idx];
> +}
> +
> +static uint32_t
> +designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int l=
en)
> +{
> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(d);
> +    DesignwarePCIEViewport *viewport =3D
> +        designware_pcie_root_get_current_viewport(root);
> +
> +    uint32_t val;
> +
> +    switch (address) {
> +    case PCIE_PORT_LINK_CONTROL:
> +    case PCIE_LINK_WIDTH_SPEED_CONTROL:
> +        val =3D 0xDEADBEEF;
> +        /* No-op */

Not really a no-op
> +        break;
> +
> +    case PCIE_MSI_ADDR_LO:
> +        val =3D root->msi.base;
> +        break;
> +
> +    case PCIE_MSI_ADDR_HI:
> +        val =3D root->msi.base >> 32;
> +        break;
> +
> +    case PCIE_MSI_INTR0_ENABLE:
> +        val =3D root->msi.intr[0].enable;
> +        break;
> +
> +    case PCIE_MSI_INTR0_MASK:
> +        val =3D root->msi.intr[0].mask;
> +        break;
> +
> +    case PCIE_MSI_INTR0_STATUS:
> +        val =3D root->msi.intr[0].status;
> +        break;
> +
> +    case PCIE_PHY_DEBUG_R1:
> +        val =3D PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
> +        break;
> +
> +    case PCIE_ATU_VIEWPORT:
> +        val =3D root->atu_viewport;
> +        break;
> +
> +    case PCIE_ATU_LOWER_BASE:
> +        val =3D viewport->base;
> +        break;
> +
> +    case PCIE_ATU_UPPER_BASE:
> +        val =3D viewport->base >> 32;
> +        break;
> +
> +    case PCIE_ATU_LOWER_TARGET:
> +        val =3D viewport->target;
> +        break;
> +
> +    case PCIE_ATU_UPPER_TARGET:
> +        val =3D viewport->target >> 32;
> +        break;
> +
> +    case PCIE_ATU_LIMIT:
> +        val =3D viewport->limit;
> +        break;
> +
> +    case PCIE_ATU_CR1:
> +    case PCIE_ATU_CR2:          /* FALLTHROUGH */
> +        val =3D viewport->cr[(address - PCIE_ATU_CR1) / sizeof(uint32_=
t)];
> +        break;
> +
> +    default:
> +        val =3D pci_default_read_config(d, address, len);
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static uint64_t designware_pcie_root_data_read(void *opaque,
> +                                               hwaddr addr, unsigned l=
en)
> +{
> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(opaque);
> +    DesignwarePCIEViewport *viewport =3D
> +        designware_pcie_root_get_current_viewport(root);
> +
> +    const uint8_t busnum =3D PCIE_ATU_BUS(viewport->target);
> +    const uint8_t devfn  =3D PCIE_ATU_DEVFN(viewport->target);
> +    PCIBus    *pcibus    =3D pci_get_bus(PCI_DEVICE(root));
> +    PCIDevice *pcidev    =3D pci_find_device(pcibus, busnum, devfn);
> +
> +    if (pcidev) {
> +        addr &=3D PCI_CONFIG_SPACE_SIZE - 1;
> +
> +        return pci_host_config_read_common(pcidev, addr,
> +                                           PCI_CONFIG_SPACE_SIZE, len)=
;
> +    }
You can use "pci_data_read" instead
> +
> +    return UINT64_MAX;
> +}
> +
> +static void designware_pcie_root_data_write(void *opaque, hwaddr addr,
> +                                            uint64_t val, unsigned len=
)
> +{
> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(opaque);
> +    DesignwarePCIEViewport *viewport =3D
> +        designware_pcie_root_get_current_viewport(root);
> +    const uint8_t busnum =3D PCIE_ATU_BUS(viewport->target);
> +    const uint8_t devfn  =3D PCIE_ATU_DEVFN(viewport->target);
> +    PCIBus    *pcibus    =3D pci_get_bus(PCI_DEVICE(root));
> +    PCIDevice *pcidev    =3D pci_find_device(pcibus, busnum, devfn);
> +
> +    if (pcidev) {
> +        addr &=3D PCI_CONFIG_SPACE_SIZE - 1;
> +        pci_host_config_write_common(pcidev, addr,
> +                                     PCI_CONFIG_SPACE_SIZE,
> +                                     val, len);
> +    }
You can use pci_data_write instead.

> +}
> +
> +const MemoryRegionOps designware_pci_host_conf_ops =3D {
> +    .read =3D designware_pcie_root_data_read,
> +    .write =3D designware_pcie_root_data_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,

Maybe you want to limit the access size also here.
> +};
> +
> +static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
> +                                            DesignwarePCIEViewport *vi=
ewport)
> +{
> +    DesignwarePCIEHost *host =3D designware_pcie_root_to_host(root);
> +
> +    MemoryRegion *mem     =3D &viewport->memory;
> +    const uint64_t target =3D viewport->target;
> +    const uint64_t base   =3D viewport->base;
> +    const uint64_t size   =3D (uint64_t)viewport->limit - base + 1;
> +    const bool inbound    =3D viewport->inbound;
> +
> +    MemoryRegion *source, *destination;
> +    const char *direction;
> +    char *name;
> +
> +    if (inbound) {
> +        source      =3D &host->pci.address_space_root;
> +        destination =3D get_system_memory();
> +        direction   =3D "Inbound";
> +    } else {
> +        source      =3D get_system_memory();
> +        destination =3D &host->pci.memory;
> +        direction   =3D "Outbound";
> +    }
> +
> +    if (memory_region_is_mapped(mem)) {
> +        /* Before we modify anything, unmap and destroy the region */

I saw this also before. Can you please explain a little
why/when do you need to destroy prev mappings?
> +        memory_region_del_subregion(source, mem);
> +        object_unparent(OBJECT(mem));
> +    }
> +
> +    name =3D g_strdup_printf("PCI %s Viewport %p", direction, viewport=
);
> +
> +    switch (viewport->cr[0]) {
> +    case PCIE_ATU_TYPE_MEM:
> +        memory_region_init_alias(mem, OBJECT(root), name,
> +                                 destination, target, size);
> +        break;
> +    case PCIE_ATU_TYPE_CFG0:
> +    case PCIE_ATU_TYPE_CFG1:    /* FALLTHROUGH */
> +        if (inbound) {
> +            goto exit;
> +        }
> +
> +        memory_region_init_io(mem, OBJECT(root),
> +                              &designware_pci_host_conf_ops,
> +                              root, name, size);
> +        break;
> +    }
> +
> +    if (inbound) {
> +        memory_region_add_subregion_overlap(source, base,
> +                                            mem, -1);
> +    } else {
> +        memory_region_add_subregion(source, base, mem);
> +    }
> +
> + exit:
> +    g_free(name);
> +}
> +
> +static void designware_pcie_root_config_write(PCIDevice *d, uint32_t a=
ddress,
> +                                              uint32_t val, int len)
> +{
> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(d);
> +    DesignwarePCIEHost *host =3D designware_pcie_root_to_host(root);
> +    DesignwarePCIEViewport *viewport =3D
> +        designware_pcie_root_get_current_viewport(root);
> +
> +    switch (address) {
> +    case PCIE_PORT_LINK_CONTROL:
> +    case PCIE_LINK_WIDTH_SPEED_CONTROL:
> +    case PCIE_PHY_DEBUG_R1:
> +        /* No-op */
> +        break;
> +
> +    case PCIE_MSI_ADDR_LO:
> +        root->msi.base &=3D 0xFFFFFFFF00000000ULL;
> +        root->msi.base |=3D val;
> +        break;
> +
> +    case PCIE_MSI_ADDR_HI:
> +        root->msi.base &=3D 0x00000000FFFFFFFFULL;
> +        root->msi.base |=3D (uint64_t)val << 32;
> +        break;
> +
> +    case PCIE_MSI_INTR0_ENABLE: {
> +        const bool update_msi_mapping =3D !root->msi.intr[0].enable ^ =
!!val;
> +
> +        root->msi.intr[0].enable =3D val;
> +
> +        if (update_msi_mapping) {
> +            designware_pcie_root_update_msi_mapping(root);
> +        }
> +        break;
> +    }
> +
> +    case PCIE_MSI_INTR0_MASK:
> +        root->msi.intr[0].mask =3D val;
> +        break;
> +
> +    case PCIE_MSI_INTR0_STATUS:
> +        root->msi.intr[0].status ^=3D val;
> +        if (!root->msi.intr[0].status) {
> +            qemu_set_irq(host->pci.irqs[0], 0);
> +        }
> +        break;
> +
> +    case PCIE_ATU_VIEWPORT:
> +        root->atu_viewport =3D val;
> +        break;
> +
> +    case PCIE_ATU_LOWER_BASE:
> +        viewport->base &=3D 0xFFFFFFFF00000000ULL;
> +        viewport->base |=3D val;
> +        break;
> +
> +    case PCIE_ATU_UPPER_BASE:
> +        viewport->base &=3D 0x00000000FFFFFFFFULL;
> +        viewport->base |=3D (uint64_t)val << 32;
> +        break;
> +
> +    case PCIE_ATU_LOWER_TARGET:
> +        viewport->target &=3D 0xFFFFFFFF00000000ULL;
> +        viewport->target |=3D val;
> +        break;
> +
> +    case PCIE_ATU_UPPER_TARGET:
> +        viewport->target &=3D 0x00000000FFFFFFFFULL;
> +        viewport->target |=3D val;
> +        break;
> +
> +    case PCIE_ATU_LIMIT:
> +        viewport->limit =3D val;
> +        break;
> +
> +    case PCIE_ATU_CR1:
> +        viewport->cr[0] =3D val;
> +        break;
> +    case PCIE_ATU_CR2:
> +        viewport->cr[1] =3D val;
> +
> +        if (viewport->cr[1] & PCIE_ATU_ENABLE) {
> +            designware_pcie_update_viewport(root, viewport);
> +         }
> +        break;
> +
> +    default:
> +        pci_bridge_write_config(d, address, val, len);
> +        break;
> +    }
> +}
> +
> +static int designware_pcie_root_init(PCIDevice *dev)
> +{

Please use "realize" function rather than init.
We want to get rid of it eventually.
> +    DesignwarePCIERoot *root =3D DESIGNWARE_PCIE_ROOT(dev);
> +    PCIBridge *br =3D PCI_BRIDGE(dev);
> +    DesignwarePCIEViewport *viewport;
> +    size_t i;
> +
> +    br->bus_name  =3D "dw-pcie";
> +
> +    pci_set_word(dev->config + PCI_COMMAND,
> +                 PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> +
> +    pci_config_set_interrupt_pin(dev->config, 1);
> +    pci_bridge_initfn(dev, TYPE_PCI_BUS);
So this is a PCI Express Root Port "sitting" on PCI bus?
> +
> +    pcie_port_init_reg(dev);
> +
> +    pcie_cap_init(dev, 0x70, PCI_EXP_TYPE_ROOT_PORT,
> +                  0, &error_fatal);
> +
> +    msi_nonbroken =3D true;
> +    msi_init(dev, 0x50, 32, true, true, &error_fatal);
> +
> +    for (i =3D 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
> +        viewport =3D &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND=
][i];
> +        viewport->inbound =3D true;
> +    }
> +
> +    /*
> +     * If no inbound iATU windows are configured, HW defaults to
> +     * letting inbound TLPs to pass in. We emulate that by exlicitly
> +     * configuring first inbound window to cover all of target's
> +     * address space.
> +     *
> +     * NOTE: This will not work correctly for the case when first
> +     * configured inbound window is window 0
> +     */
> +    viewport =3D &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0]=
;
> +    viewport->base   =3D 0x0000000000000000ULL;
> +    viewport->target =3D 0x0000000000000000ULL;
> +    viewport->limit  =3D UINT32_MAX;
> +    viewport->cr[0]  =3D PCIE_ATU_TYPE_MEM;
> +
> +    designware_pcie_update_viewport(root, viewport);
> +
> +    return 0;
> +}
> +
> +static void designware_pcie_set_irq(void *opaque, int irq_num, int lev=
el)
> +{
> +    DesignwarePCIEHost *host =3D DESIGNWARE_PCIE_HOST(opaque);
> +
> +    qemu_set_irq(host->pci.irqs[irq_num], level);
> +}
> +
> +static const char *designware_pcie_host_root_bus_path(PCIHostState *ho=
st_bridge,
> +                                                      PCIBus *rootbus)
> +{
> +    return "0000:00";
> +}
> +
> +
> +static void designware_pcie_root_class_init(ObjectClass *klass, void *=
data)
> +{
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +
> +    k->vendor_id =3D PCI_VENDOR_ID_SYNOPSYS;
> +    k->device_id =3D 0xABCD;
> +    k->revision =3D 0;
> +    k->class_id =3D PCI_CLASS_BRIDGE_HOST;
So is a Root Port with call is "BRIDGE_HOST" ?

> +    k->is_express =3D true;
> +    k->is_bridge =3D true;
> +    k->init =3D designware_pcie_root_init;
> +    k->exit =3D pci_bridge_exitfn;
> +    dc->reset =3D pci_bridge_reset;
> +    k->config_read =3D designware_pcie_root_config_read;
> +    k->config_write =3D designware_pcie_root_config_write;

Please add category:
set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +
> +    /*
> +     * PCI-facing part of the host bridge, not usable without the
> +     * host-facing part, which can't be device_add'ed, yet.
> +     */
> +    dc->user_creatable =3D false;
> +}
> +
> +static uint64_t designware_pcie_host_mmio_read(void *opaque, hwaddr ad=
dr,
> +                                               unsigned int size)
> +{
> +    PCIHostState *pci =3D PCI_HOST_BRIDGE(opaque);
> +    PCIDevice *device =3D pci_find_device(pci->bus, 0, 0);
> +
> +    return pci_host_config_read_common(device,
> +                                       addr,
> +                                       pci_config_size(device),
> +                                       size);
> +}
> +
> +static void designware_pcie_host_mmio_write(void *opaque, hwaddr addr,
> +                                            uint64_t val, unsigned int=
 size)
> +{
> +    PCIHostState *pci =3D PCI_HOST_BRIDGE(opaque);
> +    PCIDevice *device =3D pci_find_device(pci->bus, 0, 0);
> +
> +    return pci_host_config_write_common(device,
> +                                        addr,
> +                                        pci_config_size(device),
> +                                        val, size);
> +}
> +
> +static const MemoryRegionOps designware_pci_mmio_ops =3D {
> +    .read       =3D designware_pcie_host_mmio_read,
> +    .write      =3D designware_pcie_host_mmio_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static AddressSpace *designware_pcie_host_set_iommu(PCIBus *bus, void =
*opaque,
> +                                                    int devfn)
> +{
> +    DesignwarePCIEHost *s =3D DESIGNWARE_PCIE_HOST(opaque);
> +
> +    return &s->pci.address_space;
> +}
> +
> +static void designware_pcie_host_realize(DeviceState *dev, Error **err=
p)
> +{
> +    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
> +    DesignwarePCIEHost *s =3D DESIGNWARE_PCIE_HOST(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    size_t i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->pci.irqs); i++) {
> +        sysbus_init_irq(sbd, &s->pci.irqs[i]);
> +    }
> +
> +    memory_region_init_io(&s->mmio,
> +                          OBJECT(s),
> +                          &designware_pci_mmio_ops,
> +                          s,
> +                          "pcie.reg", 4 * 1024);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    memory_region_init(&s->pci.io, OBJECT(s), "pcie-pio", 16);
> +    memory_region_init(&s->pci.memory, OBJECT(s),
> +                       "pcie-bus-memory",
> +                       UINT64_MAX);
> +
> +    pci->bus =3D pci_register_root_bus(dev, "pcie",
> +                                     designware_pcie_set_irq,
> +                                     pci_swizzle_map_irq_fn,
> +                                     s,
> +                                     &s->pci.memory,
> +                                     &s->pci.io,
> +                                     0, 4,
> +                                     TYPE_PCIE_BUS);
> +
> +    memory_region_init(&s->pci.address_space_root,
> +                       OBJECT(s),
> +                       "pcie-bus-address-space-root",
> +                       UINT64_MAX);
> +    memory_region_add_subregion(&s->pci.address_space_root,
> +                                0x0, &s->pci.memory);
> +    address_space_init(&s->pci.address_space,
> +                       &s->pci.address_space_root,
> +                       "pcie-bus-address-space");
> +    pci_setup_iommu(pci->bus, designware_pcie_host_set_iommu, s);
> +
> +    qdev_set_parent_bus(DEVICE(&s->root), BUS(pci->bus));
> +    qdev_init_nofail(DEVICE(&s->root));
> +}
> +
> +static void designware_pcie_host_class_init(ObjectClass *klass, void *=
data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> +
> +    hc->root_bus_path =3D designware_pcie_host_root_bus_path;
> +    dc->realize =3D designware_pcie_host_realize;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->fw_name =3D "pci";
> +}
> +
> +static void designware_pcie_host_init(Object *obj)
> +{
> +    DesignwarePCIEHost *s =3D DESIGNWARE_PCIE_HOST(obj);
> +    DesignwarePCIERoot *root =3D &s->root;
> +
> +    object_initialize(root, sizeof(*root), TYPE_DESIGNWARE_PCIE_ROOT);
> +    object_property_add_child(obj, "root", OBJECT(root), NULL);
> +    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
> +    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
> +}
> +
> +static const TypeInfo designware_pcie_root_info =3D {
> +    .name =3D TYPE_DESIGNWARE_PCIE_ROOT,
> +    .parent =3D TYPE_PCI_BRIDGE,
> +    .instance_size =3D sizeof(DesignwarePCIERoot),
> +    .class_init =3D designware_pcie_root_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { }
> +    },
> +};
> +
> +static const TypeInfo designware_pcie_host_info =3D {
> +    .name       =3D TYPE_DESIGNWARE_PCIE_HOST,
> +    .parent     =3D TYPE_PCI_HOST_BRIDGE,
> +    .instance_size =3D sizeof(DesignwarePCIEHost),
> +    .instance_init =3D designware_pcie_host_init,
> +    .class_init =3D designware_pcie_host_class_init,
> +};
> +
> +static void designware_pcie_register(void)
> +{
> +    type_register_static(&designware_pcie_root_info);
> +    type_register_static(&designware_pcie_host_info);
> +}
> +type_init(designware_pcie_register)
> +
> +/* 00:00.0 Class 0604: 16c3:abcd */
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/des=
ignware.h
> new file mode 100644
> index 0000000000..55e45fcba0
> --- /dev/null
> +++ b/include/hw/pci-host/designware.h
> @@ -0,0 +1,93 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * Designware PCIe IP block emulation
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef DESIGNWARE_H
> +#define DESIGNWARE_H
> +
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pcie_host.h"
> +#include "hw/pci/pci_bridge.h"
> +
> +#define TYPE_DESIGNWARE_PCIE_HOST "designware-pcie-host"
> +#define DESIGNWARE_PCIE_HOST(obj) \
> +     OBJECT_CHECK(DesignwarePCIEHost, (obj), TYPE_DESIGNWARE_PCIE_HOST=
)
> +
> +#define TYPE_DESIGNWARE_PCIE_ROOT "designware-pcie-root"
> +#define DESIGNWARE_PCIE_ROOT(obj) \
> +     OBJECT_CHECK(DesignwarePCIERoot, (obj), TYPE_DESIGNWARE_PCIE_ROOT=
)
> +
> +typedef struct DesignwarePCIEViewport {
> +    MemoryRegion memory;
> +
> +    uint64_t base;
> +    uint64_t target;
> +    uint32_t limit;
> +    uint32_t cr[2];
> +
> +    bool inbound;
> +} DesignwarePCIEViewport;
> +
> +typedef struct DesignwarePCIERoot {
> +    PCIBridge parent_obj;
> +
> +    uint32_t atu_viewport;
> +
> +#define DESIGNWARE_PCIE_VIEWPORT_OUTBOUND    0
> +#define DESIGNWARE_PCIE_VIEWPORT_INBOUND     1
> +#define DESIGNWARE_PCIE_NUM_VIEWPORTS        4
> +
> +    DesignwarePCIEViewport viewports[2][DESIGNWARE_PCIE_NUM_VIEWPORTS]=
;
> +
> +    struct {
> +        uint64_t     base;
> +        MemoryRegion iomem;
> +
> +        struct {
> +            uint32_t enable;
> +            uint32_t mask;
> +            uint32_t status;
> +        } intr[1];
> +    } msi;

I think I didn't understand the msi struct above.
Is it some special msi implementation?
(related to the dumb question above)



> +} DesignwarePCIERoot;
> +
> +typedef struct DesignwarePCIEHost {
> +    PCIHostState parent_obj;
> +
> +    bool link_up;
> +
> +    DesignwarePCIERoot root;
> +
> +    struct {
> +        AddressSpace address_space;
> +        MemoryRegion address_space_root;
> +
> +        MemoryRegion memory;
> +        MemoryRegion io;
> +
> +        qemu_irq     irqs[4];
> +    } pci;
> +
> +    MemoryRegion mmio;
> +} DesignwarePCIEHost;
> +
> +#endif  /* DESIGNWARE_H */
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 35df1874a9..23fefe1bc6 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -266,4 +266,6 @@
>   #define PCI_VENDOR_ID_TEWS               0x1498
>   #define PCI_DEVICE_ID_TEWS_TPCI200       0x30C8
>  =20
> +#define PCI_VENDOR_ID_SYNOPSYS           0x16C3
> +
>   #endif


The host-bridge part looks OK to me, the Root Port part looks strange but=
 it may

be because of the chipset.

Thanks,

Marcel
